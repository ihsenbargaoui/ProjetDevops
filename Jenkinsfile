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
    }
}
