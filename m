Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "maxg@mellanox.com" <maxg@mellanox.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout handling
Date: Wed, 11 Apr 2018 20:38:48 +0200
Message-ID: <11544331.gmjPRolTO7@merkaba>
In-Reply-To: <ac0d5904dbcd55e190df318a66a9d7d51c56f3ae.camel@wdc.com>
References: <20180410135541.GA22340@ming.t460p> <20180410215456.GD793541@devbig577.frc2.facebook.com> <ac0d5904dbcd55e190df318a66a9d7d51c56f3ae.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Bart Van Assche - 11.04.18, 14:50:
> On Tue, 2018-04-10 at 14:54 -0700, tj@kernel.org wrote:
> > Ah, yeah, I was moving it out of add_timer but forgot to actully add
> > it to the issue path.  Fixed patch below.
> >=20
> > BTW, no matter what we do w/ the request handover between normal and
> > timeout paths, we'd need something similar.  Otherwise, while we can
> > reduce the window, we can't get rid of it.
>=20
> (+Martin Steigerwald)
[=E2=80=A6]
> Thank you for having shared this patch. It looks interesting to me.
> What I know about the blk-mq timeout handling is as follows:
> * Nobody who has reviewed the blk-mq timeout handling code with this
> patch applied has reported any shortcomings for that code.
> * However, several people have reported kernel crashes that disappear
> when the blk-mq timeout code is reworked. I'm referring to "nvme-rdma
> corrupts memory upon timeout"
> =20
> (http://lists.infradead.org/pipermail/linux-nvme/2018-February/015848
> .html) and also to a "RIP: scsi_times_out+0x17" crash during boot
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D199077).

Yes, with the three patches:

=2D '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a=20
request.mbox'

=2D '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into=20
rcu_read_{lock,unlock}().mbox'

=2D '[PATCH v4] blk-mq_Fix race conditions in request timeout=20
handling.mbox'

the occasional hangs on some boots / resumes from hibernation appear to=20
be gone.

Also it appears that the error loading SMART data issue is gone as well=20
(see my bug report). However it is still to early to say for sure. I=20
think I need at least 2-3 days of additional testing with this kernel to=20
be sufficiently sure about it.

However=E2=80=A6 I could also test another patch, but from reading the rest=
 of=20
this thread so far I have no clear on whether to try one of the new=20
patches and if so which one and whether adding it on top of some of the=20
patches I already applied or using it as a replacement of it.

So while doing a training this and next week I can apply a patch here=20
and then, but I won=C2=B4t have much time to read the complete discussion t=
o=20
figure out what to apply.

Personally as a stable kernel has been released with those issues, I=20
think its good to fix it up soon. On the other hand it may take quite=20
some time til popular distros carry 4.16 for regular users. And I have=20
no idea how frequent the reported issues are, i.e. how many users would=20
be affected.

Thanks,
=2D-=20
Martin
