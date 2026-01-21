def call(String repoUrl, String imageName, String tag, String gitToken) {

    sh """
      rm -rf manifests
      git clone https://${gitToken}@github.com/OMAR-BESHIR/k8s-manifests.git manifests

      cd manifests

      sed -i 's|image: .*|image: ${imageName}:${tag}|' deployment.yml

      git config user.email "jenkins@local"
      git config user.name "jenkins"

      git add .
      git commit -m "Update image to ${imageName}:${tag}" || echo "No changes to commit"
      git push origin main
    """
}
