<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kw="http://www.klocwork.com/inForce/report/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
<xsl:output method="html" encoding="GBK" version="4.0"/>
<xsl:template match="/kw:errorList">
    <html>
      <head>
        <title>Klocwork Issues</title>
      </head>
	  <style type="text/css"> 
	/* CSS Document */ 
	body { 
		font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		background: #E6EAE9; 
	} 

	table { 
		border-collapse: collapse;
		empty-cells: show;
		width: 900px; 
		padding: 0; 
		margin: 0; 
	} 

	caption { 
		padding: 0 0 5px 0;      
		font: 20px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		text-align: center; 
	}
	caption.sub { 
		padding: 0 0 5px 0;      
		font: 12px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		text-align: left; 
	}

	th { 
		font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		border-top: 1px solid #C1DAD7; 
		letter-spacing: 2px; 
		text-transform: uppercase; 
		text-align: center; 
		padding: 5px 4px 4px 6px;    
		background: #CAE8EA; 
	} 
	
	th.fst { 
		font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		border-left: 1px solid #C1DAD7; 
		border-right: 1px solid #C1DAD7;
		border-bottom: 1px solid #C1DAD7; 
		border-top: 1px solid #C1DAD7; 
		letter-spacing: 2px; 
		text-transform: uppercase; 
		text-align: center; 
		padding: 5px 4px 4px 6px;    
		background: #CAE8EA; 
		width: 60px;
	} 

	td { 
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px; 
		text-align: right;
		color: #4f6b72; 
	} 

	td.fst { 
		border-left: 1px solid #C1DAD7;
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px; 
		text-align: left;
		color: #4f6b72; 
	} 
	td.E { 
		border-left: 1px solid #C1DAD7;
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px; 
		text-align: right;		
		color: #FF0000; 
	} 
	td.sub{
		text-align: left;
	}
	dt {
		color: #4f6b72;
	}

	dt.E {
		color: #FF0000;
	}
	
	</style> 
      <body>
        <table>
		<caption>Klocwork Report</caption>
		<caption class="sub">Project:projectDescription Time:buildTime</caption>
          <tr>
            <th class="fst" rowspan="3">Owner</th>
			<th width="80px" rowspan="3">Count</th>
            <th colspan="10">Severity</th>
            <th rowspan="2" colspan="3">State</th>
            <th rowspan="2" colspan="3">Status</th>
          </tr>
		  <tr>
            <th colspan="5">Error</th>
			<th colspan="5">Warning</th>
          </tr>
		  <tr>
			<th width="60px">Critical(1)</th>
			<th width="60px">Severe(2)</th>
			<th width="60px">Error(3)</th>
			<th width="60px">Unexpected(4)</th>
			<th width="60px">Investigate(5)</th>
			<th width="60px">Warning(6)</th>
			<th width="60px">Suggestion(7)</th>
			<th width="60px">Style(8)</th>
			<th width="60px">Review(9)</th>
			<th width="60px">Info(10)</th>
			
            <th width="60px">New</th>
            <th width="60px">Existing</th>
            <th width="60px">Recurred</th>
			
            <th width="60px">Analyze</th>
            <th width="60px">Fix</th>
            <th width="60px">Defer</th>
          </tr> 
<!--		  <tr>
			<th width="40px">1级</th>
			<th width="40px">2级</th>
			<th width="40px">3级</th>
			<th width="40px">4级</th>
			<th width="40px">5级</th>
			<th width="40px">6级</th>
			<th width="40px">7级</th>
			<th width="40px">8级</th>
			<th width="40px">9级</th>
			<th width="50px">10级</th>
			
            <th width="50px">New</th>
            <th width="50px">Existing</th>
            <th width="50px">Recurred</th>
			
            <th width="50px">Analyze</th>
            <th width="50px">Fix</th>
            <th width="50px">Defer</th>
          </tr>-->
          <tr>
			<td class = "fst">Total</td>
			<td>
				<xsl:value-of select="count(//kw:problem)"/>
            </td>
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="count(//kw:severitylevel[contains(.,'1')])>0"> 
				<td class="E">
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'1')])"/>
				</td>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
				<td>
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'1')])"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="count(//kw:severitylevel[contains(.,'2')])=0"> 
				<td>
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'2')])"/>
				</td>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
				<td class="E">
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'2')])"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="count(//kw:severitylevel[contains(.,'3')])>0"> 
				<td class="E">
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'3')])"/>
				</td>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
				<td>
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'3')])"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="count(//kw:severitylevel[contains(.,'4')])>0"> 
				<td class="E">
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'4')])"/>
				</td>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
				<td>
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'4')])"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="count(//kw:severitylevel[contains(.,'5')])>0"> 
				<td class="E">
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'5')])"/>
				</td>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
				<td>
					<xsl:value-of select="count(//kw:severitylevel[contains(.,'5')])"/>
				</td>
			</xsl:otherwise>
			</xsl:choose>
		<!--	
			<td class="E">
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'1')])"/>
			</td>
			
			<td class="E">
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'2')])"/>
			</td>
			<td class="E">
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'3')])"/>
			</td>
			<td class="E">
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'4')])"/>
			</td> 
			<td class="E">
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'5')])"/>
			</td>
		-->
			<td>
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'6')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'7')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'8')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:severitylevel[contains(.,'9')])"/>
			</td>
			<td>
			  	<xsl:value-of select="count(//kw:severitylevel[contains(.,'10')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:state[contains(.,'New')])"/>
			</td> 
			<td>
				<xsl:value-of select="count(//kw:state[contains(.,'Existing')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:state[contains(.,'Recurred')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:citingStatus[contains(.,'Analyze')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:citingStatus[contains(.,'Fix')])"/>
			</td>
			<td>
				<xsl:value-of select="count(//kw:citingStatus[contains(.,'Defer')])"/>
			</td>
		  </tr>
		  
		    <xsl:for-each-group select="/kw:errorList/kw:problem" group-by="./kw:owner">
				<xsl:sort select="kw:owner"/>
				<tr>
				 			
				<td class = "fst">
					<xsl:value-of select="current-grouping-key()"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:owner)"/>
				</td>
				
				<xsl:choose>
				<!-- type of "E"-->
				<xsl:when test="count(current-group()/kw:severitylevel[contains(.,'1')])>0"> 
					<td class="E">
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'1')])"/>
					</td>
				</xsl:when>
				<!-- type of "C"-->
				<xsl:otherwise> 
					<td>
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'1')])"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<!-- type of "E"-->
				<xsl:when test="count(current-group()/kw:severitylevel[contains(.,'2')])>0"> 
					<td class="E">
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'2')])"/>
					</td>
				</xsl:when>
				<!-- type of "C"-->
				<xsl:otherwise> 
					<td>
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'2')])"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<!-- type of "E"-->
				<xsl:when test="count(current-group()/kw:severitylevel[contains(.,'3')])>0"> 
					<td class="E">
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'3')])"/>
					</td>
				</xsl:when>
				<!-- type of "C"-->
				<xsl:otherwise> 
					<td>
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'3')])"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<!-- type of "E"-->
				<xsl:when test="count(current-group()/kw:severitylevel[contains(.,'4')])>0"> 
					<td class="E">
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'4')])"/>
					</td>
				</xsl:when>
				<!-- type of "C"-->
				<xsl:otherwise> 
					<td>
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'4')])"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<!-- type of "E"-->
				<xsl:when test="count(current-group()/kw:severitylevel[contains(.,'5')])>0"> 
					<td class="E">
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'5')])"/>
					</td>
				</xsl:when>
				<!-- type of "C"-->
				<xsl:otherwise> 
					<td>
						<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'5')])"/>
					</td>
				</xsl:otherwise>
				</xsl:choose>
			<!--	
				<td class="E">
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'1')])"/>
				</td>
				<td class="E">
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'2')])"/>
				</td>
				<td class="E">
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'3')])"/>
				</td>
				<td class="E">
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'4')])"/>
				</td> 
				<td class="E">
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'5')])"/>
				</td>
				-->
				<td>
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'6')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'7')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'8')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'9')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:severitylevel[contains(.,'10')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:state[contains(.,'New')])"/>
				</td> 
				<td>
					<xsl:value-of select="count(current-group()/kw:state[contains(.,'Existing')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:state[contains(.,'Recurred')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:citingStatus[contains(.,'Analyze')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:citingStatus[contains(.,'Fix')])"/>
				</td>
				<td>
					<xsl:value-of select="count(current-group()/kw:citingStatus[contains(.,'Defer')])"/>
				</td>
			  </tr>
			 </xsl:for-each-group>
        </table>
<!--
		<br />
		<br />
		<table style="width: 250px;">
		<caption class="sub" style="text-align: center">严重等级说明表</caption>
			<tr><th>类别</th><th>级别</th><th>说明</th></tr>
			<tr><th rowspan="5" style="width: 40px; writing-mode:tb-rl">Error</th><td class="sub">1级</td><td class="sub">Critical(1)</td></tr>
			<tr><td class="sub">2级</td><td class="sub">Severe(2)</td></tr>
			<tr><td class="sub">3级</td><td class="sub">Error(3)</td></tr>
			<tr><td class="sub">4级</td><td class="sub">Unexpected(4)</td></tr>
			<tr><td class="sub">5级</td><td class="sub">Investigate(5)</td></tr>
			<tr><th rowspan="5" style="width: 40px; writing-mode:tb-rl">Warning</th><td class="sub">6级</td><td class="sub">Warning(6)</td></tr>
			<tr><td class="sub">7级</td><td class="sub">Suggestion(7)</td></tr>
			<tr><td class="sub">8级</td><td class="sub">Style(8)</td></tr>
			<tr><td class="sub">9级</td><td class="sub">Review(9)</td></tr>
			<tr><td class="sub">10级</td><td class="sub">Info(10)</td></tr>
		</table>  -->
      </body>
    </html>
  </xsl:template>
	
</xsl:stylesheet>