Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6EC433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768222073E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXeuJkmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgF3OGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:06:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgF3OGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 10:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593525960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rby9+YHyerEnVYuURkUovDKko0Gh77p1am4KIwtiPY=;
        b=iXeuJkmmoFTNT5yX65Y4jKWTgBOgKMmRcvVogTsD1xWh5GwOlYRR/EXC7qaNMhFFI8bOJj
        0tn64DeJ36BRRtWeA5VlhZ0OqH/Rvq5DbMBY+laR1hjvXFckPpvLAzVIBgY9I17Ceblu+T
        DqLTqaxdSO/QG9So7IVdjRlH94IQL2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-b9akNzg8OxqYbv59WrtoDA-1; Tue, 30 Jun 2020 10:05:58 -0400
X-MC-Unique: b9akNzg8OxqYbv59WrtoDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D0BA8031FC;
        Tue, 30 Jun 2020 14:04:26 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E35CD5BAC8;
        Tue, 30 Jun 2020 14:04:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 3/3] blk-mq: centralise related handling into blk_mq_get_driver_tag
Date:   Tue, 30 Jun 2020 22:03:57 +0800
Message-Id: <20200630140357.2251174-4-ming.lei@redhat.com>
In-Reply-To: <20200630140357.2251174-1-ming.lei@redhat.com>
References: <20200630140357.2251174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 block/blk-flush.c  | 17 ++++++-----------
 block/blk-mq-tag.h | 12 ------------
 block/blk-mq.c     | 30 ++++++++++++++----------------
 block/blk.h        |  5 -----
 4 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 21108a550fbf..e756db088d84 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -236,12 +236,10 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		error = fq->rq_status;
 
 	hctx = flush_rq->mq_hctx;
-	if (!q->elevator) {
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag = -1;
-	} else {
-		flush_rq->internal_tag = -1;
-	}
+	if (!q->elevator)
+		flush_rq->tag = BLK_MQ_NO_TAG;
+	else
+		flush_rq->internal_tag = BLK_MQ_NO_TAG;
 
 	running = &fq->flush_queue[fq->flush_running_idx];
 	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
@@ -315,13 +313,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
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
index e7a2d2d44b51..a20647139c95 100644
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
@@ -1127,9 +1121,10 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
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
@@ -1142,19 +1137,22 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
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
+	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&hctx->nr_active);
+	}
+	hctx->tags->rqs[rq->tag] = rq;
+	return true;
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk.h b/block/blk.h
index 41a50880c94e..0184a31fe4df 100644
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

