# Class to manage timezone parameters.
#
# Dont include this class directly.
#
class timezone::params {
  $default_timezone = 'UTC'
  $package_name = 'tzdata'
  $package_version = 'present'
}
