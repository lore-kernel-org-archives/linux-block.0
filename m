Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Feb 2018 13:20:44 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180213212044.GS695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518024428.2870.35.camel@wdc.com>
 <20180207173531.GC695913@devbig577.frc2.facebook.com>
 <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518107501.3611.19.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

Sorry about the delay.

On Thu, Feb 08, 2018 at 04:31:43PM +0000, Bart Van Assche wrote:
> The crash is reported at address scsi_times_out+0x17 == scsi_times_out+23. The
> instruction at that address tries to dereference scsi_cmnd.device (%rax). The
> register dump shows that that pointer has the value NULL. The only function I
> know of that clears the scsi_cmnd.device pointer is scsi_req_init(). The only
> caller of that function in the SCSI core is scsi_initialize_rq(). That function
> has two callers, namely scsi_init_command() and blk_get_request(). However,
> the scsi_cmnd.device pointer is not cleared when a request finishes. This is
> why I think that the above crash report indicates that scsi_times_out() was
> called for a request that was being reinitialized and not by device hotplugging.

Can you please give the following patch a shot?  While timeout path is
synchornizing against the completion path (and the following re-init)
while taking back control of a timed-out request, it wasn't doing that
while giving it back, so the timer registration could race against
completion and re-issue.  I'm still not quite sure how that can lead
to the oops tho.  Anyways, we need something like this one way or the
other.

This isn't the final patch.  We should add batching-up of rcu
synchronize calls similar to the abort path.

Thanks.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..b66aec3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -816,7 +816,8 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct blk_mq_hw_ctx *hctx, struct request *req,
+				bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
@@ -836,8 +837,12 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		 * ->aborted_gstate is set, this may lead to ignored
 		 * completions and further spurious timeouts.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
 		blk_add_timer(req);
+		if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+			synchronize_rcu();
+		else
+			synchronize_srcu(hctx->srcu);
+		blk_mq_rq_update_aborted_gstate(req, 0);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -893,7 +898,7 @@ static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
 	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
-		blk_mq_rq_timed_out(rq, reserved);
+		blk_mq_rq_timed_out(hctx, rq, reserved);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
