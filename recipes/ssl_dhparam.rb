app = AppHelpers.new node['app']

dhparam_file = "/etc/ssl/#{app.name}.dhparam.pem"

node.override['chef_rails_nginx']['ssl_files']['ssl_dhparam'] = dhparam_file

bash 'Generate DH parameters' do
  not_if { File.exist? dhparam_file }
  code <<-CODE
    openssl dhparam -out #{dhparam_file} 2048
  CODE
end
