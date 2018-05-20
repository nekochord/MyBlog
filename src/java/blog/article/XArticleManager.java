/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog.article;

import java.util.Set;
import java.util.Iterator;
import java.util.Date;
import java.util.HashSet;

/**
 *
 * @author 林哲宏
 */
public class XArticleManager extends ArticleManager {

    public XArticleManager() {
        this.articles = null;
    }

    @Override
    public boolean openArticles(String name) {
        this.articles = new XArticles(name);
        return this.articles != null;
    }

    @Override
    public int[] getArticleIDsSortedByDate() {
        Set<Integer> idset = this.articles.getArticleIDsSet();
        int[] answer = new int[idset.size()];
        if (idset.isEmpty()) {
            return answer;
        }
        int count = 0;
        while (!idset.isEmpty()) {
            //找出最新 加入answer陣列 然後把最新從idset剃除
            Iterator run = idset.iterator();
            Integer newest = (Integer) run.next();
            while (run.hasNext()) {
                Integer pointer = (Integer) run.next();
                Article a = articles.getArticleByID(newest);
                Article b = articles.getArticleByID(pointer);
                Article result = findNewestDateArticle(a, b);
                newest = (a == result) ? newest : pointer;
            }
            answer[count] = newest;
            count++;
            idset.remove(newest);
        }
        return answer;
    }

    private Article findNewestDateArticle(Article a, Article b) {
        Date da = a.get_date();
        Date db = b.get_date();
        if (da.compareTo(db) >= 0) {
            return a;
        } else {
            return b;
        }
    }

    @Override
    public Article getArticleByID(int id) {
        return this.articles.getArticleByID(id);
    }

    @Override
    public boolean deleteArticleByID(int id) {
        return this.articles.deleteArticleByID(id);
    }

    @Override
    public boolean addArticle(Article k) {
        return this.articles.addArticle(k);
    }

    @Override
    public boolean updateArticleByID(int id, Article k) {
        return this.articles.updateArticleByID(id, k);
    }

    @Override
    public int[] getArticleIDs() {
        return this.articles.getArticleIDs();
    }

    @Override
    public int[] getArticleIDsSortedByViews() {
        Set<Integer> idset = this.articles.getArticleIDsSet();
        int[] answer = new int[idset.size()];
        if (idset.isEmpty()) {
            return answer;
        }
        int count = 0;
        while (!idset.isEmpty()) {
            //找出最大 加入answer陣列 然後把最大從idset剃除
            Iterator run = idset.iterator();
            Integer big = (Integer) run.next();
            while (run.hasNext()) {
                Integer pointer = (Integer) run.next();
                Article a = articles.getArticleByID(big);
                Article b = articles.getArticleByID(pointer);
                Article result = findBigViews(a, b);
                big = (a == result) ? big : pointer;
            }
            answer[count] = big;
            count++;
            idset.remove(big);
        }
        return answer;
    }

    private Article findBigViews(Article a, Article b) {
        int aviews = a.getviews();
        int bviews = b.getviews();
        if (aviews >= bviews) {
            return a;
        } else {
            return b;
        }
    }

    @Override
    public String[] getArticleTags() {
        HashSet<String> tags = new HashSet<>();
        for (Integer i : this.articles.getArticleIDsSet()) {
            Article pointer = this.articles.getArticleByID(i);
            tags.add(pointer.get_tag());
        }
        return tags.toArray(new String[tags.size()]);
    }

    @Override
    public int[] getArticleIDsByTag(String tag) {
        HashSet<Integer> ids = new HashSet<>();
        for (Integer i : this.articles.getArticleIDsSet()) {
            Article pointer = this.articles.getArticleByID(i);
            if (pointer.get_tag().equals(tag)) {
                ids.add(i);
            }
        }
        int[] answer = new int[ids.size()];
        int count = 0;
        for (Integer i : ids) {
            answer[count] = i;
            count++;
        }
        return answer;
    }

    @Override
    public void addViewsByID(int id) {
        this.articles.getArticleByID(id).addviews();
    }

    @Override
    public int getViewsByID(int id) {
        return this.articles.getArticleByID(id).getviews();
    }

    public int[] getArticleIDsByTagAndSort(String tag, int sort_number) {
        int[] sortArticleIDs;
        if (sort_number == HOT_COLD_SORT) {
            int[] k = this.getArticleIDsSortedByViews();
            int[] p = this.getArticleIDsByTag(tag);
            sortArticleIDs = new int[p.length];
            int count = 0;
            for (int i = 0; i < k.length; i++) {
                if (arrayContain(p, k[i])) {
                    sortArticleIDs[count] = k[i];
                    count++;
                }
            }
            return sortArticleIDs;
        }
        if(sort_number == COLD_HOT_SORT){
            int[] k = this.getArticleIDsSortedByViews();
            int[] p = this.getArticleIDsByTag(tag);
            sortArticleIDs = new int[p.length];
            int count = 0;
            for(int i=k.length-1;i>=0;i--){
                if (arrayContain(p, k[i])) {
                    sortArticleIDs[count] = k[i];
                    count++;
                }
            }
           return sortArticleIDs;     
        }
        if(sort_number == NEW_OLD_SORT){
            int[] k = this.getArticleIDsSortedByDate();
            int[] p = this.getArticleIDsByTag(tag);
            sortArticleIDs = new int[p.length];
            int count = 0;
            for (int i = 0; i < k.length; i++) {
                if (arrayContain(p, k[i])) {
                    sortArticleIDs[count] = k[i];
                    count++;
                }
            }
            return sortArticleIDs;
        }
        if(sort_number==OLD_NEW_SORT){
            int[] k = this.getArticleIDsSortedByDate();
            int[] p = this.getArticleIDsByTag(tag);
            sortArticleIDs = new int[p.length];
            int count = 0;
            for(int i=k.length-1;i>=0;i--){
                if (arrayContain(p, k[i])) {
                    sortArticleIDs[count] = k[i];
                    count++;
                }
            }
           return sortArticleIDs;     
        }
        return null;
    }
    public int[] getArticleIDsBySort(int sort_number) {
        if (sort_number == HOT_COLD_SORT) {
            return this.getArticleIDsSortedByViews();
        }
        if(sort_number == COLD_HOT_SORT){
            int[] k=this.getArticleIDsSortedByViews();
            int[] p=new int[k.length];
            int count=0;
            for(int i=k.length-1;i>=0;i--){
                p[count]=k[i];
                count++;
            }
            return p;
        }
         if (sort_number == NEW_OLD_SORT) {
            return this.getArticleIDsSortedByDate();
        }
          if(sort_number == OLD_NEW_SORT){
            int[] k=this.getArticleIDsSortedByDate();
            int[] p=new int[k.length];
            int count=0;
            for(int i=k.length-1;i>=0;i--){
                p[count]=k[i];
                count++;
            }
            return p;
        }
        return null;
    }

    private boolean arrayContain(int[] array, int number) {
        for (int i : array) {
            if (i == number) {
                return true;
            }
        }
        return false;
    }
}
