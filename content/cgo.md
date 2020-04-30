Status: draft
title: Trying to handle C segfaults in Go
slug: cgo-segfault
date: 2020-04-29 08:00:00
Tags: go, golang, cgo, segfault, sigsegv, systems, C

I've been working on a system primarily written in Go, but with heavy usage of [cgo][cgo] to call into C++ functions and recently I ran into an issue where the system was calling into C++ and crashing. The C++ code was accessing invalid memory and causing a segmentation fault which results in the operating system issuing a `SIGSEGV` signal to the parent Go process, which then crashes. Unfortunately, the Go signal handler doesn't know how to unwind the C stack and generate a panic, so instead it just outputs something like:

```
go fatal error: unexpected signal during runtime execution
```

Instead I wanted to find a way to intercept the signal using my own signal handler, then traverse the thread stack and write the backtrace to logs for later analysis. After some research I found this [promising comment][ian] from one of the Go authors:

>If you install a C signal handler before the Go code starts, such as by using a global constructor, then the right thing should happen

With some confidence that this was probably possible I was able to come up with an [almost working example][repo] based on information about backtrace generation from an old [Linux Journal article](https://www.linuxjournal.com/article/6391). Unfortunately, I could only get a proper backtrace when calling my backtrace printing function from outside of a signal handler. Turns out this code would not actually resolve my issue because the OS (platform specific) uses a special [signal stack](https://www.gnu.org/software/libc/manual/html_node/Signal-Stack.html) when handling signals, so using `backtrace()` isn't sufficient to dump the stack for the thread of execution which actually ran into the fault.

It appears that the right way to handle this is to use the `ucontext_t` structure passed to your signal handler to determine the top of the (non-signal) stack via the `rsp` [stack register](https://en.wikipedia.org/wiki/Stack_register), which is [architecture dependent][rsp], and then modify the first frame of the signal-stack to point there. This way the subsequent call to [`backtrace_symbols()`][symb] will jump to the correct memory address for function called by the thread which faulted.

I spent a while trying to do just that. The definition for the `ucontext_t` structure is platform dependent and I was compiling this on MacOS, so I checked out the [Darwin source](https://opensource.apple.com/source/xnu/xnu-792/bsd/sys/_types.h) to see which fields are available on Darwin's version of the structure (`__darwin_ucontext_t`). This looked promising:

>*uc_link;	/* pointer to resuming context */

After trying to use this pointer and the technique above, I wasn't making any progress and decided to discontinue the experiment. Later on I found some helpful cross-platform libraries that accomplish the goal (mentioned below).

## Advice
To anyone that happens to stumble upon this and has a similar issue, my suggestion is just to avoid manual signal handling entirely unless your intention is to actually fix the issue causing the signal and resume normal program execution. You can't just handle a critical signal like `SIGSEGV` and then return from the signal handler, so the range of useful things you can do are fairly limited. Actually trying to get a backtrace is highly platform dependent, so you would have to either write a handler that is specific to the exact OS and archictecture you are running your application on, or use a cross platform library.

Turns out, such libraries exist! (I didn't know this at the time.) So if your goal is simply to get a more helpful backtrace of the C stack for later debugging, I'd suggest using this package which uses a special function in the Go runtime to output symbols interleaved with the Go stack:
https://github.com/ianlancetaylor/cgosymbolizer

That library makes us of a portable C library that allows for stack unwinding on many platforms:
https://www.nongnu.org/libunwind/

## Code
The code for this experiment can be found here: https://github.com/keyan/cgo_segfault

[golang]: http://golang.org/
[cgo]: https://golang.org/cmd/cgo/
[segfault]: https://en.wikipedia.org/wiki/Segmentation_fault
[sigaction]: http://man7.org/linux/man-pages/man2/sigaction.2.html
[ian]: https://groups.google.com/forum/#!topic/golang-nuts/_NSAyPVKstU
[repo]: https://github.com/keyan/cgo_segfault
[rsp]: https://github.com/libunwind/libunwind/blob/edc427a9eccd6db583fd0cd920e2af23b4b544a9/src/x86_64/ucontext_i.h#L41
[symb]: https://github.com/keyan/cgo_segfault/blob/86ef923520bf092c8113ff65b32e69f6defb2857/handler.c#L24
