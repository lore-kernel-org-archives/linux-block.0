Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9FC433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D9C20772
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 11:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFCLxu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:53:50 -0400
Received: from verein.lst.de ([213.95.11.211]:50422 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCLxu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 07:53:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A250A68B05; Wed,  3 Jun 2020 13:53:47 +0200 (CEST)
Date:   Wed, 3 Jun 2020 13:53:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200603115347.GA8653@lst.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603105128.2147139-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 03, 2020 at 06:51:27PM +0800, Ming Lei wrote:
> Commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> prevents new request from being allocated on hctx which is going to be inactive,
> meantime drains all in-queue requests.
> 
> We needn't to prevent driver tag from being allocated during cpu hotplug, more
> importantly we have to provide driver tag for requests, so that the cpu hotplug
> handling can move on. blk_mq_get_tag() is shared for allocating both internal
> tag and drive tag, so driver tag allocation may fail because the hctx is
> marked as inactive.
> 
> Fix the issue by moving BLK_MQ_S_INACTIVE check to __blk_mq_alloc_request().

This looks correct, but a little ugly.  How about we resurrect my
patch to split off blk_mq_get_driver_tag entirely?  Quick untested rebase
below, still needs a better changelog and fixes tg:

---
From e432011e2eb5ac7bd1046bbf936645e9f7b74e64 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 16 May 2020 08:03:48 +0200
Subject: blk-mq: split out a __blk_mq_get_driver_tag helper

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
index 96a39d0724a29..cded7fdcad8ef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
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
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		    unsigned int tag)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d38e48f2a0a4a..2e4ef51cdb32a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -51,6 +51,14 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
+bool __blk_mq_get_driver_tag(struct request *rq);
+static inline bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag != BLK_MQ_NO_TAG)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
+}
+
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9a36ac1c1fa1d..4f57d27bfa737 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1052,35 +1052,6 @@ static inline unsigned int queued_to_index(unsigned int queued)
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
-	if (rq->tag != BLK_MQ_NO_TAG)
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
-	return rq->tag != BLK_MQ_NO_TAG;
-}
-
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a139b06318174..b3ce0f3a2ad2a 100644
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

