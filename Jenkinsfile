@Library('clouddevops-shared-lib@main')_

pipeline {
    agent any

    environment {
        IMAGE_NAME   = "omarredaa/final-app"
        IMAGE_TAG    = "v1"
        MANIFEST_REPO = "https://github.com/OMAR-BESHIR/k8s-manifests.git"
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
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    dockerPush(
                        IMAGE_NAME,
                        IMAGE_TAG,
                        env.DOCKER_USER,
                        env.DOCKER_PASS
                    )
                }
            }
        }

        stage('Delete Image Locally') {
            steps {
                deleteLocalImage(IMAGE_NAME, IMAGE_TAG)
            }
        }

        stage('Update Manifests') {
            steps {
                withCredentials([
                    string(
                        credentialsId: 'github-token',
                        variable: 'GIT_TOKEN'
                    )
                ]) {
                    updateK8sManifests(
                        MANIFEST_REPO,
                        IMAGE_NAME,
                        IMAGE_TAG,
                        env.GIT_TOKEN
                    )
                }
            }
        }

        stage('Push Manifests') {
            steps {
                echo "Kubernetes manifests updated and pushed successfully "
            }
        }
    }
}
