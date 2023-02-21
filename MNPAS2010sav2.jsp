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
<%@ page import="java.awt.Color" %>
 
<%


 
long systime=System.currentTimeMillis();




response.addDateHeader("Expires", 791589600000L); // Wed Feb 01 00:00:00 EET 1995
response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate,post-check=0,pre-check=0");
response.addHeader("Pragma", "no-cache");




//Input Parameters

		
String parcelp=request.getParameter("pid");
String cidp=request.getParameter("cid");


Calendar cal = Calendar.getInstance();
     SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd yyyy");
     SimpleDateFormat sdf2 = new SimpleDateFormat("h:mm a");
     String mydate=sdf.format(cal.getTime());
     String mytime=sdf2.format(cal.getTime());



//Create County Folder
String cnty="CNTY"+cidp;


//Formating

NumberFormat nf = NumberFormat.getNumberInstance();
nf.setMinimumFractionDigits(0);
nf.setMaximumFractionDigits(0);

String fmt="#,###,###,###.00";
DecimalFormat df=new DecimalFormat(fmt);

String fmt0="#,###,###";
DecimalFormat df0=new DecimalFormat(fmt0);

String fmt1="###,###,###";
DecimalFormat df1=new DecimalFormat(fmt1);

String fmt2="####";
DecimalFormat df2=new DecimalFormat(fmt2);



//Globals

//String database=("C:\\WEBTABXX.mdb");
String database=("c:\\Inetpub\\wwwroot\\Tax\\Data\\WebTab"+cidp+".mdb");

String table=("Table 1 - Name/Addr/Desc/Tax/Recap Info");
String table2=("CAMA");
String table3=("CAMASum");
String table4=("Table 11 - Legal Descriptions(9+)");


String FILE="C:/PASpdf.pdf";

PdfPTable tabled=new PdfPTable(3);

String propertyaddress="";
String lsection="";
String ltownship="";
String lrange="";
String llot="";
String lblock="";
String legal0="";
String legal00="";


String xsqft="";
String xlandval="";
String xbldval="";
String xtotval="";
String xyrbuilt="";
String xyrremodel="";
String xccer="";

String xtotmkv="";
String xtotimpv="";
String xtotga="";
String xtotplat="";
String xtotjobz="";
String xtothous="";
String xtotvets="";
String xtottmv="";

String lake="";

String[] legals;
legals = new String[100];
String[] plegal;
plegal = new String[110];
int xx=0;
int xxx=0;




//Set Fonts -----------------------------------------------------------------

Font headFont = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);
Font secondFont = new Font(Font.TIMES_ROMAN, 10);
Font F10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);

Image jpg1;
Image jpg2;
Image jpg3;


//Remove dashes from parcel number ------------------------------------------

String xparcel="";
for (int i=0; i<parcelp.length(); i ++) {
	if (parcelp.charAt(i) !='-') xparcel +=parcelp.charAt(i);
}


//String picture=xparcel+"0101.jpg";


String sketch11=xparcel+"0101.JPG";
String sketch12=xparcel+"0201.JPG";
String sketch21=xparcel+"0101-1.JPG";
String sketch22=xparcel+"0201-1.JPG";


//Get Images ----------------------------------------------------------------

//try {
//jpg1 = Image.getInstance("http://192.168.1.2/Loren/images/"+picture+"");
//} catch (IOException e) {
//jpg1 = Image.getInstance("http://192.168.1.2/Loren/images/ParcelPhotoNotFound.jpg");
//}


//try {
//jpg2 = Image.getInstance("http://192.168.1.2/Loren/images/Sketches/"+sketch+"");
//} catch (IOException e) {
//jpg2 = Image.getInstance("http://192.168.1.2/Loren/images/Sketches/ParcelSketchNotFound.jpg");
//}


//Get Sketches -------------------------------------------------------------

//Set jpgs to null --------------

jpg2=null;
jpg3=null;

//Sketch One --------------------

try {
jpg2 = Image.getInstance("http://192.168.1.2/sketches/"+cidp+"/"+sketch11+"");
} catch (IOException e) {
}

try {
jpg2 = Image.getInstance("http://192.168.1.2/sketches/"+cidp+"/"+sketch21+"");
} catch (IOException e) {
}

if (jpg2!=null) {
jpg2.setBorder(Rectangle.BOX);
jpg2.setBorderWidth(3f);
jpg2.setBorderColor(new GrayColor(0.5f));
}



//Sketch Two --------------------

try {
jpg3 = Image.getInstance("http://192.168.1.2/sketches/"+cidp+"/"+sketch12+"");
} catch (IOException e) {
}

try {
jpg3 = Image.getInstance("http://192.168.1.2/sketches/"+cidp+"/"+sketch22+"");
} catch (IOException e) {
}

if (jpg3!=null) {
jpg3.setBorder(Rectangle.BOX);
jpg3.setBorderWidth(3f);
jpg3.setBorderColor(new GrayColor(0.5f));
}



response.setHeader("Cache-Control", "NO-CACHE");
response.setDateHeader("Expires", 0 );

//Connection String -----------------------------------------------------------

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");




//Create Document -------------------------------------------------------------  


Document document = new Document();

PdfWriter.getInstance(document, new FileOutputStream(new File(request.getRealPath("/reports/"+cnty+"/paspdf.pdf"))));
//PdfWriter.getInstance(document, new FileOutputStream(FILE));

document.open();

Paragraph p0 = new Paragraph();
p0.add(new Paragraph("Date Printed: "+mydate,F10B));
p0.setAlignment(Element.ALIGN_RIGHT);
document.add(p0);

document.add(Chunk.NEWLINE);


Paragraph p1 = new Paragraph();
p1.add(new Paragraph("PARCEL APPRAISAL SUMMARY",headFont));
p1.setAlignment(Element.ALIGN_CENTER);
document.add(p1);


Paragraph p2 = new Paragraph();
p2.add(new Paragraph("2011 ASSESSMENT FOR TAX PAYABLE IN 2012",headFont));
p2.setAlignment(Element.ALIGN_CENTER);
document.add(p2);

document.add(Chunk.NEWLINE);

Paragraph p3 = new Paragraph();
p3.add(new Paragraph("The 2011 assessment reflects the property value as of January 2nd, 2011 using sales that occurred between October 2009 and",secondFont));
document.add(p3);

Paragraph p4 = new Paragraph();
p4.add(new Paragraph("September 2010.  Buildings built prior to January 2nd, 2011 or buildings which were partially complete as of January 2nd, 2011",secondFont));
document.add(p4);

Paragraph p5 = new Paragraph();
p5.add(new Paragraph("are included here.  Any buildings built after January 2nd, 2011 will be included on the January 2nd, 2012 assessment.",secondFont));
document.add(p5);

Paragraph p6=new Paragraph();
p6.add(new Paragraph(" ",secondFont));
document.add(p6);




//Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=c:\\WEBTABXX.mdb");
Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\Inetpub\\wwwroot\\Tax\\Data\\WebTab"+cidp+".mdb");

//System.out.println("CONNECTION CON IS "+con);


String query4=" SELECT * FROM ["+table4+"] ";
query4+=" WHERE (((["+table4+"].TXPRCL)='"+parcelp+"') and((["+table4+"].TXFLAG)='V'))";

   
   Statement stmt4 = con.createStatement();
   ResultSet rs4=stmt4.executeQuery(query4);
  
//System.out.println("QUERY4 IS "+query4);  


 while (rs4.next()) {
 
 int mrec=rs4.getInt(4);
 String mlegal=rs4.getString(5);
 
 if (mlegal==null) {
	mlegal="";
 }

 if (mrec!=99) {	
 legals[xx]=mlegal;
 xx=xx+1;
 }

 if (mrec==99) {
  	lake=mlegal;
 }

 }
   
 rs4.close();


	

String query=" SELECT * FROM ["+table+"] ";
query+=" WHERE (((["+table+"].TXPRCL)='"+parcelp+"') and((["+table+"].TXFLAG)='V'))";

   
   Statement stmt = con.createStatement();
   ResultSet rs=stmt.executeQuery(query);
  
//System.out.println("QUERY IS "+query);  
  

 if (rs.next()) {
 

  	String parcelno=rs.getString(1);
 	String parcel="PARCEL "+parcelno;
 
 	String township=rs.getString(41);
 	 
 	String schlno=rs.getString(42);
 	String schld=rs.getString(43);
 	String school=schlno+" "+schld;
 	
 	String taxpayer=rs.getString(6);
 	
 	int lsection1=rs.getInt(25);
 	int ltownship1=rs.getInt(26);
 	int lrange1=rs.getInt(27);
 	int llot1=rs.getInt(29);
 	int lblock1=rs.getInt(30);
 	
 	
 	if (lsection1==0) {
		lsection="";
	}
	else {
		lsection="SECT-"+lsection1;
	}
 	
 	if (ltownship1==0) {
		ltownship="";
	}
	else {
		ltownship="TWP-"+ltownship1;
	}
	if (lrange1==0) {
		lrange="";
	}
	else {
		lrange="RANGE-"+lrange1;
	}
	
	if (llot1==0) {
		llot="";
	}
	else {
		llot="LOT-"+llot1;
	}
	
	
	if (lblock1==0) {
		lblock="";
	}
	else {
		lblock="BLK-"+lblock1;
	}
	
	legal0=lsection+" "+ltownship+" "+lrange+" "+llot+" "+lblock;
	
	legal00=rs.getString(31);
	
	if (legal00==null) {
		legal00="";
	}
	
	
	
	
	
	
//Reverse taxpayer name -----------------------------------------------------------

 	//int x=taxpayer.indexOf("/",1);
	//String lastname=taxpayer.substring(0,x);
	//String firstnames=taxpayer.substring(x+1);
	//firstnames=firstnames.trim();
	//String taxpayername=firstnames+" "+lastname;
	
	String taxpayername=taxpayer;
	
 	
 	String taxpad1=rs.getString(7);
 	String taxpad2=rs.getString(8);
 	String taxpad3=rs.getString(9);
 	
 	String alternatename=rs.getString(12);
 	String alternatead1=rs.getString(13);
 	String alternatead2=rs.getString(14);
 	String alternatead3=rs.getString(15);
 	String alternatead4=rs.getString(16);
 	
 	String ownername=rs.getString(18);
 	
 	String legal1=rs.getString(32);
 	String legal2=rs.getString(33);
 	String legal3=rs.getString(34);
 	String legal4=rs.getString(35);
	String legal5=rs.getString(36);
	String legal6=rs.getString(37);
	String legal7=rs.getString(38);
	String legal8=rs.getString(39);


//Check for null legal descriptions -----------------------------------------------	
	
	if (legal1==null) {
		legal1="";
	}
	if (legal2==null) {
		legal2="";
	}
	if (legal3==null) {
		legal3="";
	}
	if (legal4==null) {
		legal4="";
	}
	if (legal5==null) {
		legal5="";
	}
	if (legal6==null) {
		legal6="";
	}
	if (legal7==null) {
		legal7="";
	}
	if (legal8==null) {
		legal8="";
	}
	
	
	
//Check for null property address ------------------------------------------------

	String propertyadr1=rs.getString(50);
	String propertyzip1=rs.getString(51);
	if ( (propertyzip1.equals("00000")) || (propertyzip1.equals("000000000")) ) {
		propertyzip1="";
	}
	if (propertyadr1==null) {
		propertyaddress="";
	}
	else {
	propertyaddress=propertyadr1+" "+propertyzip1;
	}
		
	
	
//Build legal description array --------------------------------------------------

	if (!legal0.equals("")) {
		plegal[xxx]=legal0;
		xxx=xxx+1;
	}
	if (!legal00.equals("")) {
		plegal[xxx]=legal00;
		xxx=xxx+1;
	}
	if (!legal1.equals("")) {
		plegal[xxx]=legal1;
		xxx=xxx+1;
	}
	if (!legal2.equals("")) {
		plegal[xxx]=legal2;
		xxx=xxx+1;
	}
	if (!legal3.equals("")) {
		plegal[xxx]=legal3;
		xxx=xxx+1;
	}
	if (!legal4.equals("")) {
		plegal[xxx]=legal4;
		xxx=xxx+1;
	}
	if (!legal5.equals("")) {
		plegal[xxx]=legal5;
		xxx=xxx+1;
	}
	if (!legal6.equals("")) {
		plegal[xxx]=legal6;
		xxx=xxx+1;
	}
	if (!legal7.equals("")) {
		plegal[xxx]=legal7;
		xxx=xxx+1;
	}
	if (!legal8.equals("")) {
		plegal[xxx]=legal8;
		xxx=xxx+1;
	}
	
	
	for (int yyy = 0; yyy<legals.length; yyy++) {
		plegal[xxx]=legals[yyy];
		xxx=xxx+1;
	}
	
	//System.out.println("PLEGAL20 IS "+plegal[20]); 	
	//System.out.println("PLEGAL21 IS "+plegal[21]); 	
	
		
	PdfPTable tablec=new PdfPTable(3);
	PdfPCell cell1=new PdfPCell(new Paragraph(parcel,secondFont));
	PdfPCell cell2=new PdfPCell(new Paragraph(township,secondFont));
	PdfPCell cell3=new PdfPCell(new Paragraph(school,secondFont));
	cell1.setBorder(Rectangle.NO_BORDER);
	cell2.setBorder(Rectangle.NO_BORDER);
	cell3.setBorder(Rectangle.NO_BORDER);
	tablec.addCell(cell1);
	tablec.addCell(cell2);
	tablec.addCell(cell3);
	float[] rowsc= { 175f, 175f, 175f };
	tablec.setTotalWidth(rowsc);
	tablec.setLockedWidth(true);
	
	PdfPCell cell12=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cell22=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cell32=new PdfPCell(new Paragraph(" ",secondFont));
	cell12.setBorder(Rectangle.NO_BORDER);
	cell22.setBorder(Rectangle.NO_BORDER);
	cell32.setBorder(Rectangle.NO_BORDER);
	tablec.addCell(cell12);
	tablec.addCell(cell22);
	tablec.addCell(cell32);
		
	
	document.add(tablec);
	
	
//Primary Taxpayer-Legal Description ---------------------------------------------

	
	PdfPCell celld1=new PdfPCell(new Paragraph("Primary Taxpayer",F10B));
	PdfPCell celld2=new PdfPCell(new Paragraph(" ",F10B));
	PdfPCell celld3=new PdfPCell(new Paragraph("Legal Description",F10B));
	float[] rowsd= { 200f, 5f, 350f };
	tabled.setTotalWidth(rowsd);
	tabled.setLockedWidth(true);
	celld1.setBorder(Rectangle.NO_BORDER);
	celld2.setBorder(Rectangle.NO_BORDER);
	celld3.setBorder(Rectangle.NO_BORDER);
	celld1.setHorizontalAlignment(Element.ALIGN_LEFT);
	celld1.setBackgroundColor(Color.LIGHT_GRAY);
	celld3.setBackgroundColor(Color.LIGHT_GRAY);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld1);
	tabled.addCell(celld2);
	tabled.addCell(celld3);
	
		
	
	
	PdfPCell celld11=new PdfPCell(new Paragraph(taxpayername,secondFont));
	PdfPCell celld21=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld31=new PdfPCell(new Paragraph(plegal[0],secondFont));
	//PdfPCell celld31=new PdfPCell(new Paragraph(legal1,secondFont));
	celld11.setBorder(Rectangle.NO_BORDER);
	celld21.setBorder(Rectangle.NO_BORDER);
	celld31.setBorder(Rectangle.NO_BORDER);
	celld11.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld11);
	tabled.addCell(celld21);
	tabled.addCell(celld31);
	
	PdfPCell celld12=new PdfPCell(new Paragraph(taxpad1,secondFont));
	PdfPCell celld22=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld32=new PdfPCell(new Paragraph(plegal[1],secondFont));
	//PdfPCell celld32=new PdfPCell(new Paragraph(legal2,secondFont));
	celld12.setBorder(Rectangle.NO_BORDER);
	celld22.setBorder(Rectangle.NO_BORDER);
	celld32.setBorder(Rectangle.NO_BORDER);
	celld12.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld12);
	tabled.addCell(celld22);
	tabled.addCell(celld32);
	
	PdfPCell celld13=new PdfPCell(new Paragraph(taxpad2,secondFont));
	PdfPCell celld23=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld33=new PdfPCell(new Paragraph(plegal[2],secondFont));
	celld13.setBorder(Rectangle.NO_BORDER);
	celld23.setBorder(Rectangle.NO_BORDER);
	celld33.setBorder(Rectangle.NO_BORDER);
	celld13.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld13);
	tabled.addCell(celld23);
	tabled.addCell(celld33);
	
	PdfPCell celld14=new PdfPCell(new Paragraph(taxpad3,secondFont));
	PdfPCell celld24=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld34=new PdfPCell(new Paragraph(plegal[3],secondFont));
	celld14.setBorder(Rectangle.NO_BORDER);
	celld24.setBorder(Rectangle.NO_BORDER);
	celld34.setBorder(Rectangle.NO_BORDER);
	celld14.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld14);
	tabled.addCell(celld24);
	tabled.addCell(celld34);
	
	PdfPCell celld15=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld25=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld35=new PdfPCell(new Paragraph(plegal[4],secondFont));
	celld15.setBorder(Rectangle.NO_BORDER);
	celld25.setBorder(Rectangle.NO_BORDER);
	celld35.setBorder(Rectangle.NO_BORDER);
	celld15.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld15);
	tabled.addCell(celld25);
	tabled.addCell(celld35);
	
	  
	
	for (int yyy = 5; yyy<plegal.length; yyy++) {
		if (plegal[yyy] !=null) {
			if (!plegal[yyy].equals("")) {
				PdfPCell celld150=new PdfPCell(new Paragraph(" ",secondFont));
				PdfPCell celld250=new PdfPCell(new Paragraph(" ",secondFont));
				PdfPCell celld350=new PdfPCell(new Paragraph(plegal[yyy],secondFont));
				celld150.setBorder(Rectangle.NO_BORDER);
				celld250.setBorder(Rectangle.NO_BORDER);
				celld350.setBorder(Rectangle.NO_BORDER);
				celld150.setHorizontalAlignment(Element.ALIGN_LEFT);
				tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
				tabled.addCell(celld150);
				tabled.addCell(celld250);
				tabled.addCell(celld350);		
			}
		}
	}
	
	
	
	
	
	
	
	PdfPCell celld151=new PdfPCell(new Paragraph(" ",F10B));
	PdfPCell celld251=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld351=new PdfPCell(new Paragraph(" ",secondFont));
	celld151.setBorder(Rectangle.NO_BORDER);
	celld251.setBorder(Rectangle.NO_BORDER);
	celld351.setBorder(Rectangle.NO_BORDER);
	celld151.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld151);
	tabled.addCell(celld251);
	tabled.addCell(celld351);

//Check if Alternate mailing information should be printed --------------------------	

	if (alternatename!=null) {	
	PdfPCell celld16=new PdfPCell(new Paragraph("Alternate Mailing Address",F10B));
	PdfPCell celld26=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld36=new PdfPCell(new Paragraph(" ",secondFont));
	celld16.setBorder(Rectangle.NO_BORDER);
	celld26.setBorder(Rectangle.NO_BORDER);
	celld36.setBorder(Rectangle.NO_BORDER);
	celld16.setBackgroundColor(Color.LIGHT_GRAY);
	celld16.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld16);
	tabled.addCell(celld26);
	tabled.addCell(celld36);
	
	PdfPCell celld17=new PdfPCell(new Paragraph(alternatename,secondFont));
	PdfPCell celld27=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld37=new PdfPCell(new Paragraph(" ",secondFont));
	celld17.setBorder(Rectangle.NO_BORDER);
	celld27.setBorder(Rectangle.NO_BORDER);
	celld37.setBorder(Rectangle.NO_BORDER);
	celld17.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld17);
	tabled.addCell(celld27);
	tabled.addCell(celld37);
	
	PdfPCell celld18=new PdfPCell(new Paragraph(alternatead1,secondFont));
	PdfPCell celld28=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld38=new PdfPCell(new Paragraph(" ",secondFont));
	celld18.setBorder(Rectangle.NO_BORDER);
	celld28.setBorder(Rectangle.NO_BORDER);
	celld38.setBorder(Rectangle.NO_BORDER);
	celld18.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld18);
	tabled.addCell(celld28);
	tabled.addCell(celld38);
	
	PdfPCell celld19=new PdfPCell(new Paragraph(alternatead2,secondFont));
	PdfPCell celld29=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld39=new PdfPCell(new Paragraph(" ",secondFont));
	celld19.setBorder(Rectangle.NO_BORDER);
	celld29.setBorder(Rectangle.NO_BORDER);
	celld39.setBorder(Rectangle.NO_BORDER);
	celld19.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld19);
	tabled.addCell(celld29);
	tabled.addCell(celld39);
	
	PdfPCell celld191=new PdfPCell(new Paragraph(alternatead3,secondFont));
	PdfPCell celld291=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld391=new PdfPCell(new Paragraph(" ",secondFont));
	celld191.setBorder(Rectangle.NO_BORDER);
	celld291.setBorder(Rectangle.NO_BORDER);
	celld391.setBorder(Rectangle.NO_BORDER);
	celld191.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld191);
	tabled.addCell(celld291);
	tabled.addCell(celld391);
	
	PdfPCell celld192=new PdfPCell(new Paragraph(alternatead4,secondFont));
	PdfPCell celld292=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld392=new PdfPCell(new Paragraph(" ",secondFont));
	celld192.setBorder(Rectangle.NO_BORDER);
	celld292.setBorder(Rectangle.NO_BORDER);
	celld392.setBorder(Rectangle.NO_BORDER);
	celld192.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld192);
	tabled.addCell(celld292);
	tabled.addCell(celld392);
	
	
	PdfPCell celld193=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld293=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell celld393=new PdfPCell(new Paragraph(" ",secondFont));
	celld193.setBorder(Rectangle.NO_BORDER);
	celld293.setBorder(Rectangle.NO_BORDER);
	celld393.setBorder(Rectangle.NO_BORDER);
	celld193.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.setHorizontalAlignment(Element.ALIGN_LEFT);
	tabled.addCell(celld193);
	tabled.addCell(celld293);
	tabled.addCell(celld393);
	
	}
	
		
		
	
    }



rs.close();


	

String query2=" SELECT * FROM ["+table2+"] ";
query2+=" WHERE (((["+table2+"].PARCEL)='"+parcelp+"'))";

   
   Statement stmt2 = con.createStatement();
   ResultSet rs2=stmt2.executeQuery(query2);
  
//System.out.println("QUERY2 IS "+query2);  
  
  

 if (rs2.next()) {
 
 
 	
 	String asmt1=rs2.getString(2);
 	String asmt2=rs2.getString(3);
 	String asmt3=rs2.getString(4);
 	String housecond=rs2.getString(5);
 	String housetype=rs2.getString(6);
 	String aircond=rs2.getString(7);
 	int yrblt=rs2.getInt(8);
 	int yrremodel=rs2.getInt(9);
 	int sqft=rs2.getInt(10);
 	float landval=rs2.getFloat(12);
 	float bldval=rs2.getFloat(13);
 	float totval=rs2.getFloat(14);
 	float totmkv=rs2.getFloat(15);
 	float totimpv=rs2.getFloat(16);
 	float totga=rs2.getFloat(17);
 	float totplat=rs2.getFloat(18);
 	float totjobz=rs2.getFloat(19);
 	float tothous=rs2.getFloat(20);
 	float totvets=rs2.getFloat(21);
 	float tottmv=rs2.getFloat(22);
 	
//Estimated Market Value
 	if (totmkv==0) {
		xtotmkv="";
	}
	else {
		xtotmkv=df1.format(totmkv);
	}
	
//Value of New Improvements
	if (totimpv==0) {
		xtotimpv="";
		}
	else {
		xtotimpv=df1.format(totimpv);
	}
	
//Green Acres Value
	if (totga==0) {
		xtotga="";
	}
	else {
		xtotga=df1.format(totga);
	}
	
//Plat Deferment
	if (totplat==0) {
		xtotplat="";
	}
	else {
		xtotplat=df1.format(totplat);
	}
	
//JOBZ
	if (totjobz==0) {
		xtotjobz="";
	}
	else {
		xtotjobz=df1.format(totjobz);
	}

//This Old House
	if (tothous==0) {
		xtothous="";
	}
	else {
		xtothous=df1.format(tothous);
	}

//Disabled Vets
	if (totvets==0) {
		xtotvets="";
	}
	else {
		xtotvets=df1.format(totvets);
	}

//Taxable Market Value
	if (tottmv==0) {
		xtottmv="";
	}
	else {
		xtottmv=df1.format(tottmv);
	}

//Year Built
	if (yrblt==0) {
		xyrbuilt="";
	}
	else {
		xyrbuilt=df2.format(yrblt);
	}

//Year Remodeled
	if (yrremodel==0) {
			xyrremodel="";
		}
	else {
		xyrremodel=df2.format(yrremodel);
	}

//Square Feet
	if (sqft==0) {
		xsqft="";
	}
	else {
		xsqft=df0.format(sqft);
	}

//Total Land Value
	if (landval==0) {
		xlandval="";
	}
	else {
		xlandval=df1.format(landval);
	}

//Total Building Value
	if (bldval==0){
		xbldval="";
	}
	else {
		xbldval=df1.format(bldval);
	}

//Total Value
	if (totval==0) {
		xtotval="";
	}
	else {
		xtotval=df1.format(totval);
	}
 	
 	 	
 	
	
	document.add(tabled);
	


//Table X ---------------------------------------------------------------------------


	PdfPTable tablex=new PdfPTable(5);
	float[] rowsx= { 200f, 5f, 200f, 5f, 200f };
	tablex.setTotalWidth(rowsx);
	tablex.setLockedWidth(true);
	
	
	PdfPCell cellx1=new PdfPCell(new Paragraph("Property Classification",F10B));
	PdfPCell cellx2=new PdfPCell(new Paragraph(" ",F10B));
	PdfPCell cellx3=new PdfPCell(new Paragraph("Property Address",F10B));
	PdfPCell cellx4=new PdfPCell(new Paragraph(" ",F10B));
	PdfPCell cellx5=new PdfPCell(new Paragraph("Lake #",F10B));
	cellx1.setBorder(Rectangle.NO_BORDER);
	cellx2.setBorder(Rectangle.NO_BORDER);
	cellx3.setBorder(Rectangle.NO_BORDER);
	cellx4.setBorder(Rectangle.NO_BORDER);
	cellx5.setBorder(Rectangle.NO_BORDER);
	cellx1.setBackgroundColor(Color.LIGHT_GRAY);
	cellx3.setBackgroundColor(Color.LIGHT_GRAY);
	cellx5.setBackgroundColor(Color.LIGHT_GRAY);
	cellx1.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.addCell(cellx1);
	tablex.addCell(cellx2);
	tablex.addCell(cellx3);
	tablex.addCell(cellx4);
	tablex.addCell(cellx5);
	
		

	PdfPCell cellx11=new PdfPCell(new Paragraph(asmt1,secondFont));
	PdfPCell cellx21=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx31=new PdfPCell(new Paragraph(propertyaddress,secondFont));
	PdfPCell cellx41=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx51=new PdfPCell(new Paragraph(lake,secondFont));
	cellx11.setBorder(Rectangle.NO_BORDER);
	cellx21.setBorder(Rectangle.NO_BORDER);
	cellx31.setBorder(Rectangle.NO_BORDER);
	cellx41.setBorder(Rectangle.NO_BORDER);
	cellx51.setBorder(Rectangle.NO_BORDER);
	cellx11.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.addCell(cellx11);
	tablex.addCell(cellx21);
	tablex.addCell(cellx31);
	tablex.addCell(cellx41);
	tablex.addCell(cellx51);
	
		

	PdfPCell cellx12=new PdfPCell(new Paragraph(asmt2,secondFont));
	PdfPCell cellx22=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx32=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx42=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx52=new PdfPCell(new Paragraph(" ",secondFont));
	cellx12.setBorder(Rectangle.NO_BORDER);
	cellx22.setBorder(Rectangle.NO_BORDER);
	cellx32.setBorder(Rectangle.NO_BORDER);
	cellx42.setBorder(Rectangle.NO_BORDER);
	cellx52.setBorder(Rectangle.NO_BORDER);
	cellx12.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.addCell(cellx12);
	tablex.addCell(cellx22);
	tablex.addCell(cellx32);
	tablex.addCell(cellx42);
	tablex.addCell(cellx52);
	
	
	PdfPCell cellx13=new PdfPCell(new Paragraph(asmt3,secondFont));
	PdfPCell cellx23=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx33=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx43=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellx53=new PdfPCell(new Paragraph(" ",secondFont));
	cellx13.setBorder(Rectangle.NO_BORDER);
	cellx23.setBorder(Rectangle.NO_BORDER);
	cellx33.setBorder(Rectangle.NO_BORDER);
	cellx43.setBorder(Rectangle.NO_BORDER);
	cellx53.setBorder(Rectangle.NO_BORDER);
	cellx33.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablex.addCell(cellx13);
	tablex.addCell(cellx23);
	tablex.addCell(cellx33);
	tablex.addCell(cellx43);
	tablex.addCell(cellx53);
	
	
	document.add(tablex);
	




//TABLE E ----------------------------------------------------------------------------

	
	PdfPTable tablee=new PdfPTable(4);
	float[] rowse= { 180f, 70f, 150f, 100f };
	tablee.setTotalWidth(rowse);
	tablee.setLockedWidth(true);
	
	PdfPCell celle1=new PdfPCell(new Paragraph(" "));
	PdfPCell celle2=new PdfPCell(new Paragraph(" "));
	PdfPCell celle3=new PdfPCell(new Paragraph(" ",F10B));
	PdfPCell celle4=new PdfPCell(new Paragraph(" ",secondFont));
	celle1.setBorder(Rectangle.NO_BORDER);
	celle2.setBorder(Rectangle.NO_BORDER);
	celle3.setBorder(Rectangle.NO_BORDER);
	celle4.setBorder(Rectangle.NO_BORDER);
	celle3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle4.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablee.addCell(celle1);
	tablee.addCell(celle2);
	tablee.addCell(celle3);
	tablee.addCell(celle4);

	PdfPCell celle12=new PdfPCell(new Paragraph("Estimated Market Value",secondFont));
	PdfPCell celle22=new PdfPCell(new Paragraph(xtotmkv,secondFont));
	PdfPCell celle32=new PdfPCell(new Paragraph("PRIMARY",F10B));
	PdfPCell celle42=new PdfPCell(new Paragraph("HOUSE SUMMARY",F10B));
	celle12.setBorder(Rectangle.NO_BORDER);
	celle22.setBorder(Rectangle.NO_BORDER);
	celle32.setBorder(Rectangle.NO_BORDER);
	celle42.setBorder(Rectangle.NO_BORDER);
	celle12.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle22.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle32.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle42.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablee.addCell(celle12);
	tablee.addCell(celle22);
	tablee.addCell(celle32);
	tablee.addCell(celle42);

	PdfPCell celle13=new PdfPCell(new Paragraph("Value of New Improvements",secondFont));
	PdfPCell celle23=new PdfPCell(new Paragraph(xtotimpv,secondFont));
	PdfPCell celle33=new PdfPCell(new Paragraph("Condition",secondFont));
	PdfPCell celle43=new PdfPCell(new Paragraph(housecond,secondFont));
	celle13.setBorder(Rectangle.NO_BORDER);
	celle23.setBorder(Rectangle.NO_BORDER);
	celle33.setBorder(Rectangle.NO_BORDER);
	celle43.setBorder(Rectangle.NO_BORDER);
	celle13.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle23.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle33.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle43.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle13);
	tablee.addCell(celle23);
	tablee.addCell(celle33);
	tablee.addCell(celle43);
	
	PdfPCell celle14=new PdfPCell(new Paragraph("Green Acres Value",secondFont));
	PdfPCell celle24=new PdfPCell(new Paragraph(xtotga,secondFont));
	PdfPCell celle34=new PdfPCell(new Paragraph("Type",secondFont));
	PdfPCell celle44=new PdfPCell(new Paragraph(housetype,secondFont));
	celle14.setBorder(Rectangle.NO_BORDER);
	celle24.setBorder(Rectangle.NO_BORDER);
	celle34.setBorder(Rectangle.NO_BORDER);
	celle44.setBorder(Rectangle.NO_BORDER);
	celle14.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle24.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle34.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle44.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle14);
	tablee.addCell(celle24);
	tablee.addCell(celle34);
	tablee.addCell(celle44);
	
	PdfPCell celle15=new PdfPCell(new Paragraph("Plat Deferement",secondFont));
	PdfPCell celle25=new PdfPCell(new Paragraph(xtotplat,secondFont));
	PdfPCell celle35=new PdfPCell(new Paragraph("# of Units",secondFont));
	PdfPCell celle45=new PdfPCell(new Paragraph(" "));
	celle15.setBorder(Rectangle.NO_BORDER);
	celle25.setBorder(Rectangle.NO_BORDER);
	celle35.setBorder(Rectangle.NO_BORDER);
	celle45.setBorder(Rectangle.NO_BORDER);
	celle15.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle25.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle35.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle45.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle15);
	tablee.addCell(celle25);
	tablee.addCell(celle35);
	tablee.addCell(celle45);
	
	PdfPCell celle16=new PdfPCell(new Paragraph("JOBZ Amount Excluded",secondFont));
	PdfPCell celle26=new PdfPCell(new Paragraph(xtotjobz,secondFont));
	PdfPCell celle36=new PdfPCell(new Paragraph("Total Sq Ft",secondFont));
	PdfPCell celle46=new PdfPCell(new Paragraph(xsqft,secondFont));
	celle16.setBorder(Rectangle.NO_BORDER);
	celle26.setBorder(Rectangle.NO_BORDER);
	celle36.setBorder(Rectangle.NO_BORDER);
	celle46.setBorder(Rectangle.NO_BORDER);
	celle16.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle26.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle36.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle46.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle16);
	tablee.addCell(celle26);
	tablee.addCell(celle36);
	tablee.addCell(celle46);
	
	PdfPCell celle17=new PdfPCell(new Paragraph("This Old House Exclusion",secondFont));
	PdfPCell celle27=new PdfPCell(new Paragraph(xtothous,secondFont));
	PdfPCell celle37=new PdfPCell(new Paragraph("Year Built",secondFont));
	PdfPCell celle47=new PdfPCell(new Paragraph(xyrbuilt,secondFont));
	celle17.setBorder(Rectangle.NO_BORDER);
	celle27.setBorder(Rectangle.NO_BORDER);
	celle37.setBorder(Rectangle.NO_BORDER);
	celle47.setBorder(Rectangle.NO_BORDER);
	celle17.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle27.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle37.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle47.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle17);
	tablee.addCell(celle27);
	tablee.addCell(celle37);
	tablee.addCell(celle47);
	
	PdfPCell celle18=new PdfPCell(new Paragraph("Dis Vets Mkt Value Exclusion",secondFont));
	PdfPCell celle28=new PdfPCell(new Paragraph(xtotvets,secondFont));
	PdfPCell celle38=new PdfPCell(new Paragraph("Year Remdl",secondFont));
	PdfPCell celle48=new PdfPCell(new Paragraph(xyrremodel,secondFont));
	celle18.setBorder(Rectangle.NO_BORDER);
	celle28.setBorder(Rectangle.NO_BORDER);
	celle38.setBorder(Rectangle.NO_BORDER);
	celle48.setBorder(Rectangle.NO_BORDER);
	celle18.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle28.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle38.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle48.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle18);
	tablee.addCell(celle28);
	tablee.addCell(celle38);
	tablee.addCell(celle48);
	
	PdfPCell celle19=new PdfPCell(new Paragraph("Taxable Market Value",secondFont));
	PdfPCell celle29=new PdfPCell(new Paragraph(xtottmv,secondFont));
	PdfPCell celle39=new PdfPCell(new Paragraph("Air Cond",secondFont));
	PdfPCell celle49=new PdfPCell(new Paragraph(aircond,secondFont));
	celle19.setBorder(Rectangle.NO_BORDER);
	celle29.setBorder(Rectangle.NO_BORDER);
	celle39.setBorder(Rectangle.NO_BORDER);
	celle49.setBorder(Rectangle.NO_BORDER);
	celle19.setHorizontalAlignment(Element.ALIGN_LEFT);
	celle29.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle39.setHorizontalAlignment(Element.ALIGN_RIGHT);
	celle49.setHorizontalAlignment(Element.ALIGN_RIGHT);
	tablee.addCell(celle19);
	tablee.addCell(celle29);
	tablee.addCell(celle39);
	tablee.addCell(celle49);
	
	document.add(tablee);
	
	document.add(Chunk.NEWLINE);
	
	
	
	
	
}


rs2.close();

//MOVE TO NEW PAGE
//document.newPage();


//TABLE F -------------------------------------------------------------------------

	
	PdfPTable tablef=new PdfPTable(6);
	float[] rowsf= { 40f, 100f, 100f, 100f, 10f, 50f };
	tablef.setTotalWidth(rowsf);
	tablef.setLockedWidth(true);



	PdfPCell cellf1=new PdfPCell(new Paragraph("YEAR",F10B));
	PdfPCell cellf2=new PdfPCell(new Paragraph(" "));
	PdfPCell cellf3=new PdfPCell(new Paragraph(" "));
	PdfPCell cellf4=new PdfPCell(new Paragraph(" "));
	PdfPCell cellf5=new PdfPCell(new Paragraph(" "));
	PdfPCell cellf6=new PdfPCell(new Paragraph(" "));
	

	cellf1.setBorder(Rectangle.NO_BORDER);
	cellf2.setBorder(Rectangle.NO_BORDER);
	cellf3.setBorder(Rectangle.NO_BORDER);
	cellf4.setBorder(Rectangle.NO_BORDER);
	cellf5.setBorder(Rectangle.NO_BORDER);
	cellf6.setBorder(Rectangle.NO_BORDER);
	
	
	cellf1.setPadding(-2f);
	cellf2.setPadding(-2f);
	cellf3.setPadding(-2f);
	cellf4.setPadding(-2f);
	cellf5.setPadding(-2f);
	cellf6.setPadding(-2f);
	
	
	
	cellf1.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellf2.setHorizontalAlignment(Element.ALIGN_LEFT);
	tablef.addCell(cellf1);
	tablef.addCell(cellf2);
	tablef.addCell(cellf3);
	tablef.addCell(cellf4);
	tablef.addCell(cellf5);
	tablef.addCell(cellf6);
	
	
		
	PdfPCell cellf12=new PdfPCell(new Paragraph("BUILT",F10B));
	PdfPCell cellf22=new PdfPCell(new Paragraph("ITEM",F10B));
	PdfPCell cellf32=new PdfPCell(new Paragraph("TYPE",F10B));
	PdfPCell cellf42=new PdfPCell(new Paragraph("QUANT/SF",F10B));
	PdfPCell cellf52=new PdfPCell(new Paragraph("",F10B));
	PdfPCell cellf62=new PdfPCell(new Paragraph("CER",F10B));
	

	cellf12.setBorder(Rectangle.BOTTOM);
	cellf22.setBorder(Rectangle.BOTTOM);
	cellf32.setBorder(Rectangle.BOTTOM);
	cellf42.setBorder(Rectangle.BOTTOM);
	cellf52.setBorder(Rectangle.BOTTOM);
	cellf62.setBorder(Rectangle.BOTTOM);
	

	
	cellf12.setPadding(1f);
	cellf22.setPadding(1f);
	cellf32.setPadding(1f);
	cellf42.setPadding(1f);
	cellf52.setPadding(1f);
	cellf62.setPadding(1f);
	

	cellf12.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellf22.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellf42.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	tablef.addCell(cellf12);
	tablef.addCell(cellf22);
	tablef.addCell(cellf32);
	tablef.addCell(cellf42);
	tablef.addCell(cellf52);
	tablef.addCell(cellf62);
	
	
	
	document.add(tablef);
	
	
	

String query3=" SELECT * FROM ["+table3+"] ";
query3+=" WHERE (((["+table3+"].PARCEL)='"+parcelp+"'))";

   
   Statement stmt3 = con.createStatement();
   ResultSet rs3=stmt3.executeQuery(query3);
  
//.err.println("QUERY3 IS "+query3);  
  
  	int svrecnum=0;
	int svsecnum=0;
 	String ft="Y";
 	String xcyrblt="";
 	String xcyreff="";
  	
  
	PdfPTable tableg=new PdfPTable(6);
	float[] rowsg= { 40f, 100f, 100f, 100f, 10f, 50f };
	tableg.setTotalWidth(rowsg);
	tableg.setLockedWidth(true);

 while (rs3.next()) {
 
 
 	
 	int recnum=rs3.getInt(2);
 	int secnum=rs3.getInt(3);
 	String item=rs3.getString(4);
 	String type=rs3.getString(5);
 	int cyrblt=rs3.getInt(8);
 	int cyreff=rs3.getInt(9);
 	float csqft=rs3.getFloat(10);
 	float ccer=rs3.getFloat(11);
 	
 	
 	if (item==null) {
		item="";
 	}
 	
 	
 	if (cyrblt==0) {
 		xcyrblt="";
 	}
 	else {
 	xcyrblt=df2.format(cyrblt);
 	}
 	
 	if (cyreff==0) {
		xcyreff="";
	}
 	else {
 	xcyreff=df2.format(cyreff);
 	}
 	
 	String xcsqft=df.format(csqft);

	if (ft.equals("Y")) {
		svrecnum=recnum;
		svsecnum=recnum;
		ft="N";
	}
	
	if (ccer==0) {
	 	xccer="";
 	}
	else {
	 	xccer=df.format(ccer);
 	}
	
//Process only if item not equal to blanks 	
 	if (!item.trim().equals("")) {
	 
	//System.err.println("ITEM IS "+item); 
	 
 	if ((svrecnum==recnum) | (svsecnum==secnum)) {
 	
	
	PdfPCell cellg1=new PdfPCell(new Paragraph(xcyrblt,secondFont));
	PdfPCell cellg2=new PdfPCell(new Paragraph(item,secondFont));
	PdfPCell cellg3=new PdfPCell(new Paragraph(type,secondFont));
	PdfPCell cellg4=new PdfPCell(new Paragraph(xcsqft,secondFont));
	PdfPCell cellg5=new PdfPCell(new Paragraph("",secondFont));
	PdfPCell cellg6=new PdfPCell(new Paragraph(xccer,secondFont));
	
	
	cellg1.setBorder(Rectangle.NO_BORDER);
	cellg2.setBorder(Rectangle.NO_BORDER);
	cellg3.setBorder(Rectangle.NO_BORDER);
	cellg4.setBorder(Rectangle.NO_BORDER);
	cellg5.setBorder(Rectangle.NO_BORDER);
	cellg6.setBorder(Rectangle.NO_BORDER);
	
	
	cellg1.setPadding(1f);
	cellg2.setPadding(1f);
	cellg3.setPadding(1f);
	cellg4.setPadding(1f);
	cellg5.setPadding(1f);
	cellg6.setPadding(1f);
	
	cellg1.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg2.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg4.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	tableg.addCell(cellg1);
	tableg.addCell(cellg2);
	tableg.addCell(cellg3);
	tableg.addCell(cellg4);
	tableg.addCell(cellg5);
	tableg.addCell(cellg6);
	
	
	}
	else {
	
	PdfPCell cellg11=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellg21=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellg31=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellg41=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellg51=new PdfPCell(new Paragraph(" ",secondFont));
	PdfPCell cellg61=new PdfPCell(new Paragraph(" ",secondFont));
	

	cellg11.setBorder(Rectangle.NO_BORDER);
	cellg21.setBorder(Rectangle.NO_BORDER);
	cellg31.setBorder(Rectangle.NO_BORDER);
	cellg41.setBorder(Rectangle.NO_BORDER);
	cellg51.setBorder(Rectangle.NO_BORDER);
	cellg61.setBorder(Rectangle.NO_BORDER);
	
	
	cellg11.setPadding(1f);
	cellg21.setPadding(1f);
	cellg31.setPadding(1f);
	cellg41.setPadding(1f);
	cellg51.setPadding(1f);
	cellg61.setPadding(1f);
	
	
	cellg11.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg21.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg41.setHorizontalAlignment(Element.ALIGN_RIGHT);

	tableg.addCell(cellg11);
	tableg.addCell(cellg21);
	tableg.addCell(cellg31);
	tableg.addCell(cellg41);
	tableg.addCell(cellg51);
	tableg.addCell(cellg61);
	
	
	svrecnum=recnum;
	svsecnum=recnum;
	
	PdfPCell cellg1=new PdfPCell(new Paragraph(xcyrblt,secondFont));
	PdfPCell cellg2=new PdfPCell(new Paragraph(item,secondFont));
	PdfPCell cellg3=new PdfPCell(new Paragraph(type,secondFont));
	PdfPCell cellg4=new PdfPCell(new Paragraph(xcsqft,secondFont));
	PdfPCell cellg5=new PdfPCell(new Paragraph("",secondFont));
	PdfPCell cellg6=new PdfPCell(new Paragraph(xccer,secondFont));
	

	cellg1.setBorder(Rectangle.NO_BORDER);
	cellg2.setBorder(Rectangle.NO_BORDER);
	cellg3.setBorder(Rectangle.NO_BORDER);
	cellg4.setBorder(Rectangle.NO_BORDER);
	cellg5.setBorder(Rectangle.NO_BORDER);
	cellg6.setBorder(Rectangle.NO_BORDER);
	
	
	cellg1.setPadding(1f);
	cellg2.setPadding(1f);
	cellg3.setPadding(1f);
	cellg4.setPadding(1f);
	cellg5.setPadding(1f);
	cellg6.setPadding(1f);
	

	cellg1.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg2.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellg4.setHorizontalAlignment(Element.ALIGN_RIGHT);

	tableg.addCell(cellg1);
	tableg.addCell(cellg2);
	tableg.addCell(cellg3);
	tableg.addCell(cellg4);
	tableg.addCell(cellg5);
	tableg.addCell(cellg6);
	
	
	
	}
	
	}
}

	document.add(tableg);
	

rs3.close();


	document.add(Chunk.NEWLINE);
	

	PdfPTable tablei=new PdfPTable(1);
	tablei.setWidthPercentage(90); 
	PdfPCell celli1=new PdfPCell(new Paragraph("Totals",F10B));
	
	celli1.setBorder(Rectangle.NO_BORDER);
	celli1.setHorizontalAlignment(Element.ALIGN_LEFT);
	celli1.setBackgroundColor(Color.LIGHT_GRAY);
	
	tablei.addCell(celli1);
	
	document.add(tablei);
	
	
	String land="LAND  "+xlandval;
	String buildings="BUILDINGS  "+xbldval;
	String total="TOTAL  "+xtotval;
	

	PdfPTable tableh=new PdfPTable(3);
	float[] rowsh= { 150f, 150f, 150f };
	tableh.setTotalWidth(rowsh);
	tableh.setLockedWidth(true);

	PdfPCell cellh1=new PdfPCell(new Paragraph(land,secondFont));	PdfPCell cellh2=new PdfPCell(new Paragraph(buildings,secondFont));
	PdfPCell cellh3=new PdfPCell(new Paragraph(total,secondFont));
	
	cellh1.setBorder(Rectangle.NO_BORDER);
	cellh2.setBorder(Rectangle.NO_BORDER);
	cellh3.setBorder(Rectangle.NO_BORDER);
	
	cellh1.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellh2.setHorizontalAlignment(Element.ALIGN_LEFT);
	cellh3.setHorizontalAlignment(Element.ALIGN_RIGHT);
	
	tableh.addCell(cellh1);
	tableh.addCell(cellh2);
	tableh.addCell(cellh3);
	
	document.add(tableh);
	
	
//Advance to new page of jpg2 is not null ----------------------------------------------
	
	if (jpg2!=null) {
	document.newPage();
	}
	
		
//Place images on document if image is not null ----------------------------------------

	if (jpg2!=null) {
	jpg2.scaleAbsolute(520, 520); 
	jpg2.setRotationDegrees(0); 
	document.add(jpg2);
	document.add(Chunk.NEWLINE);
	}

	
	if (jpg3!=null) {
	jpg3.scaleAbsolute(520, 520); 
	jpg3.setRotationDegrees(0); 
	document.add(jpg3);
	}


document.close();


  
response.sendRedirect("/iText/reports/"+cnty+"/paspdf.pdf?Time="+systime+"");  
  



%>
