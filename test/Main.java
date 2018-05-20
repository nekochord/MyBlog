/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author 林哲宏
 */
import blog.article.*;
import java.util.Calendar;
import java.util.Date;
public class Main {
    public static void main(String[] args){
        XArticleManager test=new XArticleManager();
        test.openArticles("neko");
        Calendar ca=Calendar.getInstance();
        ca.set(2018, 2, 5, 12, 0, 0);
        XArticle a1=new XArticle("標題三",ca.getTime(),"picture","我是一的文章，還有他他他","生活");
        a1.addviews();
        a1.addviews();
        a1.addviews();
        a1.addviews();
        a1.addviews();
        ca.set(2018, 2, 5, 13, 0, 0);
        XArticle a2=new XArticle("標題三",ca.getTime(),"picture","我是一的文章，還有他他他","生活");
        a2.addviews();
        a2.addviews();
        ca.set(2018, 2, 5, 14, 0, 0);
        XArticle a3=new XArticle("標題三",ca.getTime(),"picture","我是一的文章，還有他他他","生活");
        test.addArticle(a1);
        test.addArticle(a2);
        test.addArticle(a3);
    }
}
