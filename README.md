# ejercicioSRE
EjercicioSRE

## Crear infraestructura a través de código en aws

Ejercicio donde se describen los pasos para proveer infraestructura a partir de código

### Prerequisitos

- Una cuenta de AWS y los tokens de acceso
- Tener instalado ansible
- Tener instalado Packer
- Tener instalado Terraform

### Bajar el codigo fuente

```
git clone https://github.com/pumajd/ejercicioSRE.git
```

### Crear una imagen personalizada con packer y ansible


Para crear la imagen personalizada e instalar un servidor web para revisar el funcionamiento se utilizó los siguientes archivos

- scripts_packer/AMI.pkr.hcl  	Contiene la programación para crear la imagen personalizada en base a una imagen existente
- scripts_packer/playbook.yml	Contiene la programación para la instalción del servidor web nginx

Los pasos a seguir son:
Nota: Se debe registrar previamente la clave de acceso y la contraseña de AWS
```
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```
Los pasos a seguir son:

1. Acceder a la carpeta scripts_packer/ de ejercicioSRE
```
cd scripts_packer
```
2. Inicializar la herramienta packer
```
packer init .
```
3. Validar el script con la herramienta packer
```
packer validate .
```
4. Construir la imagen en AWS
```
packer build .
```
**Nota:** El resultado de packer puede variar en cada construcción, en caso de errores se debe volver a ejecutar
5. Revisar el resultado en la consola de AWS



### Desplegar la infraestructura con terraform

Para desplegar la infraestructura con terraform se utilizó los siguientes archivos

- scripts_terraform/main.tf Contiene la configuración principal para la ejecución y sus varaiables
- scripts_terraform/balanceador.tf Contiene la programación para crear el balanceador 
- scripts_terraform/grupo_seguridad.tf Contiene la programación para la configuración de grupos de seguridad
- scripts_terraform/rds.tf Contiene la programación para crear de una base de datos relacional postgres

Los pasos a seguir son:

1. Acceder a la carpeta scripts_terraform/ de ejercicioSRE
```
cd scripts_terraform
```
2. Inicializar la herramienta terraform
```
terraform init
```
3. Validar los scripts con terraform
```
terraform validate
```
4. Construir ls infraestructura, donde se debe indicar:
- aws_acceso [AWS_ACCESS_KEY], 
- aws_secreto [AWS_SECRET_ACCESS_KEY], 
- db_clave que es la clave que se le quiera dar a la base de datos  
```
terraform apply
```
5. Revisar el resultado en la consola de AWS

**Nota:** Para cuando ya no se necesite la infraestructura se puuede eliminar todo lo creado con:
```
terraform destroy
```