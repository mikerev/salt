tevatron:
  user.present:
    - home: /home/tevatron
    - groups:
      - tevatron

python-pip:
  pkg.installed:
    - name: python-pip 

sopel-clone:
  git.latest:
    - name: git://github.com/sopel-irc/sopel.git
    - target: /home/tevatron/sopel
    - user: tevatron
    - branch: master
    - force_reset: True

install-sopel:
  cmd.run:
    - name: 'python setup.py install'
    - cwd: /home/tevatron/sopel
    - onchanges:
        - git: sopel-clone

tevatron-files:
  git.latest:
    - name: https://github.com/mikerev/tevatron.git
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
  file.symlink:
    - target: /home/tevatron/custom_modules/tevatron.service


bounce-tevatron-on-sopel-pull:
  cmd.run:
    - name: 'systemctl restart tevatron.service'
    - cwd: /home/tevatron/sopel
    - onchanges:
        - git: sopel-clone
        - git: tevatron-files
        - file: /home/tevatron/.sopel/default.cfg

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
