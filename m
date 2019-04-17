Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84443C10F12
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544B320835
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 03:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfDQDpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:45:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfDQDpE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 23:45:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EC7AC049D7C;
        Wed, 17 Apr 2019 03:45:03 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC9371001DCC;
        Wed, 17 Apr 2019 03:45:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V6 4/9] blk-mq: move all hctx alloction & initialization into __blk_mq_alloc_and_init_hctx
Date:   Wed, 17 Apr 2019 11:44:05 +0800
Message-Id: <20190417034410.31957-5-ming.lei@redhat.com>
In-Reply-To: <20190417034410.31957-1-ming.lei@redhat.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 17 Apr 2019 03:45:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all hctx related allocation and initialization into
__blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
into real two functions, one is for allocate everything, and another is for
initializing everyting.

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
 block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 239b404b9e6c..4c6fbbc6791b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2290,15 +2290,45 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
-static int blk_mq_init_hctx(struct request_queue *q,
-		struct blk_mq_tag_set *set,
-		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
+static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 {
-	int node;
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
+static struct blk_mq_hw_ctx *
+__blk_mq_alloc_and_init_hctx(struct request_queue *q,
+			     struct blk_mq_tag_set *set,
+			     unsigned hctx_idx, int node)
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
+	hctx->queue_num = hctx_idx;
 
-	node = hctx->numa_node;
 	if (node == NUMA_NO_NODE)
-		node = hctx->numa_node = set->numa_node;
+		hctx->numa_node = set->numa_node;
+	node = hctx->numa_node;
 
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -2343,8 +2373,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
+	blk_mq_hctx_kobj_init(hctx);
 
-	return 0;
+	return hctx;
 
  free_fq:
 	blk_free_flush_queue(hctx->fq);
@@ -2357,7 +2388,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
 	blk_mq_remove_cpuhp(hctx);
-	return -1;
+	free_cpumask_var(hctx->cpumask);
+ free_hctx:
+	kfree(hctx);
+ fail_alloc_hctx:
+	return NULL;
 }
 
 static void blk_mq_init_cpu_queues(struct request_queue *q,
@@ -2703,51 +2738,11 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
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
-	struct blk_mq_hw_ctx *hctx;
-
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
-			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-			node);
-	if (!hctx)
-		return NULL;
-
-	if (!zalloc_cpumask_var_node(&hctx->cpumask,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				node)) {
-		kfree(hctx);
-		return NULL;
-	}
-
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
-
-	return hctx;
+	return __blk_mq_alloc_and_init_hctx(q, set, hctx_idx, node);
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-- 
2.9.5

