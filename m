Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>, Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and BLK_EH_RESET_TIMER
Date: Sun, 15 Apr 2018 18:31:44 +0200
Message-ID: <4563853.Bq5iVV2DL3@merkaba>
In-Reply-To: <20180415154357.19788-1-ming.lei@redhat.com>
References: <20180415154357.19788-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Hi Ming.

Ming Lei - 15.04.18, 17:43:
> Hi Jens,
>=20
> This two patches fixes the recently discussed race between completion
> and BLK_EH_RESET_TIMER.
>=20
> Israel & Martin, this one is a simpler fix on this issue and can
> cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request, could
> you test V4 and see if your issue can be fixed?

In replacement of all the three other patches I applied?

=2D '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a=20
request.mbox'

=2D '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into=20
rcu_read_{lock,unlock}().mbox'

=2D '[PATCH v4] blk-mq_Fix race conditions in request timeout=20
handling.mbox'

These patches worked reliably so far both for the hang on boot and error=20
reading SMART data.

I=B4d compile a kernel tomorrow or Tuesday I think.

> V4:
> 	- run synchronize_rcu() once for handling all timed out request
> 	between .timeout() and the following handling
> 	- address tj's concern about reorder between blk_add_timer() and
>     blk_mq_rq_update_aborted_gstate(req, 0)
>=20
> V3:
> 	- before completing rq for BLK_EH_HANDLED, sync with normal
> completion path - make sure rq's state updated as MQ_RQ_IN_FLIGHT
> before completing V2:
> 	- rename the new flag as MQ_RQ_COMPLETE_IN_TIMEOUT
> 	- fix lock uses in blk_mq_rq_timed_out
> 	- document re-order between blk_add_timer() and
> 	blk_mq_rq_update_aborted_gstate(req, 0)
>=20
>=20
> Ming Lei (2):
>   blk-mq: set RQF_MQ_TIMEOUT_EXPIRED when the rq's timeout isn't
> handled blk-mq: fix race between complete and BLK_EH_RESET_TIMER
>=20
>  block/blk-mq.c         | 120
> +++++++++++++++++++++++++++++++++++++++---------- block/blk-mq.h    =20
>    |   1 +
>  block/blk-timeout.c    |   1 -
>  include/linux/blkdev.h |   6 +++
>  4 files changed, 104 insertions(+), 24 deletions(-)


=2D-=20
Martin
