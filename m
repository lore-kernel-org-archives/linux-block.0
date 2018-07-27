Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25831 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbeG0RnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 13:43:20 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] block: Simplify blk_add_timer() and blk_mq_add_timer()
Date: Fri, 27 Jul 2018 09:20:41 -0700
Message-Id: <20180727162042.13425-5-bart.vanassche@wdc.com>
In-Reply-To: <20180727162042.13425-1-bart.vanassche@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use the fact that q->mq_ops == NULL for the legacy block layer and
also that q->mq_ops != NULL for blk-mq to simplify blk_add_timer and
blk_mq_add_timer(). This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-timeout.c | 54 +++++++++------------------------------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 527670f2f985..02d7e3427369 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -219,34 +219,21 @@ static void __blk_add_timer(struct request *req, unsigned long deadline)
 void blk_add_timer(struct request *req)
 {
 	struct request_queue *q = req->q;
+	unsigned long deadline;
 
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
+	lockdep_assert_held(q->queue_lock);
 
-	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
-	if (!q->mq_ops && !q->rq_timed_out_fn)
+	if (!q->rq_timed_out_fn)
 		return;
-
-	BUG_ON(!list_empty(&req->timeout_list));
-
-	/*
-	 * Some LLDs, like scsi, peek at the timeout to prevent a
-	 * command from being retried forever.
-	 */
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
-	blk_rq_set_deadline(req, jiffies + req->timeout);
+	deadline = jiffies + req->timeout;
+	blk_rq_set_deadline(req, deadline);
+	list_add_tail(&req->timeout_list, &req->q->timeout_list);
 
-	/*
-	 * Only the non-mq case needs to add the request to a protected list.
-	 * For the mq case we simply scan the tag map.
-	 */
-	if (!q->mq_ops)
-		list_add_tail(&req->timeout_list, &req->q->timeout_list);
-
-	__blk_add_timer(req, blk_rq_deadline(req));
+	__blk_add_timer(req, deadline);
 }
 
 /**
@@ -259,32 +246,13 @@ void blk_add_timer(struct request *req)
 void blk_mq_add_timer(struct request *req)
 {
 	struct request_queue *q = req->q;
+	unsigned long deadline;
 
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
-
-	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
-	if (!q->mq_ops && !q->rq_timed_out_fn)
-		return;
-
-	BUG_ON(!list_empty(&req->timeout_list));
-
-	/*
-	 * Some LLDs, like scsi, peek at the timeout to prevent a
-	 * command from being retried forever.
-	 */
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
-	blk_rq_set_deadline(req, jiffies + req->timeout);
-
-	/*
-	 * Only the non-mq case needs to add the request to a protected list.
-	 * For the mq case we simply scan the tag map.
-	 */
-	if (!q->mq_ops)
-		list_add_tail(&req->timeout_list, &req->q->timeout_list);
-
-	__blk_add_timer(req, blk_rq_deadline(req));
+	deadline = jiffies + req->timeout;
+	blk_rq_set_deadline(req, deadline);
+	__blk_add_timer(req, deadline);
 }
-- 
2.18.0
