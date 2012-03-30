Puppet module for [Chris Lea packages for Ubuntu]
(eg. [node.js], [zeromq]). 

Inspired by [niallo]. 

## Usage:

* `cd /etc/puppet/modules`
* `git clone git://github.com/garthk/puppet-chrislea`
* `ln -s puppet-chrislea chris`
* Use `chris::lea::nodejs` and other classes
  ([details](#installingnode.js:))
* Use `chris::lea::repo` to define your own classes
  ([details](#installingotherpackages:))

### Installing Node.js:

In your `node` definition, or whichever `class` it's including:

* `include chris::lea::nodejs`

So far, I've only defined these two classes:

* `chris::lea::nodejs`
* `chris::lea::zeromq`

### Installing Other Packages:

To add a package from a repository for which I haven't made a class:

* Use `chris::lea::repo` to add the repositories
* Declare your `package`
* Use the right `$name` between the curly bracket and the colon: this
  will be the argument to `apt-get install`
* `require` the repositories you just added

Example:

    class zeromq_development {
      chris::lea::repo { 'libpgm': }
      chris::lea::repo { 'zeromq': }
      package { 'libzmq-dev':
        ensure  => installed,
        require => [
          Chris::Lea::Repo['libpgm'],
          Chris::Lea::Repo['zeromq'],
        ],
      }
    }

To find out which repositories you need:

* Visit the archive page, e.g. [zeromq]
* Click "Technical details about this PPA"
* Look under the title "Dependencies"

## Adjustments from original:

* Fixed operation on Ubuntu with `sources.list.d` in `/etc/apt`
* Fixed operation on Ubuntu with current `add-apt-repository` entry filenames
* Broke out definition for repository
* Set `timeout=3600` for `apt-get update`, which can be slow
* Avoided `apt-get update` if it's been done once since `add-apt-repository`
* Added `g++`, `libexpat1-dev` to `nodejs`
* Broke out `zeromq` to its own class
* Packaged it all as a Puppet module

[Chris Lea packages for Ubuntu]: https://launchpad.net/~chris-lea
[node.js]: https://launchpad.net/~chris-lea/+archive/node.js
[zeromq]: https://launchpad.net/~chris-lea/+archive/zeromq
[niallo]: https://gist.github.com/2003430
