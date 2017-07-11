Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756325AbdGKSWE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:22:04 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/6] blk-mq: send the request to dispatch list if direct issue returns busy
Date: Wed, 12 Jul 2017 02:21:00 +0800
Message-Id: <20170711182103.11461-4-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-1-ming.lei@redhat.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before mq IO scheduler is in, we always send the request to
dispatch list if .queue_rq() return busy. After mq IO scheduler
is introduced, we only do this way when scheduler is used in
case of direct issue. Actually we can do that when scheduler
isn't used too.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..6e0fc80aa151 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1463,6 +1463,16 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
 }
 
+static void blk_mq_direct_dispatch(struct blk_mq_hw_ctx *hctx,
+				   struct request *rq)
+{
+	spin_lock(&hctx->lock);
+	list_add(&rq->queuelist, &hctx->dispatch);
+	spin_unlock(&hctx->lock);
+
+	blk_mq_run_hw_queue(hctx, false);
+}
+
 static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 					struct request *rq,
 					blk_qc_t *cookie, bool may_sleep)
@@ -1499,15 +1509,17 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		*cookie = new_cookie;
-		return;
+		break;
 	case BLK_STS_RESOURCE:
 		__blk_mq_requeue_request(rq);
-		goto insert;
+		blk_mq_direct_dispatch(hctx, rq);
+		break;
 	default:
 		*cookie = BLK_QC_T_NONE;
 		blk_mq_end_request(rq, ret);
-		return;
+		break;
 	}
+	return;
 
 insert:
 	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);
-- 
2.9.4
