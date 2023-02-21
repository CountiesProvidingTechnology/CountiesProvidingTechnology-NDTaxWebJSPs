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


String table=("EQNOT"+"11");



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

String pdf21="/reports/MN21NOT2011.pdf";
String pdfxx="/reports/MNNOT2011.pdf";
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
		msg1="This form is to notify you of the market value and";
		msg2="classification of your property for assessment";
		msg3="year 2011.  The property taxes you will pay in 2012";
		msg4="will be based on this valuation and classification.";
		Year1="(For Taxes Payable in 2011)";
		Year2="(For Taxes Payable in 2012)";
	}
	
	if (!mhflag.equals("0")) {
		msg1="This form is to notify you of the market value and";
		msg2="classification of your property for assessment";
		msg3="year 2011.  The property taxes you will pay in 2011";
		msg4="will be based on this valuation and classification.";
		Year1="(For Taxes Payable in 2010)";
		Year2="(For Taxes Payable in 2011)";
	}
	
	String taxpno=rs.getString(61);
	String taxpayer="# "+taxpno;
	
	
	
	
	
//Fill PDF Form Fields by Line
 	
 	
 	form.setField("EQNAME",rs.getString(8));
 	form.setField("EQSYSNM",rs.getString(4));
 	
 	form.setField("EQADR1",rs.getString(9));
 	form.setField("EQADR2",rs.getString(10));
 	form.setField("EQADR3",rs.getString(11));
	form.setField("EQADR4",rs.getString(12));
   	
   	form.setField("MSG1", msg1);
   	form.setField("MSG2", msg2);
   	form.setField("MSG3", msg3);
   	form.setField("MSG4", msg4);
   	
   	form.setField("EQONAM", rs.getString(62));
	form.setField("EQMSG1", rs.getString(55));
   	
   	form.setField("EQOAD1",address[0]); 
   	form.setField("EQMSG2", rs.getString(56));
	
	form.setField("EQOAD2",address[1]); 
   	form.setField("EQMSG3", rs.getString(57));
	
	form.setField("EQOAD3",address[2]); 
   	form.setField("EQMSG4", rs.getString(58));
   	
   	form.setField("EQOCSZ",address[3]); 
   	form.setField("EQMSG5", rs.getString(59));
   	
   	form.setField("EQMSG6", rs.getString(60));
	   	
   	form.setField("TAXPAYER",taxpayer);
   	
   	form.setField("PayableYear1", Year1);
   	form.setField("PayableYear2", Year2);
   	
   	form.setField("EQDSC1", rs.getString(18));
   	form.setField("EQDSC2", rs.getString(19));
   	form.setField("EQDSC3", rs.getString(20));
   	form.setField("EQDSC4", rs.getString(21));
   	form.setField("EQCDS1", rs.getString(22));
   	form.setField("EQCDS2", rs.getString(23));
   	form.setField("EQCDS3", rs.getString(24));
   	form.setField("EQPRCL", rs.getString(3));
   	form.setField("EQCTPN", rs.getString(25));
   	
   	form.setField("EQPROP", rs.getString(6));
   	
   	form.setField("PayableYear11", Year1);
   	form.setField("PayableYear21", Year2);
	
	form.setField("EQEST",rs.getString(26)); 
	form.setField("EQIMPR", rs.getString(27));
	form.setField("EQGALA", rs.getString(29));
	form.setField("EQRURP", rs.getString(70));
	form.setField("EQDEFR", rs.getString(30));
	form.setField("EQJZEX", rs.getString(31));
	form.setField("EQEXCL", rs.getString(32));
	form.setField("EQVEX", rs.getString(33));
	form.setField("EQTMKT", rs.getString(34));
	form.setField("EQPEST", rs.getString(35));
	form.setField("EQPIMPR", rs.getString(36));
   	form.setField("EQPLIMK", rs.getString(37));  
	form.setField("EQPGALA", rs.getString(38));
	form.setField("EQPRURP",rs.getString(71));
	form.setField("EQPDEFR", rs.getString(39));  
	form.setField("EQPJZEX", rs.getString(40));  
	form.setField("EQPEXCL", rs.getString(41));  
	form.setField("EQPVEX", rs.getString(42));  
	form.setField("EQPTMKT", rs.getString(43));  
	form.setField("EQPCD1", rs.getString(44));  
	form.setField("EQPCD2", rs.getString(45));  
	form.setField("EQPCD3", rs.getString(46));
		
	form.setField("EQRBM1", rs.getString(47));  
	form.setField("EQRBM2", rs.getString(48));  
	form.setField("EQRBM3", rs.getString(49));
	form.setField("EQRBM4", rs.getString(50));
	
	form.setField("EQCBM1", rs.getString(51));  	
	form.setField("EQCBM2", rs.getString(52));  
	form.setField("EQCBM3", rs.getString(53));  	
	form.setField("EQCBM4", rs.getString(54));  
	
	
    }

stamper.setFormFlattening(true);
stamper.close();
rs.close();
con.close();



response.sendRedirect("/iText/reports/"+cnty+"/new.pdf?Time="+systime+"");

%>
