Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-5-hare@suse.de>
In-Reply-To: <20180730071227.22887-5-hare@suse.de>
From: Ed Cashin <ed.cashin@acm.org>
Date: Tue, 31 Jul 2018 21:00:28 -0400
Message-ID: <CADvA-d=ESWUgJNpsSxdOhLp1amt3B9Aqy+GZ-i=t5zkLVn6RWg@mail.gmail.com>
Subject: Re: [PATCH 4/6] aoe: use device_add_disk_with_groups()
To: hare@suse.de
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, hare@suse.com,
	"Ed L. Cashin" <ed.cashin@acm.org>
Content-Type: multipart/alternative; boundary="000000000000254c160572553947"
List-ID: <linux-block@vger.kernel.org>

--000000000000254c160572553947
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 30, 2018 at 3:12 AM Hannes Reinecke <hare@suse.de> wrote:

> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.
>

I love the idea of getting rid of the race, but I am having trouble
seeing what happened to the cleanup we had via sysfs_remove_group.
You're storing a pointer to groups off the device, but I don't see it
getting
used for cleanup later in this patch set.  Are you patching linux-next?

-- Ed

--000000000000254c160572553947
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Jul 30=
, 2018 at 3:12 AM Hannes Reinecke &lt;<a href=3D"mailto:hare@suse.de">hare@=
suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Use device_a=
dd_disk_with_groups() to avoid a race condition with<br>
udev during startup.<br></blockquote><div><br></div><div>I love the idea of=
 getting rid of the race, but I am having trouble</div><div>seeing what hap=
pened to the cleanup we had via sysfs_remove_group.</div><div>You&#39;re st=
oring a pointer to groups off the device, but I don&#39;t see it getting</d=
iv><div>used for cleanup later in this patch set.=C2=A0 Are you patching li=
nux-next?</div><div><br></div><div>-- Ed</div><div></div></div></div>

--000000000000254c160572553947--
