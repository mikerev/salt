tevatron:
  group:
    - present
  user: 
    - present

python-pip:
  pkg.installed

sopel-clone:
  git.latest:
    - name: git://github.com/sopel-irc/sopel.git
    - target: /home/tevatron/sopel
    - user: tevatron
    - branch: master
    - force_reset: True

tevatron-files:
  git.latest:
    - name: git@github.com:mikerev/tevatron.git
    - target: /home/tevatron/custom_modules
    - user: tevatron
    - branch: master
    - force_reset: True

/home/tevatron/.sopel:
  file.directory:
    - user: tevatron
    - recurse:
      - user

/home/tevatron/.sopel/default.cfg: 
  file.managed: 
    - user: tevatron 
    - mode: 0644 
    - source: salt://tevatron/default.cfg
    - template: jinja

/etc/systemd/system/tevatron.service:
  file.managed:
    - user: tevatron
    - mode: 0644
    - source: salt://tevatron/tevatron.service

bounce-tevatron-on-sopel-pull:
  cmd.run:
    - name: 'systemctl restart tevatron.service'
    - cwd: /home/tevatron/sopel
    - onchanges:
        - git: sopel-clone
        - git: tevatron-files

/home/tevatron/custom_modules:
  file.directory:
    - user: tevatron
    - group: tevatron
    - recurse: 
      - user
      - group

/home/tevatron/sopel/custom_modules:
  file.symlink:
    - target: /home/tevatron/custom_modules

tevatron.service:
  service.running:
    - watch: 
      - git: tevatron-files
      - git: sopel-clone 
