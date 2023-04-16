Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF80C77B76
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDPUJv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPUJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884091FE8
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d51jTUgTf+HsfInkkWmMuDwS2m4QhnnekxPqCNQ/t9o=; b=wtgnJb2sD/qgNDwIT8i7WGT22q
        uoMZE4Gr7A7eiaRfvd+Ad1zQjr4w/Q47/KldESidFDOMQVZzUJex92OUQWaBdZj+AAn9R9RP4d6Se
        WO12lZ4pr3NH3KfDSgvUhYBVm/E/L++9Xo1L03+LJrjinNWhuvEB3Z7JWu4jtIgG2e4ao8vUE7TQj
        cmpmhROIUO6cfS3Y6jR6IrJGnyH97mIF9TQhDUrj+RUSjkS9RSjG/4V0TtV54GrY0jk1/KcFbMd1M
        vyrED40DdxjIESL3z6SK7oa6u3mIhtyf3CF76U/TFPDDDid7LtBUhgL345qL0Y3dB9+sN3wvWzkme
        CEyjZ/rw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8h1-00EOIE-0I;
        Sun, 16 Apr 2023 20:09:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/7] blk-mq: defer to the normal submission path for non-flush flush commands
Date:   Sun, 16 Apr 2023 22:09:26 +0200
Message-Id: <20230416200930.29542-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_insert_flush decides that a command does not need to use the
flush state machine, return false and let blk_mq_submit_bio handle
it the normal way (including using an I/O scheduler) instead of doing
a bypass insert.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 22 ++++++++--------------
 block/blk-mq.c    |  8 ++++----
 block/blk-mq.h    |  4 ----
 block/blk.h       |  2 +-
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 9fcfee7394f27d..5bc462524473b2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -385,22 +385,17 @@ static void blk_rq_init_flush(struct request *rq)
 	rq->end_io = mq_flush_data_end_io;
 }
 
-/**
- * blk_insert_flush - insert a new PREFLUSH/FUA request
- * @rq: request to insert
- *
- * To be called from __elv_add_request() for %ELEVATOR_INSERT_FLUSH insertions.
- * or __blk_mq_run_hw_queue() to dispatch request.
- * @rq is being submitted.  Analyze what needs to be done and put it on the
- * right queue.
+/*
+ * Insert a PREFLUSH/FUA request into the flush state machine.
+ * Returns true if the request has been consumed by the flush state machine,
+ * or false if the caller should continue to process it.
  */
-void blk_insert_flush(struct request *rq)
+bool blk_insert_flush(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned long fflags = q->queue_flags;	/* may change, cache */
 	unsigned int policy = blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	/* FLUSH/FUA request must never be merged */
 	WARN_ON_ONCE(rq->bio != rq->biotail);
@@ -429,16 +424,14 @@ void blk_insert_flush(struct request *rq)
 		 * complete the request.
 		 */
 		blk_mq_end_request(rq, 0);
-		return;
+		return true;
 	case REQ_FSEQ_DATA:
 		/*
 		 * If there's data, but no flush is necessary, the request can
 		 * be processed directly without going through flush machinery.
 		 * Queue for normal execution.
 		 */
-		blk_mq_request_bypass_insert(rq, 0);
-		blk_mq_run_hw_queue(hctx, false);
-		return;
+		return false;
 	default:
 		/*
 		 * Mark the request as part of a flush sequence and submit it
@@ -448,6 +441,7 @@ void blk_insert_flush(struct request *rq)
 		spin_lock_irq(&fq->mq_flush_lock);
 		blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
 		spin_unlock_irq(&fq->mq_flush_lock);
+		return true;
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2d297efe229db..452bc17cce4dcf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -45,6 +45,8 @@
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
+static void blk_mq_request_bypass_insert(struct request *rq,
+		blk_insert_t flags);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -2429,7 +2431,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
+static void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
@@ -2972,10 +2974,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (op_is_flush(bio->bi_opf)) {
-		blk_insert_flush(rq);
+	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
-	}
 
 	if (plug) {
 		blk_add_rq_to_plug(plug, rq);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f882677ff106a5..62c505e6ef1e40 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -64,10 +64,6 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 			     struct blk_mq_tags *tags,
 			     unsigned int hctx_idx);
-/*
- * Internal helpers for request insertion into sw queues
- */
-void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags);
 
 /*
  * CPU -> queue mappings
diff --git a/block/blk.h b/block/blk.h
index 2da83110347173..512a1c0db6ba15 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -277,7 +277,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
  */
 #define ELV_ON_HASH(rq) ((rq)->rq_flags & RQF_HASHED)
 
-void blk_insert_flush(struct request *rq);
+bool blk_insert_flush(struct request *rq);
 
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
 void elevator_disable(struct request_queue *q);
-- 
2.39.2

