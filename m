Return-Path: <sarab.1509@gmail.com>
MIME-Version: 1.0
From: Sarabjeet Singh <sarab.1509@gmail.com>
Date: Thu, 9 Aug 2018 11:32:55 +0530
Message-ID: <CAAB-rvomEKnzqc_kx9nLQWo1eUZ24=oPjegXv7EBP=tDgKbj2A@mail.gmail.com>
Subject: "block_device" structure removed from "bio"
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000007907b0572fa636d"
List-ID: <linux-block@vger.kernel.org>

--00000000000007907b0572fa636d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Greetings..!!

I'd like to report an issue which I've been facing in the new kernels (from
4.14 and newer).

Till kernel 4.13, we had the block_device structure as part of

struct *bio* <https://elixir.bootlin.com/linux/v4.4.146/ident/bio> {

       struct *bio*
<https://elixir.bootlin.com/linux/v4.4.146/ident/bio>
*bi_next;     */* request queue link */*

       *struct** block_device
<https://elixir.bootlin.com/linux/v4.4.146/ident/block_device>
*bi_bdev;*

       unsigned int         bi_flags;     */* status, command, etc */*

       int                  bi_error;

       unsigned long        bi_rw;        */* bottom bits READ/WRITE,*

*                                          * top bits priority*

*                                          */*


>From kernel 4.14 onwards, this has been removed and I'm facing this error:

*Error: =E2=80=9Cstruct bio=E2=80=9D has no member named =E2=80=9Cbi_bdev=
=E2=80=9D*


Code block (which gives this error):


*dev_t block_device =3D bio->bi_bdev->bd_dev*

As part of the driver code, I need to retrieve the *block_device* from
the *bio* structure.

As per my understanding there is no existing API to do the same. Can
you please let me know if there is any such API? If not, then can I
expect any fix for the same in the future?

--=20
Regards,
Sarabjeet Singh

--00000000000007907b0572fa636d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Greetings..!!</div><div><br></div><=
div>I&#39;d like to report an issue which I&#39;ve been facing in the new k=
ernels (from 4.14 and newer).</div><div><br></div><div>Till kernel 4.13, we=
 had the block_device structure as part of=C2=A0</div><div><br></div><div><=
pre style=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&quot;Couri=
er New&quot;"><span class=3D"gmail-k"><span style=3D"color:rgb(0,136,0)">st=
ruct</span></span><span style=3D"font-size:11pt;color:black"> <span class=
=3D"gmail-n"><a href=3D"https://elixir.bootlin.com/linux/v4.4.146/ident/bio=
" style=3D"color:rgb(5,99,193)"><b><span style=3D"background:rgb(244,246,25=
5)">bio</span></b></a></span> </span><span class=3D"gmail-p"><span style=3D=
"font-size:11pt;color:rgb(102,102,102)">{</span></span><span style=3D"font-=
size:11pt;color:black"></span></pre><pre style=3D"margin:0in 0in 0.0001pt;f=
ont-size:10pt;font-family:&quot;Courier New&quot;"><span style=3D"font-size=
:11pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </span><span class=
=3D"gmail-k"><span style=3D"color:rgb(0,136,0)">struct</span></span><span s=
tyle=3D"font-size:11pt;color:black"> <span class=3D"gmail-n"><a href=3D"htt=
ps://elixir.bootlin.com/linux/v4.4.146/ident/bio" style=3D"color:rgb(5,99,1=
93)"><b><span style=3D"background:rgb(244,246,255)">bio</span></b></a></spa=
n>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </span><span clas=
s=3D"gmail-o"><span style=3D"font-size:11pt;color:rgb(102,102,102)">*</span=
></span><span class=3D"gmail-n"><span style=3D"font-size:11pt;color:black">=
bi_next</span></span><span class=3D"gmail-p"><span style=3D"font-size:11pt;=
color:rgb(102,102,102)">;</span></span><span style=3D"font-size:11pt;color:=
black">=C2=A0=C2=A0=C2=A0=C2=A0 </span><span class=3D"gmail-cm"><i><span st=
yle=3D"font-size:11pt;color:slategray">/* request queue link */</span></i><=
/span><span style=3D"font-size:11pt;color:black"></span></pre><pre style=3D=
"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&quot;Courier New&quot;=
"><span style=3D"font-size:11pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 </span><span class=3D"gmail-k"><b><span style=3D"font-size:14pt;colo=
r:red">struct</span></b></span><b><span style=3D"font-size:16pt;color:red">=
 <span class=3D"gmail-n"><a href=3D"https://elixir.bootlin.com/linux/v4.4.1=
46/ident/block_device" style=3D"color:rgb(5,99,193)"><span style=3D"color:r=
ed;background:rgb(244,246,255)">block_device</span></a></span> <span class=
=3D"gmail-o">*</span><span class=3D"gmail-n">bi_bdev</span><span class=3D"g=
mail-p">;</span></span></b></pre><pre style=3D"margin:0in 0in 0.0001pt;font=
-size:10pt;font-family:&quot;Courier New&quot;"><span style=3D"font-size:11=
pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </span><span class=3D"=
gmail-kt"><span style=3D"font-size:11pt;color:rgb(51,51,153)">unsigned</spa=
n></span><span style=3D"font-size:11pt;color:black"> </span><span class=3D"=
gmail-kt"><span style=3D"font-size:11pt;color:rgb(51,51,153)">int</span></s=
pan><span style=3D"font-size:11pt;color:black">=C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 <span class=3D"gmail-n">bi_flags</span></span><span class=
=3D"gmail-p"><span style=3D"font-size:11pt;color:rgb(102,102,102)">;</span>=
</span><span style=3D"font-size:11pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0 =
</span><span class=3D"gmail-cm"><i><span style=3D"font-size:11pt;color:slat=
egray">/* status, command, etc */</span></i></span><span style=3D"font-size=
:11pt;color:black"></span></pre><pre style=3D"margin:0in 0in 0.0001pt;font-=
size:10pt;font-family:&quot;Courier New&quot;"><span style=3D"font-size:11p=
t;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </span><span class=3D"g=
mail-kt"><span style=3D"font-size:11pt;color:rgb(51,51,153)">int</span></sp=
an><span style=3D"font-size:11pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <spa=
n class=3D"gmail-n">bi_error</span></span><span class=3D"gmail-p"><span sty=
le=3D"font-size:11pt;color:rgb(102,102,102)">;</span></span><span style=3D"=
font-size:11pt;color:black"></span></pre><pre style=3D"margin:0in 0in 0.000=
1pt;font-size:10pt;font-family:&quot;Courier New&quot;"><span style=3D"font=
-size:11pt;color:black">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </span><span c=
lass=3D"gmail-kt"><span style=3D"font-size:11pt;color:rgb(51,51,153)">unsig=
ned</span></span><span style=3D"font-size:11pt;color:black"> </span><span c=
lass=3D"gmail-kt"><span style=3D"font-size:11pt;color:rgb(51,51,153)">long<=
/span></span><span style=3D"font-size:11pt;color:black"> =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <span class=3D"gmail-n">bi_rw</span></span><span class=
=3D"gmail-p"><span style=3D"font-size:11pt;color:rgb(102,102,102)">;</span>=
</span><span style=3D"font-size:11pt;color:black"> =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 </span><span class=3D"gmail-cm"><i><span style=3D"font-size:11=
pt;color:slategray">/* bottom bits READ/WRITE,</span></i></span><span style=
=3D"font-size:11pt;color:black"></span></pre><pre style=3D"margin:0in 0in 0=
.0001pt;font-size:10pt;font-family:&quot;Courier New&quot;"><span class=3D"=
gmail-cm"><i><span style=3D"font-size:11pt;color:slategray">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * top bits priority</span></i></span><span style=3D"font-size:11pt;c=
olor:black"></span></pre><pre style=3D"margin:0in 0in 0.0001pt;font-size:10=
pt;font-family:&quot;Courier New&quot;"><span class=3D"gmail-cm"><i><span s=
tyle=3D"font-size:11pt;color:slategray">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */</span></=
i></span><span style=3D"font-size:11pt;color:black"></span></pre><pre style=
=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&quot;Courier New&qu=
ot;"><br></pre><pre style=3D"margin:0in 0in 0.0001pt;font-family:&quot;Cour=
ier New&quot;"><span style=3D"font-family:Arial,Helvetica,sans-serif;white-=
space:normal">From kernel 4.14 onwards, this has been removed and I&#39;m f=
acing this error:</span></pre><pre style=3D"margin:0in 0in 0.0001pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;background-image:initi=
al;background-position:initial;background-size:initial;background-repeat:in=
itial;background-origin:initial;background-clip:initial"><b>Error: =E2=80=
=9Cstruct bio=E2=80=9D has no member named =E2=80=9Cbi_bdev=E2=80=9D</b></s=
pan>
</pre><pre style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:11pt;=
font-family:Arial,sans-serif;background-image:initial;background-position:i=
nitial;background-size:initial;background-repeat:initial;background-origin:=
initial;background-clip:initial"><b><br></b></span></pre><pre style=3D"marg=
in:0in 0in 0.0001pt"><span style=3D"font-size:11pt;font-family:Arial,sans-s=
erif;background-image:initial;background-position:initial;background-size:i=
nitial;background-repeat:initial;background-origin:initial;background-clip:=
initial">Code block (which gives this error):</span></pre><pre style=3D"mar=
gin:0in 0in 0.0001pt"><span style=3D"font-size:11pt;font-family:Arial,sans-=
serif;background-image:initial;background-position:initial;background-size:=
initial;background-repeat:initial;background-origin:initial;background-clip=
:initial"><b><br></b></span></pre><pre style=3D"margin:0in 0in 0.0001pt"><s=
pan style=3D"font-size:11pt;font-family:Arial,sans-serif;background-image:i=
nitial;background-position:initial;background-size:initial;background-repea=
t:initial;background-origin:initial;background-clip:initial"><b>dev_t block=
_device =3D bio-&gt;bi_bdev-&gt;bd_dev</b>
</span></pre><pre style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;background-image:initial;background-pos=
ition:initial;background-size:initial;background-repeat:initial;background-=
origin:initial;background-clip:initial">
</span></pre><pre style=3D"margin:0in 0in 0.0001pt"><pre style=3D"margin:0i=
n 0in 0.0001pt;font-family:&quot;Courier New&quot;"><span style=3D"font-fam=
ily:Arial,Helvetica,sans-serif;white-space:normal">As part of the driver co=
de, I need to retrieve the <b>block_device</b>=C2=A0from the <b>bio</b>=C2=
=A0structure.</span></pre><pre style=3D"margin:0in 0in 0.0001pt"><font face=
=3D"Arial, Helvetica, sans-serif"><span style=3D"white-space:normal">As per=
 my understanding there is no existing API to do the same. Can you please l=
et me know if there is any such API? If not, then can I expect any fix for =
the same in the future?</span></font></pre>
</pre></div><div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>Sarabjeet Sing=
h<br></div></div></div></div></div>

--00000000000007907b0572fa636d--
