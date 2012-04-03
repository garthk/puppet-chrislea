Puppet module for [Chris Lea packages for Ubuntu], e.g. [node.js] and [zeromq]. 

Inspired by [niallo]. 

## Testing:

Either:

* `make test` to perform a simple [smoke test]; or
* `make vm` to create the [Vagrant] virtual machine and install Node.js.

I use the latter for my own testing.

## Usage:

* `apt-get update` if you have a fresh Ubuntu install, just in case
* `cd /etc/puppet/modules`
* `git clone git://github.com/garthk/puppet-chrislea`
* `ln -s puppet-chrislea chris`
* Use `chris::lea::nodejs` and other classes as below
* Use `chris::lea::repo` to define your own classes as below

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
* Added Vagrantfile and Makefile

[Chris Lea packages for Ubuntu]: https://launchpad.net/~chris-lea
[node.js]: https://launchpad.net/~chris-lea/+archive/node.js
[zeromq]: https://launchpad.net/~chris-lea/+archive/zeromq
[niallo]: https://gist.github.com/2003430
[Vagrant]: http://vagrantup.com/
[smoke test]: http://docs.puppetlabs.com/guides/tests_smoke.html
