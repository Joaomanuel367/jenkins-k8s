pipeline {
    agent { docker { image 'docker:stable' } }
    stages {
       stage('Build') {
          environment {
                CI_REGISTRY_USER = credentials('CI_REGISTRY_USER')
                CI_REGISTRY_PASSWORD = credentials('CI_REGISTRY_PASSWORD')
                CI_SSH_PRIVATE_KEY = credentials('CI_SSH_PRIVATE_KEY')
                CI_SSH_AUTHORIZED_KEY = credentials('CI_SSH_AUTHORIZED_KEY')

            } 
          steps {
               sh "date"
               sh "docker info"
               sh "docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD" 
               sh "cat \"$CI_SSH_PRIVATE_KEY\" > docker_build/id_rsa"
               sh "cat \"$CI_SSH_AUTHORIZED_KEY\" > docker_build/authorized_keys"
               sh "docker build -t $CI_REGISTRY_USER/image-ansible:1.0 ./docker_build/"
               sh "docker push $CI_REGISTRY_USER/image-ansible:1.0"
          }
       }
       stage('Deployment') {
          environment {
                CI_REGISTRY_USER = credentials('CI_REGISTRY_USER')
                CI_REGISTRY_PASSWORD = credentials('CI_REGISTRY_PASSWORD')
                CI_SSH_PRIVATE_KEY = credentials('CI_SSH_PRIVATE_KEY')
                CI_SSH_AUTHORIZED_KEY = credentials('CI_SSH_AUTHORIZED_KEY')
                dockerhub = credentials('dockerhub')
            }
           agent {
               docker {
                    image 'joaomanuel/image-ansible:1.0' 
                    alwaysPull true
                    registryCredentialsId 'dockerhub'              
                    }
           }
           steps {
               sh "date"
               sh "chmod +x docker_build/integracao_continua.sh"
               sh "docker_build/integracao_continua.sh"
           }
       }
    }
 }
