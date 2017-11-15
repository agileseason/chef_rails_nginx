#
# Cookbook Name:: chef_rails_nginx
# Recipe:: default
#
# Copyright 2017, Alexander Kalinichev
#
# All rights reserved - Do Not Redistribute
#

app = AppHelpers.new node['app']
config = node['chef_rails_nginx']

# include_recipe 'chef_rails_nginx::upload_ssl_files'
include_recipe 'chef_nginx::source'

# always create default server config
template '/etc/nginx/sites-available/default_server' do
  source 'nginx_default_server.erb'
  notifies :reload, 'service[nginx]'
end

config_name = "#{app.name}_#{app.env}"
upstream_name = "#{app.name}_#{app.env}"

unless config['ssl_mode'] == 'http_only'
  bash 'Generate DH parameters' do
    not_if { File.exists? "/etc/ssl/#{@app_name}.dhparam.pem" }
    code <<-CODE
      openssl dhparam -out /etc/ssl/#{@app_name}.dhparam.pem 2048
    CODE
  end
end

template "/etc/nginx/sites-available/#{config_name}" do
  source 'nginx_server.erb'

  variables(
    upstream_name: upstream_name,
    domains: config['domains'],
    app_name: app.name,
    app_root: app.dir(:root),
    app_shared: app.dir(:shared),
    app_cache: app.dir(:nginx_cache),
    ssl_files: config['ssl_files'],
    is_cache_enabled: config['cache_enabled'],
    is_http_only: (config['ssl_mode'] == 'http_only'),
    is_https_only: (config['ssl_mode'] == 'https_only'),
    is_ssl_password: (config['ssl_files'] && config['ssl_files']['ssl_password_file']),
    is_www_redirect: config['www_redirect'],
    www_redirect_from: (config['www_redirect']['from'] if config['www_redirect']),
    www_redirect_to: (config['www_redirect']['to'] if config['www_redirect'])
  )

  notifies :reload, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default_server' do
  to '/etc/nginx/sites-available/default_server'
end

link "/etc/nginx/sites-enabled/#{config_name}" do
  to "/etc/nginx/sites-available/#{config_name}"
end
