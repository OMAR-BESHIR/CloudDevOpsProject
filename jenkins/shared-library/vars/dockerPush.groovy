def call(String imageName, String tag, String user, String pass) {
    sh """
      echo '${pass}' | docker login -u '${user}' --password-stdin
      docker push ${imageName}:${tag}
      docker logout
    """
}
