# Ruby bindings to bsdiff and bspatch


## Installation

```bash
gem install 'rb-bsdiff'
```

Or via Gemfile:

```ruby
gem 'rb-bsdiff'
```

As this uses native-code extensions you will of course require a working build
toolchain.  Additionally, you will need the BZip2 libraries to be present on
your system.  On OSX they should already be present.  On Linux, you may need to
install relevant packages, for example:

```bash
sudo apt-get install libbz2-1.0 libbz2-dev
```

See http://bzip.org/ for more information.


## Usage

```ruby
  # Generate a patch from ext/b0 to ext/b1 as p0.
  BSDiff.diff('ext/b0', 'ext/b1', 'p0')

  # apply patch p0 to ext/b0 and produce output as b3.  b3 should be
  # identical to ext/b1.
  BSDiff.patch('ext/b0', 'b3', 'p0')
```


## Caveats

As the underlying code only works with files, so does this API.  Pass in only
filenames for parameters.


## License

* bsdiff is produced under the [Simplified BSD License](http://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29)
* The original version of this gem, by Todd Fisher is under the [4-Clause BSD License](http://en.wikipedia.org/wiki/BSD_licenses#4-clause_license_.28original_.22BSD_License.22.29)
* Cloudability's contributions to this project are made available under the [Simplified BSD License](http://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29).
