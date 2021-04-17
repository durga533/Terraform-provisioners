provider "aws" {

region = "us-east-1"


}


resource "aws_instance" "durga"{

  instance_type = "t2.micro"
  ami = "ami-047a51fa27710816e"
  key_name = "login1"
  vpc_security_group_ids  = [aws_security_group.allowssh.id]
  provisioner "remote-exec"{
      on_failure = "continue"
    inline = [
      "sudo yum -y install nano"
       ]

       connection {
    type     = "ssh"
    user     =  "ec2-user"
    private_key = file("./login1.pem")
    host     = self.public_ip
  }
     }


     }

resource "aws_security_group" "allowssh"{

  name = "allow_ssh"
  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
