Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E29C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712402075D
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 08:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfD1IOe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfD1IOe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 04:14:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6175356CE;
        Sun, 28 Apr 2019 08:14:33 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB714171EE;
        Sun, 28 Apr 2019 08:14:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V8 4/7] blk-mq: split blk_mq_alloc_and_init_hctx into two parts
Date:   Sun, 28 Apr 2019 16:14:05 +0800
Message-Id: <20190428081408.27331-5-ming.lei@redhat.com>
In-Reply-To: <20190428081408.27331-1-ming.lei@redhat.com>
References: <20190428081408.27331-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 28 Apr 2019 08:14:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split blk_mq_alloc_and_init_hctx into two parts, and one is
blk_mq_alloc_hctx() for allocating all hctx resources, another
is blk_mq_init_hctx() for initializing hctx, which serves as
counter-part of blk_mq_exit_hctx().

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 138 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 61 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d98cb9614dfa..44ecca6b0cac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2284,15 +2284,70 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
+static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
+{
+	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
+
+	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
+			   __alignof__(struct blk_mq_hw_ctx)) !=
+		     sizeof(struct blk_mq_hw_ctx));
+
+	if (tag_set->flags & BLK_MQ_F_BLOCKING)
+		hw_ctx_size += sizeof(struct srcu_struct);
+
+	return hw_ctx_size;
+}
+
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	int node;
+	hctx->queue_num = hctx_idx;
 
-	node = hctx->numa_node;
+	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
+
+	hctx->tags = set->tags[hctx_idx];
+
+	if (set->ops->init_hctx &&
+	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
+		goto unregister_cpu_notifier;
+
+	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
+				hctx->numa_node))
+		goto exit_hctx;
+	return 0;
+
+ exit_hctx:
+	if (set->ops->exit_hctx)
+		set->ops->exit_hctx(hctx, hctx_idx);
+ unregister_cpu_notifier:
+	blk_mq_remove_cpuhp(hctx);
+	return -1;
+}
+
+static struct blk_mq_hw_ctx *
+blk_mq_alloc_hctx(struct request_queue *q,
+		struct blk_mq_tag_set *set,
+		unsigned hctx_idx, int node)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+			node);
+	if (!hctx)
+		goto fail_alloc_hctx;
+
+	if (!zalloc_cpumask_var_node(&hctx->cpumask,
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node))
+		goto free_hctx;
+
+	atomic_set(&hctx->nr_active, 0);
+	hctx->numa_node = node;
 	if (node == NUMA_NO_NODE)
-		node = hctx->numa_node = set->numa_node;
+		hctx->numa_node = set->numa_node;
+	node = hctx->numa_node;
 
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -2300,10 +2355,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-
-	hctx->tags = set->tags[hctx_idx];
-
 	/*
 	 * Allocate space for all possible cpus to avoid allocation at
 	 * runtime
@@ -2311,47 +2362,38 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	hctx->ctxs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
 			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
 	if (!hctx->ctxs)
-		goto unregister_cpu_notifier;
+		goto free_cpumask;
 
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
+	blk_mq_hctx_kobj_init(hctx);
 
-	return 0;
+	return hctx;
 
- free_fq:
-	blk_free_flush_queue(hctx->fq);
- exit_hctx:
-	if (set->ops->exit_hctx)
-		set->ops->exit_hctx(hctx, hctx_idx);
  free_bitmap:
 	sbitmap_free(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
- unregister_cpu_notifier:
-	blk_mq_remove_cpuhp(hctx);
-	return -1;
+ free_cpumask:
+	free_cpumask_var(hctx->cpumask);
+ free_hctx:
+	kfree(hctx);
+ fail_alloc_hctx:
+	return NULL;
 }
 
 static void blk_mq_init_cpu_queues(struct request_queue *q,
@@ -2697,51 +2739,25 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 }
 EXPORT_SYMBOL(blk_mq_init_sq_queue);
 
-static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
-{
-	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
-
-	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
-			   __alignof__(struct blk_mq_hw_ctx)) !=
-		     sizeof(struct blk_mq_hw_ctx));
-
-	if (tag_set->flags & BLK_MQ_F_BLOCKING)
-		hw_ctx_size += sizeof(struct srcu_struct);
-
-	return hw_ctx_size;
-}
-
 static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
 {
 	struct blk_mq_hw_ctx *hctx;
 
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
-			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-			node);
+	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
 	if (!hctx)
-		return NULL;
-
-	if (!zalloc_cpumask_var_node(&hctx->cpumask,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				node)) {
-		kfree(hctx);
-		return NULL;
-	}
+		goto fail;
 
-	atomic_set(&hctx->nr_active, 0);
-	hctx->numa_node = node;
-	hctx->queue_num = hctx_idx;
-
-	if (blk_mq_init_hctx(q, set, hctx, hctx_idx)) {
-		free_cpumask_var(hctx->cpumask);
-		kfree(hctx);
-		return NULL;
-	}
-	blk_mq_hctx_kobj_init(hctx);
+	if (blk_mq_init_hctx(q, set, hctx, hctx_idx))
+		goto free_hctx;
 
 	return hctx;
+
+ free_hctx:
+	kobject_put(&hctx->kobj);
+ fail:
+	return NULL;
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-- 
2.9.5

