Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170828090620.GA4529@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de>
 <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me> <20170828090620.GA4529@lst.de>
From: Tony Yang <yyt168@gmail.com>
Date: Thu, 7 Sep 2017 23:17:22 +0800
Message-ID: <CADL4p-rkUeLjFemUL=rtvhYn=8q+cJ5Ef390Rm43jp_Q2BZ7gg@mail.gmail.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Content-Type: multipart/alternative; boundary="001a113f9c280bd7e105589af5a2"
List-ID: <linux-block@vger.kernel.org>

--001a113f9c280bd7e105589af5a2
Content-Type: text/plain; charset="UTF-8"

Hi, Where can I download this patch? Thanks

2017-08-28 17:06 GMT+08:00 Christoph Hellwig <hch@lst.de>:

> On Mon, Aug 28, 2017 at 10:23:33AM +0300, Sagi Grimberg wrote:
> > This is really taking a lot into the nvme driver.
>
> This patch adds about 100 lines of code, out of which 1/4th is the
> parsing of status codes.  I don't think it's all that much..
>
> > I'm not sure if
> > this approach will be used in other block driver, but would it
> > make sense to place the block_device node creation,
>
> I really want to reduce the amount of boilerplate code for creating
> a block queue and I have some ideas for that.  But that's not in
> any way related to this multi-path code.
>
> > the make_request
>
> That basically just does a lookup (in a data structure we need for
> tracking the siblings inside nvme anyway) and the submits the
> I/O again.  The generic code all is in generic_make_request_fast.
> There are two more things which could move into common code, one
> reasonable, the other not:
>
>  (1) the whole requeue_list list logic.  I thought about moving this
>      to the block layer as I'd also have some other use cases for it,
>      but decided to wait until those materialize to see if I'd really
>      need it.
>  (2) turning the logic inside out, e.g. providing a generic make_request
>      and supplying a find_path callback to it.  This would require (1)
>      but even then we'd save basically no code, add an indirect call
>      in the fast path and make things harder to read.  This actually
>      is how I started out and didn't like it.
>
> > and failover logic
>
> The big thing about the failover logic is looking a the detailed error
> codes and changing the controller state, all of which is fundamentally
> driver specific.  The only thing that could reasonably be common is
> the requeue_list handling as mentioned above.  Note that this will
> become even more integrated with the nvme driver once ANA support
> lands.
>
> > and maybe the path selection in the block layer
> > leaving just the construction of the path mappings in nvme?
>
> The point is that path selection fundamentally depends on your
> actual protocol.  E.g. for NVMe we now look at the controller state
> as that's what our keep alive work on, and what reflects that status
> in PCIe. We could try to communicate this up, but it would just lead
> to more data structure that get out of sync.  And this will become
> much worse with ANA where we have even more fine grained state.
> In the end path selection right now is less than 20 lines of code.
>
> Path selection is complicated when you want non-trivial path selector
> algorithms like round robin or service time, but I'd really avoid having
> those on nvme - we already have multiple queues to go beyong the limits
> of a single queue and use blk-mq for that, and once we're beyond the
> limits of a single transport path for performance reasons I'd much
> rather rely on ANA, numa nodes or static partitioning of namepsaces
> than trying to do dynamic decicions in the fast path.  But if I don't
> get what I want there and we'll need more complicated algorithms they
> absolutely should be in common code.  In fact one of my earlier protoypes
> moved the dm-mpath path selector algorithms to core block code and
> tried to use them - it just turned out enabling them was pretty much
> pointless.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

--001a113f9c280bd7e105589af5a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:14px">Hi,=C2=A0Where can I downlo=
ad this patch? Thanks</span><br></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">2017-08-28 17:06 GMT+08:00 Christoph Hellwig <span dir=
=3D"ltr">&lt;<a href=3D"mailto:hch@lst.de" target=3D"_blank">hch@lst.de</a>=
&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, Aug=
 28, 2017 at 10:23:33AM +0300, Sagi Grimberg wrote:<br>
&gt; This is really taking a lot into the nvme driver.<br>
<br>
</span>This patch adds about 100 lines of code, out of which 1/4th is the<b=
r>
parsing of status codes.=C2=A0 I don&#39;t think it&#39;s all that much..<b=
r>
<span class=3D""><br>
&gt; I&#39;m not sure if<br>
&gt; this approach will be used in other block driver, but would it<br>
&gt; make sense to place the block_device node creation,<br>
<br>
</span>I really want to reduce the amount of boilerplate code for creating<=
br>
a block queue and I have some ideas for that.=C2=A0 But that&#39;s not in<b=
r>
any way related to this multi-path code.<br>
<br>
&gt; the make_request<br>
<br>
That basically just does a lookup (in a data structure we need for<br>
tracking the siblings inside nvme anyway) and the submits the<br>
I/O again.=C2=A0 The generic code all is in generic_make_request_fast.<br>
There are two more things which could move into common code, one<br>
reasonable, the other not:<br>
<br>
=C2=A0(1) the whole requeue_list list logic.=C2=A0 I thought about moving t=
his<br>
=C2=A0 =C2=A0 =C2=A0to the block layer as I&#39;d also have some other use =
cases for it,<br>
=C2=A0 =C2=A0 =C2=A0but decided to wait until those materialize to see if I=
&#39;d really<br>
=C2=A0 =C2=A0 =C2=A0need it.<br>
=C2=A0(2) turning the logic inside out, e.g. providing a generic make_reque=
st<br>
=C2=A0 =C2=A0 =C2=A0and supplying a find_path callback to it.=C2=A0 This wo=
uld require (1)<br>
=C2=A0 =C2=A0 =C2=A0but even then we&#39;d save basically no code, add an i=
ndirect call<br>
=C2=A0 =C2=A0 =C2=A0in the fast path and make things harder to read.=C2=A0 =
This actually<br>
=C2=A0 =C2=A0 =C2=A0is how I started out and didn&#39;t like it.<br>
<br>
&gt; and failover logic<br>
<br>
The big thing about the failover logic is looking a the detailed error<br>
codes and changing the controller state, all of which is fundamentally<br>
driver specific.=C2=A0 The only thing that could reasonably be common is<br=
>
the requeue_list handling as mentioned above.=C2=A0 Note that this will<br>
become even more integrated with the nvme driver once ANA support<br>
lands.<br>
<span class=3D""><br>
&gt; and maybe the path selection in the block layer<br>
&gt; leaving just the construction of the path mappings in nvme?<br>
<br>
</span>The point is that path selection fundamentally depends on your<br>
actual protocol.=C2=A0 E.g. for NVMe we now look at the controller state<br=
>
as that&#39;s what our keep alive work on, and what reflects that status<br=
>
in PCIe. We could try to communicate this up, but it would just lead<br>
to more data structure that get out of sync.=C2=A0 And this will become<br>
much worse with ANA where we have even more fine grained state.<br>
In the end path selection right now is less than 20 lines of code.<br>
<br>
Path selection is complicated when you want non-trivial path selector<br>
algorithms like round robin or service time, but I&#39;d really avoid havin=
g<br>
those on nvme - we already have multiple queues to go beyong the limits<br>
of a single queue and use blk-mq for that, and once we&#39;re beyond the<br=
>
limits of a single transport path for performance reasons I&#39;d much<br>
rather rely on ANA, numa nodes or static partitioning of namepsaces<br>
than trying to do dynamic decicions in the fast path.=C2=A0 But if I don&#3=
9;t<br>
get what I want there and we&#39;ll need more complicated algorithms they<b=
r>
absolutely should be in common code.=C2=A0 In fact one of my earlier protoy=
pes<br>
moved the dm-mpath path selector algorithms to core block code and<br>
tried to use them - it just turned out enabling them was pretty much<br>
pointless.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
______________________________<wbr>_________________<br>
Linux-nvme mailing list<br>
<a href=3D"mailto:Linux-nvme@lists.infradead.org">Linux-nvme@lists.infradea=
d.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-nvme" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mailman/listin=
fo/linux-nvme</a><br>
</div></div></blockquote></div><br></div>

--001a113f9c280bd7e105589af5a2--
