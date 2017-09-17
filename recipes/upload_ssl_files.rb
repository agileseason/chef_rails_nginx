app = AppHelpers.new node['app']

node['chef_rails_nginx']['ssl_files'].each do |_, ssl_file|
  mkfile ssl_file['name'] do
    source ssl_file['source']
    cookbook ssl_file['cookbook']
    owner app.user
  end
end
