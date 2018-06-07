Return-Path: <liwan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Jun 2018 11:22:12 +0800
Message-ID: <CAEemH2drzjnUbSP=65_UtwrdJxohKS3LcZLeT+ZL2iOiTXjg=w@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Coly Li <colyli@suse.de>, hch@lst.de,
	darrick.wong@oracle.com, snitzer@redhat.com, linux-block@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000001b3d66056e04ca9b"
List-ID: <linux-block@vger.kernel.org>

--0000000000001b3d66056e04ca9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 6, 2018 at 10:18 PM, Jens Axboe <axboe@kernel.dk> wrote:

> On 6/6/18 2:41 AM, Kent Overstreet wrote:
> > On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
> >> Hi BIO experts,
> >>
> >> I catch this panic issue on some kind of arches(x86_64, ppc64,
> >> ppc64le..), it seems the root cause is very probably from BIO changes
> >> from kernel-4.17-rc7. Plz take a look.
> >
> > That's the bioset changes, the fix is out and on its way in
>
> It's already in mainline, since about lunch time yesterday.
>

=E2=80=8BWhich commit fix that?=E2=80=8B



>
>
> --
> Jens Axboe
>
>


--=20
Regards,
Li Wang

--0000000000001b3d66056e04ca9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Ju=
n 6, 2018 at 10:18 PM, Jens Axboe <span dir=3D"ltr">&lt;<a href=3D"mailto:a=
xboe@kernel.dk" target=3D"_blank">axboe@kernel.dk</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 6=
/6/18 2:41 AM, Kent Overstreet wrote:<br>
&gt; On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:<br>
&gt;&gt; Hi BIO experts,<br>
&gt;&gt;<br>
&gt;&gt; I catch this panic issue on some kind of arches(x86_64, ppc64,<br>
&gt;&gt; ppc64le..), it seems the root cause is very probably from BIO chan=
ges<br>
&gt;&gt; from kernel-4.17-rc7. Plz take a look.<br>
&gt; <br>
&gt; That&#39;s the bioset changes, the fix is out and on its way in<br>
<br>
</div></div>It&#39;s already in mainline, since about lunch time yesterday.=
<br></blockquote><div><br></div><div><div style=3D"font-size:small" class=
=3D"gmail_default">=E2=80=8BWhich commit fix that?=E2=80=8B</div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Jens Axboe<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div>
</div></div>

--0000000000001b3d66056e04ca9b--
