provider "aws" {

region = "us-east-1"

}


resource "aws_instance" "durga"{

  instance_type = "t2.micro"
  ami = "ami-047a51fa27710816e"
  key_name = "login1"



  provisioner "remote-exec"{

    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
     "sudo systemctl start nginx"
       ]

       connection {
    type     = "ssh"
    user     =  "ec2-user"
    private_key = file("./login1.pem")
    host     = self.public_ip
  }
     }



  }
