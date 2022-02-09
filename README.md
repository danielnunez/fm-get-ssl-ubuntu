# FileMaker Get SSL (LetsEncrypt) Ubuntu
Un script bash para obtener y renovar certificados Let's Encrypt (certbot) para FileMaker Server con Linux (Ubuntu).


### Instrucciones de instalación inicial:
1. Instalar Ubuntu + FMS (a partir de la versión 19.4.2.204)
2. Instalar `certbot`
3. Descargar `wget https://raw.githubusercontent.com/danielnunez/fm-get-ssl-ubuntu/main/get-ssl.sh`
4. Dar permiso de ejecución `chmod +x get-ssl.sh`
5. Editor contenido del script `nano get-ssl.sh`
6. Ejecutar `sudo ./get-ssl.sh`


### Instrucciones de instalación de renovación:
1. Descargar `wget https://raw.githubusercontent.com/danielnunez/fm-get-ssl-ubuntu/main/renew-cert.sh`
2. Dar permiso de ejecución `chmod +x renew-cert.sh`
3. Editar contenido del script `nano ./renew-cert.sh` (Solo es necesario editar usuario y clave)
4. Ejecutar `sudo ./renew-cert.sh`


### Solución de problemas
+ Tuve un problema al detener/iniciar el servidor después, así que intente
```bash
# Detener servicio FM
sudo service fmshelper stop

# esperar 15 segundos

# Iniciar servicio FM
sudo service fmshelper start
```