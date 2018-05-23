Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <20180519074406.6045-1-ming.lei@redhat.com> <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
 <20180523093225.GA32067@ming.t460p> <20180523174823.GC12533@vader>
 <CACVXFVPm_ds=b9ZGwfdfnwErdAPEVfoct65neRXt5pV1E9fjew@mail.gmail.com> <48643bc2-cff9-717a-73b1-7ce068529a39@kernel.dk>
In-Reply-To: <48643bc2-cff9-717a-73b1-7ce068529a39@kernel.dk>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 24 May 2018 06:56:07 +0800
Message-ID: <CACVXFVPyfuE9fqVQKFgQJn03P63A5TYpYdKB9Zvm4yJtBD36xA@mail.gmail.com>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@osandov.com>, Ming Lei <ming.lei@redhat.com>,
	linux-block <linux-block@vger.kernel.org>, Omar Sandoval <osandov@fb.com>
Content-Type: multipart/alternative; boundary="0000000000009781c2056ce77142"
List-ID: <linux-block@vger.kernel.org>

--0000000000009781c2056ce77142
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk> =E4=BA=8E 2018=E5=B9=B45=E6=9C=8824=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:19=E5=86=99=E9=81=93=EF=BC=9A

> On 5/23/18 4:09 PM, Ming Lei wrote:
> > On Thu, May 24, 2018 at 1:48 AM, Omar Sandoval <osandov@osandov.com>
> wrote:
> >> On Wed, May 23, 2018 at 05:32:31PM +0800, Ming Lei wrote:
> >>> On Tue, May 22, 2018 at 09:59:17PM -0600, Jens Axboe wrote:
> >>>> On 5/19/18 1:44 AM, Ming Lei wrote:
> >>>>> When the allocation process is scheduled back and the mapped hw
> queue is
> >>>>> changed, do one extra wake up on orignal queue for compensating wak=
e
> up
> >>>>> miss, so other allocations on the orignal queue won't be starved.
> >>>>>
> >>>>> This patch fixes one request allocation hang issue, which can be
> >>>>> triggered easily in case of very low nr_request.
> >>>>
> >>>> Trying to think of better ways we can fix this, but I don't see
> >>>> any right now. Getting rid of the wake_up_nr() kills us on tons
> >>>> of tasks waiting.
> >>>
> >>> I am not sure if I understand your point, but this issue isn't relate=
d
> >>> with wake_up_nr() actually, and it can be reproduced after reverting
> >>> 4e5dff41be7b5201c1c47c (blk-mq: improve heavily contended tag case).
> >>>
> >>> All tasks in current sbq_wait_state may be scheduled to other CPUs, a=
nd
> >>> there may still be tasks waiting for allocation from this
> sbitmap_queue,
> >>> and the root cause is about cross-queue allocation, as you said,
> >>> there are too many queues, :-)
> >>
> >> I don't follow. Your description of the problem was that we have two
> >> waiters and only wake up one, which doesn't in turn allocate and free =
a
> >> tag and wake up the second waiter. Changing it back to wake_up_nr()
> >> eliminates that problem. And if waking up everything doesn't fix it, h=
ow
> >> does your fix of waking up a few extra tasks fix it?
> >
> > What matters is that this patch wakes up the previous sbq, let's see if
> > from another view:
> >
> > 1) still 2 hw queues, nr_requests are 2, and wake_batch is one
> >
> > 2) there are 3 waiters on hw queue 0
> >
> > 3) two in-flight requests in hw queue 0 are completed, and only two
> waiters
> > of 3 are waken up because of wake_batch, but both the two waiters can b=
e
> > scheduled to another CPU and cause to switch to hw queue 1
> >
> > 4) then the 3rd waiter will wait for ever, since no in-flight request
> > is in hw queue
> > 0 any more.
> >
> > 5) this patch fixes it by the fake wakeup when waiter is scheduled to
> another
> > hw queue
> >
> > The issue can be understood a bit easier if we just forget
> sbq_wait_state and
> > focus on sbq, :-)
>
> It makes sense to me, and also explains why wake_up() vs wake_up_nr()
> doesn't
> matter. Which is actually a relief. And the condition of moving AND havin=
g
> a waiter should be rare enough that it'll work out fine in practice, I
> don't
> see any performance implications from this. You're right that we already
> abort early if we don't have pending waiters, so it's all good.
>
> Can you respin with the comments from Omar and myself covered?
>

OK, will do it after returning from outside.


> --
> Jens Axboe
>
>

--0000000000009781c2056ce77142
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
Jens Axboe &lt;<a href=3D"mailto:axboe@kernel.dk">axboe@kernel.dk</a>&gt; =
=E4=BA=8E 2018=E5=B9=B45=E6=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=
=8D=886:19=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On 5/23/18 4:09 PM, Ming Lei wrote:<br>
&gt; On Thu, May 24, 2018 at 1:48 AM, Omar Sandoval &lt;<a href=3D"mailto:o=
sandov@osandov.com" target=3D"_blank" rel=3D"noreferrer">osandov@osandov.co=
m</a>&gt; wrote:<br>
&gt;&gt; On Wed, May 23, 2018 at 05:32:31PM +0800, Ming Lei wrote:<br>
&gt;&gt;&gt; On Tue, May 22, 2018 at 09:59:17PM -0600, Jens Axboe wrote:<br=
>
&gt;&gt;&gt;&gt; On 5/19/18 1:44 AM, Ming Lei wrote:<br>
&gt;&gt;&gt;&gt;&gt; When the allocation process is scheduled back and the =
mapped hw queue is<br>
&gt;&gt;&gt;&gt;&gt; changed, do one extra wake up on orignal queue for com=
pensating wake up<br>
&gt;&gt;&gt;&gt;&gt; miss, so other allocations on the orignal queue won&#3=
9;t be starved.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This patch fixes one request allocation hang issue, wh=
ich can be<br>
&gt;&gt;&gt;&gt;&gt; triggered easily in case of very low nr_request.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Trying to think of better ways we can fix this, but I don&=
#39;t see<br>
&gt;&gt;&gt;&gt; any right now. Getting rid of the wake_up_nr() kills us on=
 tons<br>
&gt;&gt;&gt;&gt; of tasks waiting.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am not sure if I understand your point, but this issue isn&#=
39;t related<br>
&gt;&gt;&gt; with wake_up_nr() actually, and it can be reproduced after rev=
erting<br>
&gt;&gt;&gt; 4e5dff41be7b5201c1c47c (blk-mq: improve heavily contended tag =
case).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; All tasks in current sbq_wait_state may be scheduled to other =
CPUs, and<br>
&gt;&gt;&gt; there may still be tasks waiting for allocation from this sbit=
map_queue,<br>
&gt;&gt;&gt; and the root cause is about cross-queue allocation, as you sai=
d,<br>
&gt;&gt;&gt; there are too many queues, :-)<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t follow. Your description of the problem was that we ha=
ve two<br>
&gt;&gt; waiters and only wake up one, which doesn&#39;t in turn allocate a=
nd free a<br>
&gt;&gt; tag and wake up the second waiter. Changing it back to wake_up_nr(=
)<br>
&gt;&gt; eliminates that problem. And if waking up everything doesn&#39;t f=
ix it, how<br>
&gt;&gt; does your fix of waking up a few extra tasks fix it?<br>
&gt; <br>
&gt; What matters is that this patch wakes up the previous sbq, let&#39;s s=
ee if<br>
&gt; from another view:<br>
&gt; <br>
&gt; 1) still 2 hw queues, nr_requests are 2, and wake_batch is one<br>
&gt; <br>
&gt; 2) there are 3 waiters on hw queue 0<br>
&gt; <br>
&gt; 3) two in-flight requests in hw queue 0 are completed, and only two wa=
iters<br>
&gt; of 3 are waken up because of wake_batch, but both the two waiters can =
be<br>
&gt; scheduled to another CPU and cause to switch to hw queue 1<br>
&gt; <br>
&gt; 4) then the 3rd waiter will wait for ever, since no in-flight request<=
br>
&gt; is in hw queue<br>
&gt; 0 any more.<br>
&gt; <br>
&gt; 5) this patch fixes it by the fake wakeup when waiter is scheduled to =
another<br>
&gt; hw queue<br>
&gt; <br>
&gt; The issue can be understood a bit easier if we just forget sbq_wait_st=
ate and<br>
&gt; focus on sbq, :-)<br>
<br>
It makes sense to me, and also explains why wake_up() vs wake_up_nr() doesn=
&#39;t<br>
matter. Which is actually a relief. And the condition of moving AND having<=
br>
a waiter should be rare enough that it&#39;ll work out fine in practice, I =
don&#39;t<br>
see any performance implications from this. You&#39;re right that we alread=
y<br>
abort early if we don&#39;t have pending waiters, so it&#39;s all good.<br>
<br>
Can you respin with the comments from Omar and myself covered?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">OK, will do i=
t after returning from outside.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- <br>
Jens Axboe<br>
<br>
</blockquote></div></div></div>

--0000000000009781c2056ce77142--
