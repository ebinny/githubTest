package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import db.DBConn;
import dto.UserDTO;

public class UserDAO {

    // 회원가입
    public boolean insertUser(UserDTO user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            conn = DBConn.getConnection();
            String sql = "INSERT INTO users (nickname, password, gender, birthdate) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNickname());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getGender());
            pstmt.setString(4, user.getBirthdate());

            int rows = pstmt.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        return result;
    }

    public boolean loginUser(String nickname, String password) {
        String sql = "SELECT * FROM users WHERE nickname = ? AND password = ?";

        try (Connection conn = DBConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, nickname);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();
            return rs.next();  // 결과 있으면 로그인 성공

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

