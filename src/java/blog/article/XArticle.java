/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;
import java.io.Serializable;
import java.util.Date;
/**
 *
 * @author 林哲宏
 */
public class XArticle extends Article implements Serializable{
    private String title;
    private Date date;
    private String picture_url;
    private String context;
    private String tag;
    private int views;
    public XArticle(String title,Date date,String picture_url,String context,String tag){
        this.title=title;
        this.date=date;
        this.picture_url=picture_url;
        this.tag=tag;
        this.context=context;
        this.views=0;
    }
    @Override
    public void set_title(String title) {
        this.title=title;
    }

    @Override
    public void set_date(Date date) {
        this.date=date;
    }

    @Override
    public void set_picture_url(String picture_url) {
        this.picture_url=picture_url;
    }

    @Override
    public void set_context(String context) {
       this.context=context;
    }

    @Override
    public void set_tag(String tag) {
        this.tag=tag;
    }

    @Override
    public String get_tag() {
        return this.tag;
    }

    @Override
    public String get_title() {
        return this.title;
    }

    @Override
    public Date get_date() {
         return this.date;
    }

    @Override
    public String get_picture_url() {
        return this.picture_url;
    }

    @Override
    public String get_context() {
        return this.context;
    }

    @Override
    public void addviews() {
       this.views++;
    }

    @Override
    public int getviews() {
         return this.views;
    }
    
}
