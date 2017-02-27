#!/bin/bash -ex

sudo cp *.repo /etc/yum.repos.d/
sudo cp RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/ 

cat > /tmp/iff.key <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mQENBFHLrjgBCACzI7l8y1nygGN1b0XwgEDdBZGUlaTZhyHs1Y2VLBmYm3dgyRHp
qLfHhVGZm1FXzT1X7GlGgQRV+GsyeXNUHWcY794UwZMCM4h0mGDGXX1eR2objUNZ
tVE9VzoXwKwnu7mKJGXgSm+olZKQ43wPnr7Keyap42yKSJv3GBkMmfKjwnjTooLk
g62wwpJa3AOZBBqLwHKt0BYVRT/7ILXJnW4NqDoQPeT1y3Iqt1KxsaR1Ik+byh3g
UUvDqgFRXPW+HDkB265MbQgXHmPTGih8j7ygZz1dM5pJQ//bMqNHmbDPZSwLt0Wb
yB6UNbO9W5ZENCz4h7+3utYAvwERqdZ/nxKZABEBAAG0L0Z1bmFwaSBTdXBwb3J0
IDxmdW5hcGktc3VwcG9ydEBpZnVuZmFjdG9yeS5jb20+iQE4BBMBAgAiBQJRy644
AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCj9+/dSTj/5jzNB/45CD2R
Bv8CrB+ErIVeFjXuhqYwg2fuAdQcXbVpla5rhrvHjGEbCl35kKqEPFP09YvWReIi
i3kK1yF7zNxyk/9N3GUZpIEgbyEuNVjkizPjrs+DWx0j6oZZQLrsEflUMxfALAmr
v3n6fB6XeCk2Hd83XBoqZSHKfzLPFUynS7e2/Vte4UVKbgFPsypPXazYrqvq4ej2
bnHva6/aUakti+A+l8Cs0kf2WzrwOp47PcceT5N0/mwF5XslwaiqH6q+6iGNLdj0
9hjzRcdZ5My/Do6rGXcFJJY17U72HGFTUCU8RXZRTBY2EfjAV6zQlKlaO/Aw0eWX
7UMXUhc+CLv+aZOxuQENBFHLrjgBCAC/xHRd1tH2zs8nplyI3EYRyWqF82waGIyK
SnV/pJ4CCc2YuECnQV0RvoOtZiuwmB3CuNTSEEyAfwU/K3tMsvczMN04MjQGvSA1
4it7xIkg24Qcx0O46JBwvihR4sZ8O/j6X/nVV4pN4zUg5PQh///yn/R7mVH2sWVW
WE5ZpZ1G/eA/fSiqdmZPOjFW9SWsVgPXvyKCM0b5lCjMlbwZspx8YGblJtDqCtWW
Ip2RnGTCSkSo4kRauDU+iGYojUsgsmUSxjtdGZHa41g5HDRoIcL3e40UYe3el7Sx
Aa+lV529kHAZCWtDfS7MoqtE7gvHSGoJAK+2nCAEfw1mz0Ja+XELABEBAAGJAR8E
GAECAAkFAlHLrjgCGwwACgkQo/fv3Uk4/+Y36Qf/VPov5n+h4pEzKspA6hHezD4J
rw9rVCQ/BvidBerV4VvL+oH5ghBV5QeAvd2TyccuKdZJsikAM9wUM1MS+Y4Akno7
vgIKO/7sGGkbAkgSG4vvfG4W9EQ0GqFycaTl9zpiNUrUri5vGNK2PC6p9uXxXmdQ
3iHe1c5+5jvLKCzOdC+Er2E949PzsMuI2L4viNp72J6ilm62RJ+/Pg1rOaRmTH1H
ax7L3Hwsy0GXeubKaeDizvBeKcv6e08DqI2TCllmd8NkR6OSLuks4yHDU1ztAa0c
+RcnddKag+TCYwto617oMZvCPaic/d6AjW3OL48PFNUPpfBeZEJ8B8tm16HxaQ==
=p+5n
-----END PGP PUBLIC KEY BLOCK-----
EOF

sudo rpm --import /tmp/iff.key

sudo yum makecache
sudo yum -y update

sudo yum -y install xz binutils curl gawk gflags glog google-breakpad grep hiredis jemalloc openssl mariadb-connector-c libsodium python-gflags python-simplejson || true

sudo mkdir -p /etc/ifunfactory

cat > /tmp/account.$$.ilf <<EOF
# This license is exclusively assigned to "Ltizen"'s "BnB".
# It violates the license agreement between "Ltizen" and iFunFactory
# Inc to apply this license information to different project(s) without
# the prior consent of iFunFactory Inc.
# iFunFactory Inc. reserves the right to inspect a license violation
# and to revoke the license if "Ltizen" violates the license agreement.

4da12f257dd9b41fee1fe98f9d52e71cdd1d478d8ba95180784b2564ce30422ee14d328cd41a9628
584376a23f1214d10f3df1dd64e0e13ac9682258e5342b0beyJsaWNlbnNlIjogeyJwcm9qZWN0Ijog
IkJuQiIsICJpc3N1ZWQiOiAiMjAxNS0wNC0xM1QwNDoyMDo1NVoiLCAiY29tcGFueSI6ICJMdGl6ZW4i
LCAiZXhwaXJlcyI6ICIyMDIwLTEyLTMxVDIzOjU5OjU5WiJ9fQ==fdfd014530ba7fe28044decf8c3b
a3e682ea47a38d96d546ce809ea5833715b3
EOF

sudo mv /tmp/account.$$.ilf /etc/ifunfactory/account.ilf
sudo chmod -R a+rX /etc/ifunfactory

WORKING_DIRECTORY=$(pwd)
pushd /
sudo tar -Jxf ${WORKING_DIRECTORY}/gcc4.9-install.tar.xz
sudo tar -zxf ${WORKING_DIRECTORY}/gamelift-protobuf.tar.gz
sudo tar -zxf ${WORKING_DIRECTORY}/gamelift-boost.tar.gz
sudo tar -Jxf ${WORKING_DIRECTORY}/funapi-install.tar.xz
sudo tar -zxf ${WORKING_DIRECTORY}/gamelift-demo_0.0.1_install-field.tar.gz
sudo tar -zxf ${WORKING_DIRECTORY}/gamelift-demo_0.0.1_install-instance.tar.gz
sudo cp ${WORKING_DIRECTORY}/MANIFEST/field/MANIFEST.json /usr/share/gamelift_demo/field/manifests/MANIFEST.json
sudo cp ${WORKING_DIRECTORY}/MANIFEST/instance/MANIFEST.json /usr/share/gamelift_demo/instance/manifests/MANIFEST.json
popd

sudo mkdir -p /var/log/funapi/gamelift_demo.field/activity \
    /var/log/funapi/gamelift_demo.field/glog
sudo mkdir -p /var/log/funapi/gamelift_demo.instance/activity \
    /var/log/funapi/gamelift_demo.instance/glog

sudo chmod -R a+rwX /var/log/funapi/gamelift_demo.field
sudo chmod -R a+rwX /var/log/funapi/gamelift_demo.instance

sudo cp ${WORKING_DIRECTORY}/libaws-cpp-sdk* /usr/lib/
