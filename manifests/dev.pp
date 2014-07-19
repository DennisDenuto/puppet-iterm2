# Public: Installs iTerm2 beta
#
# Usage:
#
#   include iterm2::dev
#   class { 'iterm2::dev':
#     version => '20140421'
#   }
class iterm2::dev($version = '20140421') {
  package { 'iTerm':
    source   => "http://www.iterm2.com/downloads/beta/iTerm2-1_0_0_${version}.zip",
    provider => 'compressed_app'
  }

  file { "plist":
    path    => "/Users/${::boxen_user}/Library/Preferences/com.googlecode.iterm2.plist",
    source  => 'puppet:///modules/iterm2/com.googlecode.iterm2.plist',
    mode    => '0755',
    force   => true,
    require => Package['iTerm']
  }

  exec { "sync-iterm-settings":
    command => "defaults read com.googlecode.iterm2",
    path    => "/usr/local/bin/:/bin/",
    require => File['plist']
}


}
