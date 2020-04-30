#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'keyan'
SITENAME = u'keyan pishdadian'
SITEURL = ''
PATH = 'content'
TIMEZONE = 'America/Detroit'
DEFAULT_LANG = u'en'
THEME = "themes/flasky"

# Site analytics
GOOGLE_ANALYTICS_ACCOUNT = "UA-93664476-1"

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Navigation sections and relative URL:
SECTIONS = [('blog', 'index.html'),
            ('archive', 'archives.html'),
            ('about', 'pages/about-me.html')]

DEFAULT_CATEGORY = 'Uncategorized'
DATE_FORMAT = {'en': '%m %d %Y'}
DEFAULT_DATE_FORMAT = '%m %d %Y'

# Pagination settings
DEFAULT_PAGINATION = 5
DEFAULT_ORPHANS = 2

PDF_GENERATOR = False
REVERSE_CATEGORY_ORDER = True

FEED_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

OUTPUT_PATH = 'output'
# static paths will be copied under the same name
STATIC_PATHS = ["images"]

# Optional social media links
# =============================
LINKEDIN_URL = 'https://www.linkedin.com/in/keyanp'
GITHUB_URL = 'http://github.com/keyan'
MAIL_USERNAME = 'kpishdadian'
MAIL_HOST = 'gmail.com'
