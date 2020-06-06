
# apindex - static file index generator/load reducer

__Generate a file index for GitHub/GitLab Pages__
  
![enter image description here](https://i.imgur.com/m8aXfGu.png)
  

### Quick install

```sh

curl https://raw.githubusercontent.com/jayanta525/apindex/master/install.sh | bash

```

  

### What is this?

This is a program that generates `index.html` files in each directory on your server that render the file tree. This is useful for static web servers that need support for file listing. One example of this is Github Pages.

  

It can also be used to reduce the server load for servers that serve static content, as the server does not need to generate the index each time it is accessed. Basically permanent cache.

  

The file icons are also embedded into the `index.html` file so there is no need for aditional HTTP requests.

### CI/CD Pipeline

The install script can be used with CI/CD with the required dependencies.


Check it out here: [gitlab-ci.yml](https://gitlab.com/jayanta525/openwrt-sunxi/-/blob/master/.gitlab-ci.yml)

    image: ubuntu:bionic
    pages:
     script:
     - rm -rf .git*
     - apt-get update
     - apt-get install curl git -y
     - curl https://raw.githubusercontent.com/jayanta525/apindex/master/install.sh | bash
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

This openwrt kmod download archive is hosted on GitLab Pages and its generated with apindex.

Check it out: [https://jayanta525.gitlab.io/openwrt-sunxi/](https://jayanta525.gitlab.io/openwrt-sunxi/)

  

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
