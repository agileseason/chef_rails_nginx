app = AppHelpers.new node['app']
config = node['chef_rails_nginx']['letsencrypt']

if config['site_name'].nil?
  raise "node['chef_rails_nginx']['letsencrypt']['site_name'] is not set"
end
if config['contact'].nil?
  raise "node['chef_rails_nginx']['letsencrypt']['contact'] is not set"
end
if config['domains'].nil? || config['domains'].none?
  raise "node['chef_rails_nginx']['letsencrypt']['domains'] is not set"
end

node.override['chef_rails_nginx']['ssl_files']['ssl_certificate_key'] =
  "/etc/ssl/#{app.name}.key"
node.override['chef_rails_nginx']['ssl_files']['ssl_certificate_chain'] =
  "/etc/ssl/#{app.name}.chain.pem"
node.override['chef_rails_nginx']['ssl_files']['ssl_certificate'] =
  "/etc/ssl/#{app.name}.fullchain.pem"

ssl_files = node['chef_rails_nginx']['ssl_files']

template '/etc/nginx/sites-available/letsencrypt_server' do
  source 'letsencrypt_server.erb'
  variables domains: config['domains']
  notifies :reload, 'service[nginx]'
end
link '/etc/nginx/sites-enabled/letsencrypt_server' do
  to '/etc/nginx/sites-available/letsencrypt_server'
end

node.override['acme']['contact'] = config['contact']
node.override['acme']['renew'] = config['renew']

include_recipe 'acme::default'

acme_certificate config['site_name'] do
  # crt      "/etc/ssl/#{app.name}.crt"
  key      ssl_files['ssl_certificate_key']
  chain    ssl_files['ssl_certificate_chain']
  fullchain ssl_files['ssl_certificate']

  wwwroot '/var/www/letsencrypt'
  alt_names config['domains']

  notifies :restart, 'service[nginx]', :immediate
end

file '/etc/nginx/sites-available/letsencrypt_server' do
  action :delete
  only_if { File.exist? '/etc/nginx/sites-available/letsencrypt_server' }
  notifies :reload, 'service[nginx]'
end

file '/etc/nginx/sites-enabled/letsencrypt_server' do
  action :delete
  only_if { File.exist? '/etc/nginx/sites-enabled/letsencrypt_server' }
  notifies :reload, 'service[nginx]'
end
