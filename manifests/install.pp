# Class to install timezone.
#
# Dont include this class directly.
#
class timezone::install {
  package { 'tzdata':
    ensure => $::timezone::package_version,
    name   => $::timezone::package_name,
  }
}