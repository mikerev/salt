/data/hgapp:
  file.directory:
    - group: www-data
    - makedirs: True

/etc/init/hgapp.conf:
  file.managed:
    - source: salt://app/conf.d/hgapp.conf
    - template: jinja

build-essential:
  pkg:
    - installed

memcached:
  pkg:
    - installed

imagemagick:
  pkg:
    - installed

prime-node:
  cmd.run:
    - name: "curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -"
    - cwd: /

nodejs:
  pkg:
    - installed
  require:
    - cmd: prime-node

run-install-n:
  cmd.run:
    - name: 'npm install n -g'
    - cwd: /

set_node_version:
  cmd.run:
    - name: 'n 4.3.1'
    - cwd: /

install_watchr:
  cmd.run:
    - name: 'npm install watchr'
    - cwd: /data/hgapp
