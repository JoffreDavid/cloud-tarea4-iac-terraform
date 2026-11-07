#Configuracion del proveedor de AWS
provider "aws" {
    region = "us-east-1"
}

#Creamos el security group
resource "aws_security_group" "mi-sg" {
    name = "mi-security-group-tarea4"
    description = "Security group creado con Terraform"
    vpc_id = "vpc-0f159688cebf48cdc"

#Regla de entrada para SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
#Regla de salida para HTTP
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Declaracion de los recursos de aws
resource "aws_instance" "mi_instancia_t4_windows" {
    ami = "ami-0b5f645abc199e666" #ID de la imagen de amazom windows
    instance_type = "t3.micro" # Tipo de instancia 
    key_name = "mi-par-llaves-ja" # Nombre del par de claves para acceder a la instancia
    tags = {
        Name = "MiInstanciaWindowsTerraform" # Etiqueta para identificar a la instancia
    }
    vpc_security_group_ids = [aws_security_group.mi-sg.id]
}