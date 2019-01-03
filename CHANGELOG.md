chef_rails_nginx CHANGELOG
======================

0.3.5
-----
- Allow to override node['nginx']['worker_connections'] and node['nginx']['worker_rlimit_nofile'].

0.3.4
-----
- Add disable_https option.

0.3.3
-----
- Add nginx restart after acme_certificate installation.

0.3.1
-----
- Add "allow_http" option.

0.3.0
-----
- Comple overhaul of cookbook. Add support for multiple nginx servers.
