name             'chef_rails_nginx'
maintainer       'Andrey Sidorov'
maintainer_email 'takandar@gmail.com'
license          'MIT'
description      'Installs/Configures chef_rails_nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.3'

depends 'chef_nginx'
depends 'acme'
