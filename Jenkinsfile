pipeline {
    agent any
    
    stages {
        stage('Stage 1 -> install apt && ansible') {
            steps {
                sh 'apt update -y'
                sh 'apt install wget -y'
                sh 'apt install unzip -y'
                sh 'apt install git -y'
                sh 'apt install ansible -y'
                sh 'apt install docker.io -y'
            }
        }
        stage('Stage 2 -> download and install terraform') {
            steps {
                sh 'wget -O ${NAME} https://hashicorp-releases.yandexcloud.net/terraform/${VERSION}/${NAME}'
                sh 'rm -rf /usr/local/bin/LICENSE.txt; rm -rf /usr/local/bin/terraform'
                sh 'unzip ${NAME} -d /usr/local/bin'
                sh 'rm -rf /root/.ssh/id_ed25519 && rm -rf /root/.ssh/id_ed25519.pub &&'
                sh "ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ''"
            }
        }
        stage('Stage 3 -> Clone repository') {
            steps {
                sh 'rm -rf ~/repository'
                sh 'git clone https://github.com/uladzimirzel/juntest ~/repository'
            }
        }
        stage('Stage 4 -> Run terraform and create instance') {
            steps {
                dir('terraform') {
                    sh 'mv .terraformrc ~/'
                    sh 'terraform destroy -auto-approve'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}