Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD008C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B662070B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUz9UEZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFELol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:44:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726324AbgFELok (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 07:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyLx2aNUU7w/ldRLlHIN9/LKzFrn7NJHyuf4QdpdnH4=;
        b=WUz9UEZs4VzdvzC4rl1MvzQgUc5gDU+C7mXsdYfa0qCTtzveXWZsIsYtrSAXedSsoD4akS
        pgyXMm/3BNbqC9KYPfL1SPi/8BauByxdeNPTJPIef37MsegHx4+iZH90gil4v8Cyr6RC0F
        B20n7EfaCeMjT4K/h6LOnqmgr4fOJ+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-F5_YotxWMp-6TBm292l0mA-1; Fri, 05 Jun 2020 07:44:35 -0400
X-MC-Unique: F5_YotxWMp-6TBm292l0mA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8ADD835B41;
        Fri,  5 Jun 2020 11:44:33 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDBC10013C0;
        Fri,  5 Jun 2020 11:44:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blk-mq: split out a __blk_mq_get_driver_tag helper
Date:   Fri,  5 Jun 2020 19:44:09 +0800
Message-Id: <20200605114410.2416726-2-ming.lei@redhat.com>
In-Reply-To: <20200605114410.2416726-1-ming.lei@redhat.com>
References: <20200605114410.2416726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Allocation of the driver tag in the case of using a scheduler shares very
little code with the "normal" tag allocation.  Split out a new helper to
streamline this path, and untangle it from the complex normal tag
allocation.

This way also avoids to fail driver tag allocation because of inactive hctx
during cpu hotplug, and fixes potential hang risk.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Tested-by: John Garry <john.garry@huawei.com>
Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 27 +++++++++++++++++++++++++++
 block/blk-mq-tag.h |  8 ++++++++
 block/blk-mq.c     | 29 -----------------------------
 block/blk-mq.h     |  1 -
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 96a39d0724a2..cded7fdcad8e 100644
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
index d38e48f2a0a4..2e4ef51cdb32 100644
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
index a98a19353461..492ac216eac0 100644
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
index f3a93acfad03..f4c57c28ab40 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -45,7 +45,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-bool blk_mq_get_driver_tag(struct request *rq);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
 
-- 
2.25.2

