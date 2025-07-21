<%@ page import="dao.UserDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String nickname = request.getParameter("nickname");
String password = request.getParameter("password");

// 로그인 요청이 들어왔을 때만 처리
if (nickname != null && password != null) {
    nickname = nickname.trim();
    password = password.trim();

    if (nickname.equals("") || password.equals("")) {
%>
        <script>
            alert("닉네임과 비밀번호를 모두 입력하세요.");
            history.back();
        </script>
<%
    } else {
        UserDAO dao = new UserDAO();
        boolean loginSuccess = dao.loginUser(nickname, password);

        if (loginSuccess) {
            session.setAttribute("nickname", nickname);  // 세션 저장
%>
            <script>
                alert("로그인 성공!");
                location.href = "main.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("로그인 실패. 닉네임 또는 비밀번호를 확인하세요.");
                history.back();
            </script>
<%
        }
    }

    return; // 아래 HTML 출력 막음
}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SIGN IN</title>
    <!-- 구글 폰트 -->
    <link 
      href="https://fonts.googleapis.com/css2?family=Jockey+One&display=swap" 
      rel="stylesheet"
    />
    <style>
      .login_background {
          background: linear-gradient(black 30%, yellow);
          height: 100vh;
      }

      .background_head a {
          text-decoration: none;
          color: white;
      }
      .background_head {
          font-family: "Jockey One", sans-serif;
          font-size: 32px;
          color: white;
          margin-left: 1%;
          padding-top: 1%;
      }

      .background_light {
          display: flex;
          justify-content: center;
      }

      .login_form {
          position: absolute;
          top: 20%;
          left: 30%;
          display: flex;
          justify-content: center;
          align-items: center;
          background: linear-gradient(#FFF95B, white);
          width: 40%;
          font-family: "Jockey One", sans-serif;
          height: 60vh;
          border-radius: 17px;
      }

      .login_form_table {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
      }
      .login_form_name {
          font-size: 64px;
          padding-bottom: 10vh;
          margin-top: 4vh;
          text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;
      }
      .input_table {
          width: 100%;
          display: flex;
          justify-content: space-around;
          margin-bottom: 3%;
      }
      .input_table [type="text"],
      .input_table [type="password"] {
          width: 50%;
          border-radius: 5px;
          height: 4.4vh;
      }
      .input_table label {
          font-size: 32px;
      }

      .login_btn {
          font-family: "Jockey One", sans-serif;
          border: 1px solid black;
          text-align: center;
          margin-top: 5vh;
          width: 70%;
          height: 10vh;
          border-radius: 15px;
          background: linear-gradient(#8FFFEC, white);
          font-size: 32px;
          cursor: pointer;
      }

      .register_ment {
          margin-top: 1.5%;
          text-decoration: none;
          color: black;
      }
      .register_ment a {
          color: inherit;
      }
    </style>
</head>
<body>
    <div class="login_background">
        <!-- 헤더 -->
        <div class="background_head">
            <a href="${pageContext.request.contextPath}/">Excited</a>
        </div>

        <!-- 번개 이미지 -->
        <div class="background_light">
            <img 
              src="${pageContext.request.contextPath}/assets/images/lightning.png" 
              alt="번개 이미지"
            />
        </div>

        <!-- 로그인 폼 -->
        <div class="login_form">
            <form 
              class="login_form_table"
              action="login.jsp" 
              method="post"
            >
                <p class="login_form_name">SIGN IN</p>

                <div class="input_table">
                    <label for="nickname">Nickname</label>
                    <input 
                      type="text" 
                      id="nickname" 
                      name="nickname" 
                      required
                    />
                </div>

                <div class="input_table">
                    <label for="password">Password</label>
                    <input 
                      type="password" 
                      id="password" 
                      name="password" 
                      required
                    />
                </div>

                <button 
                  type="submit" 
                  class="login_btn"
                >
                  Login
                </button>

                <p class="register_ment">
                    <a href="${pageContext.request.contextPath}/join.jsp">
                      아이디가 없으신가요?
                    </a>
                </p>
            </form>
        </div>
    </div>
</body>
</html>

