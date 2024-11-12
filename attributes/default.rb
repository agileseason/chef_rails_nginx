default['chef_rails_nginx']['letsencrypt']['enabled'] = false
default['chef_rails_nginx']['letsencrypt']['site_name'] = nil
default['chef_rails_nginx']['letsencrypt']['contact'] = nil
default['chef_rails_nginx']['letsencrypt']['renew'] = 45
default['chef_rails_nginx']['letsencrypt']['domains'] = []

default['chef_rails_nginx']['basic_auth']['enabled'] = false
default['chef_rails_nginx']['basic_auth']['login'] = nil
default['chef_rails_nginx']['basic_auth']['password'] = nil
default['chef_rails_nginx']['basic_auth']['location'] = '/'
default['chef_rails_nginx']['basic_auth']['file'] =
  '/etc/nginx/conf.d/.htpasswd'

default['chef_rails_nginx']['ssl_files'] = {}
default['chef_rails_nginx']['ssl_files']['ssl_dhparam'] = nil
default['chef_rails_nginx']['ssl_files']['ssl_password_file'] = nil
default['chef_rails_nginx']['ssl_files']['ssl_certificate'] = nil
default['chef_rails_nginx']['ssl_files']['ssl_certificate_key'] = nil

default['chef_rails_nginx']['custom_config_section'] = nil

default['chef_rails_nginx']['servers'] = {}

default['chef_rails_nginx']['nginx']['worker_connections'] = 16_384
default['chef_rails_nginx']['nginx']['worker_rlimit_nofile'] = 30_000

default['chef_rails_nginx']['nginx']['http2_max_concurrent_streams'] = nil

# default['chef_rails_nginx']['servers']['default'] = {
#   name: 'default',
#   config: <<-CONFIG
#     # for requests without Host header
#     # http://nginx.org/en/docs/http/request_processing.html
#     server {
#       listen 80 default_server;
#       server_name "";
#       return 444;
#     }
#   CONFIG
# }
