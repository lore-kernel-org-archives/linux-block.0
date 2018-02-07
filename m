Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 12:07:24 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180207200724.GD695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518024428.2870.35.camel@wdc.com>
 <20180207173531.GC695913@devbig577.frc2.facebook.com>
 <1518027251.2870.53.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518027251.2870.53.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Wed, Feb 07, 2018 at 06:14:13PM +0000, Bart Van Assche wrote:
> When I wrote my comment I was not sure whether or not non-reentrancy is
> guaranteed for work queue items. However, according to what I found in the
> workqueue implementation I think that is guaranteed. So it shouldn't be
> possible that the timer activated by blk_add_timer() gets handled before
> aborted_gstate is reset. But since the timeout handler and completion

Yeah, we're basically single threaded in the timeout path.

> handlers can be executed by different CPUs, shouldn't a memory barrier be
> inserted between the blk_add_timer() call and resetting aborted_gsync to
> guarantee that a completion cannot occur before blk_add_timer() has reset
> RQF_MQ_TIMEOUT_EXPIRED?

Ah, you're right.  u64_stat_sync doesn't imply barriers, so we want
something like the following.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..d6edf3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -593,7 +593,7 @@ static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 	 */
 	local_irq_save(flags);
 	u64_stats_update_begin(&rq->aborted_gstate_sync);
-	rq->aborted_gstate = gstate;
+	smp_store_release(&rq->aborted_gstate, gstate);
 	u64_stats_update_end(&rq->aborted_gstate_sync);
 	local_irq_restore(flags);
 }
@@ -605,7 +605,7 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 
 	do {
 		start = u64_stats_fetch_begin(&rq->aborted_gstate_sync);
-		aborted_gstate = rq->aborted_gstate;
+		aborted_gstate = smp_load_acquire(&rq->aborted_gstate);
 	} while (u64_stats_fetch_retry(&rq->aborted_gstate_sync, start));
 
 	return aborted_gstate;
@@ -836,8 +836,8 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		 * ->aborted_gstate is set, this may lead to ignored
 		 * completions and further spurious timeouts.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
 		blk_add_timer(req);
+		blk_mq_rq_update_aborted_gstate(req, 0);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
