def call(String image) {
    sh """
    trivy image --exit-code 0 --severity HIGH,CRITICAL ${image}
    """
}
