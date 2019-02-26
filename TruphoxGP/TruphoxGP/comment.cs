using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace TruphoxGP
{
    public class comment
    { 
        public int postID { get; set; }
        public string commentText { get; set; }
        public DateTime commentDate { get; set; }
        public int postCommentNumber { get; set; }
        public string username { get; set; }

        DAL myDal;

        public comment(int PostID, string CommentText, DateTime CommentDate, int PostCommentNumber)
        {
            this.postID = PostID;
            this.commentText = CommentText;
            this.commentDate = CommentDate;
            this.postCommentNumber = PostCommentNumber;
        }

        public comment()
        {
           
        }      

        public void newComment(int PostID, string CommentText, string Username)
        {
            myDal = new DAL("spReadPost");
            myDal.addParm("postID", PostID.ToString());
            DataSet ds = myDal.getDataSet();

            postCommentNumber = Convert.ToInt32(ds.Tables[0].Rows[0]["lastComment"].ToString());

            myDal = new DAL("spCreateComment");
            myDal.addParm("postID", PostID.ToString());
            myDal.addParm("postCommentNumber", postCommentNumber.ToString());
            myDal.addParm("commentText", CommentText);
            myDal.addParm("username", Username);
            myDal.execNonQuery();            
        }
    }
}