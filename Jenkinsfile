pipeline {
    agent any
    
    stages {
        stage('Stage 1 -> install apt && ansible') {
            steps {
                sh 'apt update -y'
                sh 'apt install wget -y'
                sh 'apt install unzip -y'
                sh 'apt install ansible -y'
                sh 'apt install docker.io -y'
                sh 'apt install python3 -y'
                sh 'apt install nano -y'
            }
        }
        stage('Stage 2 -> download and install terraform') {
            steps {
                sh 'wget -O ${NAME} https://hashicorp-releases.yandexcloud.net/terraform/${VERSION}/${NAME}'
                sh 'rm -rf /usr/local/bin/LICENSE.txt; rm -rf /usr/local/bin/terraform'
                sh 'unzip ${NAME} -d /usr/local/bin'
                sh 'mv /var/jenkins_home/workspace/Install_Terraform/terraform/.terraformrc  ~/'
                sh 'rm -rf /root/.ssh/id_ed25519 && rm -rf /root/.ssh/id_ed25519.pub'
                sh "ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ''"
            }
        }
        stage('Stage 3 -> Run terraform and create instance') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform destroy -auto-approve'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Stage 4 -> Make inventory.ini') {
            steps {
                dir('python') {
                    sh 'python3 create_inventory.py'
                }
            }
        }
        stage('Stage 5 -> Run ansible playbook') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook playbook.yml'
                }
            }
        }
        
    }
}