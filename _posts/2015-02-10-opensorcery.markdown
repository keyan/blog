---
layout: post
title:  "Open Sorcery"
date:   2015-02-12 11:43:19
description: open source
categories:
- hacker school
- open source
---

One of my main goals coming to Hacker School was to contribute to an open source project. I have heard over and over again how contributing is important to becoming a better software engineer. Whilst also reading numerous rants by those who are resentful that open source contributions have become a *de facto* expectation of professional developers. So of course I was dying to see what all the fuss was about.

I'll premise this discussion by saying that I concur with the notion that open source contributing makes for better software developers, but that contributing shouldn't necessarily be a requirement for anyone. Naturally, if you are spending a few months programming for the sake of learning and have plenty of time (Hacker Schoolers), open source contributing makes plenty of sense! But for those who have to work 9-5 and have other responsibilities, it seems ridiculous to demand that they go home and essentially continue working.

All that said, through contributing I have learned immensely more about software development than I could have by working on my own toy projects. Working on a large project that has been in development for weeks/months/years before you even looked at the codebase is **hard**. For me the most striking fact was how much overhead is required to actually start working on an issue, especially when one is new to the codebase. Much more time is spent reading the existing source, setting up the environment, writing tests, and understanding the problem than is actually spent coding. Even seemingly trivial issues are multifaceted and have many dependencies. Although I haven't worked on a software development team, I'd imagine the experience is very similar: 

    1. Get a bug report
    2. Digest the problem
    3. Replicate the issue 
    4. Clarify the expected behavior
    5. Write tests
    6. Dive into the source to find the problem
    7. Fix the problem
    8. Realize you broke other things while fixing the problem
    9. Fix the things you broke
    10. Repeat
    11. Rejoice in your contributions to the community at large

Except maybe #11 just getting paid, although ideally that would be #12 and you could get paid and positively impact the community too. Anyhow, my next post is going be more technical and actually dissect an issue I've been working for [Flask][1]. Stay tuned!

[1]: https://github.com/mitsuhiko/flask