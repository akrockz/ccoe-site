# CCoE Site

## Introduction

The starter site for the CCoE team.

Currently a static "one pager", we can expand this later.

Maybe it becomes the portal?

## Requirements

* Install Hugo locally. https://gohugo.io/getting-started/installing/
	* Works well with Win10/WSL! (`sudo apt-get install hugo`)

## Local Hugo Development

From ccoe-site/site, you can run a hugo server (that includes drafts, if you use them):

```
# Default livereloading hugo server
hugo server

# Include drafts
hugo server -D
```

## Testing the release build outside ABC network

Assuming you have a jump host into ABC AWS (nonprod or prod),

1) Setup your hosts file:

```
127.0.0.1 cloud.ab.com
```

2) Open a SSH tunnel to local port 9000. I use a bash alias to make this easy (`~/.bashrc`):

```
# nonprod-auto release cname
alias tunnel-nonprod-ccoe-site='ssh -nN -L 9000:web.nonprod.site.ccoe.sin.auto.nonprod.c0.ab.com:80 nonprod-bastion'
```

3) Open your browser and visit http://cloud.ab.com:9000
 
 
 
 
