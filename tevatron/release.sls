{% if "tevatron" in grains.get('roles', []) %}

run-pip-sopel-upgrade:
  cmd.wait:
    - name: 'pip sopel upgrade'
    - cwd: /

{% endif %}
