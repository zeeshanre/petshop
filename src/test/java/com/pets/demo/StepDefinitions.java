package com.pets.demo;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import io.restassured.specification.RequestSpecification;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

public class StepDefinitions {
    private RequestSpecification request;
    private ValidatableResponse json;
    private Response response;
    private String requestPath;
    private String jsonString;
    private String newPetId;

    @Given("request path is {word}")
    public void request_path_is(String requestPath) {
        this.requestPath = requestPath;
        request = given();
    }

    @Given("request parameters are")
    public void request_parameters_are(DataTable dataTable) {
        List<Map<String, String>> list = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> requestParamMap : list) {
            String key = requestParamMap.get("Key");
            String value = requestParamMap.get("Value");
            request = given().param(key, value);
        }
    }

    @When("{word} method is called on webservice {word}")
    public void get_method_is_called_on_webservice(String requestMethod, String url) {
        if (StringUtils.isNotEmpty(requestPath)) {
            url = url + "/" + requestPath;
        }
        response = invokeRequest(requestMethod, url);
    }

    @Then("the status code is {int}")
    public void the_status_code_is(Integer statusCode) {
        json = response.then().statusCode(statusCode);
    }

    @Then("response includes the following")
    public void response_includes_the_following(Map<String, String> responseFields) {
        this.newPetId=this.response.jsonPath().getString("id");
        for (Map.Entry<String, String> field : responseFields.entrySet()) {
            json.body(field.getKey(), equalTo(field.getValue()));
        }
    }

    @Given("request json is {word}")
    public void request_json_is(String jsonFileName) throws IOException {
        jsonString =
          new String(Files.readAllBytes(Paths.get("src/test/resources/jsonRequests/" + jsonFileName)));
        request = given();
    }

    @Given("request path is newly created id")
    public void request_path_is_newly_created_id() {
        this.requestPath=this.newPetId;
    }

    private Response invokeRequest(String requestMethod, String url) {
        RequestSpecification when = request.when();
        if(StringUtils.isNotEmpty(jsonString)) {
            when = when.contentType(ContentType.JSON).body(jsonString);
        }
        switch (requestMethod) {
        case "GET":
            return when.get(url);
        case "POST":
            return when.post(url);
        case "PUT":
            return when.put(url);
        case "DELETE":
            return when.delete(url);
        }
        return null;
    }
}