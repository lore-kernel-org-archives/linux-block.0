Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>, Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and BLK_EH_RESET_TIMER
Date: Mon, 16 Apr 2018 15:12:30 +0200
Message-ID: <4122070.FIbsgdqFrb@merkaba>
In-Reply-To: <20180416004508.GA20345@ming.t460p>
References: <20180415154357.19788-1-ming.lei@redhat.com> <4563853.Bq5iVV2DL3@merkaba> <20180416004508.GA20345@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Ming Lei - 16.04.18, 02:45:
> On Sun, Apr 15, 2018 at 06:31:44PM +0200, Martin Steigerwald wrote:
> > Hi Ming.
> >=20
> > Ming Lei - 15.04.18, 17:43:
> > > Hi Jens,
> > >=20
> > > This two patches fixes the recently discussed race between
> > > completion
> > > and BLK_EH_RESET_TIMER.
> > >=20
> > > Israel & Martin, this one is a simpler fix on this issue and can
> > > cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request,
> > > could
> > > you test V4 and see if your issue can be fixed?
> >=20
> > In replacement of all the three other patches I applied?
> >=20
> > - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a
> > request.mbox'
> >=20
> > - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair
> > into rcu_read_{lock,unlock}().mbox'
> >=20
> > - '[PATCH v4] blk-mq_Fix race conditions in request timeout
> > handling.mbox'
>=20
> You only need to replace the above one '[PATCH v4] blk-mq_Fix race
> conditions in request timeout' with V4 in this thread.

Ming, a 4.16.2 with the patches:

'[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a=20
request.mbox'
'[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into=20
rcu_read_{lock,unlock}().mbox'
'[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s=20
timeout isn'\''t handled.mbox'
'[PATCH V4 2_2] blk-mq_fix race between complete and=20
BLK_EH_RESET_TIMER.mbox'

hung on boot 3 out of 4 times.

See

[Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime=20
and boot failures with blk_mq_terminate_expired in backtrace
https://bugzilla.kernel.org/show_bug.cgi?id=3D199077#c13

I tried to add your mail address to Cc of the bug report, but Bugzilla=20
did not know it.

=46ortunately it booted on the fourth attempt, cause I forgot my GRUB=20
password.

Reverting back to previous 4.16.1 kernel with patches from Bart.

> > These patches worked reliably so far both for the hang on boot and
> > error reading SMART data.
>=20
> And you may see the reason in the following thread:
>=20
> https://marc.info/?l=3Dlinux-block&m=3D152366441625786&w=3D2

So requests could never be completed?

> > I=B4d compile a kernel tomorrow or Tuesday I think.

Thanks,
=2D-=20
Martin
