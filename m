Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0A4C10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832020675
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDLDbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfDLDbK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 23:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A492C075D72;
        Fri, 12 Apr 2019 03:31:09 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E22F65D9CD;
        Fri, 12 Apr 2019 03:31:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V5 5/9] blk-mq: split blk_mq_alloc_and_init_hctx into two parts
Date:   Fri, 12 Apr 2019 11:30:28 +0800
Message-Id: <20190412033032.10418-6-ming.lei@redhat.com>
In-Reply-To: <20190412033032.10418-1-ming.lei@redhat.com>
References: <20190412033032.10418-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 12 Apr 2019 03:31:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split blk_mq_alloc_and_init_hctx into two parts, and one is
blk_mq_alloc_hctx() which is for allocating all hctx resources,
another is blk_mq_init_hctx() which is for initializing hctx, and
serves as counter-part of blk_mq_exit_hctx().

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 69 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ad58169ad6a..71996fe494eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2290,10 +2290,36 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 	return hw_ctx_size;
 }
 
+static int blk_mq_init_hctx(struct request_queue *q,
+			    struct blk_mq_tag_set *set,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned hctx_idx)
+{
+	hctx->queue_num = hctx_idx;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
+	hctx->tags = set->tags[hctx_idx];
+
+	if (set->ops->init_hctx &&
+	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
+		goto fail;
+
+	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
+				hctx->numa_node))
+		goto exit_hctx;
+	return 0;
+ exit_hctx:
+	if (set->ops->exit_hctx)
+		set->ops->exit_hctx(hctx, hctx_idx);
+ fail:
+	return -1;
+}
+
 static struct blk_mq_hw_ctx *
-__blk_mq_alloc_and_init_hctx(struct request_queue *q,
-			     struct blk_mq_tag_set *set,
-			     unsigned hctx_idx, int node)
+blk_mq_alloc_hctx(struct request_queue *q,
+		  struct blk_mq_tag_set *set,
+		  unsigned hctx_idx, int node)
 {
 	struct blk_mq_hw_ctx *hctx;
 
@@ -2310,8 +2336,6 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 
 	atomic_set(&hctx->nr_active, 0);
 	hctx->numa_node = node;
-	hctx->queue_num = hctx_idx;
-
 	if (node == NUMA_NO_NODE)
 		hctx->numa_node = set->numa_node;
 	node = hctx->numa_node;
@@ -2322,10 +2346,6 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
-	hctx->tags = set->tags[hctx_idx];
-
 	/*
 	 * Allocate space for all possible cpus to avoid allocation at
 	 * runtime
@@ -2338,24 +2358,16 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
 				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node))
 		goto free_ctxs;
-
 	hctx->nr_ctx = 0;
 
 	spin_lock_init(&hctx->dispatch_wait_lock);
 	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
 	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
 
-	if (set->ops->init_hctx &&
-	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto free_bitmap;
-
 	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
 			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!hctx->fq)
-		goto exit_hctx;
-
-	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
-		goto free_fq;
+		goto free_bitmap;
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
@@ -2363,11 +2375,6 @@ __blk_mq_alloc_and_init_hctx(struct request_queue *q,
 
 	return hctx;
 
- free_fq:
-	kfree(hctx->fq);
- exit_hctx:
-	if (set->ops->exit_hctx)
-		set->ops->exit_hctx(hctx, hctx_idx);
  free_bitmap:
 	sbitmap_free(&hctx->ctx_map);
  free_ctxs:
@@ -2728,7 +2735,21 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
 {
-	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
+	if (!hctx)
+		goto fail;
+
+	if (blk_mq_init_hctx(q, set, hctx, hctx_idx))
+		goto free_hctx;
+
+	return hctx;
+
+ free_hctx:
+	kobject_put(&hctx->kobj);
+ fail:
+	return NULL;
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-- 
2.9.5

