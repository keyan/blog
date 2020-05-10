PY?=python
PELICAN?=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

S3_BUCKET=keyanp.com

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

help:
	@echo 'Makefile for a pelican Web site                                                                      '
	@echo '                                                                                                     '
	@echo 'Usage:                                                                                               '
	@echo '   make help               output this message                                                       '
	@echo '   make clean              remove the generated files                                                '
	@echo '   make work               serve site at http://localhost:8000 with automatic reloading after changes'
	@echo '   make publish            generate using production settings                                        '
	@echo '   make upload             upload the web site via S3     					    '
	@echo '                                                                                                     '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html                              '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                                               '
	@echo '                                                                                                     '

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)
	[ ! -d __pycache__ ] || rm -rf __pycache__
	rm *.swo *.swp

work:
	$(PELICAN) --autoreload --listen

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

upload: publish
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --no-delete-removed --guess-mime-type
	s3cmd sync spd_force/ s3://$(S3_BUCKET)/spd_force/ --acl-public --no-delete-removed --guess-mime-type


.PHONY: help clean work publish upload
