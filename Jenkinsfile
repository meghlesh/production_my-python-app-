pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPO = "152160819093.dkr.ecr.ap-south-1.amazonaws.com/my-python-app"
        CONTAINER_NAME = "my-container"
        PORT = "5000"
    }

    stages {

        stage('Pull Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/meghlesh/production_my-python-app-.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:latest .'
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin 152160819093.dkr.ecr.ap-south-1.amazonaws.com
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh 'docker push $ECR_REPO:latest'
            }
        }

        stage('Approval Step') {
            steps {
                input message: "Deploy to Production?"
            }
        }

        stage('Deploy to Production') {
            steps {
                sh '''
                docker pull $ECR_REPO:latest

                docker stop my-container || true
                docker rm my-container || true

                docker run -d -p 5000:5000 --name my-container $ECR_REPO:latest
                '''
            }
        }
    }
}
