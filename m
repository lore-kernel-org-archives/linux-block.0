Return-Path: <alex@iss-integration.com>
MIME-Version: 1.0
In-Reply-To: <20180413160334.5496-1-josef@toxicpanda.com>
References: <20180413160334.5496-1-josef@toxicpanda.com>
From: Alex Gorbachev <alex@iss-integration.com>
Date: Fri, 13 Apr 2018 23:03:12 -0400
Message-ID: <CAM1qzF5DOT1-RwpkwtG4X4MHtTgttz1mLLmXvhg_qyvN_h5=2Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] nbd: del_gendisk after we cleanup the queue
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
	kernel-team@fb.com, Josef Bacik <jbacik@fb.com>, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="f4f5e80ecc14bbd6470569c63aa4"
List-ID: <linux-block@vger.kernel.org>

--f4f5e80ecc14bbd6470569c63aa4
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 13, 2018 at 12:03 PM, Josef Bacik <josef@toxicpanda.com> wrote:

> From: Josef Bacik <jbacik@fb.com>
>
> This fixes a use after free bug, we need to do the del_gendisk after we
> cleanup the queue on the device.
>

The three patches Josef submitted today fix the problem with the online
rbd-nbd expansion completely.

Fixes: c6a4759ea0c9 ("nbd: add device refcounting")

> cc: stable@vger.kernel.org

> Signed-off-by: Josef Bacik <jbacik@fb.com>
Tested-by: Alex Gorbachev <ag@iss-integration.com>

> ---

>  drivers/block/nbd.c | 2 +-

>  1 file changed, 1 insertion(+), 1 deletion(-)

>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c

> index 86258b00a1d4..e33da3e6aa20 100644

> --- a/drivers/block/nbd.c

> +++ b/drivers/block/nbd.c

> @@ -174,8 +174,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)

>  {

>         struct gendisk *disk = nbd->disk;

>         if (disk) {

> -               del_gendisk(disk);

>                 blk_cleanup_queue(disk->queue);

> +               del_gendisk(disk);

>                 blk_mq_free_tag_set(&nbd->tag_set);

>                 disk->private_data = NULL;

>                 put_disk(disk);

> --

> 2.14.3

>
>

--f4f5e80ecc14bbd6470569c63aa4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div><div class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr">On Fri, Apr 13, 2018 at 12:03 PM, Josef Bacik <span dir=
=3D"ltr">&lt;<a href=3D"mailto:josef@toxicpanda.com" target=3D"_blank">jose=
f@toxicpanda.com</a>&gt;</span> wrote:<br></div></div></div></div></div></d=
iv></div></div></div></div></div></div></div></div><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">From: Josef Bacik &lt;<a href=3D"mailto:j=
bacik@fb.com">jbacik@fb.com</a>&gt;<br>
<br>
This fixes a use after free bug, we need to do the del_gendisk after we<br>
cleanup the queue on the device.<br></blockquote><div><br></div><div>

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">The three patches Josef submitted today fix the =
problem with the online rbd-nbd expansion completely.</span>=C2=A0</div><di=
v>=C2=A0
=C2=A0</div>Fixes: c6a4759ea0c9 (&quot;nbd: add device refcounting&quot;)<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1=
px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-l=
eft:1ex;padding-right:1ex"></blockquote>cc: <a href=3D"mailto:stable@vger.k=
ernel.org">stable@vger.kernel.org</a><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-rig=
ht:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockqu=
ote>Signed-off-by: Josef Bacik &lt;<a href=3D"mailto:jbacik@fb.com">jbacik@=
fb.com</a>&gt;</div><div class=3D"gmail_quote">

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">Tested-by: Alex Gorbachev &lt;</span><a href=3D"=
mailto:ag@iss-integration.com" target=3D"_blank" style=3D"color:rgb(17,85,2=
04);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255)">ag@iss-integrat=
ion.com</a><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline">&gt;</span>

<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left=
:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding=
-left:1ex;padding-right:1ex"></blockquote>---<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bo=
rder-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"><=
/blockquote>=C2=A0drivers/block/nbd.c | 2 +-<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bor=
der-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></=
blockquote>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>diff --git a/drivers=
/block/nbd.c b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:=
1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote=
>index 86258b00a1d4..e33da3e6aa20 100644<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-=
right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></bloc=
kquote>--- a/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1p=
x solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=
++ b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid =
rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>@@ -174,8=
 +174,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb=
(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;padd=
ing-right:1ex"></blockquote>=C2=A0{<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right=
:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquot=
e>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct gendisk *disk =3D nbd-&gt;disk;<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1=
ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disk) {<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:=
1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-=
left:1ex;padding-right:1ex"></blockquote>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0del_gendisk(disk);<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);borde=
r-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></bl=
ockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_cleanu=
p_queue(disk-&gt;queue)<wbr>;<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px s=
olid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0del_gendisk(disk);<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px =
solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left=
:1ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 blk_mq_free_tag_set(&amp;nbd-&gt;tag_<wbr>set);<br><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;=
padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 disk-&gt;private_data =3D NULL;<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bo=
rder-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"><=
/blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_dis=
k(disk);<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote><span style=3D"color:rgb(136,136,136)">--=C2=A0</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1e=
x;padding-right:1ex"></blockquote><span style=3D"color:rgb(136,136,136)">2.=
14.3</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span clas=
s=3D"HOEnZb"><font color=3D"#888888">
<br>
</font></span></blockquote></div><br></div></div>

--f4f5e80ecc14bbd6470569c63aa4--
