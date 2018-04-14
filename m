Return-Path: <alex@iss-integration.com>
MIME-Version: 1.0
In-Reply-To: <20180413160334.5496-2-josef@toxicpanda.com>
References: <20180413160334.5496-1-josef@toxicpanda.com> <20180413160334.5496-2-josef@toxicpanda.com>
From: Alex Gorbachev <alex@iss-integration.com>
Date: Fri, 13 Apr 2018 23:02:33 -0400
Message-ID: <CAM1qzF7dMiFcNXnmd+PB0w29EnQ2KTEHAvtU=PdhPnHav3rpUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] nbd: update size when connected
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
	kernel-team@fb.com, Josef Bacik <jbacik@fb.com>, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000006172df0569c63832"
List-ID: <linux-block@vger.kernel.org>

--0000000000006172df0569c63832
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 13, 2018 at 12:03 PM, Josef Bacik <josef@toxicpanda.com> wrote:

> From: Josef Bacik <jbacik@fb.com>
>
> I messed up changing the size of an NBD device while it was connected by
> not actually updating the device or doing the uevent.  Fix this by
> updating everything if we're connected and we change the size.
>

The three patches Josef submitted today fix the problem with the online
rbd-nbd expansion completely.


cc: stable@vger.kernel.org

> Fixes: 639812a ("nbd: don't set the device size until we're connected")

> Signed-off-by: Josef Bacik <jbacik@fb.com>
Tested-by: Alex Gorbachev <ag@iss-integration.com>

> ---

>  drivers/block/nbd.c | 2 ++

>  1 file changed, 2 insertions(+)

>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c

> index e33da3e6aa20..1520383b12f6 100644

> --- a/drivers/block/nbd.c

> +++ b/drivers/block/nbd.c

> @@ -243,6 +243,8 @@ static void nbd_size_set(struct nbd_device *nbd,
loff_t blocksize,

>         struct nbd_config *config = nbd->config;

>         config->blksize = blocksize;

>         config->bytesize = blocksize * nr_blocks;

> +       if (nbd->task_recv != NULL)

> +               nbd_size_update(nbd);

>  }

>
 static void nbd_complete_rq(struct request *req)

> --

> 2.14.3

>
>

--0000000000006172df0569c63832
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Apr 13, 2018 at 12:03 PM, Josef Bacik <span dir=3D"ltr">&lt;<a href=3D"=
mailto:josef@toxicpanda.com" target=3D"_blank">josef@toxicpanda.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: J=
osef Bacik &lt;<a href=3D"mailto:jbacik@fb.com">jbacik@fb.com</a>&gt;<br>
<br>
I messed up changing the size of an NBD device while it was connected by<br=
>
not actually updating the device or doing the uevent.=C2=A0 Fix this by<br>
updating everything if we&#39;re connected and we change the size.<br></blo=
ckquote><div><br></div><div>

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">The three patches Josef submitted today fix the =
problem with the online rbd-nbd expansion completely.</span>

<br></div><div>=C2=A0</div><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px sol=
id rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>cc: <a=
 href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.org</a><br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex=
;padding-right:1ex"></blockquote>Fixes: 639812a (&quot;nbd: don&#39;t set t=
he device size until we&#39;re connected&quot;)<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);=
border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"=
></blockquote>Signed-off-by: Josef Bacik &lt;<a href=3D"mailto:jbacik@fb.co=
m">jbacik@fb.com</a>&gt;</div><div class=3D"gmail_quote">

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">Tested-by: Alex Gorbachev &lt;<a href=3D"mailto:a=
g@iss-integration.com">ag@iss-integration.com</a>&gt;</span>

<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left=
:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding=
-left:1ex;padding-right:1ex"></blockquote>---<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bo=
rder-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"><=
/blockquote>=C2=A0drivers/block/nbd.c | 2 ++<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bor=
der-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></=
blockquote>=C2=A01 file changed, 2 insertions(+)<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>diff --git a/drivers=
/block/nbd.c b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:=
1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote=
>index e33da3e6aa20..1520383b12f6 100644<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-=
right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></bloc=
kquote>--- a/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1p=
x solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=
++ b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid =
rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>@@ -243,6=
 +243,8 @@ static void nbd_size_set(struct nbd_device *nbd, loff_t blocksiz=
e,<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);paddi=
ng-left:1ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
uct nbd_config *config =3D nbd-&gt;config;<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);borde=
r-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></bl=
ockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;blksize =3D blocksize;<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px =
solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left=
:1ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt=
;bytesize =3D blocksize * nr_blocks;<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-righ=
t:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquo=
te>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nbd-&gt;task_recv !=3D NULL)<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid r=
gb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;pa=
dding-right:1ex"></blockquote>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nbd_size_update(nbd);<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:=
1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote=
>=C2=A0}<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>=C2=A0static void nb=
d_complete_rq(struct request *req)<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
</blockquote><span style=3D"color:rgb(136,136,136)">--=C2=A0</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1e=
x;padding-right:1ex"></blockquote><span style=3D"color:rgb(136,136,136)">2.=
14.3</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span clas=
s=3D"HOEnZb"><font color=3D"#888888">
<br>
</font></span></blockquote></div><br></div></div>

--0000000000006172df0569c63832--
