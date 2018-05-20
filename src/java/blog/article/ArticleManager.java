/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;

/**
 *
 * @author 林哲宏
 */
public abstract class ArticleManager {
    Articles articles;
    public final int HOT_COLD_SORT=1;
    public final int COLD_HOT_SORT=2;
    public final int NEW_OLD_SORT=3;
    public final int OLD_NEW_SORT=4;
    public abstract boolean openArticles(String name);
    public Articles getArticles(){
        return articles;
    }
    public void closeArticles(){
        articles.close();
        articles=null;
    }
    public abstract int[] getArticleIDsSortedByDate();    
    public abstract Article getArticleByID(int id);
    public abstract boolean deleteArticleByID(int id);
    public abstract boolean addArticle(Article k);
    public abstract boolean updateArticleByID(int id,Article k);
    public abstract int[] getArticleIDs();
    public abstract int[] getArticleIDsSortedByViews();
    public abstract String[] getArticleTags();
    public abstract int[] getArticleIDsByTag(String tag);
    public abstract void addViewsByID(int id);
    public abstract int getViewsByID(int id);
}
