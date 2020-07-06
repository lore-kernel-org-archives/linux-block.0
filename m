Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC74C433DF
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A743F206CB
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi4YGzaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgGFOlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:41:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729195AbgGFOlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jul 2020 10:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594046481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=viQKSFbsABgKZdu9hnfO7ROo9wLLyYsvZXciZrKq9Bg=;
        b=Wi4YGzaIu2+TjdxkUD8sFZHmqdZdPYrOHaxLkxkEYlQSeQN/FA2TXLfjHhS40AcTfpQtf6
        m+rWG3VAS/IrUltB3KtBRltZfvWt2QBlX+HCd2MQU8zpzDWPXj7qD6CzXpcljI0WZ0JWEK
        j5cSI/DtZpMhexW9nNzTRn8nS/CNutY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Ndi20o5SM8m1hWIHogtGeQ-1; Mon, 06 Jul 2020 10:41:19 -0400
X-MC-Unique: Ndi20o5SM8m1hWIHogtGeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2806C87950D;
        Mon,  6 Jul 2020 14:41:18 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F5919D61;
        Mon,  6 Jul 2020 14:41:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] blk-mq: centralise related handling into blk_mq_get_driver_tag
Date:   Mon,  6 Jul 2020 22:41:11 +0800
Message-Id: <20200706144111.3260859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
all are good to do during getting driver tag.

Meantime blk-flush related code is simplified and flush request needn't
to update the request table manually any more.

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c  | 14 ++++----------
 block/blk-mq-tag.h | 12 ------------
 block/blk-mq.c     | 31 +++++++++++++++----------------
 block/blk.h        |  5 -----
 4 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 86a8b6e747df..197e5d1cefce 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,7 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
-	struct blk_mq_hw_ctx *hctx;
 
 	blk_account_io_flush(flush_rq);
 
@@ -235,13 +234,11 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
-	hctx = flush_rq->mq_hctx;
 	if (!q->elevator) {
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag = -1;
+		flush_rq->tag = BLK_MQ_NO_TAG;
 	} else {
 		blk_mq_put_driver_tag(flush_rq);
-		flush_rq->internal_tag = -1;
+		flush_rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 
 	running = &fq->flush_queue[fq->flush_running_idx];
@@ -316,13 +313,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_ctx = first_rq->mq_ctx;
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
-	if (!q->elevator) {
-		fq->orig_rq = first_rq;
+	if (!q->elevator)
 		flush_rq->tag = first_rq->tag;
-		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
-	} else {
+	else
 		flush_rq->internal_tag = first_rq->internal_tag;
-	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 3945c7f5b944..b1acac518c4e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -101,18 +101,6 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-/*
- * This helper should only be used for flush request to share tag
- * with the request cloned from, and both the two requests can't be
- * in flight at the same time. The caller has to make sure the tag
- * can't be freed.
- */
-static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
-		unsigned int tag, struct request *rq)
-{
-	hctx->tags->rqs[tag] = rq;
-}
-
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 117dec9abace..8768ef5f235d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -277,26 +277,20 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
-	req_flags_t rq_flags = 0;
 
 	if (data->q->elevator) {
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
-			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
-		}
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
-		data->hctx->tags->rqs[rq->tag] = rq;
 	}
 
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
 	rq->mq_hctx = data->hctx;
-	rq->rq_flags = rq_flags;
+	rq->rq_flags = 0;
 	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
@@ -1107,9 +1101,10 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
 	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
-	bool shared = blk_mq_tag_busy(rq->mq_hctx);
 	int tag;
 
+	blk_mq_tag_busy(rq->mq_hctx);
+
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
@@ -1122,19 +1117,23 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 		return false;
 
 	rq->tag = tag + tag_offset;
-	if (shared) {
-		rq->rq_flags |= RQF_MQ_INFLIGHT;
-		atomic_inc(&rq->mq_hctx->nr_active);
-	}
-	rq->mq_hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
 
 static bool blk_mq_get_driver_tag(struct request *rq)
 {
-	if (rq->tag != BLK_MQ_NO_TAG)
-		return true;
-	return __blk_mq_get_driver_tag(rq);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
+		return false;
+
+	if ((hctx->flags & BLK_MQ_F_TAG_SHARED) &&
+			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&hctx->nr_active);
+	}
+	hctx->tags->rqs[rq->tag] = rq;
+	return true;
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk.h b/block/blk.h
index 94f7c084f68f..9dcf51c94096 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,11 +25,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
-	/*
-	 * flush_rq shares tag with this rq, both can't be active
-	 * at the same time
-	 */
-	struct request		*orig_rq;
 	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
-- 
2.25.2

