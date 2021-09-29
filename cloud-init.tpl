#cloud-config
output:
    all:
        output: "> /var/log/cloud-init.out"
        error: "> /var/log/cloud-init.err"

# install packages 
package_update: true

packages:
  - wget
  - bzip2

# write config files
write_files:
- path: /var/log/monerod.log
  owner: root:root
  permissions: '664'

- path: /etc/monero/monerod.conf
  owner: root:root
  permissions: '664'
  content: |
    # Credentials
    rpc-login=${daemon_username}:${daemon_password}
    
    # Blockchain data
    prune-blockchain=1
    data-dir=/srv
    
    # Log file
    log-file=/var/log/monerod.log
    max-log-file-size=0            # Prevent monerod from managing the log files; we want logrotate to take care of that
    
    # P2P full node
    p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
    p2p-bind-port=18080            # Bind to default port
    
    # RPC open node
    rpc-bind-ip=0.0.0.0            # Bind to all interfaces
    rpc-bind-port=18081            # Bind on default port
    confirm-external-bind=1        # Open node (confirm)
    restricted-rpc=1               # Prevent unsafe RPC calls
    no-igd=1                       # Disable UPnP port mapping

- path: /etc/systemd/system/monerod.service
  owner: root:root
  permissions: '774'
  content: |
    [Unit]
    Description=Monero Full Node
    After=network.target
    
    [Service]
    User=root
    Group=root
    Type=simple
    ExecStart=/usr/local/bin/monerod --config-file /etc/monero/monerod.conf --non-interactive
    StandardOutput=null
    StandardError=null
    Restart=always
    
    [Install]
    WantedBy=multi-user.target

# start monero daemon
runcmd:
  - cd /usr/local/bin
  - wget --output-document=${wget_output-document} ${download_url}
  - tar xvf ${wget_output-document} --strip-components 1
  - rm ${wget_output-document}
  - systemctl enable monerod
  - systemctl start monerod
