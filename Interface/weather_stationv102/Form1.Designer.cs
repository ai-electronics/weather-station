namespace weather_stationv102
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend2 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea3 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend3 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series3 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea4 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend4 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series4 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.refreshserialportbutton = new System.Windows.Forms.Button();
            this.temperaturecurrenttextbox = new System.Windows.Forms.TextBox();
            this.temperaturemaxtextbox = new System.Windows.Forms.TextBox();
            this.serialportcombobox = new System.Windows.Forms.ComboBox();
            this.closeserialbutton = new System.Windows.Forms.Button();
            this.openserialbutton = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.temperaturemintextbox = new System.Windows.Forms.TextBox();
            this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.pressuremintextbox = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.pressurecurrenttextbox = new System.Windows.Forms.TextBox();
            this.pressuremaxtextbox = new System.Windows.Forms.TextBox();
            this.label12 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.humiditymintextbox = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.humiditycurrenttextbox = new System.Windows.Forms.TextBox();
            this.humiditymaxtextbox = new System.Windows.Forms.TextBox();
            this.label17 = new System.Windows.Forms.Label();
            this.label18 = new System.Windows.Forms.Label();
            this.label19 = new System.Windows.Forms.Label();
            this.windspeedcurrenttextbox = new System.Windows.Forms.TextBox();
            this.windspeedmaxtextbox = new System.Windows.Forms.TextBox();
            this.label16 = new System.Windows.Forms.Label();
            this.synchronizebutton = new System.Windows.Forms.Button();
            this.label20 = new System.Windows.Forms.Label();
            this.winddirectiontextbox = new System.Windows.Forms.TextBox();
            this.manualbutton = new System.Windows.Forms.Button();
            this.automaticbutton = new System.Windows.Forms.Button();
            this.minutealarmcombobox = new System.Windows.Forms.ComboBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStatusLabel2 = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStatusLabel3 = new System.Windows.Forms.ToolStripStatusLabel();
            this.toolStripStatusLabel4 = new System.Windows.Forms.ToolStripStatusLabel();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.exportdatabutton = new System.Windows.Forms.Button();
            this.label22 = new System.Windows.Forms.Label();
            this.dayrainfallcurrenttextbox = new System.Windows.Forms.TextBox();
            this.label23 = new System.Windows.Forms.Label();
            this.dayrainfallmaxtextbox = new System.Windows.Forms.TextBox();
            this.label24 = new System.Windows.Forms.Label();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.chartpressure = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.chartwindspeed = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.charthumidity = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.charttemperature = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.closemysqlbutton = new System.Windows.Forms.Button();
            this.connectbutton = new System.Windows.Forms.Button();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.statusStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartpressure)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartwindspeed)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.charthumidity)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.charttemperature)).BeginInit();
            this.tabControl1.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.SuspendLayout();
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(170, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(148, 20);
            this.label3.TabIndex = 29;
            this.label3.Text = "Weather Parameter";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(4, 3);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 20);
            this.label2.TabIndex = 22;
            this.label2.Text = "Serial Port";
            // 
            // refreshserialportbutton
            // 
            this.refreshserialportbutton.Location = new System.Drawing.Point(89, 24);
            this.refreshserialportbutton.Name = "refreshserialportbutton";
            this.refreshserialportbutton.Size = new System.Drawing.Size(75, 23);
            this.refreshserialportbutton.TabIndex = 20;
            this.refreshserialportbutton.Text = "Refresh";
            this.refreshserialportbutton.UseVisualStyleBackColor = true;
            this.refreshserialportbutton.Click += new System.EventHandler(this.button3_Click);
            // 
            // temperaturecurrenttextbox
            // 
            this.temperaturecurrenttextbox.Location = new System.Drawing.Point(174, 125);
            this.temperaturecurrenttextbox.Name = "temperaturecurrenttextbox";
            this.temperaturecurrenttextbox.ReadOnly = true;
            this.temperaturecurrenttextbox.Size = new System.Drawing.Size(100, 20);
            this.temperaturecurrenttextbox.TabIndex = 19;
            this.temperaturecurrenttextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // temperaturemaxtextbox
            // 
            this.temperaturemaxtextbox.Location = new System.Drawing.Point(280, 125);
            this.temperaturemaxtextbox.Name = "temperaturemaxtextbox";
            this.temperaturemaxtextbox.ReadOnly = true;
            this.temperaturemaxtextbox.Size = new System.Drawing.Size(100, 20);
            this.temperaturemaxtextbox.TabIndex = 18;
            this.temperaturemaxtextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // serialportcombobox
            // 
            this.serialportcombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.serialportcombobox.FormattingEnabled = true;
            this.serialportcombobox.Location = new System.Drawing.Point(8, 26);
            this.serialportcombobox.Name = "serialportcombobox";
            this.serialportcombobox.Size = new System.Drawing.Size(75, 21);
            this.serialportcombobox.TabIndex = 17;
            // 
            // closeserialbutton
            // 
            this.closeserialbutton.Location = new System.Drawing.Point(89, 53);
            this.closeserialbutton.Name = "closeserialbutton";
            this.closeserialbutton.Size = new System.Drawing.Size(75, 23);
            this.closeserialbutton.TabIndex = 16;
            this.closeserialbutton.Text = "Close";
            this.closeserialbutton.UseVisualStyleBackColor = true;
            this.closeserialbutton.Click += new System.EventHandler(this.closeserialbutton_Click);
            // 
            // openserialbutton
            // 
            this.openserialbutton.Location = new System.Drawing.Point(8, 53);
            this.openserialbutton.Name = "openserialbutton";
            this.openserialbutton.Size = new System.Drawing.Size(75, 23);
            this.openserialbutton.TabIndex = 15;
            this.openserialbutton.Text = "Open";
            this.openserialbutton.UseVisualStyleBackColor = true;
            this.openserialbutton.Click += new System.EventHandler(this.openserialbutton_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(170, 24);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(72, 20);
            this.label4.TabIndex = 30;
            this.label4.Text = "Pressure";
            // 
            // temperaturemintextbox
            // 
            this.temperaturemintextbox.Location = new System.Drawing.Point(386, 125);
            this.temperaturemintextbox.Name = "temperaturemintextbox";
            this.temperaturemintextbox.ReadOnly = true;
            this.temperaturemintextbox.Size = new System.Drawing.Size(100, 20);
            this.temperaturemintextbox.TabIndex = 31;
            this.temperaturemintextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // serialPort1
            // 
            this.serialPort1.WriteTimeout = 2000;
            this.serialPort1.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort1_DataReceived);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(171, 47);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(47, 13);
            this.label5.TabIndex = 32;
            this.label5.Text = "Current :";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(277, 47);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(33, 13);
            this.label6.TabIndex = 33;
            this.label6.Text = "Max :";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(383, 47);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(30, 13);
            this.label7.TabIndex = 34;
            this.label7.Text = "Min :";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(383, 109);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(30, 13);
            this.label8.TabIndex = 41;
            this.label8.Text = "Min :";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(277, 109);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(33, 13);
            this.label9.TabIndex = 40;
            this.label9.Text = "Max :";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(171, 109);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(47, 13);
            this.label10.TabIndex = 39;
            this.label10.Text = "Current :";
            // 
            // pressuremintextbox
            // 
            this.pressuremintextbox.Location = new System.Drawing.Point(386, 63);
            this.pressuremintextbox.Name = "pressuremintextbox";
            this.pressuremintextbox.ReadOnly = true;
            this.pressuremintextbox.Size = new System.Drawing.Size(100, 20);
            this.pressuremintextbox.TabIndex = 38;
            this.pressuremintextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.pressuremintextbox.TextChanged += new System.EventHandler(this.pressuremintextbox_TextChanged);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(170, 86);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(100, 20);
            this.label11.TabIndex = 37;
            this.label11.Text = "Temperature";
            // 
            // pressurecurrenttextbox
            // 
            this.pressurecurrenttextbox.Location = new System.Drawing.Point(174, 63);
            this.pressurecurrenttextbox.Name = "pressurecurrenttextbox";
            this.pressurecurrenttextbox.ReadOnly = true;
            this.pressurecurrenttextbox.Size = new System.Drawing.Size(100, 20);
            this.pressurecurrenttextbox.TabIndex = 36;
            this.pressurecurrenttextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // pressuremaxtextbox
            // 
            this.pressuremaxtextbox.Location = new System.Drawing.Point(280, 63);
            this.pressuremaxtextbox.Name = "pressuremaxtextbox";
            this.pressuremaxtextbox.ReadOnly = true;
            this.pressuremaxtextbox.Size = new System.Drawing.Size(100, 20);
            this.pressuremaxtextbox.TabIndex = 35;
            this.pressuremaxtextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(383, 171);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(30, 13);
            this.label12.TabIndex = 48;
            this.label12.Text = "Min :";
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(277, 171);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(33, 13);
            this.label13.TabIndex = 47;
            this.label13.Text = "Max :";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(171, 171);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(47, 13);
            this.label14.TabIndex = 46;
            this.label14.Text = "Current :";
            // 
            // humiditymintextbox
            // 
            this.humiditymintextbox.Location = new System.Drawing.Point(386, 187);
            this.humiditymintextbox.Name = "humiditymintextbox";
            this.humiditymintextbox.ReadOnly = true;
            this.humiditymintextbox.Size = new System.Drawing.Size(100, 20);
            this.humiditymintextbox.TabIndex = 45;
            this.humiditymintextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label15.Location = new System.Drawing.Point(170, 148);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(70, 20);
            this.label15.TabIndex = 44;
            this.label15.Text = "Humidity";
            // 
            // humiditycurrenttextbox
            // 
            this.humiditycurrenttextbox.Location = new System.Drawing.Point(174, 187);
            this.humiditycurrenttextbox.Name = "humiditycurrenttextbox";
            this.humiditycurrenttextbox.ReadOnly = true;
            this.humiditycurrenttextbox.Size = new System.Drawing.Size(100, 20);
            this.humiditycurrenttextbox.TabIndex = 43;
            this.humiditycurrenttextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // humiditymaxtextbox
            // 
            this.humiditymaxtextbox.Location = new System.Drawing.Point(280, 187);
            this.humiditymaxtextbox.Name = "humiditymaxtextbox";
            this.humiditymaxtextbox.ReadOnly = true;
            this.humiditymaxtextbox.Size = new System.Drawing.Size(100, 20);
            this.humiditymaxtextbox.TabIndex = 42;
            this.humiditymaxtextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Location = new System.Drawing.Point(277, 233);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(33, 13);
            this.label17.TabIndex = 54;
            this.label17.Text = "Max :";
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Location = new System.Drawing.Point(171, 233);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(47, 13);
            this.label18.TabIndex = 53;
            this.label18.Text = "Current :";
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.Location = new System.Drawing.Point(170, 210);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(96, 20);
            this.label19.TabIndex = 51;
            this.label19.Text = "Wind Speed";
            // 
            // windspeedcurrenttextbox
            // 
            this.windspeedcurrenttextbox.Location = new System.Drawing.Point(174, 249);
            this.windspeedcurrenttextbox.Name = "windspeedcurrenttextbox";
            this.windspeedcurrenttextbox.ReadOnly = true;
            this.windspeedcurrenttextbox.Size = new System.Drawing.Size(100, 20);
            this.windspeedcurrenttextbox.TabIndex = 50;
            this.windspeedcurrenttextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // windspeedmaxtextbox
            // 
            this.windspeedmaxtextbox.Location = new System.Drawing.Point(280, 249);
            this.windspeedmaxtextbox.Name = "windspeedmaxtextbox";
            this.windspeedmaxtextbox.ReadOnly = true;
            this.windspeedmaxtextbox.Size = new System.Drawing.Size(100, 20);
            this.windspeedmaxtextbox.TabIndex = 49;
            this.windspeedmaxtextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label16.Location = new System.Drawing.Point(3, 86);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(49, 20);
            this.label16.TabIndex = 55;
            this.label16.Text = "Menu";
            // 
            // synchronizebutton
            // 
            this.synchronizebutton.Location = new System.Drawing.Point(7, 109);
            this.synchronizebutton.Name = "synchronizebutton";
            this.synchronizebutton.Size = new System.Drawing.Size(75, 23);
            this.synchronizebutton.TabIndex = 56;
            this.synchronizebutton.Text = "Synchronize";
            this.synchronizebutton.UseVisualStyleBackColor = true;
            this.synchronizebutton.Click += new System.EventHandler(this.synchronizebutton_Click);
            // 
            // label20
            // 
            this.label20.AutoSize = true;
            this.label20.Location = new System.Drawing.Point(383, 233);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(55, 13);
            this.label20.TabIndex = 59;
            this.label20.Text = "Direction :";
            // 
            // winddirectiontextbox
            // 
            this.winddirectiontextbox.Location = new System.Drawing.Point(386, 249);
            this.winddirectiontextbox.Name = "winddirectiontextbox";
            this.winddirectiontextbox.ReadOnly = true;
            this.winddirectiontextbox.Size = new System.Drawing.Size(100, 20);
            this.winddirectiontextbox.TabIndex = 58;
            this.winddirectiontextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // manualbutton
            // 
            this.manualbutton.Location = new System.Drawing.Point(7, 138);
            this.manualbutton.Name = "manualbutton";
            this.manualbutton.Size = new System.Drawing.Size(75, 23);
            this.manualbutton.TabIndex = 62;
            this.manualbutton.Text = "Manual";
            this.manualbutton.UseVisualStyleBackColor = true;
            this.manualbutton.Click += new System.EventHandler(this.manualbutton_Click);
            // 
            // automaticbutton
            // 
            this.automaticbutton.Location = new System.Drawing.Point(7, 165);
            this.automaticbutton.Name = "automaticbutton";
            this.automaticbutton.Size = new System.Drawing.Size(75, 23);
            this.automaticbutton.TabIndex = 63;
            this.automaticbutton.Text = "Automatic";
            this.automaticbutton.UseVisualStyleBackColor = true;
            this.automaticbutton.Click += new System.EventHandler(this.automaticbutton_Click);
            // 
            // minutealarmcombobox
            // 
            this.minutealarmcombobox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.minutealarmcombobox.FormattingEnabled = true;
            this.minutealarmcombobox.Location = new System.Drawing.Point(91, 167);
            this.minutealarmcombobox.Name = "minutealarmcombobox";
            this.minutealarmcombobox.Size = new System.Drawing.Size(35, 21);
            this.minutealarmcombobox.TabIndex = 64;
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1,
            this.toolStripStatusLabel2,
            this.toolStripStatusLabel3,
            this.toolStripStatusLabel4});
            this.statusStrip1.Location = new System.Drawing.Point(0, 639);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(1111, 22);
            this.statusStrip1.TabIndex = 65;
            this.statusStrip1.Text = "statusStrip1";
            this.statusStrip1.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.statusStrip1_ItemClicked);
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            // 
            // toolStripStatusLabel2
            // 
            this.toolStripStatusLabel2.Name = "toolStripStatusLabel2";
            this.toolStripStatusLabel2.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel2.Text = "toolStripStatusLabel2";
            // 
            // toolStripStatusLabel3
            // 
            this.toolStripStatusLabel3.Name = "toolStripStatusLabel3";
            this.toolStripStatusLabel3.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel3.Text = "toolStripStatusLabel3";
            // 
            // toolStripStatusLabel4
            // 
            this.toolStripStatusLabel4.Name = "toolStripStatusLabel4";
            this.toolStripStatusLabel4.Size = new System.Drawing.Size(118, 17);
            this.toolStripStatusLabel4.Text = "toolStripStatusLabel4";
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(8, 327);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.Size = new System.Drawing.Size(842, 248);
            this.dataGridView1.TabIndex = 66;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick_2);
            // 
            // exportdatabutton
            // 
            this.exportdatabutton.Location = new System.Drawing.Point(3, 581);
            this.exportdatabutton.Name = "exportdatabutton";
            this.exportdatabutton.Size = new System.Drawing.Size(75, 23);
            this.exportdatabutton.TabIndex = 67;
            this.exportdatabutton.Text = "Export";
            this.exportdatabutton.UseVisualStyleBackColor = true;
            this.exportdatabutton.Click += new System.EventHandler(this.exportdatabutton_Click);
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label22.Location = new System.Drawing.Point(501, 27);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(94, 20);
            this.label22.TabIndex = 68;
            this.label22.Text = "Day Rainfall";
            // 
            // dayrainfallcurrenttextbox
            // 
            this.dayrainfallcurrenttextbox.Location = new System.Drawing.Point(505, 63);
            this.dayrainfallcurrenttextbox.Name = "dayrainfallcurrenttextbox";
            this.dayrainfallcurrenttextbox.ReadOnly = true;
            this.dayrainfallcurrenttextbox.Size = new System.Drawing.Size(100, 20);
            this.dayrainfallcurrenttextbox.TabIndex = 69;
            this.dayrainfallcurrenttextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label23
            // 
            this.label23.AutoSize = true;
            this.label23.Location = new System.Drawing.Point(502, 47);
            this.label23.Name = "label23";
            this.label23.Size = new System.Drawing.Size(47, 13);
            this.label23.TabIndex = 70;
            this.label23.Text = "Current :";
            // 
            // dayrainfallmaxtextbox
            // 
            this.dayrainfallmaxtextbox.Location = new System.Drawing.Point(611, 63);
            this.dayrainfallmaxtextbox.Name = "dayrainfallmaxtextbox";
            this.dayrainfallmaxtextbox.ReadOnly = true;
            this.dayrainfallmaxtextbox.Size = new System.Drawing.Size(100, 20);
            this.dayrainfallmaxtextbox.TabIndex = 71;
            this.dayrainfallmaxtextbox.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label24
            // 
            this.label24.AutoSize = true;
            this.label24.Location = new System.Drawing.Point(608, 47);
            this.label24.Name = "label24";
            this.label24.Size = new System.Drawing.Size(33, 13);
            this.label24.TabIndex = 72;
            this.label24.Text = "Max :";
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            // 
            // chartpressure
            // 
            this.chartpressure.BackColor = System.Drawing.Color.Transparent;
            chartArea1.Name = "ChartArea1";
            this.chartpressure.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.chartpressure.Legends.Add(legend1);
            this.chartpressure.Location = new System.Drawing.Point(561, 17);
            this.chartpressure.Name = "chartpressure";
            this.chartpressure.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Berry;
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series1.Legend = "Legend1";
            series1.Name = "Pressure";
            series1.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.Time;
            this.chartpressure.Series.Add(series1);
            this.chartpressure.Size = new System.Drawing.Size(550, 301);
            this.chartpressure.TabIndex = 73;
            this.chartpressure.Text = "chart1";
            this.chartpressure.Click += new System.EventHandler(this.chartpressure_Click);
            // 
            // chartwindspeed
            // 
            this.chartwindspeed.BackColor = System.Drawing.Color.Transparent;
            chartArea2.Name = "ChartArea1";
            this.chartwindspeed.ChartAreas.Add(chartArea2);
            legend2.Name = "Legend1";
            this.chartwindspeed.Legends.Add(legend2);
            this.chartwindspeed.Location = new System.Drawing.Point(557, 313);
            this.chartwindspeed.Name = "chartwindspeed";
            this.chartwindspeed.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Chocolate;
            series2.ChartArea = "ChartArea1";
            series2.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series2.Legend = "Legend1";
            series2.Name = "Wind Speed";
            series2.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.Time;
            this.chartwindspeed.Series.Add(series2);
            this.chartwindspeed.Size = new System.Drawing.Size(550, 301);
            this.chartwindspeed.TabIndex = 74;
            this.chartwindspeed.Text = "chart1";
            // 
            // charthumidity
            // 
            this.charthumidity.BackColor = System.Drawing.Color.Transparent;
            chartArea3.Name = "ChartArea1";
            this.charthumidity.ChartAreas.Add(chartArea3);
            legend3.Name = "Legend1";
            this.charthumidity.Legends.Add(legend3);
            this.charthumidity.Location = new System.Drawing.Point(0, 309);
            this.charthumidity.Name = "charthumidity";
            this.charthumidity.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.SeaGreen;
            series3.ChartArea = "ChartArea1";
            series3.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series3.Legend = "Legend1";
            series3.Name = "Humidity";
            series3.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.Time;
            this.charthumidity.Series.Add(series3);
            this.charthumidity.Size = new System.Drawing.Size(550, 301);
            this.charthumidity.TabIndex = 75;
            this.charthumidity.Text = "chart1";
            // 
            // charttemperature
            // 
            this.charttemperature.BackColor = System.Drawing.Color.Transparent;
            this.charttemperature.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.charttemperature.BackImageTransparentColor = System.Drawing.Color.Transparent;
            this.charttemperature.BackSecondaryColor = System.Drawing.Color.White;
            this.charttemperature.BorderlineColor = System.Drawing.Color.WhiteSmoke;
            this.charttemperature.BorderlineDashStyle = System.Windows.Forms.DataVisualization.Charting.ChartDashStyle.Dash;
            this.charttemperature.BorderSkin.BackColor = System.Drawing.Color.Aquamarine;
            this.charttemperature.BorderSkin.PageColor = System.Drawing.Color.Red;
            chartArea4.Name = "ChartArea1";
            this.charttemperature.ChartAreas.Add(chartArea4);
            legend4.Name = "Legend1";
            this.charttemperature.Legends.Add(legend4);
            this.charttemperature.Location = new System.Drawing.Point(8, 17);
            this.charttemperature.Name = "charttemperature";
            this.charttemperature.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Fire;
            series4.ChartArea = "ChartArea1";
            series4.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series4.Legend = "Legend1";
            series4.Name = "Temperature";
            series4.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.Time;
            this.charttemperature.Series.Add(series4);
            this.charttemperature.Size = new System.Drawing.Size(550, 301);
            this.charttemperature.TabIndex = 76;
            this.charttemperature.Text = "chart2";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage1);
            this.tabControl1.Controls.Add(this.tabPage2);
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1111, 636);
            this.tabControl1.TabIndex = 77;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.closemysqlbutton);
            this.tabPage1.Controls.Add(this.connectbutton);
            this.tabPage1.Controls.Add(this.label2);
            this.tabPage1.Controls.Add(this.openserialbutton);
            this.tabPage1.Controls.Add(this.closeserialbutton);
            this.tabPage1.Controls.Add(this.serialportcombobox);
            this.tabPage1.Controls.Add(this.temperaturemaxtextbox);
            this.tabPage1.Controls.Add(this.exportdatabutton);
            this.tabPage1.Controls.Add(this.label24);
            this.tabPage1.Controls.Add(this.dataGridView1);
            this.tabPage1.Controls.Add(this.temperaturecurrenttextbox);
            this.tabPage1.Controls.Add(this.dayrainfallmaxtextbox);
            this.tabPage1.Controls.Add(this.refreshserialportbutton);
            this.tabPage1.Controls.Add(this.label23);
            this.tabPage1.Controls.Add(this.dayrainfallcurrenttextbox);
            this.tabPage1.Controls.Add(this.label22);
            this.tabPage1.Controls.Add(this.minutealarmcombobox);
            this.tabPage1.Controls.Add(this.automaticbutton);
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this.manualbutton);
            this.tabPage1.Controls.Add(this.label4);
            this.tabPage1.Controls.Add(this.label20);
            this.tabPage1.Controls.Add(this.temperaturemintextbox);
            this.tabPage1.Controls.Add(this.winddirectiontextbox);
            this.tabPage1.Controls.Add(this.label5);
            this.tabPage1.Controls.Add(this.synchronizebutton);
            this.tabPage1.Controls.Add(this.label6);
            this.tabPage1.Controls.Add(this.label16);
            this.tabPage1.Controls.Add(this.label7);
            this.tabPage1.Controls.Add(this.label17);
            this.tabPage1.Controls.Add(this.pressuremaxtextbox);
            this.tabPage1.Controls.Add(this.label18);
            this.tabPage1.Controls.Add(this.pressurecurrenttextbox);
            this.tabPage1.Controls.Add(this.label19);
            this.tabPage1.Controls.Add(this.label11);
            this.tabPage1.Controls.Add(this.windspeedcurrenttextbox);
            this.tabPage1.Controls.Add(this.pressuremintextbox);
            this.tabPage1.Controls.Add(this.windspeedmaxtextbox);
            this.tabPage1.Controls.Add(this.label10);
            this.tabPage1.Controls.Add(this.label12);
            this.tabPage1.Controls.Add(this.label9);
            this.tabPage1.Controls.Add(this.label13);
            this.tabPage1.Controls.Add(this.label8);
            this.tabPage1.Controls.Add(this.label14);
            this.tabPage1.Controls.Add(this.humiditymaxtextbox);
            this.tabPage1.Controls.Add(this.humiditymintextbox);
            this.tabPage1.Controls.Add(this.humiditycurrenttextbox);
            this.tabPage1.Controls.Add(this.label15);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1103, 610);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Main Menu";
            this.tabPage1.UseVisualStyleBackColor = true;
            this.tabPage1.Click += new System.EventHandler(this.tabPage1_Click_1);
            // 
            // closemysqlbutton
            // 
            this.closemysqlbutton.BackColor = System.Drawing.Color.Transparent;
            this.closemysqlbutton.Location = new System.Drawing.Point(167, 581);
            this.closemysqlbutton.Name = "closemysqlbutton";
            this.closemysqlbutton.Size = new System.Drawing.Size(75, 23);
            this.closemysqlbutton.TabIndex = 74;
            this.closemysqlbutton.Text = "Close";
            this.closemysqlbutton.UseVisualStyleBackColor = false;
            this.closemysqlbutton.Click += new System.EventHandler(this.Close_Click);
            // 
            // connectbutton
            // 
            this.connectbutton.Location = new System.Drawing.Point(84, 581);
            this.connectbutton.Name = "connectbutton";
            this.connectbutton.Size = new System.Drawing.Size(75, 23);
            this.connectbutton.TabIndex = 73;
            this.connectbutton.Text = "Connect";
            this.connectbutton.UseVisualStyleBackColor = true;
            this.connectbutton.Click += new System.EventHandler(this.connectbutton_Click);
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.charttemperature);
            this.tabPage2.Controls.Add(this.charthumidity);
            this.tabPage2.Controls.Add(this.chartwindspeed);
            this.tabPage2.Controls.Add(this.chartpressure);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(1103, 610);
            this.tabPage2.TabIndex = 1;
            this.tabPage2.Text = "Graph";
            this.tabPage2.UseVisualStyleBackColor = true;
            this.tabPage2.Click += new System.EventHandler(this.tabPage2_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1111, 661);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.statusStrip1);
            this.Name = "Form1";
            this.Text = "WEATHER STATION";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.Form1_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartpressure)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartwindspeed)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.charthumidity)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.charttemperature)).EndInit();
            this.tabControl1.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button refreshserialportbutton;
        private System.Windows.Forms.TextBox temperaturecurrenttextbox;
        private System.Windows.Forms.TextBox temperaturemaxtextbox;
        private System.Windows.Forms.ComboBox serialportcombobox;
        private System.Windows.Forms.Button closeserialbutton;
        private System.Windows.Forms.Button openserialbutton;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox temperaturemintextbox;
        private System.IO.Ports.SerialPort serialPort1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox pressuremintextbox;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox pressurecurrenttextbox;
        private System.Windows.Forms.TextBox pressuremaxtextbox;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TextBox humiditymintextbox;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.TextBox humiditycurrenttextbox;
        private System.Windows.Forms.TextBox humiditymaxtextbox;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.TextBox windspeedcurrenttextbox;
        private System.Windows.Forms.TextBox windspeedmaxtextbox;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.Button synchronizebutton;
        private System.Windows.Forms.Label label20;
        private System.Windows.Forms.TextBox winddirectiontextbox;
        private System.Windows.Forms.Button manualbutton;
        private System.Windows.Forms.Button automaticbutton;
        private System.Windows.Forms.ComboBox minutealarmcombobox;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel2;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button exportdatabutton;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel3;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.TextBox dayrainfallcurrenttextbox;
        private System.Windows.Forms.Label label23;
        private System.Windows.Forms.TextBox dayrainfallmaxtextbox;
        private System.Windows.Forms.Label label24;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.DataVisualization.Charting.Chart chartpressure;
        private System.Windows.Forms.DataVisualization.Charting.Chart chartwindspeed;
        private System.Windows.Forms.DataVisualization.Charting.Chart charthumidity;
        private System.Windows.Forms.DataVisualization.Charting.Chart charttemperature;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel4;
        private System.Windows.Forms.Button connectbutton;
        private System.Windows.Forms.Button closemysqlbutton;
    }
}

