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


resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "us-central1-a/web1",
    "us-central1-a/web2",
  ]

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}




resource "null_resources" "web" {
  # ...

  provisioner "local-exec" {
    command = "ansible-playbook /etc/ansible/playbooks/inovaBRA/provider-gcp.yaml"
  }
}

