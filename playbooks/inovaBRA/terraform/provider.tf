// Configurando a autenticacao no Google



provider "google" {
  credentials = "${file("key.json")}"
  project     = "desenvolvimento-212121"
  region      = "us-central1"
}



//criando a infraestrutura



resource "google_compute_instance" "web1" {
name = "web1"
machine_type = "n1-standard-1"
zone = "us-central1-a"

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


 network_interface {
    network = "default"

 access_config {
    }

  }
tags = ["http-server"]
metadata_startup_script = "apt-get update && apt-get install nginx -y && echo 'Sou DevOps no inovaBRA' > /var/www/html/index.html"


}

resource "google_compute_instance" "web2" {
name = "web2"
machine_type = "n1-standard-1"
zone = "us-central1-a"

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


 network_interface {
    network = "default"

 access_config {
    }

  }
tags = ["http-server"]
metadata_startup_script = "apt-get update && apt-get install nginx -y && echo 'Sou DevOps no inovaBRA' > /var/www/html/index.html"


}




resource "null_resource" "web" {
  # ...

  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook /etc/ansible/playbooks/inovaBRA/provider-gcp.yaml"
  }
}

