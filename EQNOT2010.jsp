<%@ page language="java" import="java.util.*" %>
<%@ page import="com.lowagie.text.*"%>
<%@ page import="com.cpui.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.lowagie.text.pdf.*"%>
<%@ page import="org.xml.sax.helpers.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="javax.xml.transform.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.xml.transform.stream.*"%>
<%@ page import="java.text.*" %>

 
 
<%

 
long systime=System.currentTimeMillis();




response.addDateHeader("Expires", 791589600000L); // Wed Feb 01 00:00:00 EET 1995
response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate,post-check=0,pre-check=0");
response.addHeader("Pragma", "no-cache");




//Input Parameters

String parcelp=request.getParameter("pid");
String cidp=request.getParameter("cid");

//Create County Folder Name
String cnty="CNTY"+cidp;


//Formating
NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMinimumFractionDigits(0);
nf.setMaximumFractionDigits(0);

String fmt="#,###.00";
DecimalFormat df=new DecimalFormat(fmt);

String fmt0="#,###,###";
DecimalFormat df0=new DecimalFormat(fmt0);


//Globals


String database=("c:\\Inetpub\\wwwroot\\Tax\\Data\\WebTab"+cidp+".mdb");
//String database=("C:\\txstmt.mdb");


String table=("EQNOT"+"13");

String xeqmsg1="";
String xeqmsg2="";
String xeqmsg3="";
String xeqmsg4="";
String xeqmsg5="";
String xeqmsg6="";

String xeqrbm1="";
String xeqrbm2="";
String xeqrbm3="";
String xeqrbm4="";

String xeqcbm1="";
String xeqcbm2="";
String xeqcbm3="";
String xeqcbm4="";


//Create County Folder
//java.io.File file = new File("c:\\Tomcat\\Tomcat 5.5\\webapps\\iText\\reports\\"+cnty+"");
//if (!file.exists()) {
	//file.mkdirs();
//}


response.setHeader("Cache-Control", "NO-CACHE");
response.setDateHeader("Expires", 0 );

//Connection String
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");




System.out.println("Before connection con");

Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ="+database+"");
//Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=c:\\TXSTMT.mdb");

System.out.println("CONNECTION CON IS "+con);

String query=" SELECT * FROM ["+table+"] ";
query+=" WHERE (((["+table+"].Field3)='"+parcelp+"'))";

    
   Statement stmt = con.createStatement();
   ResultSet rs=stmt.executeQuery(query);
  
System.out.println("QUERY IS "+query);  

String pdf21="/reports/MN21NOT2013.pdf";
String pdfxx="/reports/MNNOT2013.pdf";
String pdfinuse="";



//Set PDF to use based on county ID

if (cidp.trim().equals("21")) {
	pdfinuse=pdf21;
}
else {
	pdfinuse=pdfxx;
}



String Year1="";
String Year2="";

  
  
//Populating fields by database field position

PdfReader reader = new PdfReader(request.getRealPath(pdfinuse));
PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(new File(request.getRealPath("/reports/"+cnty+"/new.pdf"))));
AcroFields form = stamper.getAcroFields();




 if (rs.next()) {
 
 System.out.println("IN RESULT LOOP");
 
 	String eqmsg1=rs.getString(55);
 	String eqmsg2=rs.getString(56);
 	String eqmsg3=rs.getString(57);
 	String eqmsg4=rs.getString(58);
 	String eqmsg5=rs.getString(59);
 	String eqmsg6=rs.getString(60);
 	
 	if (eqmsg1 !=null) {
		xeqmsg1=eqmsg1;
	}
	else {
		xeqmsg1="";
 	}
 	
 	if (eqmsg2 !=null) {
		xeqmsg2=eqmsg2;
 	}
 	else {
		xeqmsg2="";
 	}
 	
 	if (eqmsg3 !=null) {
		xeqmsg3=eqmsg3;
 	}
 	else {
		xeqmsg3="";
 	}
 	
 	if (eqmsg4 !=null) {
		xeqmsg4=eqmsg4;
 	}
 	else {
		xeqmsg4="";
 	}
 	
 	if (eqmsg5 !=null) {
		xeqmsg5=eqmsg5;
 	}
 	else {
		xeqmsg5="";
 	}
 	
 	if (eqmsg6 !=null) {
		xeqmsg6=eqmsg6;
 	}
 	else {
		xeqmsg6="";
 	}
 	
 	String foot1=xeqmsg1+" "+xeqmsg2;
 	String foot2=xeqmsg3+" "+xeqmsg4;
 	String foot3=xeqmsg5+" "+xeqmsg6;
 
 
 	String oadr1=rs.getString(63);
 	String oadr2=rs.getString(64);
 	String oadr3=rs.getString(65);
 	String ocity=rs.getString(66);
 	ocity=ocity.trim();
 	String ostat=rs.getString(67);
 	String ofzip=rs.getString(68);
 	String ocsz=ocity+", "+ostat+"  "+ofzip;
 	
 	String[] address;
 	address=new String[4];
 	int x=0;
 	 	 	
 	if (oadr1 !=null) {
 		address[x]=oadr1;
 		x=x+1;
 	}
 	if (oadr2 !=null) {
	 	address[x]=oadr2;
	 	x=x+1;
 	}
 	if (oadr3 !=null) {
	 	address[x]=oadr3;
	 	x=x+1;
 	}
 	if (ocsz !=null) {
	 	address[x]=ocsz;
	 	x=x+1;
 	}
 	
 	
 	
 	String mhflag=rs.getString(2);
 	String msg1="";
 	String msg2="";
 	String msg3="";
 	String msg4="";
 	
	if(mhflag.equals("0")) {
		Year1="(For Taxes Payable in 2013)";
		Year2="(For Taxes Payable in 2014)";
	}
	
	if (!mhflag.equals("0")) {
		Year1="(For Taxes Payable in 2012)";
		Year2="(For Taxes Payable in 2013)";
	}
	
	String taxpno=rs.getString(61);
	String taxpayer="# "+taxpno;
	
	String eqcds1=rs.getString(22);
	String eqest=rs.getString(26);
	String eqhstex=rs.getString(28);
	String eqtmkt=rs.getString(34);
	
	String eqrbm1=rs.getString(47);  
	String eqrbm2=rs.getString(48);
	String eqrbm3=rs.getString(49);
	String eqrbm4=rs.getString(50);
	
	if (eqrbm1 !=null) {
		xeqrbm1=eqrbm1;
	}
	else {
		xeqrbm1="";
 	}
	
	if (eqrbm2 !=null) {
		xeqrbm2=eqrbm2;
	}
	else {
		xeqrbm2="";
 	}
 	
	if (eqrbm3 !=null) {
		xeqrbm3=eqrbm3;
	}
	else {
		xeqrbm3="";
 	}
 	
	if (eqrbm4 !=null) {
		xeqrbm4=eqrbm4;
 	}
 	else {
		xeqrbm4="";
 	}
	
	String eqcbm1=rs.getString(51);  
	String eqcbm2=rs.getString(52);
	String eqcbm3=rs.getString(53);
	String eqcbm4=rs.getString(54);
		
	if (eqcbm1 !=null) {
		xeqcbm1=eqcbm1;
	}
	else {
		xeqcbm1="";
 	}
 	
	if (eqcbm2 !=null) {
		xeqcbm2=eqcbm2;
	}
	else {
		xeqcbm2="";
 	}
 	
	if (eqcbm3 !=null) {
		xeqcbm3=eqcbm3;
	}
	else {
		xeqcbm3="";
 	}
 	
	if (eqcbm4 !=null) {
		xeqcbm4=eqcbm4;
 	}
 	else {
		xeqcbm4="";
 	}
	
	
	
//Fill PDF Form Fields by Line
 	
 	form.setField("EQSYSNM",rs.getString(4));
 	form.setField("EQNAME",rs.getString(8));
 	
 	
 	form.setField("EQADR1",rs.getString(9));
 	form.setField("EQADR2",rs.getString(10));
 	form.setField("EQADR3",rs.getString(11));
	form.setField("EQADR4",rs.getString(12));
   	
   	form.setField("EQCDS12",eqcds1);
   	form.setField("EQEST2",eqest);
   	form.setField("EQHSTEX2",eqhstex);
   	form.setField("EQTMKT2",eqtmkt);
   	
   	
   	form.setField("EQONAM", rs.getString(62));
	   	
   	form.setField("EQOAD1",address[0]); 
   		
	form.setField("EQOAD2",address[1]); 
   		
	form.setField("EQOAD3",address[2]); 
   	   	
   	form.setField("EQOCSZ",address[3]); 
   	   	
   	form.setField("TAXPAYER",taxpayer);
   	
   	form.setField("PayableYear1", Year1);
   	form.setField("PayableYear2", Year2);
   	
   	form.setField("EQDSC1", rs.getString(18));
   	form.setField("EQDSC2", rs.getString(19));
   	form.setField("EQDSC3", rs.getString(20));
   	form.setField("EQDSC4", rs.getString(21));
   	
   	form.setField("EQCDS1", eqcds1);
   	form.setField("EQCDS2", rs.getString(23));
   	form.setField("EQCDS3", rs.getString(24));
   	
   	form.setField("EQCLSCHG", rs.getString(75));
   	
   	form.setField("EQPRCL", rs.getString(3));
   	form.setField("EQCTPN", rs.getString(25));
   	
   	form.setField("EQPROP", rs.getString(6));
   	
   	form.setField("PayableYear11", Year1);
   	form.setField("PayableYear21", Year2);
	
	form.setField("EQEST",eqest); 
	
	if (cidp.trim().equals("21")) {
		form.setField("EQPWETLEX", rs.getString(36));
		form.setField("EQWETLEX", rs.getString(27));
	}
	
	
	form.setField("EQGALA", rs.getString(29));
	form.setField("EQRURP", rs.getString(70));
	form.setField("EQDEFR", rs.getString(30));
	form.setField("EQJZEX", rs.getString(31));
	form.setField("EQEXCL", rs.getString(32));
	form.setField("EQVEX", rs.getString(33));
	form.setField("EQREFMKT", rs.getString(72));
	form.setField("EQHSTEX", eqhstex);
	form.setField("EQTMKT", eqtmkt);
	
	form.setField("EQPEST", rs.getString(35));
	form.setField("EQPGALA", rs.getString(38));
	form.setField("EQPRURP",rs.getString(71));
	form.setField("EQPDEFR", rs.getString(39));  
	form.setField("EQPJZEX", rs.getString(40));  
	form.setField("EQPEXCL", rs.getString(41));  
	form.setField("EQPVEX", rs.getString(42));
	form.setField("EQPREFMKT", rs.getString(73));  
	form.setField("EQPHSTEX", rs.getString(37));
	form.setField("EQPTMKT", rs.getString(43));
	form.setField("EQIMPR", rs.getString(74));
	
	form.setField("EQRBM1", xeqrbm1);  
	form.setField("EQRBM2", xeqrbm2);  
	form.setField("EQRBM3", xeqrbm3);
	form.setField("EQRBM4", xeqrbm4);
	
	form.setField("EQPCD1", rs.getString(44));  
	form.setField("EQPCD2", rs.getString(45));  
	form.setField("EQPCD3", rs.getString(46));
			
	form.setField("EQCBM1", xeqcbm1);  	
	form.setField("EQCBM2", xeqcbm2);  
	form.setField("EQCBM3", xeqcbm3);  	
	form.setField("EQCBM4", xeqcbm4);  
	
	form.setField("FOOT1", foot1);
	form.setField("FOOT2", foot2);
	form.setField("FOOT3", foot3);
	
    }

stamper.setFormFlattening(true);
stamper.close();
rs.close();
con.close();



response.sendRedirect("/iText/reports/"+cnty+"/new.pdf?Time="+systime+"");

%>
