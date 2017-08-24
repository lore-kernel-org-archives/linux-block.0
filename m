Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
References: <20170818155439.GA30487@localhost.didichuxing.com> <a7a6100b-6741-8b4b-44e9-e2068e698419@kernel.dk>
In-Reply-To: <a7a6100b-6741-8b4b-44e9-e2068e698419@kernel.dk>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 24 Aug 2017 14:31:17 +0000
Message-ID: <CAA70yB6UM8XZqC=A_pygOoYQjp90K08uyHe3+Tm1HWnPwvq89A@mail.gmail.com>
Subject: Re: [PATCH] block: remove blk_free_devt in add_partition
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045c81f0195af3055780af8b"
List-ID: <linux-block@vger.kernel.org>

--f403045c81f0195af3055780af8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk>=E4=BA=8E2017=E5=B9=B48=E6=9C=8824=E6=97=A5 =E5=
=91=A8=E5=9B=9B22:27=E5=86=99=E9=81=93=EF=BC=9A

> On 08/18/2017 09:54 AM, weiping zhang wrote:
> > put_device(pdev) will call pdev->type->release finally, and blk_free_de=
vt
> > has been called in part_release(), so remove it.
>
> Your analysis looks correct to me, applied for 4.14.
>
> --
> Jens Axboe
>

>
Thanks a ton

--f403045c81f0195af3055780af8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div dir=3D"auto">Jens Axboe &lt;<a hre=
f=3D"mailto:axboe@kernel.dk">axboe@kernel.dk</a>&gt;=E4=BA=8E2017=E5=B9=B48=
=E6=9C=8824=E6=97=A5 =E5=91=A8=E5=9B=9B22:27=E5=86=99=E9=81=93=EF=BC=9A<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On 08/18/2017 09:54 AM, weiping zhang =
wrote:<br>
&gt; put_device(pdev) will call pdev-&gt;type-&gt;release finally, and blk_=
free_devt<br>
&gt; has been called in part_release(), so remove it.<br>
<br>
Your analysis looks correct to me, applied for 4.14.<br>
<br>
--<br>
Jens Axboe<br>
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Than=
ks a ton</div>

--f403045c81f0195af3055780af8b--
