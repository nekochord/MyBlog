/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;
import java.util.Set;
/**
 *
 * @author 林哲宏
 */
public abstract class Articles {
    public abstract Article getArticleByID(int id);
    public abstract boolean deleteArticleByID(int id);
    public abstract boolean addArticle(Article k);
    public abstract boolean updateArticleByID(int id,Article k);
    public abstract int[] getArticleIDs();
    public abstract Set<Integer> getArticleIDsSet();
    public abstract boolean close();
    public abstract boolean save();
}
