﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace TruphoxGP
{
    /// <summary>
    /// Summary description for replyComment
    /// </summary>
    public class replyComment : IHttpHandler
    {
        int parentCommentID;
        DAL mydal;
        public void ProcessRequest(HttpContext context)
        {
            Security mySecurity = new Security();
            if (mySecurity.isLoggedIn == true)
            {
                context.Response.ContentType = "text/plain";
                if (context.Request.HttpMethod == "POST")
                {
                    parentCommentID = Convert.ToInt32(context.Request.Form["parentCommentID"].ToString());
                }

                string username = mySecurity.username;
                mydal = new DAL("spCreateCommentReply"); //add read comment reply proc
                mydal.addParm("parentCommentID", parentCommentID.ToString());
                mydal.addParm("username", username);
                DataSet ds = mydal.getDataSet();

                string result = GetJSONString(ds.Tables[0]);

                context.Response.ContentType = "text/javascript";
                context.Response.Write(result);
            }
        }

        public static string GetJSONString(DataTable Dt)
        {
            string[] StrDc = new string[Dt.Columns.Count];
            string HeadStr = string.Empty;
            for (int i = 0; i < Dt.Columns.Count; i++)
            {
                StrDc[i] = Dt.Columns[i].Caption;
                HeadStr += "\"" + StrDc[i] + "\" : \"" + StrDc[i] + i.ToString() + "¾" + "\",";
            }
            HeadStr = HeadStr.Substring(0, HeadStr.Length - 1);
            StringBuilder Sb = new StringBuilder();
            Sb.Append("{\"" + Dt.TableName + "\" : [");
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                string TempStr = HeadStr;
                Sb.Append("{");
                for (int j = 0; j < Dt.Columns.Count; j++)
                {
                    TempStr = TempStr.Replace(Dt.Columns[j] + j.ToString() + "¾", Dt.Rows[i][j].ToString().Trim());
                }
                Sb.Append(TempStr + "},");
            }
            Sb = new StringBuilder(Sb.ToString().Substring(0, Sb.ToString().Length - 1));
            Sb.Append("]}");
            return Sb.ToString();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}