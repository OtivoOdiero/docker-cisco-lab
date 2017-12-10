#!/bin/sh

KEYGEN=/tmp/keygen.py
IOURC=/images/.iourc

if [ ! -f $IOURC ]
then
cat > $KEYGEN << 'EOF'
#! /usr/bin/python3

import os
import socket
import hashlib
import struct

hostid = os.popen("hostid").read().strip()
hostname = socket.gethostname()
ioukey = int(hostid, 16)

for x in hostname:
    ioukey = ioukey + ord(x)

iouPad1 = b'\x4B\x58\x21\x81\x56\x7B\x0D\xF3\x21\x43\x9B\x7E\xAC\x1D\xE6\x8A'
iouPad2 = b'\x80' + 39 * b'\0'
md5input = iouPad1 + iouPad2 + struct.pack('!L', ioukey) + iouPad1
iouLicense = hashlib.md5(md5input).hexdigest()[:16]

with open('/images/.iourc', 'w') as f:
    f.write('[license]\n' + hostname + ' = ' + iouLicense + ';\n')

EOF
python3 $KEYGEN
echo '127.0.0.127\txml.cisco.com' >> /etc/hosts
rm -f $KEYGEN
fi

exec gns3server --config /home/gns3/server.conf > /home/gns3/server.log 2>&1 &

exec /bin/sh
