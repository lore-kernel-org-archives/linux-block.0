Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-4-hare@suse.de>
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
From: Ed Cashin <ed.cashin@acm.org>
Date: Tue, 14 Aug 2018 07:49:07 -0400
Message-ID: <CADvA-dne2YvhrOS-6YPsgeQgr43ps8KWDWEZ6c9a-GxQBs1AHw@mail.gmail.com>
Subject: Re: [PATCH 3/5] aoe: use device_add_disk_with_groups()
To: hare@suse.de
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
	bart.vanassche@wdc.com, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hare@suse.com,
	"Ed L. Cashin" <ed.cashin@acm.org>
Content-Type: multipart/alternative; boundary="000000000000cb1166057363ccc4"
List-ID: <linux-block@vger.kernel.org>

--000000000000cb1166057363ccc4
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 14, 2018 at 3:33 AM Hannes Reinecke <hare@suse.de> wrote:

> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.
>

I think the aoe part of the series hasn't changed much, so OK, thanks.

-- 
  Ed

--000000000000cb1166057363ccc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Aug 14=
, 2018 at 3:33 AM Hannes Reinecke &lt;<a href=3D"mailto:hare@suse.de">hare@=
suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Use device_a=
dd_disk_with_groups() to avoid a race condition with<br>
udev during startup.<br>
</blockquote><div><br></div><div>I think the aoe part of the series hasn&#3=
9;t changed much, so OK, thanks.</div><div><br></div><div>--=C2=A0</div><di=
v>=C2=A0 Ed=C2=A0</div></div></div>

--000000000000cb1166057363ccc4--
