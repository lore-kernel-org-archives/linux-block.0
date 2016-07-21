Return-Path: <florian-ewald.mueller@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <3e8dcc7f-8502-b0b2-3c0a-43db0c3d7433@kernel.dk>
References: <CAHJVUej82MtyPdVXdU82Hj=HgdXRuqng5nQxgrznUBq8rB0Rng@mail.gmail.com>
 <3e8dcc7f-8502-b0b2-3c0a-43db0c3d7433@kernel.dk>
From: =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@profitbricks.com>
Date: Thu, 21 Jul 2016 20:59:14 +0200
Message-ID: <CAHJVUeiS+dHTqPRzL2bwJr9RMFXcrpwJ2O6kt6KtHni8sSTnYA@mail.gmail.com>
Subject: Re: [PATCH linux-4.7-rc7] blk_stack_limits() setting discard_granularity
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1142d01c27c5cc053829eb5b
List-ID: <linux-block@vger.kernel.org>

--001a1142d01c27c5cc053829eb5b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Ok, no problem.

Thanks for the quick answer,
Florian

On Thu, Jul 21, 2016 at 8:56 PM, Jens Axboe <axboe@kernel.dk> wrote:

> On 07/21/2016 12:09 PM, Florian-Ewald M=C3=BCller wrote:
>
>> blk_stack_limits() can set discard_granularity bigger than
>> max_discard_sectors (in bytes).
>> This makes blk_bio_discard_split() non-functional and can lead to data
>> corruption.
>>
>
> Let's get rid of the unlikely(), this isn't a hot path.
>
> --
> Jens Axboe
>
>


--=20

Florian-Ewald Mueller

Architecture Board


*ProfitBricks GmbH*
Greifswalder Str. 207
D - 10405 Berlin


Tel:       +49 30 577 008 331
Fax:      +49 30 577 008 598
Email:   florian-ewald.mueller@profitbricks.com
<firstname.lastname@profitbricks.com>
URL:     http://www.profitbricks.de <https://www.profitbricks.de/>

Sitz der Gesellschaft: Berlin.
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B.
Gesch=C3=A4ftsf=C3=BChrer: Andreas Gauger, Achim Weiss.

Please consider the environment before printing this email.

--001a1142d01c27c5cc053829eb5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Ok, no problem.</div><div><br></div=
><div>Thanks for the quick answer,</div><div>Florian</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jul 21, 2016 at 8:5=
6 PM, Jens Axboe <span dir=3D"ltr">&lt;<a href=3D"mailto:axboe@kernel.dk" t=
arget=3D"_blank">axboe@kernel.dk</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On 07/21/2016 12:09 PM, Florian-Ewald M=C3=
=BCller wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
blk_stack_limits() can set discard_granularity bigger than<br>
max_discard_sectors (in bytes).<br>
This makes blk_bio_discard_split() non-functional and can lead to data<br>
corruption.<br>
</blockquote>
<br></span>
Let&#39;s get rid of the unlikely(), this isn&#39;t a hot path.<span class=
=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Jens Axboe<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><span><div><p style=3D"margin-top:0cm;margin-right:0cm;margin-bot=
tom:0.0001pt;margin-left:0cm;font-size:12pt;font-family:&#39;Times New Roma=
n&#39;,serif"><span lang=3D"EN-US" style=3D"font-size:10pt">Florian-Ewald M=
ueller</span></p></div><div><p style=3D"margin-top:0cm;margin-right:0cm;mar=
gin-bottom:0.0001pt;margin-left:0cm;font-size:12pt;font-family:&#39;Times N=
ew Roman&#39;,serif"><font size=3D"3"><span style=3D"font-size:13px">Archit=
ecture Board</span></font></p></div><div><p style=3D"margin-top:0cm;margin-=
right:0cm;margin-bottom:0.0001pt;margin-left:0cm;font-size:12pt;font-family=
:&#39;Times New Roman&#39;,serif"><span lang=3D"EN-US" style=3D"font-size:8=
pt;color:rgb(34,34,34)"><br></span><b><span style=3D"font-size:8pt;color:rg=
b(34,34,34)">ProfitBricks GmbH</span></b><span style=3D"font-size:8pt;color=
:rgb(34,34,34)"><br>Greifswalder Str. 207<br>D - 10405 Berlin</span><span s=
tyle=3D"color:rgb(34,34,34)"><u></u><u></u></span></p></div><div><p style=
=3D"margin-top:0cm;margin-right:0cm;margin-bottom:0.0001pt;margin-left:0cm;=
font-size:12pt;font-family:&#39;Times New Roman&#39;,serif"><span style=3D"=
font-size:8pt;color:rgb(34,34,34)"><br>Tel: =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=
+49 30 577 008 331<br>Fax: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+49 30 577 008 598=
<br>Email: =C2=A0=C2=A0</span><a href=3D"mailto:firstname.lastname@profitbr=
icks.com" style=3D"color:rgb(17,85,204)" target=3D"_blank">florian-ewald.mu=
eller@profitbricks.com</a><span style=3D"font-size:8pt;color:rgb(34,34,34)"=
><br>URL: =C2=A0 =C2=A0=C2=A0</span><a href=3D"https://www.profitbricks.de/=
" style=3D"color:rgb(17,85,204)" target=3D"_blank">http://www.profitbricks.=
de</a><span style=3D"font-size:8pt;color:rgb(34,34,34)"><br><br>Sitz der Ge=
sellschaft: Berlin.<br>Registergericht: Amtsgericht Charlottenburg, HRB 125=
506 B.<br>Gesch=C3=A4ftsf=C3=BChrer: Andreas Gauger, Achim Weiss.<br><br></=
span><span lang=3D"EN-US" style=3D"font-size:8pt;color:green">Please consid=
er the environment before printing this email.<u></u><u></u></span></p><p s=
tyle=3D"margin-top:0cm;margin-right:0cm;margin-bottom:0.0001pt;margin-left:=
0cm;font-size:12pt;font-family:&#39;Times New Roman&#39;,serif"><span lang=
=3D"EN-US" style=3D"font-size:8pt;color:green"><u></u>=C2=A0</span></p></di=
v></span></div></div>
</div>

--001a1142d01c27c5cc053829eb5b--
