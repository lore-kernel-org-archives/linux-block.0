Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbdIBPR4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Sep 2017 11:17:56 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 01/14] blk-mq-sched: fix scheduler bad performance
Date: Sat,  2 Sep 2017 23:17:16 +0800
Message-Id: <20170902151729.6162-2-ming.lei@redhat.com>
In-Reply-To: <20170902151729.6162-1-ming.lei@redhat.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When hw queue is busy, we shouldn't take requests from
scheduler queue any more, otherwise it is difficult to do
IO merge.

This patch fixes the awful IO performance on some
SCSI devices(lpfc, qla2xxx, ...) when mq-deadline/kyber
is used by not taking requests if hw queue is busy.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4ab69435708c..845e5baf8af1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -94,7 +94,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
-	bool did_work = false;
+	bool do_sched_dispatch = true;
 	LIST_HEAD(rq_list);
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
@@ -125,7 +125,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		did_work = blk_mq_dispatch_rq_list(q, &rq_list);
+		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
 	} else if (!has_sched_dispatch) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list);
@@ -136,7 +136,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * on the dispatch list, OR if we did have work but weren't able
 	 * to make progress.
 	 */
-	if (!did_work && has_sched_dispatch) {
+	if (do_sched_dispatch && has_sched_dispatch) {
 		do {
 			struct request *rq;
 
-- 
2.9.5
