/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.certification;
import java.io.*;

/**
 *
 * @author 林哲宏
 */
public class Xman implements AccountMan{
    private CardAccess CA=new CardAccess();
    @Override
    public boolean login(String userName, String passWord) {
        File check=new File("D:\\blog_root\\Cards\\"+userName);
        if(!check.exists())return false;
        AccountCard user = CA.getCard(userName);
        if(user==null) return false;
        else{
            return passWord.equals(user.get_passWord());    
        }     
    }

    @Override
    public int register(String userName, String passWord, String email) {
        int status_code;
        File check=new File("D:\\blog_root\\Cards\\"+userName);
        if(!check.exists()){
            try{
                check.createNewFile();
                AccountCard user=new AccountCard(userName, passWord, email);
                CA.storeCard(user);
                status_code=100;
            }catch(Exception e){
                //寫入資料時發生錯誤
                e.printStackTrace();
                status_code=101;
            }
        }else{
            //存在相同使用者
            status_code=102;
        }
        return status_code;
    }
    public boolean checkExists(String userName){
        File check=new File("D:\\blog_root\\Cards\\"+userName);
       return check.exists();
    }
}
class CardAccess{
    public AccountCard getCard(String userName){
        try{
            FileInputStream fis = new FileInputStream("D:\\blog_root\\Cards\\"+userName);
            ObjectInputStream ois=new ObjectInputStream(fis);
            AccountCard k=(AccountCard)ois.readObject();
            ois.close();
            return k;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void storeCard(AccountCard card) throws Exception{
            File check=new File("D:\\blog_root\\Cards\\"+card.get_userName());
            check.createNewFile();
            FileOutputStream fos = new FileOutputStream(check);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(card);
            oos.flush();
            oos.close();  
    }
}
