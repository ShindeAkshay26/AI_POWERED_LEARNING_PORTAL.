<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
    <style>
        .feedback-text {
            white-space: pre-wrap;
        }
        .feedback-strong {
            font-weight: bold;
        }
    </style>
    
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Quiz Results</h1>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        Congratulations, here are your results:
                    </div>
                    <div class="card-body">
                        <% System.out.println("Score from session: " + session.getAttribute("score")); %>
                        <h5 class="card-title">Your Score: <%= session.getAttribute("score") %></h5>
                        <% System.out.println("Total Time Spent from session: " + session.getAttribute("totalTimeSpent")); %>
                        <p class="card-text">Total Time Spent: <%= session.getAttribute("totalTimeSpent") %> seconds</p>
                        <a href="index.jsp" class="btn btn-primary">Take Another Quiz</a>
                                <!-- AI Feedback Section -->
        <div class="ai-feedback mt-4">
            <h2>⭐Feedback from AI:⭐</h2>
            <div class="feedback-text">
                <%
                String aiFeedback = (String)session.getAttribute("aiFeedback");
                System.out.println("AI Feedback: " + aiFeedback);
                if(aiFeedback != null && !aiFeedback.isEmpty()) {
                    // Split the feedback into sentences or parts
                    String[] parts = aiFeedback.split("\\. ");
                    for(String part : parts) {
                        if(part.trim().length() > 0) {
                            // Identify if the part is important and should be bolded
                            if(part.contains("Learning Portal Feedback Assistant")||part.contains("improve")||part.contains("correct answer") || part.contains("Well done") || part.contains("total") || part.contains("correctly")) {
                                out.println("<strong class='feedback-strong'>" + part + ".</strong><br>");
                            } else {
                                out.println(part + ".<br>");
                            }
                        }
                    }
                } else {
                    out.println("No feedback available.");
                }
                %>
            </div>
        </div>                    
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
