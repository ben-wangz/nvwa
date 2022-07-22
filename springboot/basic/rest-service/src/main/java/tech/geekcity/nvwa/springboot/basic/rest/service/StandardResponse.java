package tech.geekcity.nvwa.springboot.basic.rest.service;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Builder
@AllArgsConstructor
public class StandardResponse<DataType> {
    @Builder.Default
    @Getter
    private long code = 200L;
    @Getter
    DataType data;
    @Getter
    private String message;
}
