chef_rails_nginx CHANGELOG
======================

0.6.1
-----
- Upgrade SSL options to support TLSv1.3, disable very old configuration https://ssl-config.mozilla.org/

0.6.0
-----
- Upgrade to `1.26.2` nginx

0.5.5
-----
- Add `http2_max_concurrent_streams` directive

0.5.4
-----
- Add `upstream_socket_name` option

0.5.3
-----
- Add `node['chef_rails_nginx']['disable_logs']` option to disable nginx logs

0.5.2
-----
- Remove letsencrypt nginx config after letsencrypt setup is complete

0.5.1
-----
- Update nginx to 1.25.4

0.5.0
-----
- Update nginx to 1.25.3

0.4.3
-----
- Add `config_app` option

0.4.2
-----
- Add `config_pre` option

0.4.1
-----
- Add letsencrypt location rule to https server

0.4.0
-----
- Update nginx to 1.21.4

0.3.17
-----
- Fix duplicate location "/" error when `basic_auth` and `upstream` are enabled #1

0.3.16
-----
- Update nginx to 1.19.10

0.3.15
-----
- Fix override of worker_connections and worker_rlimit_nofile that does not work in some cases.

0.3.14
-----
- Add http_config to server option

0.3.13
-----
- Add webp image format

0.3.13
-----
- Add webp image format

0.3.12
-----
- Update nginx to 1.17.9

0.3.11
-----
- Add `node['chef_rails_nginx']['letsencrypt']['renew']` param to configure renewal interval in days.

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
