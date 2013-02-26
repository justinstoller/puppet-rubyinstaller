define rubyinstaller::installation(
  $version     = $title,
  $source      =  undef,
  $destination = 'C:\packages'
) {

  if $source {
    $location = $source

  } else {
    if $version =~ /19/ {
      $pkg_name = "ruby-1.9.3-p374-i386-mingw32.7z"
      $install_dir = 'C:\Ruby193'
    } elsif $version =~ /18/ {
      $pkg_name = "ruby-1.8.7-p371-i386-mingw32.7z"
      $install_dir = 'C:\Ruby187'
    }
    $location = "puppet:///modules/rubyinstaller/${pkg_name}"
  }

  $on_disk = "${destination}\\${pkg_name}"

  file { $on_disk:
    ensure => file,
    source => $location,
    mode   => '750',
  }

  exec { "Extract Ruby ${version}":
    command => "7za x -o${install_dir} ${on_disk}",
    creates => $install_dir,
    path    => 'C:\Chocolatey\bin',
  }
}
