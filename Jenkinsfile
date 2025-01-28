pipeline {
    agent any

    tools {
        nodejs '20.16.0'
    }

    environment {
        // Docker image name/tag
        DOCKER_IMAGE = "projet-devops:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Check Node.js Version') {
            steps {
                sh 'node -v'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm run test'
            }
        }
        
        // Option A: Remove this local Docker build stage if you ONLY want to build in Minikube
        // ------------------------------------------------
        // stage('Build Docker Image Locally') {
        //     steps {
        //         script {
        //             sh "docker build -f Dockerfile -t ${DOCKER_IMAGE} ."
        //         }
        //     }
        // }

        stage('Build Docker Image in Minikube') {
            steps {
                script {
                    // Run all minikube steps in a single shell block to preserve env variables
                    sh '''
                        # Ensure Minikube is running (will do nothing if already up)
                        minikube start --driver=docker

                        # Switch to Minikube’s Docker environment
                        eval "$(minikube docker-env)"

                        # Build the Docker image inside Minikube
                        docker build -t projet-devops:latest .

                        # Verify the image is present in Minikube’s Docker
                        docker images | grep "projet-devops"
                    '''
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
