<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.learningportal.dao.TestResultDAO, com.learningportal.model.TestResult"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Performance</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="navbar.jsp"%>
    <div class="container mt-4">
        <h1 class="text-center mb-4">My Performance</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Test Date</th>
                    <th>Course</th>
                    <th>Score</th>
                    <th>Time Taken (seconds)</th>
                    <th>Feedback From AI</th>
                </tr>
            </thead>
            <tbody>
                <% 
                // Simulating a user ID for demonstration; in a real application, fetch this from session or user context
                
                Integer userId = (Integer) session.getAttribute("userId");
                List<TestResult> testResults = TestResultDAO.getTestResultsByUserId(userId);
                for(TestResult result : testResults) {
                %>
                <tr>
                    <td><%= result.getTestDate() %></td>
                    <td><% if(result.getCourseId()==1){ 
                    		out.print("C programming"); 
                    		}else if(result.getCourseId()==2)
                    			out.print("Java Programming");
                    		else
                    			out.print(result.getCourseId());
                    	%>
                    </td>
                    <td><%= result.getScore() %></td>
                    <td><%= result.getTimeTaken() %></td>
                    <td><%= result.getFeedback() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%>
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.learningportal.dao.TestResultDAO, com.learningportal.model.TestResult"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Performance</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="navbar.jsp"%>
<%
	Integer userId = (Integer) session.getAttribute("userId");
	List<TestResult> testResults = TestResultDAO.getTestResultsByUserId(userId);
	int totalCoursesExplored = TestResultDAO.getTotalCoursesExplored(userId);
	String bestPerformanceCourse = TestResultDAO.getBestPerformanceCourse(userId);
	double overallScore = TestResultDAO.getOverallAverageScore(userId);
%>
<div class="container mt-5">
    <h1 class="text-center mb-4">My Performance Dashboard</h1>
    <div class="row text-center mb-4">
        <div class="col-lg-4 mb-3">
            <div class="card bg-info text-white h-100">
                <div class="card-body">
                    <h2 class="card-title">Total Courses</h2>
                    <p class="display-4"><%= totalCoursesExplored %></p>
                    <p class="card-text">Courses Explored</p>
                </div>
            </div>
        </div>
        <div class="col-lg-4 mb-3">
            <div class="card bg-success text-white h-100">
                <div class="card-body">
                    <h2 class="card-title">Best Performance</h2>
                    <p class="display-4"><%= bestPerformanceCourse %></p>
                    <!-- Best score can be placed here -->
                </div>
            </div>
        </div>
        <div class="col-lg-4 mb-3">
            <div class="card bg-warning text-white h-100">
                <div class="card-body">
                    <h2 class="card-title">Overall Score</h2>
                    <p class="display-4"><%= String.format("%.2f", overallScore) %> %</p>
                    <!-- Overall score can be calculated and placed here -->
                </div>
            </div>
        </div>
    </div>
    <!-- Detailed Results -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Test Date</th>
                    <th>Course</th>
                    <th>Score</th>
                    <th>Time Taken (sec)</th>
                    <th>⭐ 🅰️ℹ️ Feedback ⭐</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for(TestResult result : testResults) {
                    	String courseName = TestResultDAO.getCourseName(result.getCourseId());
                %>
                <tr>
                    <td><%= result.getTestDate() %></td>
                    <td><%= courseName %></td>
                    <td><%= result.getScore() %></td>
                    <td><%= result.getTimeTaken() %></td>
                    <td>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#feedbackModal<%= result.getResultId() %>">Read</button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% 
        // Modals for AI feedback
        for(TestResult result : testResults) {
    %>
        <div class="modal fade" id="feedbackModal<%= result.getResultId() %>" tabindex="-1" role="dialog" aria-labelledby="feedbackModalTitle<%= result.getResultId() %>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="feedbackModalTitle<%= result.getResultId() %>">⭐AI Feedback⭐</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <%= result.getFeedback() %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 