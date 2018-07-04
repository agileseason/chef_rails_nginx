app = AppHelpers.new node['app']
config = node['chef_rails_nginx']['basic_auth']

if config['login'].nil?
  raise "node['chef_rails_nginx']['basic_auth']['login'] is not set"
end
if config['password'].nil?
  raise "node['chef_rails_nginx']['basic_auth']['password'] is not set"
end

package 'apache2-utils'

execute 'htpasswd' do
  sensitive true
  command(
    "htpasswd -c -b #{config['file']} #{config['login']} #{config['password']}"
  )
  # always overewrite file becase we have no methods to check
  # whether password was changed or not
  # not_if { File.exist? config['file'] }
end
