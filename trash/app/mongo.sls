base:
  pkgrepo.managed:
    - humanname: Mongo Repo
    - name: "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse"
    - file: /etc/apt/sources.list.d/mongodb.list
    - keyid: 7F0CEB10
    - keyserver: keyserver.ubuntu.com

mongodb-org:
  pkg:
    - installed
