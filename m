Return-Path: <fangguoju@gmail.com>
MIME-Version: 1.0
References: <20180927154146.28262-1-colyli@suse.de> <20180927154146.28262-2-colyli@suse.de>
 <970bb505-ef6e-7057-5e0f-21d9439b4031@kernel.dk> <CAB1iPWn1kYVDMdSFJC6BgzKRP781ijzW5c-m93LsQuzQofeOTQ@mail.gmail.com>
 <20fee655-d18d-c931-a910-f8965bda71e0@kernel.dk>
In-Reply-To: <20fee655-d18d-c931-a910-f8965bda71e0@kernel.dk>
From: Guoju Fang <fangguoju@gmail.com>
Date: Fri, 28 Sep 2018 00:23:05 +0800
Message-ID: <CAB1iPW=Aj52MSOAj6zsgHzEQatD+VAE1TfDQ_90+c8W8P9xYTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] bcache: add separate workqueue for journal_write to
 avoid deadlock
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000a63f560576dcc135"
List-ID: <linux-block@vger.kernel.org>

--000000000000a63f560576dcc135
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will do, thanks!

Jens Axboe <axboe@kernel.dk>=E4=BA=8E2018=E5=B9=B49=E6=9C=8828=E6=97=A5 =E5=
=91=A8=E4=BA=9400:06=E5=86=99=E9=81=93=EF=BC=9A

> On 9/27/18 9:57 AM, =E5=9B=BD=E7=82=AC=E6=96=B9 wrote:
> > Yes, Guoju Fang. Thx. :)
>
> OK, I made that change and committed it. Just be sure to use your full
> name in the future for signoffs, etc.
>
> --
> Jens Axboe
>
>

--000000000000a63f560576dcc135
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Will do, thanks!</div><div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr">Jens Axboe &lt;<a href=3D"mailto:axboe@kernel.dk">axboe@kernel.dk</a>&=
gt;=E4=BA=8E2018=E5=B9=B49=E6=9C=8828=E6=97=A5 =E5=91=A8=E4=BA=9400:06=E5=
=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/27/=
18 9:57 AM, =E5=9B=BD=E7=82=AC=E6=96=B9 wrote:<br>
&gt; Yes, Guoju Fang. Thx. :)<br>
<br>
OK, I made that change and committed it. Just be sure to use your full<br>
name in the future for signoffs, etc.<br>
<br>
-- <br>
Jens Axboe<br>
<br>
</blockquote></div></div>

--000000000000a63f560576dcc135--
