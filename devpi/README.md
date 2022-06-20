### devpi

1. installation
    * ```shell
      export IMAGE_BASE_URL=https://resource.geekcity.tech/kubernetes/docker-images/x86_64/all \
          && export DELETE_CHART_IF_EXISTS=true \
          && ./gradlew :devpi:installSoftware \
          && ./gradlew :devpi:installTool \
          && ./gradlew :devpi:initializeMirrorJob
      ```
2. test
    * set hosts
        + ```shell
          echo 172.17.0.1 devpi-server.local >> /etc/hosts
          ```
    * check connection
        + ```shell
          curl -v -H "Accept: application/json" http://devpi-server.local/+status
          ```
    * wait until index build or retry this test if failed
        + ```shell
          ./gradlew :devpi:testPipInstallJob
          ```