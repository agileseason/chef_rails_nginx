app = AppHelpers.new node['app']
config = node['chef_rails_nginx']['basic_auth']

fail "login is not set" if config['login'].nil?
fail "password is not set" if config['password'].nil?

htpasswd '/etc/nginx/conf.d/.htpasswd' do
  user config['login']
  password config['password']
  type 'sha1'
end
