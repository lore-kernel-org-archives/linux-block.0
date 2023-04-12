Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF06C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDLFds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLFdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59AE4B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J+0HOpEOIXHydqj0tbB9DppEq7IcH96jVHOmEDrVVgs=; b=aC0qZTDHd6h5o9QYXFSZeJPFC5
        4YpJeTHhUXVnuiUdVWZw7Pptratx+OZUr4ESIZ7HkiKryh5NFfRbfXxyUzodxutmFf661GlC2DKbP
        5nLaqMLDniCODjgGE+4lrykrniXQ5mYogREVF20EJfeAT8PCwWBEUiuBjCx9EBBBzx2J17nqvZH5f
        J1KQV5iBjnrY1Uqi8RJ7zBxLSJ8BoBCLD5LqjTdHYVGVo/XP+mq12/qmRVFP58CDqpEh6QwZ83sGI
        XrwIDF9NqPgXkr6sXR9aZxIqPZvDDqZmCFvnWiG6B1/+NfjJQhAci5aokT6jt/FRt3GaiMAu2MJBk
        vmZGBphQ==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6q-001rLg-26;
        Wed, 12 Apr 2023 05:33:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 16/18] blk-mq: pass a flags argument to blk_mq_insert_request
Date:   Wed, 12 Apr 2023 07:32:46 +0200
Message-Id: <20230412053248.601961-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the at_head bool with a flags argument that so far only contains
a single BLK_MQ_INSERT_AT_HEAD value.  This makes it much easier to grep
for head insertions into the blk-mq dispatch queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 19 ++++++++++---------
 block/blk-mq.h |  3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0e4a02ea6ed335..c23c32f429a0e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -44,7 +44,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
-static void blk_mq_insert_request(struct request *rq, bool at_head);
+static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1308,7 +1308,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 		return;
 	}
 
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
@@ -1371,7 +1371,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 
 	if (blk_rq_is_poll(rq)) {
@@ -1445,14 +1445,14 @@ static void blk_mq_requeue_work(struct work_struct *work)
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
@@ -2507,7 +2507,7 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
-static void blk_mq_insert_request(struct request *rq, bool at_head)
+static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -2524,7 +2524,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, at_head);
+		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2554,12 +2554,13 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
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
index f30f99166f3870..2c165de2f3f1fe 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -36,6 +36,9 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
+typedef unsigned int __bitwise blk_insert_t;
+#define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
+
 void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
-- 
2.39.2

