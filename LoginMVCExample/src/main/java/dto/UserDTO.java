package dto;

public class UserDTO {
    private String nickname;
    private String password;
    private String gender;
    private String birthdate;

    public UserDTO() {}

    public UserDTO(String nickname, String password, String gender, String birthdate) {
        this.nickname = nickname;
        this.password = password;
        this.gender = gender;
        this.birthdate = birthdate;
    }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getBirthdate() { return birthdate; }
    public void setBirthdate(String birthdate) { this.birthdate = birthdate; }
}
