using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TruphoxGP
{
    public class Security
    {
        public string username { get; set; }
        public string userPassword { get; set; }
        public int accessLevel { get; set; }
        public bool isLoggedIn { get; set; }
        public bool active { get; set; }

        DAL myDal;

        public Security()
        {
            if(HttpContext.Current.Session["username"] != null)
            {
                username = (string)HttpContext.Current.Session["username"];
                userPassword = (string)HttpContext.Current.Session["userPassword"];
                accessLevel = (int)HttpContext.Current.Session["accessLevel"];
                active = (bool)HttpContext.Current.Session["active"];
                isLoggedIn = true;
            }

            else
            {
                username ="";
                userPassword = "";
                accessLevel = -1;
                isLoggedIn = false;
            }
        }

        public Security(string Username, string UserPassword)
        {
            username = Username;
            userPassword = UserPassword;

            //Login Proc
            myDal = new DAL("spLogin");
            myDal.addParm("username", username);
            myDal.addParm("userPassword", userPassword);
            DataSet ds = myDal.getDataSet();

            string message = ds.Tables[0].Rows[0]["message"].ToString();
            accessLevel = Convert.ToInt32(ds.Tables[0].Rows[0]["accessLevel"]);
            username = ds.Tables[0].Rows[0]["username"].ToString();
            active = Convert.ToBoolean(ds.Tables[0].Rows[0]["active"]);

            if (message == "valid")
            {
                isLoggedIn = true;
                HttpContext.Current.Session["username"] = username;
                HttpContext.Current.Session["userPassword"] = userPassword;
                HttpContext.Current.Session["isLoggedIn"] = isLoggedIn;
                HttpContext.Current.Session["accessLevel"] = accessLevel;
                HttpContext.Current.Session["active"] = active;

            }
            else
            {
                isLoggedIn = false;
            }
        }
    }
}