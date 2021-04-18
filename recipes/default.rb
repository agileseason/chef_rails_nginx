#
# Cookbook Name:: chef_rails_nginx
# Recipe:: default
#
# Copyright 2017, Alexander Kalinichev
#
# All rights reserved - Do Not Redistribute
#

config = node['chef_rails_nginx']

node.override['nginx']['worker_connections'] = config['nginx']['worker_connections']
node.override['nginx']['worker_rlimit_nofile'] = config['nginx']['worker_rlimit_nofile']

raise "node['chef_rails_nginx']['servers'] is empty" if config['servers'].empty?

include_recipe 'chef_nginx::source'
include_recipe 'chef_rails_nginx::upload_ssl_files' # must be before ssl_dhparam

unless config['ssl_files']['ssl_dhparam']
  include_recipe 'chef_rails_nginx::ssl_dhparam'
end
include_recipe 'chef_rails_nginx::basic_auth' if config['basic_auth']['enabled']

if config['letsencrypt']['enabled']
  include_recipe 'chef_rails_nginx::letsencrypt'
end

include_recipe 'chef_rails_nginx::servers'
