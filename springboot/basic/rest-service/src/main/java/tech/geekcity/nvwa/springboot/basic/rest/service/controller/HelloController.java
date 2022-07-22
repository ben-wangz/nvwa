package tech.geekcity.nvwa.springboot.basic.rest.service.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import tech.geekcity.nvwa.springboot.basic.rest.service.StandardResponse;

@RestController
@RequestMapping("/basic")
public class HelloController {
    @GetMapping("/hello")
    public StandardResponse<String> sayHello(@RequestParam String message) {
        return StandardResponse.<String>builder()
                .data(String.format("hello %s", message))
                .build();
    }
}
