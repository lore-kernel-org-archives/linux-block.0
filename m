Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63314C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3225B218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDXLDE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfDXLDD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 07:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85F7C30A74D6;
        Wed, 24 Apr 2019 11:03:02 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C075D9C8;
        Wed, 24 Apr 2019 11:03:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH V7 6/9] blk-mq: always free hctx after request queue is freed
Date:   Wed, 24 Apr 2019 19:02:18 +0800
Message-Id: <20190424110221.17435-7-ming.lei@redhat.com>
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 11:03:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In normal queue cleanup path, hctx is released after request queue
is freed, see blk_mq_release().

However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
of hw queues shrinking. This way is easy to cause use-after-free,
because: one implicit rule is that it is safe to call almost all block
layer APIs if the request queue is alive; and one hctx may be retrieved
by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
finally use-after-free is triggered.

Fixes this issue by always freeing hctx after releasing request queue.
If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
a per-queue list to hold them, then try to resuse these hctxs if numa
node is matched.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 46 +++++++++++++++++++++++++++++++++-------------
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  7 +++++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1eceeb26ae7d..b9d711d12cae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2274,6 +2274,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		set->ops->exit_hctx(hctx, hctx_idx);
 
 	blk_mq_remove_cpuhp(hctx);
+
+	spin_lock(&q->unused_hctx_lock);
+	list_add(&hctx->hctx_list, &q->unused_hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -2362,6 +2366,8 @@ blk_mq_alloc_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
+	INIT_LIST_HEAD(&hctx->hctx_list);
+
 	/*
 	 * Allocate space for all possible cpus to avoid allocation at
 	 * runtime
@@ -2675,15 +2681,17 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
  */
 void blk_mq_release(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
+	struct blk_mq_hw_ctx *hctx, *next;
+	int i;
 
 	cancel_delayed_work_sync(&q->requeue_work);
 
-	/* hctx kobj stays in hctx */
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx)
-			continue;
+	queue_for_each_hw_ctx(q, hctx, i)
+		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
+
+	/* all hctx are in .unused_hctx_list now */
+	list_for_each_entry_safe(hctx, next, &q->unused_hctx_list, hctx_list) {
+		list_del_init(&hctx->hctx_list);
 		kobject_put(&hctx->kobj);
 	}
 
@@ -2750,9 +2758,22 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx = NULL, *tmp;
 
-	hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
+	/* reuse dead hctx first */
+	spin_lock(&q->unused_hctx_lock);
+	list_for_each_entry(tmp, &q->unused_hctx_list, hctx_list) {
+		if (tmp->numa_node == node) {
+			hctx = tmp;
+			break;
+		}
+	}
+	if (hctx)
+		list_del_init(&hctx->hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
+
+	if (!hctx)
+		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
 	if (!hctx)
 		goto fail;
 
@@ -2790,10 +2811,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
 		if (hctx) {
-			if (hctxs[i]) {
+			if (hctxs[i])
 				blk_mq_exit_hctx(q, set, hctxs[i], i);
-				kobject_put(&hctxs[i]->kobj);
-			}
 			hctxs[i] = hctx;
 		} else {
 			if (hctxs[i])
@@ -2824,9 +2843,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			if (hctx->tags)
 				blk_mq_free_map_and_requests(set, j);
 			blk_mq_exit_hctx(q, set, hctx, j);
-			kobject_put(&hctx->kobj);
 			hctxs[j] = NULL;
-
 		}
 	}
 	mutex_unlock(&q->sysfs_lock);
@@ -2869,6 +2886,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_sys_init;
 
+	INIT_LIST_HEAD(&q->unused_hctx_list);
+	spin_lock_init(&q->unused_hctx_lock);
+
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index db29928de467..15d1aa53d96c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -70,6 +70,8 @@ struct blk_mq_hw_ctx {
 	struct dentry		*sched_debugfs_dir;
 #endif
 
+	struct list_head	hctx_list;
+
 	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
 	struct srcu_struct	srcu[0];
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99aa98f60b9e..d7bad4ae8bc8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -535,6 +535,13 @@ struct request_queue {
 
 	struct mutex		sysfs_lock;
 
+	/*
+	 * for reusing dead hctx instance in case of updating
+	 * nr_hw_queues
+	 */
+	struct list_head	unused_hctx_list;
+	spinlock_t		unused_hctx_lock;
+
 	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
-- 
2.9.5

