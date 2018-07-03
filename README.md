chef_rails_nginx Cookbook
=====================
Installs nginx servers.

Requirements
------------

The dependencies are assumed to be downloaded from the [Chef Supermarket](https://supermarket.chef.io/) cookbook repository.

* [chef_nginx](https://supermarket.chef.io/cookbooks/chef_nginx/) cookbook
* [acme](https://supermarket.chef.io/cookbooks/acme/) cookbook

Attributes Defaults
-------------------

```ruby
node['chef_rails_nginx']['letsencrypt']['enabled'] = false
node['chef_rails_nginx']['letsencrypt']['site_name'] = nil
node['chef_rails_nginx']['letsencrypt']['contact'] = nil
node['chef_rails_nginx']['letsencrypt']['domains'] = []

node['chef_rails_nginx']['basic_auth']['enabled'] = false
node['chef_rails_nginx']['basic_auth']['login'] = nil
node['chef_rails_nginx']['basic_auth']['password'] = nil
node['chef_rails_nginx']['basic_auth']['location'] = '/'
node['chef_rails_nginx']['basic_auth']['file'] = '/etc/nginx/conf.d/.htpasswd'

node['chef_rails_nginx']['servers'] = {}
```

Usage
-----

Override described above attributes and include default recipe.

```ruby
include_recipe 'chef_rails_nginx::default'
```

Example 1
---------

```ruby
# config for rails with unicorn upstream support
node.override['chef_rails_nginx']['servers']['shikimori'] = {
  domains: %w[
    shikimori.org
    www.shikimori.org
    play.shikimori.org
  ],
  upstream: 'unicorn',
  config: <<-CONFIG
    location ~* /(faye-server-v3|faye-server-v4|faye-server-v5|camo)$ {
      access_log off;
      error_log /dev/null;
      deny  all;
    }
  CONFIG
}

# config for static server with http support
node.override['chef_rails_nginx']['servers']['static'] = {
  name: 'shikimori_static',
  domains: %w[
    nyaa.shikimori.org
    kawai.shikimori.org
    moe.shikimori.org
    dere.shikimori.org
    desu.shikimori.org
  ],
  allow_http: true,
  config: <<-CONFIG
    root /home/apps/shikimori/production/current/public;
  CONFIG
}

node.override['chef_rails_nginx']['letsencrypt'] = {
  'enabled': true,
  site_name: 'shikimori.org',
  contact: 'mailto:takandar@gmail.com',
  domains: node['chef_rails_nginx']['servers']['shikimori']['domains'] +
    node['chef_rails_nginx']['servers']['static']['domains']
}

include_recipe 'chef_rails_nginx::default'
```

Example 2
---------

```ruby
node.override['chef_rails_nginx']['servers']['camo'] = {
  name: 'camo',
  domains: %w[camo.shikimori.org camo.shikimori.one],
  config: <<-CONFIG
    location / {
      access_log off;

      proxy_pass http://127.0.0.1:#{node['camo']['port']};
      proxy_http_version 1.1;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_buffering off;
      proxy_redirect off;
      proxy_connect_timeout      90;
      proxy_send_timeout         90;
      proxy_read_timeout         90;
    }
  CONFIG
}

node.override['chef_rails_nginx']['letsencrypt'] = {
  enabled: true,
  site_name: 'camo.shikimori.org',
  contact: 'mailto:takandar@gmail.com',
  domains: node['chef_rails_nginx']['servers']['camo']['domains']
}

include_recipe 'chef_rails_nginx::default'
```
