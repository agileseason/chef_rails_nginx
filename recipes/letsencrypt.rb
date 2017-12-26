app = AppHelpers.new node['app']
config = node['chef_rails_nginx']['letsencrypt']

fail "site_name is not set" if config['site_name'].nil?
fail "contact is not set" if config['contact'].nil?
fail "domains is not set" if config['domains'].nil? || config['domains'].none?

template '/etc/nginx/sites-available/letsencrypt_server' do
  source 'letsencrypt_server.erb'
  variables domains: config['domains']
  notifies :reload, 'service[nginx]'
end
link "/etc/nginx/sites-enabled/letsencrypt_server" do
  to "/etc/nginx/sites-available/letsencrypt_server"
end

node.override['acme']['contact'] = config['contact']

include_recipe 'acme::default'

acme_certificate config['site_name'] do
  # crt      "/etc/ssl/#{config['site_name']}.crt"
  key      "/etc/ssl/#{config['site_name']}.key"
  chain    "/etc/ssl/#{config['site_name']}.chain.pem"
  fullchain "/etc/ssl/#{config['site_name']}.fullchain.pem"

  wwwroot  '/var/www/letsencrypt'
  alt_names config['domains']
end
