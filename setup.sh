#!/bin/bash
apt-get update
apt-get install -y unzip zip nano git wget
apt-get install -y postgresql
apt-get install -y build-essential

wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/12.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
apt-get update
apt-get install -y odoo
apt-get install -y python3-pip
apt-get install -y libpq-dev
apt-get install -y libsasl2-dev python-dev libldap2-dev libssl-dev
apt-get install -y postgresql-10-postgis-scripts

# Felix - Install add-ons == Copy your addon.zip to addons repository
#cp -r /root/solsme-odoo/addons /usr/lib/python3/dist-packages/odoo/
#cd /usr/lib/python3/dist-packages/odoo/addons/
#unzip -o \*.zip
#rm -rf *.zip
#cd ~

# Install essential add-ons
pip3 install wheel
pip3 install -r /usr/lib/python3/dist-packages/odoo/requirements.txt
pip3 install phonenumbers bokeh
pip3 install git+https://github.com/aeroo/currency2text.git
pip3 install psycogreen psycopg2-binary
pip3 install shapely
pip3 install geojson
pip3 install simplejson
pip3 install webcolors

#FODO-0001: Fixed Invoice Printing issue on Odoo 12
apt-get install -y xfonts-75dpi xfonts-base
cd /tmp
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
apt-get -f -y install
cd ~

#FODO-0002: Fix POS LOGO and Webtitle on Odoo 12
cp /root/solsme-odoo/fixed/pos/logo.png /usr/lib/python3/dist-packages/odoo/addons/point_of_sale/static/src/img/
cp /root/solsme-odoo/fixed/pos/pos_templates.xml /usr/lib/python3/dist-packages/odoo/addons/point_of_sale/views/

#FODO-0003: Fix Odoo Database Page and Webtitle on Odoo 12
cp /root/solsme-odoo/fixed/database/logo.png /usr/lib/python3/dist-packages/odoo/addons/web/static/src/img/
cp /root/solsme-odoo/fixed/database/favicon.ico /usr/lib/python3/dist-packages/odoo/addons/web/static/src/img/
cp /root/solsme-odoo/fixed/database/database_manager.html  /usr/lib/python3/dist-packages/odoo/addons/web/views/

#FODO-0004: Remove Odoo content on the first installation
cp /root/solsme-odoo/fixed/web/webclient_templates.xml  /usr/lib/python3/dist-packages/odoo/addons/web/views/
cp /root/solsme-odoo/fixed/web/abstract_web_client.js  /usr/lib/python3/dist-packages/odoo/addons/web/static/src/js/chrome/
