Return-Path: <gwendal@chromium.org>
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
 <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
In-Reply-To: <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Thu, 1 Nov 2018 15:41:10 -0700
Message-ID: <CAPUE2usCoYN7udO8eH7TWE2KGXoJF4O2ZV=wokL7=yC6RwQf8g@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To: evgreen@chromium.org
Cc: bvanassche@acm.org, axboe@kernel.dk, asavery@chromium.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000026086d0579a21ee2"
List-ID: <linux-block@vger.kernel.org>

--00000000000026086d0579a21ee2
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 1, 2018 at 11:15 AM Evan Green <evgreen@chromium.org> wrote:

> On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org>
> wrote:
> >
> > On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > > This series addresses some errors seen when using the loop
> > > device directly backed by a block device. The first change plumbs
> > > out the correct error message, and the second change prevents the
> > > error from occurring in many cases.
> >
> > Hi Evan,
> >
> > Can you provide some information about the use case? Why do you think
> that
> > it would be useful to support backing a loop device by a block device?
> Why
> > to use the loop driver instead of dm-linear for this use case?
> >
>
> Hi Bart,
> In our case, the Chrome OS installer uses the loop device to map
> slices of the disk that will ultimately represent partitions [1]. I
> believe it has been doing install this way for a very long time, and
> has been working well. It actually continues to work, but on block
> devices that don't support discard operations, things are a tiny bit
> bumpy. This series is meant to smooth out those bumps. As far as I
> knew this was a supported scenario.
>
> -Evan
> [1]
> https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install



The code has moved to
https://chromium.googlesource.com/chromiumos/platform2/+/master/installer/chromeos-install
but the idea is the same. We create a loop device to abstract the
persistent destination. The destination can be a block device or a file.
The later case is used for creating master images to be flashed on memory
chip before soldering on the production line.
It is handy when the final device is 4K block aligned but the builder is
using 512b block aligned device, we can mount a device over a file that
will behave like the real device we will flash the image on.

Gwendal.

--00000000000026086d0579a21ee2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Thu, Nov 1, 2018 at 11:15 AM Evan Green &lt;<a href=3D"mailto=
:evgreen@chromium.org">evgreen@chromium.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Tue, Oct 30, 2018 at 4:50 PM =
Bart Van Assche &lt;<a href=3D"mailto:bvanassche@acm.org" target=3D"_blank"=
>bvanassche@acm.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:<br>
&gt; &gt; This series addresses some errors seen when using the loop<br>
&gt; &gt; device directly backed by a block device. The first change plumbs=
<br>
&gt; &gt; out the correct error message, and the second change prevents the=
<br>
&gt; &gt; error from occurring in many cases.<br>
&gt;<br>
&gt; Hi Evan,<br>
&gt;<br>
&gt; Can you provide some information about the use case? Why do you think =
that<br>
&gt; it would be useful to support backing a loop device by a block device?=
 Why<br>
&gt; to use the loop driver instead of dm-linear for this use case?<br>
&gt;<br>
<br>
Hi Bart,<br>
In our case, the Chrome OS installer uses the loop device to map<br>
slices of the disk that will ultimately represent partitions [1]. I<br>
believe it has been doing install this way for a very long time, and<br>
has been working well. It actually continues to work, but on block<br>
devices that don&#39;t support discard operations, things are a tiny bit<br=
>
bumpy. This series is meant to smooth out those bumps. As far as I<br>
knew this was a supported scenario.<br>
<br>
-Evan<br>
[1] <a href=3D"https://chromium.googlesource.com/chromiumos/platform/instal=
ler/+/master/chromeos-install" rel=3D"noreferrer" target=3D"_blank">https:/=
/chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-=
install</a></blockquote><div><br></div><div><br></div><div>The code has mov=
ed to=C2=A0<a href=3D"https://chromium.googlesource.com/chromiumos/platform=
2/+/master/installer/chromeos-install">https://chromium.googlesource.com/ch=
romiumos/platform2/+/master/installer/chromeos-install</a></div><div>but th=
e idea is the same. We create a loop device to abstract the persistent dest=
ination. The destination can be a block device or a file. The later case is=
 used for creating master images to be flashed on memory chip before solder=
ing on the production line.</div><div>It is handy when the final device is =
4K block aligned but the builder is using 512b block aligned device, we can=
 mount a device over a file that will behave like the real device we will f=
lash the image on.</div><div><br></div><div>Gwendal.</div><div><br></div><d=
iv><br></div></div></div></div>

--00000000000026086d0579a21ee2--
