pipeline {
    
    agent any
    
    stages {
        
        stage("git login"){
            steps{
                git 'https://github.com/sagarkulkarni1989/Jenkins-Docker-Project.git'
            }
        }
        //  stage("Sending docker file to ansible server"){
        //     steps{
        //         sshagent(['ansible']) {
        //          sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215'
        //          sh 'scp /var/lib/jenkins/workspace/docker_image/* ubuntu@172.31.32.215:/opt/ansible'
        //         }
        //     }
        // }
         stage("docker build"){
             steps{
                 sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID gita/$JOB_NAME:v1.$BUILD_ID'
                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID gita/$JOB_NAME:latest'
             }
         }
         stage("push Image: DOCKERHUB"){
             steps{
                 withCredentials([string(credentialsId: 'dockerhub', variable: 'docker_passwd')]) {
                 sh "docker login -u gita -p ${docker_passwd}"
                sh 'docker image push gita/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image push gita/$JOB_NAME:latest'
               //A number of images will get stored into our jenkins server so need to remove prev build images
                //local images,taged images & latest images all delete 
              sh 'docker image rm $JOB_NAME:v1.$BUILD_ID gita/$JOB_NAME:v1.$BUILD_ID gita/$JOB_NAME:latest'
              }
             }
         }
          stage("Docker Container Deployment") {
                steps {
                    script {
                        def docker_run = 'docker run -p 9000:80 -d --name scripted-pipeline-demo gita/deployment:latest'
                        def docker_rmv_container = 'docker rmi -f gita/deployment'
                        def docker_rmi = 'docker rmi -f gita/deployment'

            // Container deployment need to be done on remote host server DOCKER-Host so ssh-Agent plugin required in Jenkins
            sshagent(['sshagent']) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.33.229 ${docker_rmv_container}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.33.229 ${docker_rmi}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.33.229 ${docker_run}"
            }
        }
    }
}
    
          
        /* stage("Building Docker Image"){
            steps{
                script {
                     sshagent(['ansible']) {
                sh 'echo $PWD'
                sh 'ssh -t -t ubuntu@172.31.32.215 -o StrictHostKeyChecking=no "echo pwd && cd /opt/ansible && echo pwd"'
               //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215'
               //sh 'cd /opt/ansible'
               sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
               sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID'
               sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
                }
            }
            }
        } */
    }
}
