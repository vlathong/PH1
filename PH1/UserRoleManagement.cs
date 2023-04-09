using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Oracle.ManagedDataAccess.Client;

namespace PH1
{
    public partial class UserRoleManagement : Form
    {
        OracleConnection conn;
        OracleCommand cmd;
        OracleDataReader dr;
        DataTable dt;
        public UserRoleManagement()
        {
            InitializeComponent();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Hide();
            MainMenu back = new MainMenu();
            back.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
            "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
            "(CONNECT_DATA =" +
            "(SERVER = DEDICATED)" +
            "(SERVICE_NAME = XE)" +
            ")" +
            ");User Id = ph1; password = 123;";
                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                string plsql = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
                cmd = new OracleCommand(plsql, conn);
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                int temp = dt.Rows.Count;
                conn.Close();
                conn.Open();
                cmd = new OracleCommand("sp_CreateUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("User id", OracleDbType.Varchar2).Value = textBox1.Text;
                cmd.Parameters.Add("password", OracleDbType.Varchar2).Value = textBox2.Text;
                cmd.Parameters.Add("tablespace", OracleDbType.Varchar2).Value = comboBox1.Text;
                cmd.Parameters.Add("quota", OracleDbType.Varchar2).Value = textBox4.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                string plsql1 = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
                OracleCommand cmd1 = new OracleCommand(plsql1, conn);
                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                dataGridView1.DataSource = dt1;
                int temp1 = dt1.Rows.Count;
                if (temp1 > temp)
                {
                    MessageBox.Show("CREATE NEW USER SUCCESSFULLY!");
                }
                else if (temp1 <= temp || textBox1.Text == "" || textBox2.Text == "")
                {
                    MessageBox.Show("USERNAME ALREADY EXIST, TRY NEW USERNAME!!!");
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
            "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
            "(CONNECT_DATA =" +
            "(SERVER = DEDICATED)" +
            "(SERVICE_NAME = XE)" +
            ")" +
            ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();

                string plsql = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
                cmd = new OracleCommand(plsql, conn);
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                int temp = dt.Rows.Count;
                conn.Close();
                conn.Open();

                cmd = new OracleCommand("sp_DeleteUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();

                dt.Load(dr);
                string plsql1 = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
                OracleCommand cmd1 = new OracleCommand(plsql1, conn);
                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                dataGridView1.DataSource = dt1;
                int temp1 = dt1.Rows.Count;
         
                if (temp1 < temp || textBox1.Text == "" || textBox2.Text == "")
                {
                    MessageBox.Show("DELETE USER SUCCESFULLY!");
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";
                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_UpdateUserPassword", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                cmd.Parameters.Add("password", OracleDbType.Varchar2).Value = textBox2.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                conn.Close();
                MessageBox.Show("UPDATE USER PASSWORD SUCCESSFULLY!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_UpdateUserTablespace", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                cmd.Parameters.Add("default_tablespace", OracleDbType.Varchar2).Value = comboBox1.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                conn.Close();
                MessageBox.Show("UPDATE USER TABLESPACE SUCCESSFULLY!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_UpdateUserQuota", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                cmd.Parameters.Add("max_bytes", OracleDbType.Int32).Value = Int32.Parse(textBox4.Text);
                cmd.Parameters.Add("default_tablespace", OracleDbType.Varchar2).Value = comboBox1.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                conn.Close();
                MessageBox.Show("UPDATE USER QUOTA SUCCESSFULLY!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();

                string plsql = "SELECT role FROM DBA_ROLES where role_id between 116 and 10000";
                cmd = new OracleCommand(plsql, conn);
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                int temp = dt.Rows.Count;
                conn.Close();
                conn.Open();

                cmd = new OracleCommand("sp_CreateRole", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("Rolename", OracleDbType.Varchar2).Value = textBox5.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();

                dt.Load(dr);
                string plsql1 = "SELECT role FROM DBA_ROLES where role_id between 116 and 10000";
                OracleCommand cmd1 = new OracleCommand(plsql1, conn);
                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                dataGridView1.DataSource = dt1;
                int temp1 = dt1.Rows.Count;
                if (temp1 > temp)
                {
                    MessageBox.Show("CREATE ROLE SUCCESSFULLY!");
                }
                else if (temp1 <= temp || textBox1.Text == "" || textBox2.Text == "")
                {
                    MessageBox.Show("ROLENAME ALREADY EXIST, TRY NEW ROLENAME!!!");
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";

                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();

                string plsql = "SELECT role FROM DBA_ROLES where role_id between 116 and 10000";
                cmd = new OracleCommand(plsql, conn);
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                int temp = dt.Rows.Count;
                conn.Close();
                conn.Open();

                cmd = new OracleCommand("sp_DeleteRole", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("rolename", OracleDbType.Varchar2).Value = textBox5.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();

                dt.Load(dr);
                string plsql1 = "SELECT role FROM DBA_ROLES where role_id between 116 and 10000";
                OracleCommand cmd1 = new OracleCommand(plsql1, conn);
                OracleDataReader dr1 = cmd1.ExecuteReader();
                DataTable dt1 = new DataTable();
                dt1.Load(dr1);
                dataGridView1.DataSource = dt1;
                int temp1 = dt1.Rows.Count;
                
                if (temp1 < temp || textBox5.Text == "")
                {
                    MessageBox.Show("DELETE ROLE SUCCESSFULLY!");
                }
                dataGridView1.Refresh();
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            try
            {
                string ConnectionString = "Data Source = (DESCRIPTION =" +
                    "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                    "(CONNECT_DATA =" +
                    "(SERVER = DEDICATED)" +
                    "(SERVICE_NAME = XE)" +
                    ")" +
                    ");User Id = ph1; password = 123;";
                conn = new OracleConnection();
                conn.ConnectionString = ConnectionString;
                conn.Open();
                cmd = new OracleCommand("sp_GrantRoleToUser", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("username", OracleDbType.Varchar2).Value = textBox1.Text;
                cmd.Parameters.Add("role", OracleDbType.Varchar2).Value = textBox5.Text;
                dr = cmd.ExecuteReader();
                dt = new DataTable();
                dt.Load(dr);
                MessageBox.Show("GRANT ROLE FOR USER SUCCESFULLY!");
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR OCCURRED: " + ex.Message);
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                "(CONNECT_DATA =" +
                "(SERVER = DEDICATED)" +
                "(SERVICE_NAME = XE)" +
                ")" +
                ");User Id = ph1; password = 123;";
            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            string pls = "select username from dba_users where username not in ('ANONYMOUS','APEX_040200','APEX_PUBLIC_USER','APPQOSSYS','AUDSYS','BI','CTXSYS','DBSNMP','DIP','DVF','DVSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER','HR','IX','LBACSYS','MDDATA','MDSYS','OE','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','PM','SCOTT','SH','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSBACKUP','SYSDG','SYSKM','SYSTEM','WMSYS','XDB','SYSMAN','RMAN','RMAN_BACKUP','OWBSYS','OWBSYS_AUDIT','APEX_030200','MGMT_VIEW','OJVMSYS','XS$NULL', 'DBSFWUSER', 'GGSYS', 'OLAPSYS','REMOTE_SCHEDULER_AGENT', 'SYSRAC', 'GSMROOTUSER', 'DGPDB_INT', 'SYS$UMF')";
            cmd = new OracleCommand(pls, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView1.DataSource = dt;
            conn.Close();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                 "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                 "(CONNECT_DATA =" +
                 "(SERVER = DEDICATED)" +
                 "(SERVICE_NAME = XE)" +
                 ")" +
                 ");User Id = ph1; password = 123;";

            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            string pls = "SELECT * FROM DBA_ROLES where role_id between 116 and 10000";
            cmd = new OracleCommand(pls, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView2.DataSource = dt;
            conn.Close();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            string ConnectionString = "Data Source = (DESCRIPTION =" +
                 "(ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))" +
                 "(CONNECT_DATA =" +
                 "(SERVER = DEDICATED)" +
                 "(SERVICE_NAME = XE)" +
                 ")" +
                 ");User Id = ph1; password = 123;";
            conn = new OracleConnection();
            conn.ConnectionString = ConnectionString;
            conn.Open();
            string plsql = "SELECT* FROM DBA_ROLE_PRIVS WHERE GRANTEE = '" + textBox1.Text + "'";
            cmd = new OracleCommand(plsql, conn);
            dr = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(dr);
            dataGridView2.DataSource = dt;
            conn.Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView1.CurrentCell.Selected = true;
            textBox1.Text = dataGridView1.Rows[e.RowIndex].Cells["username"].Value.ToString();
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            dataGridView2.CurrentCell.Selected = true;
            textBox5.Text = dataGridView2.Rows[e.RowIndex].Cells["role"].Value.ToString();
        }
    }
    
}
