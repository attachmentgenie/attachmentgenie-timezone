# Class to install and configure timezone.
#
# Use this module to install and configure timezone.
#
# @example Declaring the class
#   include ::timezone
#
# @param default_timezone Timezone for this node.
# @param package_name Name of package to install.
# @param package_version Version of tzdata to install.
class timezone (
  String $default_timezone = $::timezone::params::default_timezone,
  String $package_name = $::timezone::params::package_name,
  String $package_version = $::timezone::params::package_version,
) inherits timezone::params {
  anchor { 'timezone::begin': }
  -> class{ '::timezone::install': }
  -> class{ '::timezone::config': }
  -> anchor { 'timezone::end': }
}
