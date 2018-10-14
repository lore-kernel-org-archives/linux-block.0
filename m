Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20181011165909.32615-1-axboe@kernel.dk> <20181011165909.32615-15-axboe@kernel.dk>
 <CADvA-dnKCWSBZsmtnG=w_iAfU-aFxEq9oi_z_XV044648GYejA@mail.gmail.com>
 <fee272b4-4f75-4b70-fa32-1143bd34f6af@kernel.dk> <CADvA-dnUNB7UcaiXbbYS_VF22Po5h52MHwYCGP5+44isZ=duAw@mail.gmail.com>
 <2fb82c13-66c0-30bb-a408-10e01abc648f@kernel.dk> <CADvA-d=vzinC3+Qof7FgbKrp1e1ikdBAV0iX0fxGO=e5Qy_9CQ@mail.gmail.com>
In-Reply-To: <CADvA-d=vzinC3+Qof7FgbKrp1e1ikdBAV0iX0fxGO=e5Qy_9CQ@mail.gmail.com>
From: Ed Cashin <ecashin@noserose.net>
Date: Sat, 13 Oct 2018 20:48:55 -0400
Message-ID: <CADvA-dnc=MH1XMhPFWPTW5=GVyF7296RS_aufwN3CEFsNpiyVg@mail.gmail.com>
Subject: Re: [PATCH 14/17] aoe: convert aoeblk to blk-mq
To: Ed Cashin <ed.cashin@acm.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000000e2e52057825b027"
List-ID: <linux-block@vger.kernel.org>

--0000000000000e2e52057825b027
Content-Type: text/plain; charset="UTF-8"

I reviewed the changes. They looked good.

On Fri, Oct 12, 2018 at 12:26 PM Ed Cashin <ed.cashin@acm.org> wrote:

> On Fri, Oct 12, 2018 at 12:23 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/12/18 10:17 AM, Ed Cashin wrote:
> > > On Fri, Oct 12, 2018 at 10:20 AM Jens Axboe <axboe@kernel.dk> wrote:
> > >>
> > >> On 10/12/18 5:28 AM, Ed Cashin wrote:
> > >>> OK.  We always tried to avoid putting includes in the .h file, so
> > >>> if you wouldn't mind moving the include to the C files, that would
> > >>> be nice.  I wouldn't insist, though.
> > >>
> > >> There's really no way around it, since I'm embedding the tag_set
> > >> in the device.
> > >>
> > >> Is that OK with you?
> > >
> > > Yes, it's fine.  Thank you.
> >
> > Can I add a reviewed-by?
>
> Acked-by is already fine, but I can give it more attention tomorrow, and
> after
> that a reviewed-by would be appropriate.
>
> --
>   Ed
>
-- 
  Ed Cashin <ecashin@noserose.net>

--0000000000000e2e52057825b027
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">I reviewed the changes. They looked good.</div></div=
><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Oct 12, 2018 =
at 12:26 PM Ed Cashin &lt;<a href=3D"mailto:ed.cashin@acm.org">ed.cashin@ac=
m.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Oct 12=
, 2018 at 12:23 PM Jens Axboe &lt;<a href=3D"mailto:axboe@kernel.dk" target=
=3D"_blank">axboe@kernel.dk</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/12/18 10:17 AM, Ed Cashin wrote:<br>
&gt; &gt; On Fri, Oct 12, 2018 at 10:20 AM Jens Axboe &lt;<a href=3D"mailto=
:axboe@kernel.dk" target=3D"_blank">axboe@kernel.dk</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 10/12/18 5:28 AM, Ed Cashin wrote:<br>
&gt; &gt;&gt;&gt; OK.=C2=A0 We always tried to avoid putting includes in th=
e .h file, so<br>
&gt; &gt;&gt;&gt; if you wouldn&#39;t mind moving the include to the C file=
s, that would<br>
&gt; &gt;&gt;&gt; be nice.=C2=A0 I wouldn&#39;t insist, though.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; There&#39;s really no way around it, since I&#39;m embedding =
the tag_set<br>
&gt; &gt;&gt; in the device.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is that OK with you?<br>
&gt; &gt;<br>
&gt; &gt; Yes, it&#39;s fine.=C2=A0 Thank you.<br>
&gt;<br>
&gt; Can I add a reviewed-by?<br>
<br>
Acked-by is already fine, but I can give it more attention tomorrow, and af=
ter<br>
that a reviewed-by would be appropriate.<br>
<br>
-- <br>
=C2=A0 Ed<br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=C2=A0 Ed Cashin &lt;<a=
 href=3D"mailto:ecashin@noserose.net" target=3D"_blank">ecashin@noserose.ne=
t</a>&gt;</div></div>

--0000000000000e2e52057825b027--
