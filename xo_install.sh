#!/bin/bash
cd /opt
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install --yes nodejs
curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
chmod +x /usr/local/bin/n
n stable
node -v
npm -v
sudo apt-get install --yes build-essential redis-server libpng12-dev git python-minimal
git clone -b stable https://github.com/vatesfr/xo-server
git clone -b stable https://github.com/vatesfr/xo-web
cd xo-server
sudo npm install && npm run build
cp sample.config.yaml .xo-server.yaml
sed -i /mounts/a\\"    '/': '/opt/xo-web/dist'" .xo-server.yaml
cd /opt/xo-web
sudo npm i lodash.trim@3.0.1
sudo npm install
sudo npm run build
cd /opt/xo-server
sudo npm start
