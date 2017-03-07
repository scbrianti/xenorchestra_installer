#!/bin/bash
sudo apt-get install --yes nfs-common
cd /opt
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --yes nodejs yarn
curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
sudo chmod +x /usr/local/bin/n
sudo n stable
sudo apt-get install --yes build-essential redis-server libpng-dev git python-minimal libvhdi-utils
git clone -b stable https://github.com/vatesfr/xo-server
git clone -b stable https://github.com/vatesfr/xo-web
cd xo-server
sudo npm install && npm run build
sudo cp sample.config.yaml .xo-server.yaml
sudo sed -i /mounts/a\\"    '/': '/opt/xo-web/dist'" .xo-server.yaml
cd /opt/xo-web
sudo npm i lodash.trim@3.0.1
yarn install --force
cat > /etc/systemd/system/xo-server.service <<EOF
# systemd service for XO-Server.

[Unit]
Description= XO Server
After=network-online.target

[Service]
WorkingDirectory=/opt/xo-server/
ExecStart=/usr/local/bin/node ./bin/xo-server
Restart=always
SyslogIdentifier=xo-server

[Install]
WantedBy=multi-user.target
EOF

sudo chmod +x /etc/systemd/system/xo-server.service
sudo systemctl enable xo-server.service
sudo systemctl start xo-server.service
