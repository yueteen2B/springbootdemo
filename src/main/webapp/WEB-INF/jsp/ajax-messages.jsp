<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<jsp:include page="layout/default.jsp" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

<style>
    body {
        display: flex;
        flex-direction: column;
        position: relative;
        align-items: center;
    }
    
    nav{
         width: 100%;
    }

    .container {
        margin-top: 50px;
        display: flex;
        flex-direction: column;
        position: relative;
        align-items: center;
    }
    
    .container #myMesssage {
        border-radius: 36px;
        margin-bottom: 20px;
        padding-left:20px;
    }
    
    .container #submitBtn {
        border-radius: 12px;
        padding: 8px;
        margin-bottom: 20px;
    }
    
    .container .mytable tr {
        border: 1px solid #ccc;
        padding: 5px;
    }
    .container .mytable tr th,.container .mytable tr td{
        text-align: center;
            padding: 15px;
    }
    </style>
    
    </head>
    <body>
        <div class="container">
            <input id="myMessage" />
            <button id="submitBtn">送出</button>
    
            <div>
                <table class="mytable" id="list_table_json">
                    <thead>
                        <tr>
                            <th>訊息內容</th>
                            <th>時間</th>
                        </tr>
                    </thead>
                    <tbody id="tbody">
    
                    </tbody>
                </table>
            </div>
    
        </div>


    <script>
        $(document).ready(function () {
            $('#submitBtn').click(function () {
                var inputText = document.getElementById('myMessage').value;
                var dtoObject = { "message": inputText };
                var dtoJsonString = JSON.stringify(dtoObject);

                $.ajax({
                    url:'http://localhost:8080/myapp/api/postMessage',
                    contentType: 'application/json; charset=UTF-8', // 送過去的
                    dataType: "json", // 傳回來的
                    method: 'post',
                    data: dtoJsonString,
                    success: function (result) {
                        $('#tbody tr td').remove();
                        console.log(result)
                        msg_data = '';
                        $.each(result, function (index, value) {
                            msg_data += "<tr><td>" + value.text + "</td><td>" + value.added + "</td></tr>"
                        })
                        $('#tbody').append(msg_data);

                    },

                    error: function (err) {
                        console.log(err)
                    }
                })

            })

        })

    </script>

</body>

</html>

<!-- 0406 -->