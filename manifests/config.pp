# Class to configure timezone.
#
# Dont include this class directly.
#
class timezone::config {
  case $::osfamily {
    'debian': {
      file { '/etc/timezone':
        content => inline_template('<%= @zone + "\n" %>'),
        require => Package['tzdata'],
      }

      exec { 'reconfigure-tzdata':
        command     => '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata',
        subscribe   => File['/etc/timezone'],
        refreshonly => true,
      }
    }
    'redhat': {
      file { '/etc/localtime':
        ensure  => 'present',
        target  => "/usr/share/zoneinfo/${::timezone::default_timezone}",
        require => Package['tzdata'],
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}