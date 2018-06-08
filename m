Return-Path: <liwan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180607204541.13491-1-axboe@kernel.dk>
References: <20180607204541.13491-1-axboe@kernel.dk>
From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Jun 2018 14:12:12 +0800
Message-ID: <CAEemH2fcvMh2jS2zF0uvUuCrpL79LoBHFEQ84_bsbYkzsvMRmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix bio_set copy
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, snitzer@redhat.com,
	Kent Overstreet <kent.overstreet@gmail.com>, vrbagal1@linux.vnet.ibm.com,
	chuhu.ncepu@gmail.com
Content-Type: multipart/alternative; boundary="000000000000e9b359056e1b474d"
List-ID: <linux-block@vger.kernel.org>

--000000000000e9b359056e1b474d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk> wrote:

> After a recent change, dm ends up doing a straight copy of a
> bio_set. This breaks for various items in that bio_set,
> most notably lists. Provide a proper helper for it, and use it.
>
> =E2=80=8B

I can confirm that the issue[1] was gone with this patchset applied.


   Tested-by: Li Wang <liwang@redhat.com>

=E2=80=8B

[1] https://lkml.org/lkml/2018/6/7/36=E2=80=8B


--=20
Regards,
Li Wang

--000000000000e9b359056e1b474d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Jens Axboe <span dir=3D"ltr">&l=
t;<a href=3D"mailto:axboe@kernel.dk" target=3D"_blank">axboe@kernel.dk</a>&=
gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">After a recent change, dm ends up doing a straight c=
opy of a<br>
bio_set. This breaks for various items in that bio_set,<br>
most notably lists. Provide a proper helper for it, and use it.<br>
<span class=3D"gmail-m_-2162323037218147927m_1290600533259362776HOEnZb"><fo=
nt color=3D"#888888"><br></font></span></blockquote><div><div style=3D"font=
-size:small;display:inline" class=3D"gmail_default">=E2=80=8B</div><div sty=
le=3D"font-size:small;display:inline" class=3D"gmail_default"><br></div><di=
v style=3D"font-size:small;display:inline" class=3D"gmail_default">I can co=
nfirm that the issue[1] was gone with this patchset applied.</div><div styl=
e=3D"font-size:small;display:inline" class=3D"gmail_default"><br></div><div=
 style=3D"font-size:small;display:inline" class=3D"gmail_default"><br></div=
><div style=3D"font-size:small;display:inline" class=3D"gmail_default"><div=
 class=3D"gmail_default">=C2=A0=C2=A0 Tested-by: Li Wang &lt;<a href=3D"mai=
lto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;<br></div=
><br></div><div style=3D"font-size:small;display:inline" class=3D"gmail_def=
ault">=E2=80=8B</div>=C2=A0<div style=3D"font-size:small;display:inline" cl=
ass=3D"gmail_default">[1] <a href=3D"https://lkml.org/lkml/2018/6/7/36">htt=
ps://lkml.org/lkml/2018/6/7/36</a>=E2=80=8B</div><br></div></div><br>-- <br=
><div class=3D"gmail-m_-2162323037218147927m_1290600533259362776gmail_signa=
ture"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div><=
/div>
</div></div>

--000000000000e9b359056e1b474d--
