<?xml version="1.0" encoding="UTF-8"?>
<!--
Sépare la licence des conditions d'accès

https://ecospheres.gitbook.io/recommandations-iso-dcat/adaptation-des-metadonnees-iso-19139-pour-faciliter-la-transformation-en-dcat/separer-la-licence-des-conditions-dacces

NOTES:
- Ajout en cas d'absence ?
- Quid des cas codeListValue != 'otherRestrictions' ?
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:geonet="http://www.fao.org/geonetwork"
                exclude-result-prefixes="#all">

  <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/
                       gmd:resourceConstraints[gmd:MD_LegalConstraints]"
                priority="2">
    <xsl:for-each select="gmd:MD_LegalConstraints[gmd:accessConstraints]">
      <gmd:resourceConstraints>
        <gmd:MD_LegalConstraints>
          <xsl:copy-of select="gmd:accessConstraints"/>
          <xsl:if test="gmd:accessConstraints/gmd:MD_RestrictionCode[@codeListValue='otherRestrictions']">
             <xsl:copy-of select="gmd:otherConstraints"/>
          </xsl:if>
        </gmd:MD_LegalConstraints>
      </gmd:resourceConstraints>
    </xsl:for-each>
    <xsl:for-each select="gmd:MD_LegalConstraints[gmd:useConstraints]">
      <gmd:resourceConstraints>
        <gmd:MD_LegalConstraints>
          <xsl:copy-of select="gmd:useConstraints"/>
          <xsl:if test="gmd:useConstraints/gmd:MD_RestrictionCode[@codeListValue='otherRestrictions']">
            <xsl:copy-of select="gmd:otherConstraints"/>
          </xsl:if>
        </gmd:MD_LegalConstraints>
      </gmd:resourceConstraints>
    </xsl:for-each>
  </xsl:template>

  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
