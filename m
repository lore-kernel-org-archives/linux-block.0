Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A011C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDKNev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDKNeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202D40C6
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mYJfYXvkZ5yCW2OWmBSAD9v51J2UEdEUC5tVX2BT3PY=; b=qyRDRlvxg1YQwg11h44rBq+lxD
        y8E4ssWtmjPVGmnkD3HeggzqRPow7DLrCVYeOm+6F0jxW/JgOiYuAl9TYeQ/TKIYk8VgpVgI/Zpcy
        NR9EeQDcbOaBjWdue4BgPzQXFKQBUlKCJD+eTUTi4h9LlbEg7ofv3mNPaD/0fWUFLQiWlTcvgSXvp
        +UFIJN/ytqzOxqc4W2FOD8VKcacBG2vILkyEMbNVo4KgCYkHJ7/qTv9V/A18H7nRqzG4seNMzQwDm
        qvL8tfo5seIuSlfiTNlWQLB4qpUKhqw76u/+Y+iSKFa/hyfsRkN4tZZwnO1OdoIELYaOD3JmQ7coH
        C38bSMTw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8x-000822-2R;
        Tue, 11 Apr 2023 13:34:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 14/16] blk-mq: pass a flags argument to blk_mq_insert_request
Date:   Tue, 11 Apr 2023 15:33:27 +0200
Message-Id: <20230411133329.554624-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the at_head bool with a flags argument that so far only contains
a single BLK_MQ_INSERT_AT_HEAD value.  This makes it much easier to grep
for head insertations into the blk-mq dispatch queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 19 ++++++++++---------
 block/blk-mq.h |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index edc82ecf7f5b77..5a4ae0e4080d45 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -46,7 +46,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
-static void blk_mq_insert_request(struct request *rq, bool at_head);
+static void blk_mq_insert_request(struct request *rq, unsigned int flags);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1310,7 +1310,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 		return;
 	}
 
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
@@ -1373,7 +1373,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 
 	if (blk_rq_is_poll(rq)) {
@@ -1447,14 +1447,14 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_insert_request(rq, true);
+			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 		}
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -2509,7 +2509,7 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
-static void blk_mq_insert_request(struct request *rq, bool at_head)
+static void blk_mq_insert_request(struct request *rq, unsigned int flags)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -2526,7 +2526,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, at_head);
+		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2556,12 +2556,13 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
 
 		list_add(&rq->queuelist, &list);
-		q->elevator->type->ops.insert_requests(hctx, &list, at_head);
+		q->elevator->type->ops.insert_requests(hctx, &list,
+				flags & BLK_MQ_INSERT_AT_HEAD);
 	} else {
 		trace_block_rq_insert(rq);
 
 		spin_lock(&ctx->lock);
-		if (at_head)
+		if (flags & BLK_MQ_INSERT_AT_HEAD)
 			list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
 		else
 			list_add_tail(&rq->queuelist,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index cc17e942753117..ab2f4bfa0de6a4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -30,6 +30,8 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+#define BLK_MQ_INSERT_AT_HEAD		(1U << 0)
+
 void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
-- 
2.39.2

