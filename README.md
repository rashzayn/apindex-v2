
# apindex - static file index generator/load reducer

__Generate a file index for GitHub/GitLab Pages__
  
![enter image description here](https://i.imgur.com/m8aXfGu.png)
  
### Use with Github Actions

https://github.com/jayanta525/github-pages-directory-listing

workflow.yml
```
name: gh-pages
on: [push]

jobs:
  pages-directory-listing-index:
    runs-on: ubuntu-latest
    name: GH Pages Directory Listing
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Generate Directory Listings
        uses: jayanta525/github-pages-directory-listing@v2.0.0
        with:
          FOLDER: data

      - name: Deploy to Pages
        uses: JamesIves/github-pages-deploy-action@4.1.3
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BRANCH: gh-pages
          FOLDER: data
```

### Quick install

```sh

curl https://raw.githubusercontent.com/jayanta525/apindex-v2/master/sudo-install.sh | bash

```

  

### What is this?

This is a program that generates `index.html` files in each directory on your server that render the file tree. This is useful for static web servers that need support for file listing. One example of this is Github Pages.

  

It can also be used to reduce the server load for servers that serve static content, as the server does not need to generate the index each time it is accessed. Basically permanent cache.

  

The file icons are also embedded into the `index.html` file so there is no need for aditional HTTP requests.

### CI/CD Pipeline

The install script can be used with CI/CD with the required dependencies.

#### GitHub
[deploy-to-gh-pages.yml](https://github.com/jayanta525/openwrt-r4s-kmods/blob/master/.github/workflows/deploy-to-gh-pages.yml)

```
name: Build and Deploy
on:
  push:
    branches:
      - master
jobs:
  build-and-deploy:
    runs-on: ubuntu-18.04
    steps:
      - name: Checkout 🛎️
        uses: actions/checkout@v2.3.1
        with:
          persist-credentials: false 

      - name: Install and Build 🔧
        run: |
          sudo apt-get update
          sudo apt-get install curl git -y
          curl https://raw.githubusercontent.com/jayanta525/apindex-v2/master/sudo-install.sh | bash
          apindex .
      - name: Deploy 🚀
        uses: JamesIves/github-pages-deploy-action@4.1.3
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BRANCH: gh-pages
          FOLDER: .
```

#### Gitlab
[gitlab-ci.yml](https://gitlab.com/jayanta525/openwrt-sunxi/-/blob/master/.gitlab-ci.yml)

    image: ubuntu:bionic
    pages:
     script:
     - rm -rf .git*
     - apt-get update
     - apt-get install curl git -y
     - curl https://raw.githubusercontent.com/jayanta525/apindex-v2/master/sudo-install.sh | bash
     - apindex .
     - mkdir .public
     - cp -r * .public
     - mv .public public
     artifacts:
     paths:
     - public
     only:
     - master

### Demo

This openwrt kmod download archive is hosted on GitHub/ GitLab Pages and its generated with apindex.

- [https://jayanta525.github.io/openwrt-r4s-kmods/](https://jayanta525.github.io/openwrt-r4s-kmods/)
- [https://jayanta525.gitlab.io/openwrt-rockpie/armv8/](https://jayanta525.gitlab.io/openwrt-rockpie/armv8/)

  

### How do I use it?

Just run:

```
apindex <path-to-directory>
```

The index header server path is based on your current working directory. So if you run the script from `/home/parent` on the directory `/home/parent/child` like this:

```
cd /home/parent

apindex child/.
```

The index is generated as __Index of /child__.

If you want it to be absolute to the child directory, then you run apindex from there.

```
cd /home/parent/child

apindex .
```

This renders __Index of /__.


### How do I add/remove icons?

See `share/icons.xml` and the files under `share/img/*`.
