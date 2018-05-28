app = AppHelpers.new node['app']
basic_auth = node['chef_rails_nginx']['basic_auth']

node['chef_rails_nginx']['servers'].each do |_, config|
  config_name = config['name'] || "#{app.name}_#{app.env}"
  www_redirect = config['www_redirect']

  template "/etc/nginx/sites-available/#{config_name}" do
    source 'nginx_custom.erb'

    variables(
      domains: config['domains'],
      ssl_files: node['chef_rails_nginx']['ssl_files'],
      config: config['config'],

      upstream: config['upstream'],

      app_cache_dir: (app.dir(:nginx_cache) if config['upstream']),
      app_shared_dir: (app.dir(:shared) if config['upstream']),
      app_root_dir: (app.dir(:root) if config['upstream']),

      page_404: config['page_404'],
      page_50x: config['page_50x'],

      cache_enabled: config['cache_enabled'],

      basic_auth_location: (basic_auth['location'] if basic_auth['enabled']),
      basic_auth_file: (basic_auth['file'] if basic_auth['enabled']),

      www_redirect_from: (www_redirect['from'] if www_redirect),
      www_redirect_to: (www_redirect['to'] if www_redirect)
    )

    notifies :reload, 'service[nginx]'
  end

  link "/etc/nginx/sites-enabled/#{config_name}" do
    to "/etc/nginx/sites-available/#{config_name}"
  end
end
