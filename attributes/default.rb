default['chef_rails_nginx']['domains'] = []
default['chef_rails_nginx']['cache_enabled'] = true
default['chef_rails_nginx']['ssl_mode'] = 'http_only'
default['chef_rails_nginx']['ssl_files'] = {}
default['chef_rails_nginx']['www_redirect'] = nil

default['chef_rails_nginx']['page_404'] = true
default['chef_rails_nginx']['page_50x'] = true

default['chef_rails_nginx']['letsencrypt']['enabled'] = false
default['chef_rails_nginx']['letsencrypt']['site_name'] = nil
default['chef_rails_nginx']['letsencrypt']['contact'] = nil
default['chef_rails_nginx']['letsencrypt']['domains'] = []

default['chef_rails_nginx']['basic_auth']['enabled'] = false
default['chef_rails_nginx']['basic_auth']['login'] = nil
default['chef_rails_nginx']['basic_auth']['password'] = nil
default['chef_rails_nginx']['basic_auth']['location'] = '/'
default['chef_rails_nginx']['basic_auth']['file'] =
  '/etc/nginx/conf.d/.htpasswd'

default['chef_rails_nginx']['custom_config_section'] = nil
