#!/bin/sh

# Ingrese la ruta a su directorio de FileMaker Server, terminando en un slash
SERVER_PATH="/opt/FileMaker/FileMaker Server/"

FMADMIN="admin"
FMPASS="apolo"

#
# no deberías editar nada debajo de esta línea
#

WEB_ROOT="${SERVER_PATH}HTTPServer/htdocs"

# Obtener el certificado
certbot renew

cp "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" "${SERVER_PATH}CStore/fullchain.pem"
cp "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" "${SERVER_PATH}CStore/privkey.pem"

chmod 640 "${SERVER_PATH}CStore/privkey.pem"

# Muever el certificado anterior, si lo hay, para evitar un error
mv "${SERVER_PATH}CStore/server.pem" "${SERVER_PATH}CStore/serverKey-old.pem"

# Remover el certificado anterior
fmsadmin certificate delete --yes -u ${FMADMIN} -p ${FMPASS}

# Instalar el certificado
fmsadmin certificate import "${SERVER_PATH}CStore/fullchain.pem" --keyfile "${SERVER_PATH}CStore/privkey.pem" -y -u ${FMADMIN} -p ${FMPASS}

# Detener servicio FM
sudo service fmshelper stop

# Iniciar servicio FM
sudo service fmshelper start