using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.Windows.Forms.DataVisualization.Charting;
using MySql.Data.MySqlClient;


namespace weather_stationv102
{
    public partial class Form1 : Form
    {
        private MySqlConnection connection;
        private string server;
        private string database;
        private string uid;
        private string password;
        string wind_direction_text;
        string query;


        double wind_speed_current, wind_speed_max, wind_direction;
        double pressure_current, pressure_max, pressure_min;
        double temperature_current, temperature_max, temperature_min;
        double humidity_current, humidity_max, humidity_min;
        double day_rainfall_current, day_rainfall_max;
        double hour_current, minute_current;
        double minute_axis;
        double latency, pdr, troughput;
        double temperature_compare, pressure_compare, humidity_compare, wind_speed_compare;
        DateTime timeaxis;

        int flag_first_data;
        int data_number;
        int data_has_been_updated;

        string waktu;
        string dtmysqlkirim;

        int today;
        int jam, menit, detik, jam_alarm, menit_alarm, menit_alarm_plus;

        string tahuntext,bulantext,tanggaltext,jamtext,menittext;

        DataTable table = new DataTable();

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void exportdatabutton_Click(object sender, EventArgs e)
        {
            Microsoft.Office.Interop.Excel._Application excel = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel._Workbook workbook = excel.Workbooks.Add(Type.Missing);
            Microsoft.Office.Interop.Excel._Worksheet worksheet = null;

            try
            {

                worksheet = workbook.ActiveSheet;

                worksheet.Name = "ExportedFromDatGrid";

                int cellRowIndex = 1;
                int cellColumnIndex = 1;

                //Loop through each row and read value from each column. 
                for (int i = 0; i < dataGridView1.Rows.Count - 1; i++)
                {
                    for (int j = 0; j < dataGridView1.Columns.Count; j++)
                    {
                        // Excel index starts from 1,1. As first Row would have the Column headers, adding a condition check. 
                        if (cellRowIndex == 1)
                        {
                            worksheet.Cells[cellRowIndex, cellColumnIndex] = dataGridView1.Columns[j].HeaderText;
                        }
                        else
                        {
                            worksheet.Cells[cellRowIndex, cellColumnIndex] = dataGridView1.Rows[i].Cells[j].Value.ToString();
                        }
                        cellColumnIndex++;
                    }
                    cellColumnIndex = 1;
                    cellRowIndex++;
                }

                //Getting the location and file name of the excel to save from user. 
                SaveFileDialog saveDialog = new SaveFileDialog();
                saveDialog.Filter = "Excel files (*.xlsx)|*.xlsx|All files (*.*)|*.*";
                saveDialog.FilterIndex = 2;

                if (saveDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    workbook.SaveAs(saveDialog.FileName);
                    MessageBox.Show("Export Successful");
                }
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                excel.Quit();
                workbook = null;
                excel = null;
            }
        }

        private void troughputbutton_Click(object sender, EventArgs e)
        {
            byte[] request_data_command = { 255, 102 };
            serialPort1.Write(request_data_command, 0, 2);
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {

        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void tabPage1_Click_1(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick_2(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void tabPage2_Click(object sender, EventArgs e)
        {

        }

        private void chartpressure_Click(object sender, EventArgs e)
        {

        }

        private void connectbutton_Click(object sender, EventArgs e)
        {
            try
            {
                connection.Open();
            }
            catch (MySqlException ex)
            {
                //When handling errors, you can your application's response based 
                //on the error number.
                //The two most common error numbers when connecting are as follows:
                //0: Cannot connect to server.
                //1045: Invalid user name and/or password.
                MessageBox.Show("???");
                switch (ex.Number)
                {
                    case 0:
                        MessageBox.Show("Cannot connect to server.  Contact administrator");
                        break;

                    case 1045:
                        MessageBox.Show("Invalid username/password, please try again");
                        break;
                }
            }
        }

        private void Close_Click(object sender, EventArgs e)
        {
            try
            {
                connection.Close();
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void pdrbutton_Click(object sender, EventArgs e)
        {
            byte[] request_data_command = { 255, 103 };
            serialPort1.Write(request_data_command, 0, 2);
        }

        private void statusStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void pressuremintextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            table.Columns.Add("No");
            table.Columns.Add("Date and Time");
            table.Columns.Add("Temperature");
            table.Columns.Add("Humidity");
            table.Columns.Add("Pressure");
            table.Columns.Add("Wind Speed");
            table.Columns.Add("Wind Direction");
            table.Columns.Add("Rainfall");

            dataGridView1.DataSource = table;
        }

        private void latencybutton_Click(object sender, EventArgs e)
        {
            byte[] request_data_command = { 255, 99 };
            serialPort1.Write(request_data_command, 0, 2);
        }

        int tanggal, bulan, tahun;
        private void synchronizebutton_Click(object sender, EventArgs e)
        {
            char[] awal = new char[2];
            waktu = DateTime.Now.ToString("HH:mm:ss dd:MM:yy");
            jam = (waktu[0] - '0') * 10 + (waktu[1] - '0');
            menit = (waktu[3] - '0') * 10 + (waktu[4] - '0');
            detik = (waktu[6] - '0') * 10 + (waktu[7] - '0');
            tanggal = (waktu[9] - '0') * 10 + (waktu[10] - '0');
            bulan = (waktu[12] - '0') * 10 + (waktu[13] - '0');
            tahun = (waktu[15] - '0') * 10 + (waktu[16] - '0');
            //jam_kirim = jam1 * 10 + jam2;
            byte[] kirim = new byte[8] { 255, 98, Convert.ToByte(jam), Convert.ToByte(menit), Convert.ToByte(detik), Convert.ToByte(tanggal), Convert.ToByte(bulan), Convert.ToByte(tahun) };
            serialPort1.Write(kirim, 0, 8);
        }

        int automatic_mode;

        private void manualbutton_Click(object sender, EventArgs e)
        {
            if (automatic_mode == 1)
            {
                MessageBox.Show("Device will keep wake up if the next Data Arrived");
                automatic_mode = 0;
            }
            else
            {
                byte[] request_data_command = { 255, 97 };
                serialPort1.Write(request_data_command, 0, 2);
            }
            toolStripStatusLabel2.Text = "Manual Mode";
            automaticbutton.Enabled = true;
            minutealarmcombobox.Enabled = true;

        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            string mysql_value;
            string display_dateandtime = Convert.ToString(hour_current) + ':' + Convert.ToString(minute_current) + ' ' + Convert.ToString(tanggal) + '-' + Convert.ToString(bulan) + '-' + Convert.ToString(tahun);

            //DateTime datetimemysql = new DateTime(Convert.ToInt32(tahun), Convert.ToInt32(bulan), Convert.ToInt32(tanggal), Convert.ToInt32(hour_current), Convert.ToInt32(minute_current), 0);
            string datetimemysql = Convert.ToString(tanggal) + "-" + Convert.ToString(bulan) + "-" + Convert.ToString(tahun + 2000) + " " + Convert.ToString(hour_current) + ":" + Convert.ToString(minute_current) + ":00";
            dtmysqlkirim = Convert.ToString(tahun + 2000) + "-" + Convert.ToString(bulan) + "-" + Convert.ToString(tanggal) + " " + Convert.ToString(hour_current) + ":" + Convert.ToString(minute_current) + ":00";
            DateTime dtmysql = Convert.ToDateTime(datetimemysql);

            temperaturecurrenttextbox.Text = Convert.ToString(temperature_current) + " °C";
            pressurecurrenttextbox.Text = Convert.ToString(pressure_current) + " Pa";
            humiditycurrenttextbox.Text = Convert.ToString(humidity_current) + " %";
            windspeedcurrenttextbox.Text = Convert.ToString(wind_speed_current) + " Km/h";
            if      (wind_direction < 880 && wind_direction > 835) wind_direction_text = "N";
            else if (wind_direction < 585 && wind_direction > 560) wind_direction_text = "NE";
            else if (wind_direction < 160 && wind_direction > 130) wind_direction_text = "E";
            else if (wind_direction < 260 && wind_direction > 230) wind_direction_text = "SE";
            else if (wind_direction < 400 && wind_direction > 360) wind_direction_text = "S";
            else if (wind_direction < 740 && wind_direction > 700) wind_direction_text = "SW";
            else if (wind_direction < 990 && wind_direction > 950) wind_direction_text = "W";
            else if (wind_direction < 940 && wind_direction > 900) wind_direction_text = "NW";
            else wind_direction_text = "N";
            winddirectiontextbox.Text = wind_direction_text;
            //lastupdatetextbox.Text =  /*Convert.ToString(hour_current) + ':' + Convert.ToString(minute_current) + ' ' + Convert.ToString(tanggal) + '-' + Convert.ToString(bulan) + '-' + Convert.ToString(tahun);*/
            toolStripStatusLabel3.Text = "Last Update : ";
            toolStripStatusLabel4.Text = Convert.ToString(Convert.ToDateTime(Convert.ToString(hour_current) + ":" + Convert.ToString(minute_current)));
            //latencytextbox.Text = Convert.ToString(latency) + " ms";
            //troughputtexbox.Text = Convert.ToString(troughput) + " bps";
            //pdrtextbox.Text = Convert.ToString(pdr) + " %";
            dayrainfallcurrenttextbox.Text = Convert.ToString(day_rainfall_current) + " mm";

            mysql_value = "'" + dtmysqlkirim + "','" + Convert.ToString(temperature_current) + "','" + Convert.ToString(humidity_current) + "','" + Convert.ToString(pressure_current) + "','" + Convert.ToString(wind_speed_current) + "','" + wind_direction_text + "','" + Convert.ToString(day_rainfall_current) + "'";

            if (temperature_current > temperature_max)
            {
                temperature_max = temperature_current;
                temperaturemaxtextbox.Text = Convert.ToString(temperature_max) + " °C";
            }
            if (pressure_current > pressure_max)
            {
                pressure_max = pressure_current;
                pressuremaxtextbox.Text = Convert.ToString(pressure_max) + " Pa";
            }
            if (humidity_current > humidity_max)
            {
                humidity_max = humidity_current;
                humiditymaxtextbox.Text = Convert.ToString(humidity_max) + " %";
            }
            if (wind_speed_current > wind_speed_max)
            {
                wind_speed_max = wind_speed_current;
                windspeedmaxtextbox.Text = Convert.ToString(wind_speed_max) + " Km/h";
            }

            if (day_rainfall_current > day_rainfall_max)
            {
                day_rainfall_max = day_rainfall_current;
                dayrainfallmaxtextbox.Text = Convert.ToString(day_rainfall_max) + " mm";
            }

            //---------------------------------------------------------------------
            if (flag_first_data == 1)
            {
                if (temperature_current < temperature_min)
                {
                    temperature_min = temperature_current;
                    temperaturemintextbox.Text = Convert.ToString(temperature_min) + " °C";
                }
                if (pressure_current < pressure_min)
                {
                    pressure_min = pressure_current;
                    pressuremintextbox.Text = Convert.ToString(pressure_min) + " Pa";
                }
                if (humidity_current < humidity_min)
                {
                    humidity_min = humidity_current;
                    humiditymintextbox.Text = Convert.ToString(humidity_min) + " %";
                }
            }
            if (data_has_been_updated == 1) //table update
            {
                table.Rows.Add(data_number, dtmysql, temperature_current, humidity_current, pressure_current, wind_speed_current, wind_direction_text, day_rainfall_current);
                dataGridView1.DataSource = table;
                data_number++;

                if (minute_axis != minute_current)
                {
                    timeaxis = Convert.ToDateTime(Convert.ToString(hour_current) + ":" + Convert.ToString(minute_current));

                    minute_axis = minute_current;
                    this.charttemperature.Series["Temperature"].Points.AddXY(timeaxis, temperature_current);
                    this.chartpressure.Series["Pressure"].Points.AddXY(timeaxis, pressure_current);

                    this.charthumidity.Series["Humidity"].Points.AddXY(timeaxis, humidity_current);
                    this.chartwindspeed.Series["Wind Speed"].Points.AddXY(timeaxis, wind_speed_current);

                }

                query = "INSERT INTO weatherdata (date_and_time,temperature,RH,pressure,wind_speed,wind_direction,rainfall) VALUES(" + mysql_value + ")";

                //connection.Open();
                //create mysql command
                if (connection.State == ConnectionState.Open)
                {
                    MySqlCommand cmd = new MySqlCommand();
                    //Assign the query using CommandText
                    cmd.CommandText = query;
                    //Assign the connection using Connection
                    cmd.Connection = connection;

                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch
                    {

                    }
                }
                
                if (automatic_mode == 1)
                {
                    waktu = DateTime.Now.ToString("HH:mm:ss dd:MM:yy");
                    jam = (waktu[0] - '0') * 10 + (waktu[1] - '0');
                    menit = (waktu[3] - '0') * 10 + (waktu[4] - '0');
                    menit_alarm = menit + menit_alarm_plus;

                    if (menit_alarm > 59)
                    {
                        jam_alarm = jam + 1;
                        menit_alarm = menit_alarm - 60;
                    }
                    else
                    {
                        jam_alarm = jam;
                    }

                    if (jam_alarm > 23)
                    {
                        jam_alarm = 0;
                    }

                    byte[] kirim = new byte[4] { 255, 100, Convert.ToByte(jam_alarm), Convert.ToByte(menit_alarm) };
                    serialPort1.Write(kirim, 0, 4);
                }
                data_has_been_updated = 0;
            }
            if (automatic_mode == 1)
            {
                automaticbutton.Enabled = false;
                minutealarmcombobox.Enabled = false;
                toolStripStatusLabel2.Text = "Automatic Mode " + minutealarmcombobox.Text + " Minutes";
            }
            else
            {
                automaticbutton.Enabled = true;
                minutealarmcombobox.Enabled = true;
            }
            //waktu = DateTime.Now.ToString("HH:mm:ss dd:MM:yy");
            //today = (waktu[9] - '0') * 10 + (waktu[10] - '0');
        }

        private void automaticbutton_Click(object sender, EventArgs e)
        {
            //byte[] request_data_command = { 255, 100 };
            
            if (minutealarmcombobox.SelectedItem == null)
            {
                MessageBox.Show("Choose the the Interval");
            }
            else
            {
                //serialPort1.Write(request_data_command, 0, 2);
   
                waktu = DateTime.Now.ToString("HH:mm:ss dd:MM:yy");
                jam = (waktu[0] - '0') * 10 + (waktu[1] - '0');
                menit = (waktu[3] - '0') * 10 + (waktu[4] - '0');
                menit_alarm_plus= Convert.ToInt16(minutealarmcombobox.Text);
                menit_alarm = menit + menit_alarm_plus;

                if (menit_alarm > 59)
                {
                    jam_alarm = jam + 1;
                    menit_alarm = menit_alarm-60;
                }
                else
                {
                    jam_alarm = jam;
                }
                byte[] kirim = new byte[4] { 255, 100, Convert.ToByte(jam_alarm), Convert.ToByte(menit_alarm) };
                serialPort1.Write(kirim, 0, 4);       
            }
        }

        private void serialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data_received;
            string[] data_split;
            char[] weather_deliminator = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J','K', 'Z' };
            char[] latency_deliminator = { 'L', 'Z' };
            char[] troughput_deliminator = { 'T', 'Z' };
            char[] pdr_deliminator = { 'P', 'Z' };

            try
            {
                data_received = serialPort1.ReadLine();

                if (data_received[0] == 'A') //weather data incomming...
                {
                    data_split = data_received.Split(weather_deliminator);
                    hour_current = Convert.ToDouble(data_split[1]);
                    minute_current = Convert.ToDouble(data_split[2]);

                    wind_speed_current = Convert.ToDouble(data_split[3])*3.14*0.09*3.6; //udah dalam Km/h
                    
                    humidity_current = Convert.ToDouble(data_split[4]);
                    temperature_current = Convert.ToDouble(data_split[5]);
                    wind_direction = Convert.ToDouble(data_split[6]);
                    pressure_current = Convert.ToDouble(data_split[7]);
                    tanggal = Convert.ToInt16(data_split[8]);
                    bulan = Convert.ToInt16(data_split[9]);
                    tahun = Convert.ToInt16(data_split[10]);
                    day_rainfall_current += Convert.ToUInt32(data_split[11])*0.27;
                    flag_first_data = 1;
                    data_has_been_updated = 1;
                    serialPort1.DiscardInBuffer();
                }
                else if (data_received[0] == 'W') // device is standby now...
                {
                    byte[] request_data_command = { 255, 101, 255, 97 };
                    serialPort1.Write(request_data_command, 0, 4);
                }
                else if (data_received[0] == 'S') // device is sleep now...
                {
                    if (automatic_mode == 0) MessageBox.Show("Device in sleep mode");
                    automatic_mode = 1;
                    
                }
                else if (data_received == "OK")
                {
                    MessageBox.Show("Success!");
                }
                else if (data_received == "D123456789012345678901234567890") // ping packet data
                {
                    serialPort1.Write("K");
                }
                else if (data_received[0] == 'L') // delay value incoming..
                {
                    data_split = data_received.Split(latency_deliminator);
                    latency = Convert.ToDouble(data_split[1]);
                }
                else if (data_received[0] == 'T') // troughput value incoming..
                {
                    data_split = data_received.Split(troughput_deliminator);
                    troughput = Convert.ToDouble(data_split[1]);
                }
                else if (data_received[0] == 'P') // PDR value incoming..
                {
                    data_split = data_received.Split(pdr_deliminator);
                    pdr = Convert.ToDouble(data_split[1]);
                    MessageBox.Show("Success!");
                }
                else
                {
                    serialPort1.DiscardInBuffer();
                }
            }
            catch (TimeoutException)
            {
                MessageBox.Show("Request Time Out!");
            }
            }

        private void openserialbutton_Click(object sender, EventArgs e)
        {
            if (serialportcombobox.SelectedItem == null)
            {
                
                MessageBox.Show("Connect and Choose Serial Port");
            }
            else
            {
                serialPort1.Close();
                serialPort1.PortName = serialportcombobox.Text;
                serialPort1.BaudRate = 9600;
                serialPort1.Parity = System.IO.Ports.Parity.None;
                serialPort1.DataBits = 8;
                serialPort1.StopBits = System.IO.Ports.StopBits.One;
                serialPort1.Open();
                when_serial_open();
                toolStripStatusLabel1.Text = serialportcombobox.Text + ",9600,8N1";
                serialPort1.DiscardInBuffer();

            }
        }

        private void closeserialbutton_Click(object sender, EventArgs e)
        {
            serialPort1.Close();
            when_serial_close();
            toolStripStatusLabel1.Text = "SerialPort Closed";
        }

        
        int hour, minute, second, date, month, year;
        string last_update_time;
        public Form1()
        {
            InitializeComponent();
            server = "weatherstationundip.duckdns.org";
            database = "weatherstation";
            uid = "remot";
            password = "ariefpratama";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" + database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);

            String[] ports = SerialPort.GetPortNames();
            serialportcombobox.Items.AddRange(ports);
            timer1.Start();
            when_serial_close();

            chartpressure.Series["Pressure"].XValueType = ChartValueType.Time;
            charttemperature.Series["Temperature"].XValueType = ChartValueType.Time;
            charthumidity.Series["Humidity"].XValueType = ChartValueType.Time;
            chartwindspeed.Series["Wind Speed"].XValueType = ChartValueType.Time;

            this.MinimumSize = this.Size;
            this.MaximumSize = this.Size;

            toolStripStatusLabel1.Text = "SerialPort Closed";
            toolStripStatusLabel2.Text = "Manual Mode";
            for (int i = 1; i < 61; i++)
            {
                minutealarmcombobox.Items.Add(i);
            }
            tanggal = 1;
            bulan = 1;
            hour_current = 0;
            minute_current = 0;
            data_has_been_updated = 0;
            flag_first_data = 0;
            data_number = 1;
            temperature_min = 300;
            humidity_min = 101;
            pressure_min = 900000;
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            serialportcombobox.Items.Clear();
            String[] ports = SerialPort.GetPortNames();
            serialportcombobox.Items.AddRange(ports);
        }

        void when_serial_close()
        {
            //latencybutton.Enabled = false;
            //troughputbutton.Enabled = false;
            //pdrbutton.Enabled = false;
            synchronizebutton.Enabled = false;
            closeserialbutton.Enabled = false;
            manualbutton.Enabled = false;
            automaticbutton.Enabled = false;
            openserialbutton.Enabled = true;
            minutealarmcombobox.Enabled = false;
            serialportcombobox.Enabled = true;
        }

        void when_serial_open()
        {
            //latencybutton.Enabled = true;
            //troughputbutton.Enabled = true;
            //pdrbutton.Enabled = true;
            synchronizebutton.Enabled = true;
            closeserialbutton.Enabled = true;
            manualbutton.Enabled = true;
            automaticbutton.Enabled = true;
            openserialbutton.Enabled = false;
            minutealarmcombobox.Enabled = true;
            serialportcombobox.Enabled = false;
            
        }

        long getpressure(long ut,long up)
        {
            long x1, x2, b3, b5, x3, b6, b7;
            ulong b4;
            long p;

            int ac1 = 7654;
            int ac2 = -1023;
            int ac3 = -14587;
            uint ac4 = 33742;
            uint ac5 = 25116;
            uint ac6 = 16169;
            int b1 = 6515;
            int b2 = 34;
            int mb = -32768;
            int mc = -11786;
            int md = 2749;

            x1 = ((long)ut - ac6) * ac5 >> 15;
            x2 = ((long)mc << 11) / (x1 + md);
            b5 = x1 + x2;

            b6 = b5 - 4000;
            x1 = (b2 * (b6 * b6) >> 12) >> 11;
            x2 = (ac2 * b6) >> 11;
            x3 = x1 + x2;
            b3 = (((((long)ac1) * 4 + x3) << 0) + 2) >> 2;
            x1 = (ac3 * b6) >> 13;
            x2 = (b1 * ((b6 * b6) >> 12)) >> 16;
            x3 = ((x1 + x2) + 2) >> 2;
            b4 = (ac4 * (ulong)(x3 + 32768)) >> 15;
            b7 = ( up - b3 ) *(50000 >> 0);
            p = b7 < 0x80000000 ? Convert.ToInt32((double)(b7 << 1) / b4) : Convert.ToInt32((double)b7 / b4) << 1;
            x1 = (p >> 8) * (p >> 8);
            x1 = (x1 * 3038) >> 16;
            x2 = (-7357 * p) >> 16;
            long pressure = p + ((x1 + x2 + 3791) >> 4);

            return pressure;
        }

        void sht11(float raw_humidity,float raw_temp)
        {

            
        }
    }
}
