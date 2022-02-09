#!/bin/sh

# Cambie la variable de dominio al dominio/subdominio por el que desea un
# certificado SSL
DOMAIN="fms.dominio.com"

# Cambie la dirección de correo electrónico de contacto a su dirección de
# correo electrónico real para que Let's Encrypt pueda contactarlo si hay
# algún problema
EMAIL="correo@dominio.com"

# Ingrese la ruta a su directorio de FileMaker Server, terminando en un slash
SERVER_PATH="/opt/FileMaker/FileMaker Server/"

FMADMIN="usuario"
FMPASS="contraseña"

#
# no deberías editar nada debajo de esta línea
#

WEB_ROOT="${SERVER_PATH}HTTPServer/htdocs"


# Obtener el certificado
certbot certonly --webroot -w "$WEB_ROOT" -d $DOMAIN --agree-tos -m "$EMAIL" --preferred-challenges "http" -n

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