pipeline {
    agent any
    tools {
        nodejs '20.16.0'
    }
    environment {
        DOCKER_IMAGE = "projet-devops:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Pull the code from your repository
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                // Install project dependencies
                sh 'npm install'
            }
        }
        
        stage('Check Node.js Version') {
            steps {
                // Check the version of Node.js in the Jenkins environment (if it was installed correctly)
                sh 'node -v'
            }
        }
        
        stage('Build') {
            steps {
                // Build the project using npm
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                // Run tests using npm
                sh 'npm run test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    sh "docker build -f Dockerfile -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Build Docker Image in Minikube') {
            steps {
                script {
                    // Switch our shell to use Minikube's Docker daemon
                    sh "eval \$(minikube docker-env)"

                    // Build the Docker image inside Minikube's Docker
                    sh "docker build -t ${DOCKER_IMAGE} ."

                    // Optional: Verify the image is present in Minikube's Docker
                    sh "docker images | grep 'projet-devops'"
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    echo "Deploying to Minikube using k8s manifests..."
                    sh "kubectl apply -f Kubernetes/deployment.yaml"
                    sh "kubectl apply -f Kubernetes/service.yaml"
                }
            }
        }

        stage('Check K8s Deployment') {
            steps {
                script {
                    echo "Checking rollout status..."
                    // Wait up to 60 seconds for the new Pods to become Ready
                    sh "kubectl rollout status deployment/my-nest-app-deployment --timeout=60s"
                    // Print Pods and Service info for debug
                    sh "kubectl get pods -o wide"
                    sh "kubectl get svc"
                }
            }    
        }
    }
}
