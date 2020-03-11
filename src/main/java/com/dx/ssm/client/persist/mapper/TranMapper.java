package com.dx.ssm.client.persist.mapper;


import com.dx.ssm.client.model.TranDO;
import com.dx.ssm.client.model.UserInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface TranMapper {


    /**
     * 返回一篇文章的评论内容信息
     * @return
     */
    List<TranDO> getContent(@Param("article")String article);


    /**
     * 返回一篇文章的转发者信息
     * @return
     */
    List<UserInfo> attendPerson(@Param("article")String article);



    /**
     * 返回一篇文章的被转发的路径
     * @return
     */
    List<TranDO> queryPath(@Param("article")String article);


    /**
     * 返回一篇文章的被转发的层数
     * @return
     */
    List<TranDO> queryLevelBar(@Param("article")String article);


    /**
     * 返回一篇文章的引爆点
     * @return
     */
    List<TranDO> queryBombPoint(@Param("article")String article);

    /**
     * 返回一篇文章的引爆点信息
     *      *      * @return
     */
    List<TranDO> queryBombs (@Param("article")String article);

    /**
     * 返回一篇文章按照时间查询的结果
     * @return
     */
    List<TranDO> queryByTime(@Param("article")String article);

    /**
     * 返回该文章的发布者，内容
     * @return
     */
    TranDO queryFromWho(@Param("tablename")String tablename,@Param("article")String article);
}
