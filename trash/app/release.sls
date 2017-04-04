/data/scapp:
  file.directory:
    - group: gus
    - makedirs: True

git:
  pkg:
    - installed

pull-scapp:
  git.latest:
    - name: git@github.com:SomeClownsInc/scapp.git
    - target: /data/scapp
    - identity: /root/.ssh/id_rsa
    - rev: feature/New_Relic
    - require:
      - pkg: git

install-deps:
  cmd.run:
    - name: 'npm install'
    - cwd: /data/scapp

#build-scapp:
#  cmd.run:
#    - name: 'node build/watcher.js'
#    - cwd: /data/scapp
