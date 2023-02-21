<%@ page language="java" import="java.util.*" %>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.cpui.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.itextpdf.text.pdf.*"%>
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
String syline56="";


String database=("f:\\County Web\\NDWebTab"+cidp+".mdb");
String table=("MHSTMT"+cidp+"10");

//String database=("C:\\TXSTMT"+cidp+".mdb");
//String database=("C:\\TXSTMT"+".mdb");
//String table=("TXSTMT"+cidp);
//String table=("TXSTMT42");

//String database2=("C:\\cntyname"+".mdb");


response.setHeader("Cache-Control", "NO-CACHE");
response.setDateHeader("Expires", 0 );
//Connection String
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");


Connection con1 = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=f:\\County Web\\cntyname.mdb");
//Connection con1 = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\cntyname.mdb");

String query1=" SELECT * FROM [CNTYDATA] ";
query1+=" WHERE ((([CNTYDATA].SYCNTY)='"+cidp+"'))";


	Statement stmt1 = con1.createStatement();
   	ResultSet rs1=stmt1.executeQuery(query1);


//System.out.println("BEFORE RESULT SET ONE "+database2);
//System.out.println("QUERY IS "+query1);


 if (rs1.next()) {
 
//System.out.println("IN RESULT SET ONE");
 
	syline1=rs1.getString(2);
	syline2=rs1.getString(3);
	syline3=rs1.getString(4);
	syline4=rs1.getString(5);
	syline5=rs1.getString(6);
	syline6=rs1.getString(7);
	
		
}


//System.out.println("HERE WE ARE");

Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ="+database+"");

String query=" SELECT * FROM ["+table+"] ";
query+=" WHERE (((["+table+"].Field13)='"+parcelp+"'))";
      	
   Statement stmt = con.createStatement();
   ResultSet rs=stmt.executeQuery(query);
  
  
  
  
//Populating fields by database field position


//PdfReader reader = new PdfReader(request.getRealPath("/reports/TAXSTMT2008.pdf"));
PdfReader reader = new PdfReader(request.getRealPath("/reports/ND312010MHTS.pdf"));
PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(new File(request.getRealPath("/reports/new.pdf"))));
AcroFields form = stamper.getAcroFields();
 
 
//System.out.println("HERE WE ARE-2"+query);


 if (rs.next()) {
 
 	String None=null;		
 	
 	String taxyear=rs.getString(1);
 	String parcelno=rs.getString(13);
 	String statement=rs.getString(2);
 	
 	String payername=rs.getString(17);
	String payeraddr1=rs.getString(19);
 	String payeraddr2=rs.getString(20);
 	
	String apschl="";
	String schoolno=rs.getString(62);
	schoolno=schoolno.trim();
	if (schoolno==None) {
	 	apschl="School";
	}
	else {	
	 	apschl="School "+schoolno;
 	} 		
 	
 	String pword1="";
 	String p2cntw="";
 	String pycntw="";
 	String pamnt05="";
 	String word1=rs.getString(66);
 	String cntw2=rs.getString(67);
 	String cntwy=rs.getString(68);
 	String amnt05=rs.getString(69);
 	if (word1==None) {
		pword1="";
		p2cntw="";
		pycntw="";
		pamnt05="";
	}
	else {
		pword1=word1;
		p2cntw=cntw2;
		pycntw=cntwy;
		pamnt05=amnt05;
	}
 	
 	
 	String pword2="";
 	String p2oth1="";
	String pyoth1="";
 	String pamnt06="";
	String word2=rs.getString(70);
	String oth1=rs.getString(72);
	String yoth1=rs.getString(73);
 	String amnt06=rs.getString(74);
	if (word2==None) {
		pword2="";
		p2oth1="";
		pyoth1="";
		pamnt06="";
	}
	else {
		pword2=word2;
		p2oth1=oth1;
		pyoth1=yoth1;
		pamnt06=amnt06;
	}
 	
 	
 	String pword3="";
 	String p2oth2="";
	String pyoth2="";
 	String pamnt07="";
	String word3=rs.getString(75);
	String oth2=rs.getString(77);
	String yoth2=rs.getString(78);
 	String amnt07=rs.getString(79);
	if (word3==None) {
		pword3="";
		p2oth2="";
		pyoth2="";
		pamnt07="";
	}
	else {
		pword3=word3;
		p2oth2=oth2;
		pyoth2=yoth2;
		pamnt07=amnt07;
	}
 	
 	
 	String pword4="";
 	String p2oth3="";
	String pyoth3="";
 	String pamnt08="";
	String word4=rs.getString(80);
	String oth3=rs.getString(82);
	String yoth3=rs.getString(83);
 	String amnt08=rs.getString(84);
	if (word4==None) {
		pword4="";
		p2oth3="";
		pyoth3="";
		pamnt08="";
	}
	else {
		pword4=word4;
		p2oth3=oth3;
		pyoth3=yoth3;
		pamnt08=amnt08;
	}
 	
 	
 	String pword5="";
 	String p2oth4="";
	String pyoth4="";
 	String pamnt09="";
	String word5=rs.getString(85);
	String oth4=rs.getString(87);
	String yoth4=rs.getString(88);
 	String amnt09=rs.getString(89);
	if (word5==None) {
		pword5="";
		p2oth4="";
		pyoth4="";
		pamnt09="";
	}
	else {
		pword5=word5;
		p2oth4=oth4;
		pyoth4=yoth4;
		pamnt09=amnt09;
	}
 	
 	
	String pword6="";
	String p2oth5="";
	String pyoth5="";
 	String pamnt10="";
	String word6=rs.getString(90);
	String oth5=rs.getString(91);
	String yoth5=rs.getString(92);
 	String amnt10=rs.getString(93);
	if (word6==None) {
		pword6="";
		p2oth5="";
		pyoth5="";
		pamnt10="";
	}
	else {
		pword6=word6;
		p2oth5=oth5;
		pyoth5=yoth5;
		pamnt10=amnt09;
	}
 	
 	
 	String constax="Consolidated Tax";
 	String pycons=rs.getString(96);
 	String ptcons=rs.getString(97);
 	
 	
 	String pspecials="";
 	String ptsaprn="";
 	String specials="Specials";
 	String tsaprn=rs.getString(112);
 	if (tsaprn==None) {
		pspecials="";
		ptsaprn="";
	}
	else {
		pspecials=specials;
		ptsaprn=tsaprn;
	}
 		
 	
 	String firsthalf="";
	String month="";
	String firsdate="";
	String first=rs.getString(125);
	String mm=first.substring(0,2);
	String dd=first.substring(3,5);
	String yy=first.substring(6);
	if (first==None) {
		firsthalf="1st Half Due";
	}
	else {
		if (mm.equals("01")) {
			month="January";
		}
		if (mm.equals("02")) {
			month="February";
		}
		if (mm.equals("03")) {
			month="March";
		}
		if (mm.equals("04")) {
			month="April";
		}
		if (mm.equals("05")) {
			month="May";
		}
		if (mm.equals("06")) {
			month="June";
		}
		if (mm.equals("07")) {
			month="July";
		}
		if (mm.equals("08")) {
			month="August";
		}
		if (mm.equals("09")) {
			month="September";
		}
		if (mm.equals("10")) {
			month="October";
		}
		if (mm.equals("11")) {
			month="November";
		}
		if (mm.equals("12")) {
			month="December";
		}
		firsthalf="1st Half Due on or before "+month+" "+dd+", "+yy;
	}


	String secondhalf="";
	String second=rs.getString(129);
	mm=second.substring(0,2);
	dd=second.substring(3,5);
	yy=second.substring(6);
	if (second==None) {
		secondhalf="2nd Half Due";
	}
	else {
		if (mm.equals("01")) {
			month="January";
		}
		if (mm.equals("02")) {
			month="February";
		}
		if (mm.equals("03")) {
			month="March";
		}
		if (mm.equals("04")) {
			month="April";
		}
		if (mm.equals("05")) {
			month="May";
		}
		if (mm.equals("06")) {
			month="June";
		}
		if (mm.equals("07")) {
			month="July";
		}
		if (mm.equals("08")) {
			month="August";
		}
		if (mm.equals("09")) {
			month="September";
		}
		if (mm.equals("10")) {
			month="October";
		}
		if (mm.equals("11")) {
			month="Novoember";
		}
		if (mm.equals("12")) {
			month="December";
		}
			secondhalf="2nd Half Due "+month+" "+dd+", "+yy;
 	}
 	
 	
 	String ttax=rs.getString(118);
 	String disc=rs.getString(121);
 	String dsctax=rs.getString(124);
 	
 	
 	
 //System.out.println("IN RESULT SET");
 	
 	
	
//Fill PDF Form Fields by Line
 	
 	form.setField("ptaxyear" ,taxyear);
 	form.setField("pstatement",statement);
 	
 	 	
 	form.setField("ppayername",payername);
 	form.setField("ppayerno",rs.getString(15));
 	form.setField("ppayeraddr1",payeraddr1);
 	form.setField("ppayeraddr2",payeraddr2);
 	
 	form.setField("pparcelno",parcelno);
 	form.setField("plegal1",rs.getString(22));
 	
 	form.setField("plegal2",rs.getString(23));
 	form.setField("plegal3",rs.getString(24));
 	form.setField("plegal4",rs.getString(25));
 	form.setField("ptfvalue",rs.getString(43));
 	
 	form.setField("plegal5",rs.getString(26));
 	form.setField("ptaxvalue",rs.getString(49));
 	
 	form.setField("pmilllevy",rs.getString(60));
 	
 	form.setField("peyear2",rs.getString(38));
	form.setField("peyear1",rs.getString(39));
	form.setField("pesyear",rs.getString(40));
 	
 	
 	form.setField("p2stat",rs.getString(44));
	form.setField("pystat",rs.getString(45));
	form.setField("pamnt01",rs.getString(46));
	 	
	form.setField("p2cnty",rs.getString(50));
	form.setField("pycnty",rs.getString(51));
	form.setField("pamnt02",rs.getString(52));
	 	
	form.setField("p2twp",rs.getString(56));
 	form.setField("pytwp",rs.getString(57));
 	form.setField("pamnt03",rs.getString(58));
 	
 	form.setField("apschl",apschl);
	form.setField("p2skol",rs.getString(63));
	form.setField("pyskol",rs.getString(64));
	form.setField("pamnt04",rs.getString(65));
 	 	
 	
 	form.setField("pword1",pword1);
	form.setField("p2cntw",p2cntw);
	form.setField("pycntw",pycntw);
	form.setField("pamnt05",pamnt05);
		
		
	form.setField("pword2",pword2);
	form.setField("p2oth1",p2oth1);
	form.setField("pyoth1",pyoth1);
	form.setField("pamnt06",pamnt06);
		
	form.setField("pword3",pword3);
	form.setField("p2oth2",p2oth2);
	form.setField("pyoth2",pyoth2);
	form.setField("pamnt07",pamnt07);
	
	form.setField("pword4",pword4);
	form.setField("p2oth3",p2oth3);
	form.setField("pyoth3",pyoth3);
	form.setField("pamnt08",pamnt08);
	
	form.setField("pword5",pword5);
	form.setField("p2oth4",p2oth4);
	form.setField("pyoth4",pyoth4);
	form.setField("pamnt09",pamnt09);
	
	form.setField("pword6",pword6);
	form.setField("p2oth5",p2oth5);
	form.setField("pyoth5",pyoth5);
	form.setField("pamnt10",pamnt10);
	
	form.setField("pconstax",constax);
	form.setField("pycons",pycons);
	form.setField("ptcons",ptcons);
	
	
	form.setField("pspecials",pspecials);
	form.setField("ptsaprn",ptsaprn);
		
	
	form.setField("pmnum",rs.getString(32));
	form.setField("pmname",rs.getString(33));
	form.setField("pmfalco",rs.getString(34));
	
	form.setField("pttax", ttax);
	form.setField("pdisc", disc);
	form.setField("pdsctax", dsctax);
	
	
	form.setField("pfirsthalfdue", firsthalf);
	form.setField("psecondhalfdue", secondhalf);
	
	form.setField("pfirst",rs.getString(126));
	form.setField("psecong",rs.getString(130));
	
	
	form.setField("psyline2", syline2);
	form.setField("psyline3", syline3);
	form.setField("psyline4", syline4);
	form.setField("psyline5", syline5);
	
	form.setField("pstaxyear" ,taxyear);
	form.setField("psparcelno",parcelno);
	form.setField("psstatement",statement);
	
	form.setField("pspayername",payername);
	form.setField("pspayeraddr1",payeraddr1);
 	form.setField("pspayeraddr2",payeraddr2);
 	
 	form.setField("psptwpnm",rs.getString(6));
 	
 	form.setField("pstcons",ptcons);
 	form.setField("pstsaprn",ptsaprn);
 	form.setField("psttax" ,ttax);
 	form.setField("psdisc" ,disc);
 	form.setField("psdsctax" ,dsctax);
 	
    }

stamper.setFormFlattening(true);
stamper.close();
rs.close();
rs1.close();
con.close();
con1.close();


response.sendRedirect("/iText/reports/new.pdf?Time="+systime+"");

%>
