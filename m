Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-5-hare@suse.de>
 <CADvA-d=ESWUgJNpsSxdOhLp1amt3B9Aqy+GZ-i=t5zkLVn6RWg@mail.gmail.com> <03060ac8-57ce-9b11-cc7a-287264ac87b5@suse.de>
In-Reply-To: <03060ac8-57ce-9b11-cc7a-287264ac87b5@suse.de>
From: Ed Cashin <ecashin@noserose.net>
Date: Thu, 2 Aug 2018 07:55:46 -0400
Message-ID: <CADvA-d=uYqT55bhM5s8oVmuG3zY7+6sRbabhk7Q-PO2-wbbmDw@mail.gmail.com>
Subject: Re: [PATCH 4/6] aoe: use device_add_disk_with_groups()
To: hare@suse.de
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, hare@suse.com
Content-Type: multipart/alternative; boundary="00000000000066052a0572727e5d"
List-ID: <linux-block@vger.kernel.org>

--00000000000066052a0572727e5d
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 1, 2018 at 2:57 AM Hannes Reinecke <hare@suse.de> wrote:

> On 08/01/2018 03:00 AM, Ed Cashin wrote:
> > On Mon, Jul 30, 2018 at 3:12 AM Hannes Reinecke <hare@suse.de
> > <mailto:hare@suse.de>> wrote:
> >
> >     Use device_add_disk_with_groups() to avoid a race condition with
> >     udev during startup.
> >
> >
> > I love the idea of getting rid of the race, but I am having trouble
> > seeing what happened to the cleanup we had via sysfs_remove_group.
> > You're storing a pointer to groups off the device, but I don't see it
> > getting
> > used for cleanup later in this patch set.  Are you patching linux-next?
> >
> And that's the beauty of this patch: you don't need to free/unlink the
> groups yourself.
> Unlinking is done in the driver core via
> device_del()->device_remove_attrs()->device_remove_groups().
>
> So no separate patch needed.
>

OK, thanks for the clarification.

-- 
  Ed Cashin <ecashin@noserose.net>

--00000000000066052a0572727e5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 1,=
 2018 at 2:57 AM Hannes Reinecke &lt;<a href=3D"mailto:hare@suse.de">hare@s=
use.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 08/01/2018=
 03:00 AM, Ed Cashin wrote:<br>
&gt; On Mon, Jul 30, 2018 at 3:12 AM Hannes Reinecke &lt;<a href=3D"mailto:=
hare@suse.de" target=3D"_blank">hare@suse.de</a><br>
&gt; &lt;mailto:<a href=3D"mailto:hare@suse.de" target=3D"_blank">hare@suse=
.de</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use device_add_disk_with_groups() to avoid a race c=
ondition with<br>
&gt;=C2=A0 =C2=A0 =C2=A0udev during startup.<br>
&gt; <br>
&gt; <br>
&gt; I love the idea of getting rid of the race, but I am having trouble<br=
>
&gt; seeing what happened to the cleanup we had via sysfs_remove_group.<br>
&gt; You&#39;re storing a pointer to groups off the device, but I don&#39;t=
 see it<br>
&gt; getting<br>
&gt; used for cleanup later in this patch set.=C2=A0 Are you patching linux=
-next?<br>
&gt; <br>
And that&#39;s the beauty of this patch: you don&#39;t need to free/unlink =
the<br>
groups yourself.<br>
Unlinking is done in the driver core via<br>
device_del()-&gt;device_remove_attrs()-&gt;device_remove_groups().<br>
<br>
So no separate patch needed.<br></blockquote></div><div><br></div><div>OK, =
thanks for the clarification.</div><div><br></div>-- <br><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
">=C2=A0 Ed Cashin &lt;<a href=3D"mailto:ecashin@noserose.net" target=3D"_b=
lank">ecashin@noserose.net</a>&gt;</div></div></div>

--00000000000066052a0572727e5d--
