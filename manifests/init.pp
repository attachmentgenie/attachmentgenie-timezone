class timezone(
  String $zone='UTC',
  Enum ['present','absent'] $ensure='present',
) {
  case $::osfamily {
    'debian': {
      $tzdata_package_name = 'tzdata'
      exec { 'reconfigure-tzdata':
        command     => '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata',
        subscribe   => File['/etc/timezone'],
        require     => File['/etc/timezone'],
        refreshonly => true,
      }
    }
    'redhat': {
      $tzdata_package_name = 'tzdata'
      file { '/etc/localtime':
        ensure  => 'present',
        target  => "/usr/share/zoneinfo/${zone}",
        require => Package[$tzdata_package_name],
      }
    }
    'gentoo': {
      $tzdata_package_name = 'sys-libs/timezone-data'
      exec { 'reconfigure-timezone':
        command     => '/usr/bin/emerge --config timezone-data',
        subscribe   => File['/etc/timezone'],
        require     => File['/etc/timezone'],
        refreshonly => true,
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
  package { $tzdata_package_name:
    ensure => $ensure,
  }

  file { '/etc/timezone':
    content => inline_template('<%= @zone + "\n" %>'),
    require => Package[$tzdata_package_name],
  }

}
