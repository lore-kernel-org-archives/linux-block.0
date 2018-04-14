Return-Path: <alex@iss-integration.com>
MIME-Version: 1.0
In-Reply-To: <20180413160334.5496-3-josef@toxicpanda.com>
References: <20180413160334.5496-1-josef@toxicpanda.com> <20180413160334.5496-3-josef@toxicpanda.com>
From: Alex Gorbachev <alex@iss-integration.com>
Date: Fri, 13 Apr 2018 23:01:28 -0400
Message-ID: <CAM1qzF7TSb57pjhSqtSq7wXUc7zR6SPa7tK-tXAdPNGet55T6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] nbd: use bd_set_size when updating disk size
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
	kernel-team@fb.com, Josef Bacik <jbacik@fb.com>, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000087cd8f0569c6343c"
List-ID: <linux-block@vger.kernel.org>

--00000000000087cd8f0569c6343c
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 13, 2018 at 12:03 PM, Josef Bacik <josef@toxicpanda.com> wrote:

> From: Josef Bacik <jbacik@fb.com>
>
> When we stopped relying on the bdev everywhere I broke updating the
> block device size on the fly, which ceph relies on.  We can't just do
> set_capacity, we also have to do bd_set_size so things like parted will
> notice the device size change.
>

The three patches Josef submitted today fix the problem with the online
rbd-nbd expansion completely.


Fixes: 29eaadc ("nbd: stop using the bdev everywhere")

> cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
Tested-by: Alex Gorbachev <ag@iss-integration.com>

> ---

>  drivers/block/nbd.c | 7 ++++++-

>  1 file changed, 6 insertions(+), 1 deletion(-)

>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c

> index 1520383b12f6..61dd95aa47fa 100644

> --- a/drivers/block/nbd.c

> +++ b/drivers/block/nbd.c

> @@ -231,9 +231,15 @@ static void nbd_size_clear(struct nbd_device *nbd)

>  static void nbd_size_update(struct nbd_device *nbd)

>  {

>         struct nbd_config *config = nbd->config;

> +       struct block_device *bdev = bdget_disk(nbd->disk, 0);

> +

>         blk_queue_logical_block_size(nbd->disk->queue, config->blksize);

>         blk_queue_physical_block_size(nbd->disk->queue, config->blksize);

>         set_capacity(nbd->disk, config->bytesize >> 9);

> +       if (bdev) {

> +               bd_set_size(bdev, config->bytesize);

> +               bdput(bdev);

> +       }

>         kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);

>  }

>
@@ -1111,7 +1117,6 @@ static int nbd_start_device_ioctl(struct nbd_device
*nbd, struct block_device *b

>         if (ret)

>                 return ret;

>
-       bd_set_size(bdev, config->bytesize);

>         if (max_part)

>                 bdev->bd_invalidated = 1;

>         mutex_unlock(&nbd->config_lock);

> --

> 2.14.3

>
>

--00000000000087cd8f0569c6343c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Apr 13, 2018 at 12:03 PM, Josef Bacik <span dir=3D"ltr">&lt;<a href=3D"=
mailto:josef@toxicpanda.com" target=3D"_blank">josef@toxicpanda.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">From: Josef Bacik &lt;<a h=
ref=3D"mailto:jbacik@fb.com">jbacik@fb.com</a>&gt;<br>
<br>
When we stopped relying on the bdev everywhere I broke updating the<br>
block device size on the fly, which ceph relies on.=C2=A0 We can&#39;t just=
 do<br>
set_capacity, we also have to do bd_set_size so things like parted will<br>
notice the device size change.<br></blockquote><div><br></div><div>The thre=
e patches Josef submitted today fix the problem with the online rbd-nbd exp=
ansion completely.</div><div><br></div><div>=C2=A0</div>Fixes: 29eaadc (&qu=
ot;nbd: stop using the bdev everywhere&quot;)<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bo=
rder-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"><=
/blockquote>cc: <a href=3D"mailto:stable@vger.kernel.org">stable@vger.kerne=
l.org</a><br>
Signed-off-by: Josef Bacik &lt;<a href=3D"mailto:jbacik@fb.com">jbacik@fb.c=
om</a>&gt;<br><div>Tested-by: Alex Gorbachev &lt;<a href=3D"mailto:ag@iss-i=
ntegration.com">ag@iss-integration.com</a>&gt;</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex=
"></blockquote>---<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(20=
4,204,204);padding-left:1ex;padding-right:1ex"></blockquote>=C2=A0drivers/b=
lock/nbd.c | 7 ++++++-<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid rg=
b(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>=C2=A01 fil=
e changed, 6 insertions(+), 1 deletion(-)<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>diff --git a/drivers=
/block/nbd.c b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:=
1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote=
>index 1520383b12f6..61dd95aa47fa 100644<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-=
right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></bloc=
kquote>--- a/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1p=
x solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=
++ b/drivers/block/nbd.c<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid =
rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>@@ -231,9=
 +231,15 @@ static void nbd_size_clear(struct nbd_device *nbd)<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rg=
b(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;pad=
ding-right:1ex"></blockquote>=C2=A0static void nbd_size_update(struct nbd_d=
evice *nbd)<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;=
border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,2=
04);padding-left:1ex;padding-right:1ex"></blockquote>=C2=A0{<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(=
204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;paddi=
ng-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nbd_config *c=
onfig =3D nbd-&gt;config;<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid=
 rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct block_device *bdev =3D bdget_disk(nbd-&gt;disk, =
0);<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padd=
ing-left:1ex;padding-right:1ex"></blockquote>+<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);b=
order-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex">=
</blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_queue_logical_block_size(<wbr>=
nbd-&gt;disk-&gt;queue, config-&gt;blksize);<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bor=
der-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></=
blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_queue_physical_block_size(<wbr>n=
bd-&gt;disk-&gt;queue, config-&gt;blksize);<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bord=
er-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></b=
lockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_capacity(nbd-&gt;disk, config-&gt=
;bytesize &gt;&gt; 9);<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid rg=
b(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (bdev) {<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:1px so=
lid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bd_set_size(bdev, confi=
g-&gt;bytesize);<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
.8ex;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,=
204,204);padding-left:1ex;padding-right:1ex"></blockquote>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdput(bdev);<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-rig=
ht:1ex"></blockquote>+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1=
ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 kobject_uevent(&amp;nbd_to_dev=
(<wbr>nbd)-&gt;kobj, KOBJ_CHANGE);<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-right:=
1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockquote=
>=C2=A0}<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>@@ -1111,7 +1117,6 @=
@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_de=
vice *b<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);=
padding-left:1ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret)<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex=
;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,=
204);padding-left:1ex;padding-right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
</blockquote><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8e=
x;border-left:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204=
,204);padding-left:1ex;padding-right:1ex"></blockquote>-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0bd_set_size(bdev, config-&gt;bytesize);<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204=
);border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1e=
x"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (max_part)<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204=
,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-=
right:1ex"></blockquote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bdev-&gt;bd_invalidated =3D 1;<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);border-rig=
ht:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></blockqu=
ote>=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;nbd-&gt;config_<wbr>lock)=
;<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote><span style=3D"color:rgb(136,136,136)">--=C2=A0</span><br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1e=
x;padding-right:1ex"></blockquote><span style=3D"color:rgb(136,136,136)">2.=
14.3</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span clas=
s=3D"HOEnZb"><font color=3D"#888888">
<br>
</font></span></blockquote></div><br></div></div>

--00000000000087cd8f0569c6343c--
