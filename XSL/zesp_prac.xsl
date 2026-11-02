<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <html>
            <body>
                <h1>ZESPOŁY:</h1>
                <ol>
                    <xsl:apply-templates select="ZESPOLY/ROW"/>
                </ol>
                <xsl:apply-templates select="ZESPOLY/ROW" mode="szczegoly"/>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="ZESPOLY/ROW">
        <li><a href="#{ID_ZESP}"><xsl:value-of select="NAZWA"/></a></li>
    </xsl:template>

    <xsl:template match="ZESPOLY/ROW" mode="szczegoly">
        <h2 id="{ID_ZESP}">NAZWA: <xsl:value-of select="NAZWA"/><br/>
            ADRES: <xsl:value-of select="ADRES"/>
        </h2>
        <xsl:if test="PRACOWNICY/ROW">
        <table border="1">
            <tr>
                <th>Nazwisko</th><th>Etat</th><th>Zatrudniony</th><th>Płaca pod.</th><th>Szef</th>
            </tr>
            <xsl:apply-templates select="PRACOWNICY/ROW">
                <xsl:sort select="NAZWISKO"/>
            </xsl:apply-templates>
        </table>
        </xsl:if>
        <p>Liczba pracowników: <xsl:value-of select="count(PRACOWNICY/ROW)"/></p>
    </xsl:template>

    <xsl:template match="PRACOWNICY/ROW">
        <tr>
            <td><xsl:value-of select="NAZWISKO"/></td>
            <td><xsl:value-of select="ETAT"/></td>
            <td><xsl:value-of select="ZATRUDNIONY"/></td>
            <td><xsl:value-of select="PLACA_POD"/></td>
            <td>
                <xsl:choose>
                    <xsl:when test="ID_SZEFA != ''">
                        <xsl:value-of select="//PRACOWNICY/ROW[ID_PRAC=current()/ID_SZEFA]/NAZWISKO"/>
                    </xsl:when>
                    <xsl:otherwise>brak</xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>