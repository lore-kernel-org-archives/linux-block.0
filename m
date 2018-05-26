Return-Path: <Frederick.Knight@netapp.com>
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Christoph Hellwig <hch@lst.de>, "Popuri, Sriram"
	<Sriram.Popuri@netapp.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Jens
 Axboe" <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH 13/14] nvme: use the changed namespaces list log to	clear
 ns data changed AENs
Date: Sat, 26 May 2018 13:02:51 +0000
Message-ID: <DM6PR06MB38337075BFA7E11BC2D9BA92F1680@DM6PR06MB3833.namprd06.prod.outlook.com>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
 <BN7PR06MB403359D8914D0A17425C037E92680@BN7PR06MB4033.namprd06.prod.outlook.com>
 <20180526122137.GA21257@lst.de>
In-Reply-To: <20180526122137.GA21257@lst.de>
Content-Type: multipart/alternative;
	boundary="_000_DM6PR06MB38337075BFA7E11BC2D9BA92F1680DM6PR06MB3833namp_"
MIME-Version: 1.0
Return-Path: Frederick.Knight@netapp.com
List-ID: <linux-block@vger.kernel.org>

--_000_DM6PR06MB38337075BFA7E11BC2D9BA92F1680DM6PR06MB3833namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Section 5.2:

Asynchronous events are grouped into event types. The event type informatio=
n is indicated in Dword 0 of the completion queue entry for the Asynchronou=
s Event Request command. When the controller posts a completion queue entry=
 for an outstanding Asynchronous Event Request command and thus reports an =
asynchronous event, subsequent events of that event type are automatically =
masked by the controller until the host clears that event. An event is clea=
red by reading the log page associated with that event using the Get Log Pa=
ge command (refer to section 5.14).

The event is cleared by reading the log page associated with that event ...=
   I don't know how the event can be cleared if the associated log page is =
not supported (the masking of subsequent events of that type would turn it =
into a one-shot).  Interesting however, in the list (that reports "the foll=
owing event types are defined"), there are several of the defined events mi=
ssing.  Looks like an ECN opportunity to flush out that list of defined eve=
nt types.

In addition, how is this bit set:

95:92   M       Optional Asynchronous Events Supported (OAES): This field i=
ndicates the optional asynchronous events supported by the controller. A co=
ntroller shall not send optional asynchronous events before they are enable=
d by host software.

Bits 31:10 are reserved.
Bit 9 is set to '1' if the controller supports sending Firmware Activation =
Notices. If cleared to '0', then the controller does not support the Firmwa=
re Activation Notices event.

Bit 8 is set to '1' if the controller supports sending Namespace Attribute =
Notices and the associated Changed Namespace List log page. If cleared to '=
0', then the controller does not support the Namespace Attribute Notices ev=
ent nor the associated Changed Namespace List log page.
Bits 7:0 are reserved.

Not sure how you set that bit if you support the AEN but not the log page.

        Fred

-----Original Message-----
From: Christoph Hellwig <hch@lst.de>
Sent: Saturday, May 26, 2018 8:22 AM
To: Popuri, Sriram <Sriram.Popuri@netapp.com>
Cc: Christoph Hellwig <hch@lst.de>; linux-nvme@lists.infradead.org; Knight,=
 Frederick <Frederick.Knight@netapp.com>; Jens Axboe <axboe@kernel.dk>; Kei=
th Busch <keith.busch@intel.com>; linux-block@vger.kernel.org; Sagi Grimber=
g <sagi@grimberg.me>; Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] nvme: use the changed namespaces list log to cle=
ar ns data changed AENs

On Sat, May 26, 2018 at 12:05:02PM +0000, Popuri, Sriram wrote:
> Reading the spec it looks like ns log is alternate approach:
>
> "Namespace Attribute Changed: The Identify Namespace data structure for o=
ne or more namespaces, as well as the Namespace List returned when the Iden=
tify command is issued with the CNS field set to 02h, have changed. Host so=
ftware may use this event as an indication that it should read the Identify=
 Namespace data structures for each namespace to determine what has changed=
.
>
> Alternatively, host software may request the Changed Namespace List (Log =
Identifier 04h) to determine which namespaces in this controller have chang=
ed Identify Namespace information since the last time the log page was read=
."
>
> My question is: Does the target needs to implement log page 04h as this i=
s an optional log page and the text above suggests its used in alternate wa=
y?

Section 5.2 clearly states that each AER comes with a log page to
clear it, and the above does not contain any language to explicitly
override it. So my reading of the spec is that to clear the event you need
to read the log page, but to find out what has changed you might issue
Identify commands instead.

> If target is not required to implement, then I guess your change should s=
till work because if log page 04h fails, it fails back to rescan. Correct?

Independ of what the spec actually requires, the code tries to robust
as possible and falls back to doing the manual scan.

> I think you can optimize this by checking the "Log Page Identifier" field=
 in your result and accordingly setting EVENT_NS_CHANGED. I assume target w=
ould clear this if log page 04h is not supported.

We can try that, but I'm not sure what it is going to buy us.


--_000_DM6PR06MB38337075BFA7E11BC2D9BA92F1680DM6PR06MB3833namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div><font color=3D"#0070C0">Section 5.2:</font></div>
<div>&nbsp;</div>
<div><i>Asynchronous events are grouped into event types. The event type in=
formation is indicated in Dword 0 of the completion queue entry for the Asy=
nchronous Event Request command. When the controller posts a completion que=
ue entry for an outstanding Asynchronous
Event Request command and thus reports an asynchronous event, </i><span sty=
le=3D"background-color:yellow;"><i>subsequent events of that event type are=
 automatically masked by the controller until the host clears that event.</=
i></span><i> </i><span style=3D"background-color:yellow;"><i>An
event is cleared by reading the log page</i></span><i> associated with that=
 event using the Get Log Page command (refer to section 5.14).</i></div>
<div>&nbsp;</div>
<div><font color=3D"#0070C0">The event is cleared by reading the log page a=
ssociated with that event ...&nbsp;&nbsp; I don't know how the event can be=
 cleared if the associated log page is not supported (the masking of subseq=
uent events of that type would turn it into
a one-shot).  Interesting however, in the list (that reports &#8220;the fol=
lowing event types are defined&#8221;), there are several of the defined ev=
ents missing.&nbsp; Looks like an ECN opportunity to flush out that list of=
 defined event types.</font></div>
<div><font color=3D"#0070C0">&nbsp;</font></div>
<div><font color=3D"#0070C0">In addition, how is this bit set:</font></div>
<div><font color=3D"#0070C0">&nbsp;</font></div>
<table width=3D"778" style=3D"width:467.2pt;margin-left:5.8pt;">
<col width=3D"137" style=3D"width:82.35pt;">
<col width=3D"59" style=3D"width:35.85pt;">
<col width=3D"581" style=3D"width:349pt;">
<tr>
<td align=3D"center" style=3D"text-align:center;"><font face=3D"Arial" size=
=3D"2"><span style=3D"font-size:9pt;">95:92</span></font></td>
<td align=3D"center" style=3D"text-align:center;"><font face=3D"Arial" size=
=3D"2"><span style=3D"font-size:9pt;">M</span></font></td>
<td align=3D"left" style=3D"text-align:justify;"><font face=3D"Arial" size=
=3D"2"><span style=3D"font-size:9pt;"><b>Optional Asynchronous Events Suppo=
rted (OAES): </b>This field indicates the optional asynchronous events supp=
orted by the controller. A controller shall
not send optional asynchronous events before they are enabled by host softw=
are.=20
<div align=3D"left" style=3D"text-align:justify;margin-top:6pt;"><font face=
=3D"Arial" size=3D"2"><span style=3D"font-size:9pt;">Bits 31:10 are reserve=
d.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:9pt;">Bit 9=
 is set to &#8216;1&#8217; if the controller supports sending Firmware Acti=
vation Notices. If cleared to &#8216;0&#8217;, then the controller does not=
 support the Firmware Activation Notices event.</span></font></div>
<div align=3D"left" style=3D"text-align:justify;margin-top:6pt;"><font face=
=3D"Arial" size=3D"2"><span style=3D"font-size:9pt;">Bit 8 is set to &#8216=
;1&#8217; if <span style=3D"background-color:yellow;">the controller suppor=
ts</span> sending Namespace Attribute Notices <span style=3D"background-col=
or:yellow;">and
the associated Changed Namespace List log page</span><span style=3D"backgro=
und-color:yellow;">.</span> If cleared to &#8216;0&#8217;, then the control=
ler <span style=3D"background-color:yellow;">does not support</span> the Na=
mespace Attribute Notices event nor the associated
Changed Namespace List log page.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:9pt;">Bits =
7:0 are reserved.</span></font></div>
</span></font></td>
</tr>
</table>
<div>&nbsp;</div>
<a name=3D"_MailEndCompose"></a>
<div><font color=3D"#0070C0">Not sure how you set that bit if you support t=
he AEN but not the log page.</font></div>
<div><font color=3D"#0070C0">&nbsp;</font></div>
<div><font color=3D"#0070C0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fre=
d</font></div>
<div>&nbsp;</div>
<div>-----Original Message-----<br>

From: Christoph Hellwig &lt;hch@lst.de&gt; <br>

Sent: Saturday, May 26, 2018 8:22 AM<br>

To: Popuri, Sriram &lt;Sriram.Popuri@netapp.com&gt;<br>

Cc: Christoph Hellwig &lt;hch@lst.de&gt;; linux-nvme@lists.infradead.org; K=
night, Frederick &lt;Frederick.Knight@netapp.com&gt;; Jens Axboe &lt;axboe@=
kernel.dk&gt;; Keith Busch &lt;keith.busch@intel.com&gt;; linux-block@vger.=
kernel.org; Sagi Grimberg &lt;sagi@grimberg.me&gt;; Hannes Reinecke
&lt;hare@suse.de&gt;<br>

Subject: Re: [PATCH 13/14] nvme: use the changed namespaces list log to cle=
ar ns data changed AENs</div>
<div>&nbsp;</div>
<div>On Sat, May 26, 2018 at 12:05:02PM &#43;0000, Popuri, Sriram wrote:</d=
iv>
<div>&gt; Reading the spec it looks like ns log is alternate approach:</div=
>
<div>&gt; </div>
<div>&gt; &quot;Namespace Attribute Changed: The Identify Namespace data st=
ructure for one or more namespaces, as well as the Namespace List returned =
when the Identify command is issued with the CNS field set to 02h, have cha=
nged. Host software may use this event as
an indication that it should read the Identify Namespace data structures fo=
r each namespace to determine what has changed.</div>
<div>&gt; </div>
<div>&gt; Alternatively, host software may request the Changed Namespace Li=
st (Log Identifier 04h) to determine which namespaces in this controller ha=
ve changed Identify Namespace information since the last time the log page =
was read.&quot;</div>
<div>&gt; </div>
<div>&gt; My question is: Does the target needs to implement log page 04h a=
s this is an optional log page and the text above suggests its used in alte=
rnate way?</div>
<div>&nbsp;</div>
<div>Section 5.2 clearly states that each AER comes with a log page to</div=
>
<div>clear it, and the above does not contain any language to explicitly</d=
iv>
<div>override it. So my reading of the spec is that to clear the event you =
need</div>
<div>to read the log page, but to find out what has changed you might issue=
</div>
<div>Identify commands instead.</div>
<div>&nbsp;</div>
<div>&gt; If target is not required to implement, then I guess your change =
should still work because if log page 04h fails, it fails back to rescan. C=
orrect?</div>
<div>&nbsp;</div>
<div>Independ of what the spec actually requires, the code tries to robust<=
/div>
<div>as possible and falls back to doing the manual scan.</div>
<div>&nbsp;</div>
<div>&gt; I think you can optimize this by checking the &quot;Log Page Iden=
tifier&quot; field in your result and accordingly setting EVENT_NS_CHANGED.=
 I assume target would clear this if log page 04h is not supported.</div>
<div>&nbsp;</div>
<div>We can try that, but I'm not sure what it is going to buy us.</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_DM6PR06MB38337075BFA7E11BC2D9BA92F1680DM6PR06MB3833namp_--
