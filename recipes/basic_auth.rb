app = AppHelpers.new node['app']
config = node['chef_rails_nginx']['basic_auth']

fail "login is not set" if config['login'].nil?
fail "password is not set" if config['password'].nil?

package 'apache2-utils'

execute 'htpasswd' do
  sensitive true
  command "htpasswd -c -b #{config['file']} #{config['login']} #{config['password']}"
  # always overewrite file becase we have no methods to check
  # whether password was changed or not
  # not_if { File.exist? config['file'] }
end
