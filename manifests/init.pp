# Class elrepo
#
# This class imports public GPG signing keys and configures
# ELRepo Yum repository for Red Hat like systems.
#
# Parameters:
#   ['ensure']           - present (default) / absent
#   ['version']          - distribution major version
#   ['proxy']            - HTTP proxy: absent (default) or URL
#   ['gpgcheck']         - Check signatures: 1 (default) / 0
#   ['gpgkey']           - GPG key path
#   ['enabled']          - enable ELRepo: 1 (default) / 0
#   ['enabled_testing']  - enable ELRepo testing: 1 / 0 (default)
#   ['enabled_kernel']   - enable ELRepo kernel: 1 / 0 (default)
#   ['enabled_extras']   - enable ELRepo extras: 1 / 0 (default)
#
# Requires:
#   You should be on RHEL variant (CentOS, RHEL, Scientific etc.)
#
# Sample Usage:
#   include elrepo
#
class elrepo (
  $ensure          = $elrepo::params::ensure,
  $version         = $elrepo::params::version,
  $proxy           = $elrepo::params::proxy,
  $gpgcheck        = $elrepo::params::gpgcheck,
  $gpgkey          = $elrepo::params::gpgkey,
  $enabled         = $elrepo::params::enabled,
  $enabled_testing = $elrepo::params::enabled_testing,
  $enabled_kernel  = $elrepo::params::enabled_kernel,
  $enabled_extras  = $elrepo::params::enabled_extras
) inherits elrepo::params {

  yum::gpgkey { $gpgkey:
    ensure  => $ensure,
    source  => 'puppet:///modules/elrepo/RPM-GPG-KEY-elrepo.org',
  }

  Yumrepo {
    proxy     => $proxy,
    gpgcheck  => $gpgcheck,
    gpgkey    => "file://${gpgkey}",
    require   => Yum::Gpgkey[$gpgkey],
  }

  yumrepo { 'elrepo':
    enabled    => $enabled,
    descr      => "ELRepo.org Community Enterprise Linux Repository - el${version}",
    baseurl    => "http://elrepo.org/linux/elrepo/el${version}/\$basearch/",
    mirrorlist => "http://elrepo.org/mirrors-elrepo.el${version}",
    protect    => 0,
  }

  yumrepo { 'elrepo-testing':
    enabled    => $enabled_testing,
    descr      => "ELRepo.org Community Enterprise Linux Testing Repository - el${version}",
    baseurl    => "http://elrepo.org/linux/testing/el${version}/\$basearch/",
    mirrorlist => "http://elrepo.org/mirrors-elrepo-testing.el${version}",
    protect    => 0,
  }

  yumrepo { 'elrepo-kernel':
    enabled    => $enabled_kernel,
    descr      => "ELRepo.org Community Enterprise Linux Kernel Repository - el${version}",
    baseurl    => "http://elrepo.org/linux/kernel/el${version}/\$basearch/",
    mirrorlist => "http://elrepo.org/mirrors-elrepo-kernel.el${version}",
    protect    => 0,
  }

  yumrepo { 'elrepo-extras':
    enabled    => $enabled_extras,
    descr      => "ELRepo.org Community Enterprise Linux Extras Repository - el${version}",
    baseurl    => "http://elrepo.org/linux/extras/el${version}/\$basearch/",
    mirrorlist => "http://elrepo.org/mirrors-elrepo-extras.el${version}",
    protect    => 0;
  }
}
