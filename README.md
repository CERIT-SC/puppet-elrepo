# Puppet ELRepo module

This module adds ELRepo Yum repository.

### Requirements

Module has been tested on:

* Puppet 3.0
* CentOS 6.3
* Puppet Yum module (https://github.com/CERIT-SC/puppet-yum)

# Quick Start

Add repository

```puppet
include elrepo
```

Full configuration options:

```puppet
class { 'elrepo':
  ensure          => present|absent,  # ensure state
  version         => 6,               # system major release
  proxy           => absent|'...',    # URL or absent
  gpgcheck        => 1|0,             # check GPG signatures
  gpgkey          => '...',           # local path to GPG key
  enabled         => 1|0,             # enabled main repository
  enabled_testing => 1|0,             # enabled testing repo.
  enabled_kernel  => 1|0,             # enabled kernel repo.
  enabled_extras  => 1|0,             # enabled extras repo.
}
```

***

CERIT Scientific Cloud, <support@cerit-sc.cz>
