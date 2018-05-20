/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.certification;

/**
 *
 * @author 林哲宏
 */
interface AccountMan {
    public boolean login(String userName,String passWord);
    public int register(String userName,String passWord,String email);
}
