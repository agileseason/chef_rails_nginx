version = '1.25.4'
# curl -L -s http://nginx.org/download/nginx-<version>.tar.gz | shasum -a 256
checksum = '760729901acbaa517996e681ee6ea259032985e37c2768beef80df3a877deed9'

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

override['nginx']['log_formats']['proxied'] =
  <<-FORMAT.gsub(/^ +/, '').delete("\n")
    '$http_x_forwarded_for - $remote_user [$time_local] "$request"
    $status $body_bytes_sent "$http_referer" "$http_user_agent"'
  FORMAT
