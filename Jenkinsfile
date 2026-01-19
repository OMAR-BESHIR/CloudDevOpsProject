@Library('clouddevops-shared-lib@main')_

pipeline {
    agent any
    
    environment {
        IMAGE_NAME = "omarredaa/final-app"
        IMAGE_TAG  = "v1"
        
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        GIT_CREDS       = credentials('github-token')
        
        MAINFEST_REPO = "https://github.com/OMAR-BESHIR/k8s-manifests.git"
    }

    stages {
        stage('Build Image') {
            steps {
                dockerBuild(IMAGE_NAME, IMAGE_TAG)
            }
        }
        
        stage('Scan Image') {
            steps {
                trivyScan("${IMAGE_NAME}:${IMAGE_TAG}")
            }
        }
        
        stage('Push Image') {
            steps {
                dockerPush(IMAGE_NAME, IMAGE_TAG, DOCKERHUB_CREDS)
            }
        }
        
        stage('Delete Image Locally') {
            steps {
                deleteLocalImage(IMAGE_NAME, IMAGE_TAG)
            }
        }
        
        stage('Update Manifests') {
            steps {
                updateK8sManifests(
                    MANIFEST_REPO,
                    IMAGE_NAME,
                    IMAGE_TAG,
                    GIT_CREDS
                )
            }
        }
        
        stage('Push Manifests') {
            steps {
                echo "Kubernetes manifests updated and pushed"
            }
        }
    }
}
