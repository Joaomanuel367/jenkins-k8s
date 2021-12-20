pipeline {
    agent { docker { image 'docker:stable' } }
    stages {
       stage('build') {
          steps {
               sh "docker info"
               sh "docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD" 
               echo "$CI_SSH_PRIVATE_KEY" > $(pwd)/docker_build/id_rsa
               echo "$CI_SSH_AUTHORIZED_KEY" > $(pwd)/docker_build/authorized_keys
               sh "docker build -t joaomanuel/image-ansible:1.0 ./docker_build/"
               sh "docker push joaomanuel/image-ansible:1.0"
          }
       }
       stage(test) {
           steps {
               echo $CI_COMMIT_BRANCH
               echo $CI_DEFAULT_BRANCH
               sh "chmod +x ./docker_build/integracao_continua.sh && ./docker_build/integracao_continua.sh"
           }
       }
    }
 }
