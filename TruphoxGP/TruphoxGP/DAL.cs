using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TruphoxGP
{
    public class DAL
    {
        string _connnectionString { get; set; }
        string _command { get; set; }

        SqlConnection _Connection;

        struct parms
        {
            public string _p;
            public string _v;
        }

        List<parms> _parms = new List<parms>();

        public DAL(string command)
        {
            _command = command;
            _connnectionString = ConfigurationManager.ConnectionStrings["dal"].ConnectionString;
            _Connection = new SqlConnection(_connnectionString);
        }

        public void addParm(string p, string v)
        {
            parms myParms = new parms();
            myParms._p = p;
            myParms._v = v;
            _parms.Add(myParms);
        }

        public void execNonQuery()
        {
            SqlCommand sc = new SqlCommand(_command, _Connection);
            sc.CommandType = CommandType.StoredProcedure;
            foreach (var parm in _parms)
            {
                sc.Parameters.AddWithValue(parm._p, parm._v);
            }
            _Connection.Open();
            sc.ExecuteNonQuery();
            _Connection.Close();
        }

        public string execScalar()
        {
            SqlCommand sc = new SqlCommand(_command, _Connection);
            sc.CommandType = CommandType.StoredProcedure;
            foreach (var parm in _parms)
            {
                sc.Parameters.AddWithValue(parm._p, parm._v);
            }
            _Connection.Open();
            string result = sc.ExecuteScalar().ToString();
            _Connection.Close();

            return result;
        }

        public DataSet getDataSet()
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(_command, _Connection);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            foreach (var parm in _parms)
            {
                da.SelectCommand.Parameters.AddWithValue(parm._p, parm._v);
            }

            _Connection.Open();
            da.Fill(ds);
            _Connection.Close();

            return ds;
        }

        public void clearParams()
        {
            _parms = new List<parms>();
        }
    }
}