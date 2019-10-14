# keyanp.com

My personal webpage and blog. Mostly aspirational.

## Setup

```
# Install requirements
$ pip install -r requirements.txt

# Fetch submodule for theme
$ git submodule update --init --recursive`

# Setup S3 cli, use iam if new creds are needed
$ s3cmd --configure
```

## Writing/publishing content

```
# Write content in `./content`

# Generate output files and checkout changes
$ pelican content/ && make serve

# Upload to S3
$ make s3_upload
```
