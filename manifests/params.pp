class elrepo::params {
  $proxy = absent
  $ensure = present
  $version = $::operatingsystemmajrelease
  $gpgcheck = 1
  $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-elrepo.org'
  $enabled= 1
  $enabled_testing = 0
  $enabled_kernel = 0
  $enabled_extras = 0

  unless $::osfamily == 'RedHat' or $::operatingsystem != 'Fedora' {
    fail("Unsupported OS: ${::operatingsystem}")
  }
}
