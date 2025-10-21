package com.trip.ai.service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class GeminiClient {

    private final String apiKey;
    private final HttpClient client;
    private final String model = "gemini-2.5-flash";

    public GeminiClient(String apiKey) {
        this.apiKey = apiKey;
        this.client = HttpClient.newHttpClient();
    }

    public String generate(String prompt) throws Exception {
        String url = "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent";

        String jsonBody = """
        {
            "contents": [
                {"parts": [{"text": "%s"}]}
            ]
        }
        """.formatted(prompt.replace("\"", "\\\""));

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url + "?key=" + apiKey))
                .timeout(Duration.ofSeconds(60))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                .build();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            // 오류 메시지를 더 명확하게 변경
            throw new RuntimeException("Gemini API Error: " + response.statusCode() + " " + response.body());
        }

        return response.body();
    }
}