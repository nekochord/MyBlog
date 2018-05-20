/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;
import java.util.Date;
/**
 *
 * @author 林哲宏
 */
public abstract class Article {
    abstract public void set_title(String title);
    abstract public void set_date(Date date);
    abstract public void set_picture_url(String picture_url);
    abstract public void set_context(String context);
    abstract public void set_tag(String tag);
    abstract public String get_tag();
    abstract public String get_title();
    abstract  public Date get_date();
    abstract public String get_picture_url();
    abstract public String get_context();
    abstract public void addviews();
    abstract public int getviews();
}
