Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A6C433E1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3242073E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnncH/KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgF3HLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:11:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730735AbgF3HLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593501092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7N21nLofkde1YHsNeeP1kr/z3aDXLvAPmwi4UzpOfVQ=;
        b=gnncH/KZ8R8tr1inkrc3J9i/ovqTQ7KEwqNyBfzcQKqm4NpgeQaCWSe6EDV+/UQEfxcdmA
        ahtR4noTgZ9IPJEgV75zU6PkBcN/01KoL+sqvLz8CFEjdKcnxogNT2agwkHceabw3/ss3y
        CVcUgQXvV93CzX+qVNImsi3DnrmB9wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-vvOuN6eENiWoqVqoTTg_Aw-1; Tue, 30 Jun 2020 03:11:26 -0400
X-MC-Unique: vvOuN6eENiWoqVqoTTg_Aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0362800D5C;
        Tue, 30 Jun 2020 07:11:24 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FFD27BECF;
        Tue, 30 Jun 2020 07:11:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 1/3] blk-mq: move blk_mq_get_driver_tag into blk-mq.c
Date:   Tue, 30 Jun 2020 15:11:06 +0800
Message-Id: <20200630071108.2192017-2-ming.lei@redhat.com>
In-Reply-To: <20200630071108.2192017-1-ming.lei@redhat.com>
References: <20200630071108.2192017-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_get_driver_tag() is only used by blk-mq.c and is supposed to
stay in blk-mq.c, so move it and preparing for cleanup code of
get/put driver tag.

Meantime hctx_may_queue() is moved to header file and it is fine
since it is defined as inline always.

No functional change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 58 ----------------------------------------------
 block/blk-mq-tag.h | 39 ++++++++++++++++++++++++-------
 block/blk-mq.c     | 34 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index ae722f8b13fb..d54890b1a44e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -56,37 +56,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
-/*
- * For shared tag users, we track the number of currently active users
- * and attempt to provide a fair share of the tag depth for each of them.
- */
-static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
-				  struct sbitmap_queue *bt)
-{
-	unsigned int depth, users;
-
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
-		return true;
-	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-		return true;
-
-	/*
-	 * Don't try dividing an ant
-	 */
-	if (bt->sb.depth == 1)
-		return true;
-
-	users = atomic_read(&hctx->tags->active_queues);
-	if (!users)
-		return true;
-
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return atomic_read(&hctx->nr_active) < depth;
-}
-
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
@@ -191,33 +160,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return tag + tag_offset;
 }
 
-bool __blk_mq_get_driver_tag(struct request *rq)
-{
-	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
-	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
-	bool shared = blk_mq_tag_busy(rq->mq_hctx);
-	int tag;
-
-	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
-		bt = &rq->mq_hctx->tags->breserved_tags;
-		tag_offset = 0;
-	}
-
-	if (!hctx_may_queue(rq->mq_hctx, bt))
-		return false;
-	tag = __sbitmap_queue_get(bt);
-	if (tag == BLK_MQ_NO_TAG)
-		return false;
-
-	rq->tag = tag + tag_offset;
-	if (shared) {
-		rq->rq_flags |= RQF_MQ_INFLIGHT;
-		atomic_inc(&rq->mq_hctx->nr_active);
-	}
-	rq->mq_hctx->tags->rqs[rq->tag] = rq;
-	return true;
-}
-
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		    unsigned int tag)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2e4ef51cdb32..3945c7f5b944 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -51,14 +51,6 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-bool __blk_mq_get_driver_tag(struct request *rq);
-static inline bool blk_mq_get_driver_tag(struct request *rq)
-{
-	if (rq->tag != BLK_MQ_NO_TAG)
-		return true;
-	return __blk_mq_get_driver_tag(rq);
-}
-
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
@@ -78,6 +70,37 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	__blk_mq_tag_idle(hctx);
 }
 
+/*
+ * For shared tag users, we track the number of currently active users
+ * and attempt to provide a fair share of the tag depth for each of them.
+ */
+static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
+				  struct sbitmap_queue *bt)
+{
+	unsigned int depth, users;
+
+	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
+		return true;
+	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		return true;
+
+	/*
+	 * Don't try dividing an ant
+	 */
+	if (bt->sb.depth == 1)
+		return true;
+
+	users = atomic_read(&hctx->tags->active_queues);
+	if (!users)
+		return true;
+
+	/*
+	 * Allow at least some tags
+	 */
+	depth = max((bt->sb.depth + users - 1) / users, 4U);
+	return atomic_read(&hctx->nr_active) < depth;
+}
+
 /*
  * This helper should only be used for flush request to share tag
  * with the request cloned from, and both the two requests can't be
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d07e55455726..0438bf388fde 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1107,6 +1107,40 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
+static bool __blk_mq_get_driver_tag(struct request *rq)
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
+	if (tag == BLK_MQ_NO_TAG)
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
+static bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag != BLK_MQ_NO_TAG)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
+}
+
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
 {
-- 
2.25.2

