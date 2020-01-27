chef_rails_nginx CHANGELOG
======================

0.3.11
-----
- Add `['chef_rails_nginx']['letsencrypt']['renew']` param to configure renewal interval in days.

0.3.10
-----
- Do not add `server_name` line when domains are nil

0.3.9
-----
- Fix duplication of upstream names

0.3.8
-----
- Update nginx to 1.17.0

0.3.7
-----
- Add "proxied" log format, allow to specify log_format for access_log

0.3.6
-----
- Added woff2 format to rule for static files.

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
