/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;
import java.util.*;
import java.io.*;

/**
 *
 * @author 林哲宏
 */
public class XArticles extends Articles {
    private HashMap<Integer,Article> all=null;
    private mapAccess mA=new mapAccess();
    private String user;
    public XArticles(String name){
        user=name;
       File userA=new File("D:\\blog_root\\Articles\\"+name);
       if(userA.exists()){
           all=mA.getMap(name);
       }
       if(all==null){
           all=new HashMap<>();
       }   
    }
    @Override
    public Article getArticleByID(int id) {
        return this.all.get(id);
    }

    @Override
    public boolean deleteArticleByID(int id) {
        Article check=this.all.remove(id);
        if(check != null){
            return save();
        }else{
            return false;
        }
    }

    @Override
    public boolean addArticle(Article k) {
        if(this.all.isEmpty()){
            return this.all.put(1, k)==null;
        }else{
            Set<Integer> keyset=this.all.keySet();
            Iterator<Integer> run=keyset.iterator();
            int max=0;
            System.out.println("計算下一個ID中...");
            while(run.hasNext()){
                max=Math.max(max,run.next());
            }
            System.out.println("計算完成!");
            if(this.all.put(max+1, k)==null){
                return save();
            }else{
                return false;
            }
        }
    }

    @Override
    public boolean updateArticleByID(int id, Article k) {
        if(this.all.replace(id, k)!=null){
            return save();
        }else{
            return false;
        }
        
    }

    @Override
    public int[] getArticleIDs() {
        Set<Integer> keyset=this.all.keySet();
        Iterator<Integer> run=keyset.iterator();
        int[] answer=new int[keyset.size()];
        int i=0;
        while(run.hasNext()){
            answer[i]=run.next();
            i++;
        }
        return answer;
    }
    @Override
    public  Set<Integer> getArticleIDsSet(){
        HashSet<Integer> k=new HashSet<>();
        for(Integer i : this.all.keySet()){
            k.add(i);
        }
        return k;
    }

    @Override
    public boolean close() {
        return this.save();
    }

    @Override
    public boolean save() {
        return mA.saveMap(user, this.all);
    }
    
}
class mapAccess{
    public HashMap<Integer,Article> getMap(String name) {
        try {
            File check=new File("D:\\blog_root\\Articles\\"+name);
            if(!check.exists()) return null;
            FileInputStream fis=new FileInputStream(check);
            ObjectInputStream ois =new ObjectInputStream(fis);
            HashMap<Integer,Article> k=(HashMap<Integer,Article>)ois.readObject();
            ois.close();
            return k;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public boolean  saveMap(String name,HashMap<Integer,Article> k){
        try {
            File check=new File("D:\\blog_root\\Articles\\"+name);
            check.delete();
            check.createNewFile();
            FileOutputStream fos=new FileOutputStream(check);
            ObjectOutputStream oos=new ObjectOutputStream(fos);
            oos.writeObject(k);
            oos.flush();
            oos.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}