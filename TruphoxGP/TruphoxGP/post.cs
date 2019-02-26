using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace TruphoxGP
{
    public class post
    {
        DAL myDal;

        public string postText { get; set; }
        public DateTime postDate { get; set; }

        public List<comment> comments;

        public post()
        {
            comments = new List<comment>();
        }

        public List<comment> getComments(int postID)
        {
            myDal = new DAL("spReadComment");
            myDal.addParm("postID", postID.ToString());
            DataSet ds = myDal.getDataSet();

            DataTable dt = new DataTable();
            dt = ds.Tables[0];

            foreach (DataRow dr in dt.Rows)
            {
                comment newComment = new comment();
                newComment.commentText = dr["commentText"].ToString();
                newComment.commentDate = Convert.ToDateTime(dr["commentDate"].ToString());
                newComment.postCommentNumber = Convert.ToInt32(dr["postCommentNumber"].ToString());
                newComment.postID = Convert.ToInt32(dr["postID"].ToString());
                newComment.username = dr["username"].ToString();

                comments.Add(newComment);
            }
            return comments;
        }
    }
}