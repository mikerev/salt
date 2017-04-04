/data/hgapp:
  file.directory:
    - group: gus
    - makedirs: True

git:
  pkg:
    - installed

pull-hgapp:
  git.latest:
    - name: git@github.com:HighGroundInc/hgapp.git
    - target: /data/hgapp
    - identity: /root/.ssh/id_rsa
    - rev: feature/New_Relic
    - require:
      - pkg: git

install-deps:
  cmd.run:
    - name: 'npm install'
    - cwd: /data/hgapp

#build-hgapp:
#  cmd.run:
#    - name: 'node build/watcher.js'
#    - cwd: /data/hgapp
