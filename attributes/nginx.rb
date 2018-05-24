# version = '1.10.1'
# checksum = '1fd35846566485e03c0e318989561c135c598323ff349c503a6c14826487a801'

# version = '1.10.3'
# checksum = '75020f1364cac459cb733c4e1caed2d00376e40ea05588fb8793076a4c69dd90'

version = '1.14.0'
# curl -L -s http://nginx.org/download/nginx-<version>.tar.gz | shasum -a 256
checksum = '5d15becbf69aba1fe33f8d416d97edd95ea8919ea9ac519eff9bafebb6022cb5'

override['nginx']['version'] = version
override['nginx']['dir'] = '/etc/nginx'
override['nginx']['log_dir'] = '/var/log/nginx'
override['nginx']['init_style'] = 'systemd'
override['nginx']['default_site_enabled'] = false

# NOTE: override all source attributes using version
override['nginx']['source']['version'] = version
override['nginx']['source']['prefix'] = "/opt/nginx-#{version}"
override['nginx']['source']['sbin_path'] =
  "#{node['nginx']['source']['prefix']}/sbin/nginx"
override['nginx']['source']['url'] =
  "http://nginx.org/download/nginx-#{version}.tar.gz"

override['nginx']['source']['checksum'] = checksum
override['nginx']['source']['modules'] = %w[
  chef_nginx::http_stub_status_module
  chef_nginx::http_ssl_module
  chef_nginx::http_v2_module
  chef_nginx::http_gzip_static_module
]

override['nginx']['source']['default_configure_flags'] = %W[
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
]
