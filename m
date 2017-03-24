Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36806 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdCXMgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 08:36:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so193538pfr.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 05:36:36 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 1/4] blk-mq: comment on races related with timeout handler
Date: Fri, 24 Mar 2017 20:36:18 +0800
Message-Id: <20170324123621.5227-2-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-1-tom.leiming@gmail.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds comment on two races related with
timeout handler:

- requeue from queue busy vs. timeout
- rq free & reallocation vs. timeout

Both the races themselves and current solution aren't
explicit enough, so add comments on them.

Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-mq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c212b9644a9f..b36f0481ba0e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -523,6 +523,15 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
+/*
+ * When we reach here because queue is busy, REQ_ATOM_COMPLETE
+ * flag isn't set yet, so there may be race with timeout hanlder,
+ * but given rq->deadline is just set in .queue_rq() under
+ * this situation, the race won't be possible in reality because
+ * rq->timeout should be set as big enough to cover the window
+ * between blk_mq_start_request() called from .queue_rq() and
+ * clearing REQ_ATOM_STARTED here.
+ */
 static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -696,6 +705,19 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
 		return;
 
+	/*
+	 * The rq being checked may have been freed and reallocated
+	 * out already here, we avoid this race by checking rq->deadline
+	 * and REQ_ATOM_COMPLETE flag together:
+	 *
+	 * - if rq->deadline is observed as new value because of
+	 *   reusing, the rq won't be timed out because of timing.
+	 * - if rq->deadline is observed as previous value,
+	 *   REQ_ATOM_COMPLETE flag won't be cleared in reuse path
+	 *   because we put a barrier between setting rq->deadline
+	 *   and clearing the flag in blk_mq_start_request(), so
+	 *   this rq won't be timed out too.
+	 */
 	if (time_after_eq(jiffies, rq->deadline)) {
 		if (!blk_mark_rq_complete(rq))
 			blk_mq_rq_timed_out(rq, reserved);
-- 
2.9.3
