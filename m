Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE97C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6AE20787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWGGplcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgERGjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:39:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B3C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EF6pWUi9283dieNg5RpqBBsqbySgxzMhSIKNcba1CmA=; b=DWGGplcQI4KUIGFKj5ETQI+z0V
        JeIX2dw19uYC/m/kEEkPK0dsO73HUxDrelbGr3YXLg6xvoiEc0s7cEeZ89f45QX26mDkdJQgaKv8a
        uIdnc3sYyCcFwJWJ4FuI6GG2JxCfeznRl7Oq2pHiII+i9UT66gWTwePAXRkqOsabmriGILuBHMy0O
        eU5GcNlZlTt1WyZJnwHmGK80L0xbdc2UsMaWLm7zfLq5zyu0m072Xi5CfPI5KpFn9nAPB+L9TZ9Wc
        jyGn63bGR6GYDzjlD4FkQiAG9QrmcbF4445RNQKgtiuIhZMSTE2jM76+3FNBOKpq4C90crjagqEo1
        UZzV8a/Q==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZR8-0001wz-SM; Mon, 18 May 2020 06:39:43 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/9] blk-mq: split out a __blk_mq_get_driver_tag helper
Date:   Mon, 18 May 2020 08:39:29 +0200
Message-Id: <20200518063937.757218-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allocation of the driver tag in the case of using a scheduler shares very
little code with the "normal" tag allocation.  Split out a new helper to
streamline this path, and untangle it from the complex normal tag
allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 27 +++++++++++++++++++++++++++
 block/blk-mq-tag.h |  8 ++++++++
 block/blk-mq.c     | 29 -----------------------------
 block/blk-mq.h     |  1 -
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904ab..e5b17300ec882 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -183,6 +183,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return tag + tag_offset;
 }
 
+bool __blk_mq_get_driver_tag(struct request *rq)
+{
+	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
+	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
+	bool shared = blk_mq_tag_busy(rq->mq_hctx);
+	int tag;
+
+	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
+		bt = &rq->mq_hctx->tags->breserved_tags;
+		tag_offset = 0;
+	}
+
+	if (!hctx_may_queue(rq->mq_hctx, bt))
+		return false;
+	tag = __sbitmap_queue_get(bt);
+	if (tag == BLK_MQ_TAG_FAIL)
+		return false;
+
+	rq->tag = tag + tag_offset;
+	if (shared) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&rq->mq_hctx->nr_active);
+	}
+	rq->mq_hctx->tags->rqs[rq->tag] = rq;
+	return true;
+}
+
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		    unsigned int tag)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b8321efb6820..c2ad3ed637106 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -25,6 +25,14 @@ struct blk_mq_tags {
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
+bool __blk_mq_get_driver_tag(struct request *rq);
+static inline bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag != -1)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
+}
+
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f6023..5283c0105f6f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1015,35 +1015,6 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-bool blk_mq_get_driver_tag(struct request *rq)
-{
-	struct blk_mq_alloc_data data = {
-		.q = rq->q,
-		.hctx = rq->mq_hctx,
-		.flags = BLK_MQ_REQ_NOWAIT,
-		.cmd_flags = rq->cmd_flags,
-	};
-	bool shared;
-
-	if (rq->tag != -1)
-		return true;
-
-	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
-		data.flags |= BLK_MQ_REQ_RESERVED;
-
-	shared = blk_mq_tag_busy(data.hctx);
-	rq->tag = blk_mq_get_tag(&data);
-	if (rq->tag >= 0) {
-		if (shared) {
-			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
-		}
-		data.hctx->tags->rqs[rq->tag] = rq;
-	}
-
-	return rq->tag != -1;
-}
-
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494faf..e7d1da4b1f731 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -44,7 +44,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-bool blk_mq_get_driver_tag(struct request *rq);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
 
-- 
2.26.2

