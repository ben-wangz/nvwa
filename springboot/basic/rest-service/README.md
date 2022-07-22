# rest-service

## objects

1. build a service which accepts http get requests at `http://localhost:8080/greeting?message=world`
   and then response with data in json format

## implementation

1. [Application](src/main/java/tech/geekcity/nvwa/springboot/basic/rest/service/Application.java) contains the main
   process to drive springboot
    * main method of java
    * annotation `@SpringBootApplication` will configure the whole springboot application
2. [HelloController](src/main/java/tech/geekcity/nvwa/springboot/basic/rest/service/controller/HelloController.java)
   controls the process of how to response the request
    * annotation `@RestController` will tell springboot framework to transform response object to json data
    * annotation `@RequestMapping` can configure the routing rules of springboot while dealing with requests
    * annotation `@GetMapping("/hello")` will bind a specific routing rule with the method to dealing with requests
    * annotation `@RequestParam` will bind the argument with the dependent data extracted from the request
3. [StandardResponse](src/main/java/tech/geekcity/nvwa/springboot/basic/rest/service/StandardResponse.java) defines the
   structure of response data
4. start the service
    * ```shell
      ./gradlew :springboot:basic:rest-service:bootRun
      ```

## testing

1. test with curl
    * ```shell
      curl "http://localhost:8080/basic/hello?message=world"
      # response expected
      # {"code":200,"data":"hello world","message":null}
      ```
