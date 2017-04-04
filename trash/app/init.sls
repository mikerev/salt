{% if "testing.hgapp" in grains.get('roles', []) %}

nodejs:
  pkg.installed:
    - name: nodejs

npm:
  pkg.installed:
    - name: npm

run-install-n:
  cmd.wait:
    - name: 'npm install n'
    - cwd: /

set_node_version:
  cmd.wait:
    - name: 'n 4.3.1'
    - cwd: /


{% endif %}
