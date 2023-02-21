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



//Formating

NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMinimumFractionDigits(0);
nf.setMaximumFractionDigits(0);

String fmt="#,###.00";
DecimalFormat df=new DecimalFormat(fmt);

String fmt0="#,###,###";
DecimalFormat df0=new DecimalFormat(fmt0);


//Globals

String syline1="";
String syline2="";
String syline3="";
String syline4="";
String syline5="";
String syline6="";


//String database=("f:\\County Web\\WebTab"+cidp+".mdb");
String table=("TXSTMT"+cidp);


String database=("C:\\TXSTMT"+".mdb");
//String table=("TXSTMT");




response.setHeader("Cache-Control", "NO-CACHE");
response.setDateHeader("Expires", 0 );
//Connection String
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");


//Connection con1 = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=f:\\County Web\\cntyname.mdb");
Connection con1 = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\cntyname.mdb");

String query1=" SELECT * FROM [CNTYDATA] ";
query1+=" WHERE ((([CNTYDATA].SYCNTY)='"+cidp+"'))";


	Statement stmt1 = con1.createStatement();
   	ResultSet rs1=stmt1.executeQuery(query1);

 if (rs1.next()) {
	syline1=rs1.getString(2);
	syline2=rs1.getString(3);
	syline3=rs1.getString(4);
	syline4=rs1.getString(5);
	syline5=rs1.getString(6);
	syline6=rs1.getString(7);
	
}





Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ="+database+"");

String query=" SELECT * FROM ["+table+"] ";
query+=" WHERE (((["+table+"].Field2)='"+parcelp+"'))";
      	
   Statement stmt = con.createStatement();
   ResultSet rs=stmt.executeQuery(query);
  
  
  
  
//Populating fields by database field position

PdfReader reader = new PdfReader(request.getRealPath("/reports/TAXSTMT2008.pdf"));
PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(new File(request.getRealPath("/reports/new.pdf"))));
AcroFields form = stamper.getAcroFields();




 if (rs.next()) {
 
 	String parcelno=rs.getString(2);
 	String parcelwords=rs.getString(116);
 	String receiptwords=rs.getString(117);
 	String receiptno=rs.getString(3);
 	String escrowwords=rs.getString(119);
 	String escrowname=rs.getString(6);
 	String escrowno=rs.getString(5);
 	String propertyclass=rs.getString(20);
 	String year=rs.getString(1);
 	String taxpayername=rs.getString(48);
 	String taxpayeradr1=rs.getString(54); 
 	String taxpayeradr2=rs.getString(58); 
 	String taxpayeradr3=rs.getString(62); 
 	String taxpayeradr4=rs.getString(63); 
 	String totaltax=rs.getString(111);  
 	String tnumbr4=rs.getString(49);  
 	String code=rs.getString(50);  
 	String tnumbr4code=tnumbr4+code;
 	
 	String tnumb4=rs.getString(41);
 	String letter=rs.getString(40);
 	System.out.println("TNUMB4 is"+tnumb4);
 	System.out.println("LETTER is"+letter);
 	 	
 	String tnumb4letter=tnumb4+letter;
 	if (tnumb4letter.equals("nullnull")) {
	 	tnumb4letter="";
 	}
 	
 	
 	String None=null;
 	String acresw=rs.getString(120);
 	String deededacres=rs.getString(30);
 	String duedate1=rs.getString(125);
 	duedate1=duedate1.trim();
 	
 	
 	
 	String acres="";
 	if (acresw==None) {
 		acres="";
 	}
 	else {
 		acres=acresw+" "+deededacres;
 	}
 	
 	
 	String saint=rs.getString(64);
 	String saprin=rs.getString(65);
 	double satot=rs.getDouble(109);
 	
 		 	
 	String saprinw="";
 	String saintw="";
 	String satotw="";
 	String psaprin="";
 	String psaint="";
 	String psatot="";
 	
 	if (satot==0) {
 		saprinw="";
 		saintw="";
 		satotw="";
 		psaprin="";
 		psaint="";
 		psatot="";
 	}
 	else {
 		saprinw="PRIN";
 		saintw="INT";
 		satotw="TOT";
 		psaprin=saprin;
 		psaint=saint;
 		psatot=df.format(satot);
 	}
 	
 	
	
//Fill PDF Form Fields by Line
 	
 	form.setField("SYLINE1",syline1);
 	form.setField("MOBILEHOMEW",rs.getString(132));
 	form.setField("PARCELW",parcelwords);
 	form.setField("PARCEL2", parcelno);
 	form.setField("RCPTW",receiptwords);
 	form.setField("TVSTMT4",receiptno);
 	
 	form.setField("SYLINE2",syline2);
 	form.setField("ESCROWW",escrowwords);
 	form.setField("APESCR3",escrowno);
 	form.setField("ESNAME",escrowname);
 	
 	form.setField("SYLINE3",syline3);
 	form.setField("TEXT",rs.getString(7));
 	form.setField("TPTOTL2",rs.getString(8));
 	form.setField("TOTLAV2",rs.getString(9));
 	
 	form.setField("SYLINE4",syline4);
 	form.setField("SYCTPN",rs.getString(4));
	
	form.setField("SYLINE5",syline5);
   	form.setField("PARCEL", parcelno);
   	form.setField("GAFLD",rs.getString(32));
   	
   	form.setField("SYLINE6",syline6);   	
   	form.setField("PDESC1", rs.getString(11));
   	form.setField("LINE1B2", rs.getString(28));
	form.setField("TOTLES2", rs.getString(31));
   	
   	
   	form.setField("PDESC2",rs.getString(12)); 
   	form.setField("LYHSAM2", rs.getString(25));
	form.setField("HSEAMT2", rs.getString(26));
   	
   	form.setField("PDESC3",rs.getString(13)); 
   	form.setField("LINE1A2", rs.getString(27));
	form.setField("TOTLNC2", rs.getString(29));
	
	form.setField("ADADR1",rs.getString(35)); 
	form.setField("LYTXBL2", rs.getString(33));
	form.setField("LMTMKT2", rs.getString(34));
	
	form.setField("TNAME", rs.getString(38));
	form.setField("SYFF", rs.getString(39));
	form.setField("TNUMB4LETTER", tnumb4letter);
	
	
	form.setField("TNAM30", taxpayername);
   	form.setField("LSTCLS", rs.getString(19));
	form.setField("CLASS1", propertyclass);
	form.setField("TNUMBR4CODE", tnumbr4code);
	form.setField("ACRES", acres);
	
   	   	
   	form.setField("PADR1", taxpayeradr1);   	
   	form.setField("LSTCL2", rs.getString(21));
	form.setField("CLASS2", rs.getString(22));
		
	form.setField("PADR2", taxpayeradr2);  	
	form.setField("LSTCL3", rs.getString(23));
	form.setField("CLASS3", rs.getString(24));
   	
   	form.setField("PADR3", taxpayeradr3);
   	
	form.setField("PADR4", taxpayeradr4);
		
	form.setField("ASTFLD", rs.getString(67));  
	form.setField("PTQ", rs.getString(68));  
	
	form.setField("DELINQ", rs.getString(69));  
	
	form.setField("LINE2", rs.getString(70));  
	
	form.setField("LINE3", rs.getString(71));  
	form.setField("GROSS", rs.getString(72));  
	
	form.setField("LINE4", rs.getString(73));  
	form.setField("TLSTPD1", rs.getString(74));  
	
	form.setField("LINE5A1", rs.getString(75));  
	form.setField("GVC9", rs.getString(76));  
	
	form.setField("LINE5B1", rs.getString(77));  
	form.setField("CRED", rs.getString(78));  
	
	form.setField("LINE6", rs.getString(79));  
	form.setField("NETTAX1", rs.getString(80));  
	
	form.setField("LINE7", rs.getString(81));  
	form.setField("GVT1", rs.getString(82));  	
		
	form.setField("LINE8", rs.getString(83));  
	form.setField("GVT3", rs.getString(84));  	
		
	form.setField("LINE8A1", rs.getString(85));  
	form.setField("STATTX1", rs.getString(86));  	
		
	form.setField("SUBSCL4", rs.getString(87));  
	form.setField("LINE9B1", rs.getString(88));  	
	form.setField("SCHREF1", rs.getString(89));  
	
	form.setField("LINE9A1", rs.getString(90));  	
	form.setField("GVT4", rs.getString(91));	
		
	form.setField("HDNG1", rs.getString(92));  
	form.setField("STY1", rs.getString(93));  
	form.setField("STP1", rs.getString(94));  
	
	form.setField("HDNG2", rs.getString(95));  
	form.setField("STY2", rs.getString(96));  
	form.setField("STP2", rs.getString(97));
	
	form.setField("HDNG3", rs.getString(98));  
	form.setField("STY3", rs.getString(99));  
	form.setField("STP3", rs.getString(100));
		
	form.setField("HDNG4", rs.getString(101));  
	form.setField("STY4", rs.getString(102));  
	form.setField("STP4", rs.getString(103));
	
	form.setField("LINE112", rs.getString(104));  
	form.setField("STP4", rs.getString(105));
	
	form.setField("LINE121", rs.getString(106));  
	form.setField("NETTAX12", rs.getString(107));
	
	form.setField("SAC1", rs.getString(43));
	form.setField("NAM1", rs.getString(42));  
	form.setField("SA1", rs.getString(44));  
	
	form.setField("SAC2", rs.getString(46));
	form.setField("NAM2", rs.getString(45));  
	form.setField("SA2", rs.getString(47));  
	
	form.setField("SAPRINW", saprinw);  
	form.setField("PSAPRIN", psaprin);
	form.setField("SAC3", rs.getString(52));
	form.setField("NAM3", rs.getString(51));  
	form.setField("SA3", rs.getString(53));  	
		
	form.setField("SAINTW", saintw);  
	form.setField("PSAINT", psaint);
	form.setField("SAC4", rs.getString(56));
	form.setField("NAM4", rs.getString(55));  
	form.setField("SA4", rs.getString(57));  	
	
	form.setField("SATOTW", satotw);  
	form.setField("PSATOT", psatot); 
	form.setField("SAC5", rs.getString(60));
	form.setField("NAM5", rs.getString(59));  
	form.setField("SA5", rs.getString(61));  	
		
	form.setField("LINE141", rs.getString(110));  
	form.setField("TTAX", totaltax);  	
		
	form.setField("R2PARCELW", parcelwords);  
	form.setField("R2PARCEL", parcelno);  
	form.setField("R2RCPTW", receiptwords);  
	form.setField("R2TVSTMT4", receiptno);  
	
	form.setField("R1PARCELW", parcelwords);  
	form.setField("R1PARCEL", parcelno);  
	form.setField("R1RCPTW", receiptwords);  
	form.setField("R1TVSTMT4", receiptno); 
	
	form.setField("R2CLASS1", propertyclass);
	form.setField("R2ESCROWW",escrowwords);
	form.setField("R2APESCR3",escrowno);
	form.setField("R1CLASS1", propertyclass);
 	form.setField("R1ESCROWW",escrowwords);
	form.setField("R1APESCR3",escrowno);
	
 	form.setField("R2ESNAME",escrowname);
	form.setField("R1SNAME",escrowname);
	
	form.setField("R2AMTDUEW",rs.getString(130));  
	form.setField("R1AMTDUEW",rs.getString(131)); 
	form.setField("R1TOTALTAX",totaltax);
	
	form.setField("DUEDATE2", rs.getString(128)+" "+year);
	form.setField("HALF2", rs.getString(134));
	form.setField("DUEDATE1", duedate1+" "+year);
	form.setField("HALF1", rs.getString(133));
	
	form.setField("R2TNAM30",taxpayername);
	form.setField("R2TNUMBR4CODE", tnumbr4code);
	form.setField("R2CODE", code);
	form.setField("R1TNAM30",taxpayername);
	form.setField("R1TNUMBR4CODE", tnumbr4code);
	form.setField("R1CODE", code);
	
	form.setField("R2PADR1",taxpayeradr1);
	form.setField("R1PADR1",taxpayeradr1);
	
	form.setField("R2PADR2",taxpayeradr2);
	form.setField("R1PADR2",taxpayeradr2);
	
	form.setField("R2PADR3",taxpayeradr3);
	form.setField("R1PADR3",taxpayeradr3);
	
	form.setField("R2PADR4",taxpayeradr4);
	form.setField("R1PADR4",taxpayeradr4);
	
	form.setField("SYLINE11",syline1);
	form.setField("SYLINE21",syline2);
	form.setField("SYLINE12",syline1);
	form.setField("SYLINE22",syline2);
	
    }

stamper.setFormFlattening(true);
stamper.close();
rs.close();
rs1.close();



response.sendRedirect("/iText/reports/new.pdf?Time="+systime+"");

%>
