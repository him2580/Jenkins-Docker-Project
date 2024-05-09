pipeline {
    
    agent any
    
    stages {
        
        stage("git login"){
            steps{
                git 'https://github.com/him2580/Jenkins-Docker-Project.git'
            }
        }
   
         stage("docker build"){
             steps{
                 sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID himanshu3010/$JOB_NAME:v1.$BUILD_ID'
                 sh 'docker image tag $JOB_NAME:v1.$BUILD_ID himanshu3010/$JOB_NAME:latest'
             }
         }
         stage("push Image: DOCKERHUB"){
             steps{
                 withCredentials([string(credentialsId: 'Dockerhub', variable: 'docker_passwd')]) {
                 sh "docker login -u himanshu3010 -p ${docker_passwd}"
                sh 'docker image push himanshu3010/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image push himanshu3010/$JOB_NAME:latest'
               //A number of images will get stored into our jenkins server so need to remove prev build images
                //local images,taged images & latest images all delete 
              sh 'docker image rm $JOB_NAME:v1.$BUILD_ID himanshu3010/$JOB_NAME:v1.$BUILD_ID himanshu3010/$JOB_NAME:latest'
              }
             }
         }
          stage("Docker Container Deployment") {
                steps {
                    script {
                        def docker_run = 'docker run -p 9000:80 -d --name scripted-pipeline-demo himanshu3010/deployment:latest'
                        def docker_rmv_container = 'docker rmi -f himanshu3010/docker'
                        def docker_rmi = 'docker rmi -f himanshu3010/docker

            sshagent(['sshagent1']) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.103.159 ${docker_rmv_container}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.103.159 ${docker_rmi}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@65.0.103.159 ${docker_run}"
            }
        }
    }
}
    
    
    }
}
