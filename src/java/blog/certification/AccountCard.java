/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.certification;
import java.io.Serializable;
/**
 *
 * @author 林哲宏
 */
public class AccountCard implements Serializable{
    private final String userName;
    private String passWord;
    private String email;
    public AccountCard(String userName,String passWord ,String email){
        this.userName=userName;
        this.passWord=passWord;
        this.email=email;
    }
    public void set_passWord(String k){
        this.passWord=k;
    }
    public void set_email(String k){
        this.email=k;
    }
    public String get_userName(){
        return this.userName;
    }
    public String get_passWord(){
        return this.passWord;
    }
    public String get_email(){
        return this.email;
    }
}
