Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20180801223020.GA11729@embeddedor.com>
In-Reply-To: <20180801223020.GA11729@embeddedor.com>
From: Ed Cashin <ecashin@noserose.net>
Date: Thu, 2 Aug 2018 20:26:29 -0400
Message-ID: <CADvA-d=RvV+uUs33FwO4-n+gQo=RxAvHJCGJZ_eNmDjscGmc9w@mail.gmail.com>
Subject: Re: [PATCH] aoe: mark expected switch fall-through
To: gustavo@embeddedor.com
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000004babbe05727cfbec"
List-ID: <linux-block@vger.kernel.org>

--0000000000004babbe05727cfbec
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 1, 2018 at 6:30 PM Gustavo A. R. Silva <gustavo@embeddedor.com>
wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.


OK, thanks.


>
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index 096882e..136dc50 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -1137,6 +1137,7 @@ noskb:            if (buf)
>                         break;
>                 }
>                 bvcpy(skb, f->buf->bio, f->iter, n);
> +               /* fall through */
>         case ATA_CMD_PIO_WRITE:
>         case ATA_CMD_PIO_WRITE_EXT:
>                 spin_lock_irq(&d->lock);
> --
> 2.7.4
>
>

-- 
  Ed Cashin <ecashin@noserose.net>

--0000000000004babbe05727cfbec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 1,=
 2018 at 6:30 PM Gustavo A. R. Silva &lt;<a href=3D"mailto:gustavo@embedded=
or.com">gustavo@embeddedor.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">In preparation to enabling -Wimplicit-fallthrough, mark switch c=
ases<br>
where we are expecting to fall through.</blockquote><div><br></div><div>OK,=
 thanks.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c<br>
index 096882e..136dc50 100644<br>
--- a/drivers/block/aoe/aoecmd.c<br>
+++ b/drivers/block/aoe/aoecmd.c<br>
@@ -1137,6 +1137,7 @@ noskb:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (b=
uf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bvcpy(skb, f-&gt;bu=
f-&gt;bio, f-&gt;iter, n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ATA_CMD_PIO_WRITE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case ATA_CMD_PIO_WRITE_EXT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&amp;=
d-&gt;lock);<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr">=C2=A0 Ed Cashin &lt;<a href=3D"mailto:ecashin@noserose.net" target=3D"=
_blank">ecashin@noserose.net</a>&gt;</div></div></div>

--0000000000004babbe05727cfbec--
