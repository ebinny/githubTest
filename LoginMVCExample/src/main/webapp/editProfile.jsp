<%@ page import="java.sql.*" %>
<%@ page import="db.DBConn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

// 🔐 세션에서 로그인된 사용자 닉네임 가져오기
String loginNickname = (String)session.getAttribute("nickname");

if (loginNickname == null) {
    // 로그인 안 했으면 로그인 페이지로 이동
    response.sendRedirect("login.jsp");
    return;
}

// 폼에서 전송된 값 가져오기
String newNickname = request.getParameter("newNickname");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");
String realName = request.getParameter("realName");

// 값이 모두 들어온 경우만 처리
if (newNickname != null && newPassword != null && confirmPassword != null && realName != null) {
    if (!newPassword.equals(confirmPassword)) {
%>
        <script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>
<%
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConn.getConnection();
            String sql = "UPDATE users SET nickname = ?, password = ?, name = ? WHERE nickname = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newNickname);
            pstmt.setString(2, newPassword);
            pstmt.setString(3, realName);
            pstmt.setString(4, loginNickname); // 기존 닉네임

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                // 닉네임이 바뀌었으면 세션도 갱신
                session.setAttribute("nickname", newNickname);
%>
                <script>alert('회원 정보가 수정되었습니다.'); location.href = 'main.jsp';</script>
<%
            } else {
%>
                <script>alert('수정 실패!'); history.back();</script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>alert('DB 오류 발생'); history.back();</script>
<%
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>프로필 수정</title>
  <link href="https://fonts.googleapis.com/css2?family=Jockey+One&display=swap" rel="stylesheet" />
  <style>
    @font-face {
      font-family: 'PFStardustExtraBold';
      src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2506-1@1.0/PFStardustExtraBold.woff2') format('woff2');
      font-weight: 800;
      font-style: normal;
    }
    .EditProfile_background {background:linear-gradient(black 30%, yellow);height:100vh;position:relative;font-family:'Jockey One',sans-serif;}
    .background_head{position:absolute;top:1%;left:1%;font-size:32px;color:white;}
    .background_head a{text-decoration:none;color:inherit;}
    .background_light{position:absolute;left:50%;transform:translateX(-50%);height:100vh;}
    .EditProfile_form{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:40%;height:80vh;background:linear-gradient(#FFF95B,white);border-radius:8px;box-shadow:0 4px 12px rgba(0,0,0,0.2);padding:1.5rem 5%;display:flex;flex-direction:column;font-family:'PFStardustExtraBold',sans-serif;font-size:20px;}
    .back_arrow{width:10%;height:auto;display:block;margin-bottom:1rem;cursor:pointer;}
    .EditProfile_form h1{text-align:center;font-size:48px;margin:0 0 2rem;}
    .EditProfile_form p{margin:0.5rem 0 0.2rem;}
    .EditProfile_form input{width:100%;margin-bottom:1.5rem;padding:0.5rem;box-sizing:border-box;font-family:inherit;font-size:1rem;border-radius:4px;border:1px solid #ccc;}
    .link_p{margin-top:auto;text-align:right;}
    .link_p a{text-decoration:none;color:#00CC77;}
    .save_btn{display:flex;justify-content:center;align-items:center;margin-top:2rem;}
    .save_btn button{width:30%;height:5vh;border-radius:15px;background:linear-gradient(#8FFFEC,white);border:none;font-family:'PFStardustExtraBold',sans-serif;font-size:1rem;cursor:pointer;}
  </style>
</head>
<body>
  <div class="EditProfile_background">
    <div class="background_head">
      <a href="<%=request.getContextPath()%>/">Excited</a>
    </div>
    <div class="background_light">
      <img src="<%=request.getContextPath()%>/images/lightning.png" alt="번개 이미지" />
    </div>
    <div class="EditProfile_form">
      <a href="<%=request.getContextPath()%>/">
        <img class="back_arrow" src="<%=request.getContextPath()%>/images/BackArrow.png" alt="뒤로가기 화살표" />
      </a>
      <h1>프로필 수정</h1>
      <form action="editProfile.jsp" method="post">
        <p>새 닉네임</p>
        <input type="text" name="newNickname" placeholder="ex) 태그맨" required />

        <p>새 비밀번호</p>
        <input type="password" name="newPassword" required />

        <p>비밀번호 확인</p>
        <input type="password" name="confirmPassword" required />

        <p>이름</p>
        <input type="text" name="realName" required />

        <p class="link_p">
          <a href="<%=request.getContextPath()%>/tmi.jsp">TMI 설정하기 →</a>
        </p>

        <div class="save_btn">
          <button type="submit">저장</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
