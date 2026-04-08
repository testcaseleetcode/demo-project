pipeline {
    agent any

    environment {
        IMAGE_NAME = "demo-project"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Build Docker Image (Minikube)') {
            steps {
                sh '''
                eval $(minikube docker-env)
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                kubectl get pods
                kubectl get svc
                '''
            }
        }
    }
}