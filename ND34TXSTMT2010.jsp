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
String table=("TXSTMT"+cidp+"10");

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
System.out.println("QUERY IS "+query1);


 if (rs1.next()) {
 
 System.out.println("IN RESULT SET ONE");
 
	syline1=rs1.getString(2);
	syline2=rs1.getString(3);
	syline3=rs1.getString(4);
	syline4=rs1.getString(5);
	syline5=rs1.getString(6);
	syline6=rs1.getString(7);
	
	syline56=syline5+"  "+syline6;
	
}


System.out.println("HERE WE ARE");

Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ="+database+"");

String query=" SELECT * FROM ["+table+"] ";
query+=" WHERE (((["+table+"].Field13)='"+parcelp+"'))";
      	
   Statement stmt = con.createStatement();
   ResultSet rs=stmt.executeQuery(query);
  
  
  
  
//Populating fields by database field position


//PdfReader reader = new PdfReader(request.getRealPath("/reports/TAXSTMT2008.pdf"));
PdfReader reader = new PdfReader(request.getRealPath("/reports/ND342010STMT.pdf"));
PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(new File(request.getRealPath("/reports/new.pdf"))));
AcroFields form = stamper.getAcroFields();
 
 
System.out.println("HERE WE ARE-2"+query);


 if (rs.next()) {
 
 	String None=null;		
 	
 	String receipt="";
 	String receiptno=rs.getString(2);
 	if (receiptno==None) {
 		receipt="Receipt # "+0;
 	}
 	else {	
 		receipt="Receipt # "+receiptno;
 	}
 	
 	
 	String escrowword=rs.getString(3);
 	String escrow="";
 	if (escrowword==None) {
 		escrow="";
 	}	
 	else {
 		String escrowno=rs.getString(4);
	 	escrowno=escrowno.trim();
 		String escrowname=rs.getString(5);
 		escrow=escrowword+" ";
 		if (escrowno==None) {
 		}
 		else {
 		escrow=escrow+escrowno+" ";
 		}
 		if (escrowname==None) {
 		}
 		else {
 		escrow=escrow+escrowname;
 		}
 	}
 	
 	String parcelno=rs.getString(13);
 	String parcel="Parcel Number: "+parcelno;
 	
 	String taxpayerword=rs.getString(14);
 	String taxpayerno=rs.getString(15);
 	String taxpayer=taxpayerword+taxpayerno;
 	
 	String multiparcelno=rs.getString(16);
 	String multiparcel="";
 	if (multiparcelno==null) {
 		multiparcel="";
 	}
 	else {
 		multiparcel="Multi Prcl# "+multiparcelno;
 	}
 	
 	String deliquent="";
 	String dlq8=rs.getString(7);
 	String dlqyr01=rs.getString(8);
 	String dlqyr02=rs.getString(9);
 	String dlqyr03=rs.getString(10);
 	String dlqyr04=rs.getString(11);
 	String dlqyr05=rs.getString(12);
 	 	
 	if (dlq8==None) {
 		deliquent=" ";
 	}
 	else {
 		deliquent=dlq8+" ";
 		if (dlqyr01==None) {
 		}
 		else {
 		deliquent=deliquent+dlqyr01+" ";
 		}
 		if (dlqyr02==None) {
 		}
 		else {
 		deliquent=deliquent+dlqyr02+" ";
 		}
 		if (dlqyr03==None) {
 		}
 		else {
 		deliquent=deliquent+dlqyr03+" ";
 		}
 		if (dlqyr04==None) {
 		}
 		else {
 		deliquent=deliquent+dlqyr04+" ";
 		}
 		if (dlqyr05==None) {
 		}
 		else {
 		deliquent=deliquent+dlqyr05;
 		}
 	}
 	
 	
 	String acreword="";
 	String acres="";
 	String pacres="";
 	acreword=rs.getString(27);
 	acres=rs.getString(28);
 	
 	if (acreword==None) {
 		pacres=" ";
 	}
 	else {
 		acres=acres.trim();
 		pacres=acreword+" "+acres;
 	}
 	
 	
 	String pownr="";
 	String mnum="";
 	String mname="";
 	String mfalco="";
 	String owner="";
 	pownr=rs.getString(31);
 	mnum=rs.getString(32);
 	mname=rs.getString(33);
 	mfalco=rs.getString(34);
 	if (pownr==None) {
 		owner="";
 	}
 	else {	
 		owner=pownr+" ";
 		if (mnum==None) {
 		}
 		else {
 		owner=owner+mnum+"  ";
 		}
 		if (mname==None) {
 		}
 		else {
 		owner=owner+mname+" ";
 		}
 		if (mfalco==None) {
 		}
 		else {
 		owner=owner+mfalco;
 		}
 	}
 

 	
 	
 	String apschl="";
	String schoolno=rs.getString(62);
	schoolno=schoolno.trim();
	if (schoolno==None) {
	 	apschl="School";
	}
	else {	
	 	apschl="School "+schoolno;
 	}
 	
 	
 	String mortgage1=rs.getString(94);
 	String mortgage2=rs.getString(95);
 	
 	
 	
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
			month="Jan";
 		}
 		if (mm.equals("02")) {
			month="Feb";
 		}
 		if (mm.equals("03")) {
 			month="Mar";
 		}
 		if (mm.equals("04")) {
			month="Apr";
 		}
 		if (mm.equals("05")) {
			month="May";
 		}
 		if (mm.equals("06")) {
			month="Jun";
 		}
 		if (mm.equals("07")) {
			month="Jul";
 		}
 		if (mm.equals("08")) {
			month="Aug";
 		}
 		if (mm.equals("09")) {
			month="Sep";
 		}
 		if (mm.equals("10")) {
			month="Oct";
 		}
 		if (mm.equals("11")) {
			month="Nov";
 		}
 		if (mm.equals("12")) {
			month="Dec";
 		}
 		firsthalf="1st Half Due "+month+" "+dd+", "+yy;
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
			month="Jan";
		}
		if (mm.equals("02")) {
		 	month="Feb";
		}
		if (mm.equals("03")) {
			month="Mar";
		}
		if (mm.equals("04")) {
			month="Apr";
		}
		if (mm.equals("05")) {
			month="May";
		}
		if (mm.equals("06")) {
			month="Jun";
		}
		if (mm.equals("07")) {
			month="Jul";
		}
		if (mm.equals("08")) {
			month="Aug";
		}
		if (mm.equals("09")) {
			month="Sep";
		}
		if (mm.equals("10")) {
			month="Oct";
		}
		if (mm.equals("11")) {
			month="Nov";
		}
		if (mm.equals("12")) {
			month="Dec";
 		}
		secondhalf="2nd Half Due "+month+" "+dd+", "+yy;
 	}
 	
 	
 	String sescrowword=rs.getString(133);
	String sescrowno=rs.getString(134);
	String sescrowname=rs.getString(135);
	String pseswrd="";
	String psescrow="";
	 	
	if (sescrowword==None) {
		pseswrd="";
		psescrow="";
	}	
	else {
		pseswrd=sescrowword;
		psescrow=sescrowno+" "+sescrowname;
 	}
 	
 	String staxpayerword=rs.getString(147);
	String staxpayerno=rs.getString(148);
 	String staxpayer=staxpayerword+staxpayerno;
 	
 	String smultiparcelno=rs.getString(150);
	String smultiparcel="";
	if (smultiparcelno==null) {
		smultiparcel="";
	}
	else {
		smultiparcel="MP # "+multiparcelno;
 	}
 	
 	
 	//String pstname=syline1+"  ("+syline5+")";
 	String pstname=syline1;
 	
 	String pdscday=rs.getString(123);
 	String pnettaxdue="Net Tax due By Feb "+pdscday;
 	
 	
 	String sdeliquent="";
	String sdlq8=rs.getString(137);
	String sdlqyr01=rs.getString(138);
	String sdlqyr02=rs.getString(139);
	String sdlqyr03=rs.getString(140);
	String sdlqyr04=rs.getString(141);
	String sdlqyr05=rs.getString(142);
	 	 	
	if (sdlq8==None) {
		sdeliquent=" ";
	}
	else {
		sdeliquent=sdlq8+" ";
		if (sdlqyr01==None) {
		}
		else {
		sdeliquent=sdeliquent+sdlqyr01+" ";
		}
		if (sdlqyr02==None) {
		}
		else {
		sdeliquent=sdeliquent+sdlqyr02+" ";
		}
		if (sdlqyr03==None) {
		}
		else {
		sdeliquent=sdeliquent+sdlqyr03+" ";
		}
		if (sdlqyr04==None) {
		}
		else {
		sdeliquent=sdeliquent+sdlqyr04+" ";
		}
		if (sdlqyr05==None) {
		}
		else {
		sdeliquent=sdeliquent+sdlqyr05;
		}
 	}
 	
 	
 	 	
 	
 	String psdscday=rs.getString(151);
 	String psnettaxdue="NET TAX DUE BY FEB "+psdscday+"TH";
 	
 	
 	String stubfirsthalf="";
 	String psdatefirst=rs.getString(153);
 	mm=psdatefirst.substring(0,2);
	dd=psdatefirst.substring(3,5);
	yy=psdatefirst.substring(6);
	if (psdatefirst==None) {
		stubfirsthalf="1st Half Due";
	}
	else {
		if (mm.equals("01")) {
		month="Jan";
		}
		if (mm.equals("02")) {
		month="Feb";
		}
		if (mm.equals("03")) {
		month="Mar";
		}
		if (mm.equals("04")) {
		month="Apr";
		}
		if (mm.equals("05")) {
		month="May";
		}
		if (mm.equals("06")) {
		month="Jun";
		}
		if (mm.equals("07")) {
		month="Jul";
		}
		if (mm.equals("08")) {
		month="Aug";
		}
		if (mm.equals("09")) {
		month="Sep";
		}
		if (mm.equals("10")) {
		month="Oct";
		}
		if (mm.equals("11")) {
		month="Nov";
		}
		if (mm.equals("12")) {
		month="Dec";
		}
	stubfirsthalf="1st Half Due "+month+" "+dd+", "+yy;
 	}
 	
 	 	
 	String stubsecondhalf="";
 	String psdatesecond=rs.getString(155);
 	mm=psdatesecond.substring(0,2);
	dd=psdatesecond.substring(3,5);
	yy=psdatesecond.substring(6);
	if (psdatesecond==None) {
		stubsecondhalf="2nd Half Due";
	}
	else {
		if (mm.equals("01")) {
			month="Jan";
		}
		if (mm.equals("02")) {
		 	month="Feb";
		}
		if (mm.equals("03")) {
			month="Mar";
		}
		if (mm.equals("04")) {
			month="Apr";
		}
		if (mm.equals("05")) {
			month="May";
		}
		if (mm.equals("06")) {
			month="Jun";
		}
		if (mm.equals("07")) {
			month="Jul";
		}
		if (mm.equals("08")) {
			month="Aug";
		}
		if (mm.equals("09")) {
			month="Sep";
		}
		if (mm.equals("10")) {
			month="Oct";
		}
		if (mm.equals("11")) {
			month="Nov";
		}
		if (mm.equals("12")) {
			month="Dec";
	 	}
	stubsecondhalf="2nd Half Due "+month+" "+dd+", "+yy;
	}
 	
 	
 	
 	
 	
 	
 	String spownr="";
	String smnum="";
	String smname="";
	String smfalco="";
	String psowner="";
	spownr=rs.getString(162);
	smnum=rs.getString(163);
	smname=rs.getString(164);
	smfalco=rs.getString(165);
	if (spownr==None) {
		psowner="";
	}
	else {	
		psowner=spownr+" ";
		if (smnum==None) {
		}
		else {
		psowner=psowner+smnum+"  ";
		}
		if (smname==None) {
		}
		else {
		psowner=psowner+smname+" ";
		}
	if (smfalco==None) {
		}
		else {
		psowner=psowner+smfalco;
		}
 	}
 	
 	
 	
 System.out.println("IN RESULT SET");
 	
 	
	
//Fill PDF Form Fields by Line
 	
 	form.setField("syline1",syline1);
 	form.setField("syline2",syline2);
 	form.setField("syline3",syline3);
 	form.setField("syline4",syline4);
 	form.setField("syline5",syline5);
 	form.setField("syline6",syline6);
 	
 	form.setField("deliquent",deliquent);
 	
 	form.setField("receipt",receipt);
 	form.setField("township",rs.getString(6));
 	form.setField("parcel",parcel);
 	form.setField("escrow",escrow);
 	form.setField("taxpayerx",taxpayer);
 	form.setField("multiparcel",multiparcel);
 	
 	form.setField("lgl01",rs.getString(22));
 	
 	form.setField("adr01",rs.getString(17));
 	form.setField("lgl02",rs.getString(23));
 	
 	form.setField("adr02",rs.getString(18));
 	form.setField("lgl03",rs.getString(24));
 	
 	form.setField("adr03",rs.getString(19));
 	
	form.setField("adr04",rs.getString(20));
	form.setField("pacres",pacres);
	
	form.setField("adr05",rs.getString(21));
	
	form.setField("ppadwrd",rs.getString(29));
	
	form.setField("powner",owner);
	form.setField("pscad42",rs.getString(30));
	
	form.setField("pyear2",rs.getString(35));
	form.setField("pyear1",rs.getString(36));
	form.setField("psyyear",rs.getString(37));
	form.setField("peyear2",rs.getString(38));
	form.setField("peyear1",rs.getString(39));
	form.setField("pesyear",rs.getString(40));
	 
	 
	form.setField("p2full",rs.getString(41));
	form.setField("pyfull",rs.getString(42));
	form.setField("pfull",rs.getString(43));
	form.setField("p2stat",rs.getString(44));
	form.setField("pystat",rs.getString(45));
	form.setField("pamnt01",rs.getString(46));
	
	form.setField("pwdhsve",rs.getString(167));
	form.setField("phcrd",rs.getString(170));
	
	form.setField("p2netv",rs.getString(47));
	form.setField("pynetv",rs.getString(48));
	form.setField("ptaxb1",rs.getString(49));
	form.setField("p2cnty",rs.getString(50));
	form.setField("pycnty",rs.getString(51));
	form.setField("pamnt02",rs.getString(52));
	
	form.setField("p2taxb",rs.getString(53));
	form.setField("pytaxb",rs.getString(54));
	form.setField("taxb",rs.getString(55));
	form.setField("p2twp",rs.getString(56));
	form.setField("pytwp",rs.getString(57));
	form.setField("pamnt03",rs.getString(58));
	
	form.setField("p2mill",rs.getString(59));
	form.setField("pymill",rs.getString(60));
	form.setField("pmill",rs.getString(61));
	form.setField("apschl",apschl);
	form.setField("p2skol",rs.getString(63));
	form.setField("pyskol",rs.getString(64));
	form.setField("pamnt04",rs.getString(65));
	
	form.setField("pword1",rs.getString(66));
	form.setField("p2cntw",rs.getString(67));
	form.setField("pycntw",rs.getString(68));
	form.setField("pamnt05",rs.getString(69));
	
	form.setField("pword2",rs.getString(70));
	form.setField("pvalu01",rs.getString(71));
	form.setField("p2oth1",rs.getString(72));
	form.setField("pyoth1",rs.getString(73));
	form.setField("pamnt06",rs.getString(74));
	
	form.setField("pword3",rs.getString(75));
	form.setField("pvalu02",rs.getString(76));
	form.setField("p2oth2",rs.getString(77));
	form.setField("pyoth2",rs.getString(78));
	form.setField("pamnt07",rs.getString(79));
		
	form.setField("mort01",mortgage1);
	form.setField("pword4",rs.getString(80));
	form.setField("pvalu03",rs.getString(81));
	form.setField("p2oth3",rs.getString(82));
	form.setField("pyoth3",rs.getString(83));
	form.setField("pamnt08",rs.getString(84));
	
	form.setField("mort02",mortgage2);
	form.setField("pword5",rs.getString(85));
	form.setField("pvalu04",rs.getString(86));
	form.setField("p2oth4",rs.getString(87));
	form.setField("pyoth4",rs.getString(88));
	form.setField("pamnt09",rs.getString(89));
	
	form.setField("pword6",rs.getString(90));
	form.setField("p2oth5",rs.getString(91));
	form.setField("pyoth5",rs.getString(92));
	form.setField("pamnt10",rs.getString(93));
	
	
	form.setField("pycons",rs.getString(96));
	form.setField("tcons",rs.getString(97));
	
	form.setField("psade01",rs.getString(98));
	form.setField("psap201",rs.getString(99));
	form.setField("psap101",rs.getString(100));
	form.setField("psaam01",rs.getString(101));
	
	form.setField("psade02",rs.getString(102));
	form.setField("psap202",rs.getString(103));
	form.setField("psap102",rs.getString(104));
	form.setField("psaam02",rs.getString(105));
	
	form.setField("psade03",rs.getString(106));
	form.setField("psap203",rs.getString(107));
	form.setField("psap103",rs.getString(108));
	form.setField("psaam03",rs.getString(109));
	
	form.setField("ppntly1",rs.getString(110));
	form.setField("ppytprn",rs.getString(111));
	form.setField("ptsaprn",rs.getString(112));
	
	form.setField("ppntly2",rs.getString(113));
	form.setField("ppyttin",rs.getString(114));
	form.setField("ptsaint",rs.getString(115));
	
	form.setField("ppntly3",rs.getString(116));
	form.setField("ppyttax",rs.getString(117));
	form.setField("pttax",rs.getString(118));
	
	form.setField("ppntly4",rs.getString(119));
	
	form.setField("ppntly5",rs.getString(120));
	form.setField("pdisc",rs.getString(121));
	
	form.setField("ppntly6",rs.getString(122));
	form.setField("pnettaxdue",pnettaxdue);
	form.setField("pdsctax",rs.getString(124));
	
	form.setField("firsthalf",firsthalf);
	form.setField("pfirst",rs.getString(126));
	
	form.setField("secondhalf",secondhalf);
	form.setField("psecond",rs.getString(130));
	
	form.setField("psprcl",rs.getString(131));
	
	form.setField("psrcpt",rs.getString(132));
	
	form.setField("pseswrd",sescrowword);
	form.setField("psescrow",psescrow);
	
	form.setField("pssyline2",syline2);
	
	form.setField("pssyline3",syline3);
	form.setField("sdeliquent",sdeliquent);
	
	form.setField("pssyline4",syline4);
	form.setField("smort01",mortgage1);
	
	form.setField("pssyline6",syline6);
	form.setField("smort02",mortgage2);
	
	form.setField("pssyline5",syline5);
	
	form.setField("psttax",rs.getString(146));
	
	form.setField("staxpayer",staxpayer);
	form.setField("psdisc",rs.getString(149));
	
	form.setField("smultiparcel",smultiparcel);
	
	form.setField("psnettaxdue",psnettaxdue);
	form.setField("psdsctax",rs.getString(152));
	
	form.setField("psdate1",stubfirsthalf);
	form.setField("psfirst",rs.getString(154));
	
	form.setField("psdate2",stubsecondhalf);
	form.setField("pssecond",rs.getString(156));
	
	form.setField("psadr01",rs.getString(157));
	
	form.setField("psadr02",rs.getString(158));
	
	form.setField("psadr03",rs.getString(159));
	
	form.setField("psadr04",rs.getString(160));
	
	form.setField("psadr05",rs.getString(161));
	
	form.setField("psowner",psowner);
	
    }

stamper.setFormFlattening(true);
stamper.close();
rs.close();
rs1.close();
con.close();
con1.close();


response.sendRedirect("/iText/reports/new.pdf?Time="+systime+"");

%>
