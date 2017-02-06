Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34627 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdBFTyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 14:54:04 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so26239832pfg.1
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2017 11:54:03 -0800 (PST)
Date: Mon, 6 Feb 2017 11:53:30 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] blk-mq-sched: separate mark hctx and queue restart
 operations
Message-ID: <20170206195330.GB20714@vader>
References: <0ec9b1167d22966cdf77a1d5140499493ea888a2.1486408944.git.osandov@fb.com>
 <182de41f-33d3-bbf8-c591-9e577b0f1762@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <182de41f-33d3-bbf8-c591-9e577b0f1762@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 06, 2017 at 12:39:57PM -0700, Jens Axboe wrote:
> On 02/06/2017 12:24 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
> > after we dispatch requests left over on our hardware queue dispatch
> > list. This is so we'll go back and dispatch requests from the scheduler.
> > In this case, it's only necessary to restart the hardware queue that we
> > are running; there's no reason to run other hardware queues just because
> > we are using shared tags.
> > 
> > So, split out blk_mq_sched_mark_restart() into two operations, one for
> > just the hardware queue and one for the whole request queue. The core
> > code uses both, and I/O schedulers may also want to use them.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> > Patch based on block/for-next.
> > 
> >  block/blk-mq-sched.c |  2 +-
> >  block/blk-mq-sched.h | 25 ++++++++++++++++++-------
> >  block/blk-mq.c       |  5 ++++-
> >  3 files changed, 23 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index ee455e7cf9d8..7538565359ea 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -201,7 +201,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	 * needing a restart in that case.
> >  	 */
> >  	if (!list_empty(&rq_list)) {
> > -		blk_mq_sched_mark_restart(hctx);
> > +		blk_mq_sched_mark_restart_hctx(hctx);
> >  		blk_mq_dispatch_rq_list(hctx, &rq_list);
> 
> What if we dispatched nothing on this hardware queue, and it currently
> doesn't have any IO pending?

Hm, so there are two ways that could happen. If it's because
->queue_rq() returned BLK_MQ_RQ_QUEUE_BUSY, then the driver is supposed
to kick I/O off again, right?

If it's because we failed to get a driver tag, then we'll call
blk_mq_sched_mark_restart_queue() in the shared case. I just realized
that there's a bug there, though. Since we already set the hctx restart
bit, we won't set the queue restart bit. The below should work, and
makes more sense in general.

Or were you thinking of something else?

>From c6fb0a75bd3169d09d0da0dd2da82f20f20b8574 Mon Sep 17 00:00:00 2001
Message-Id: <c6fb0a75bd3169d09d0da0dd2da82f20f20b8574.1486410655.git.osandov@fb.com>
From: Omar Sandoval <osandov@fb.com>
Date: Fri, 3 Feb 2017 11:06:37 -0800
Subject: [PATCH v3] blk-mq-sched: separate mark hctx and queue restart
 operations

In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
after we dispatch requests left over on our hardware queue dispatch
list. This is so we'll go back and dispatch requests from the scheduler.
In this case, it's only necessary to restart the hardware queue that we
are running; there's no reason to run other hardware queues just because
we are using shared tags.

So, split out blk_mq_sched_mark_restart() into two operations, one for
just the hardware queue and one for the whole request queue. The core
code uses both, and I/O schedulers may also want to use them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h | 26 ++++++++++++++++++--------
 block/blk-mq.c       |  5 ++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ee455e7cf9d8..7538565359ea 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -201,7 +201,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * needing a restart in that case.
 	 */
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart(hctx);
+		blk_mq_sched_mark_restart_hctx(hctx);
 		blk_mq_dispatch_rq_list(hctx, &rq_list);
 	} else if (!e || !e->type->ops.mq.dispatch_request) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5954859c8670..36cc68481b0c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -121,17 +121,27 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
-static inline void blk_mq_sched_mark_restart(struct blk_mq_hw_ctx *hctx)
+/*
+ * Mark a hardware queue as needing a restart.
+ */
+static inline void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
-			struct request_queue *q = hctx->queue;
+}
+
+/*
+ * Mark a hardware queue and the request queue it belongs to as needing a
+ * restart.
+ */
+static inline void blk_mq_sched_mark_restart_queue(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
 
-			if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
-				set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
-		}
-	}
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+		set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
 }
 
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e6115a1..a494c0b589d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -937,7 +937,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			 * in case the needed IO completed right before we
 			 * marked the queue as needing a restart.
 			 */
-			blk_mq_sched_mark_restart(hctx);
+			if (hctx->flags & BLK_MQ_F_TAG_SHARED)
+				blk_mq_sched_mark_restart_queue(hctx);
+			else
+				blk_mq_sched_mark_restart_hctx(hctx);
 			if (!blk_mq_get_driver_tag(rq, &hctx, false))
 				break;
 		}
-- 
2.11.1
