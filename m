Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF84C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiB1JGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiB1JGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90AE83AA47
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuCzF6eW9QGa5PFmSGaSPuCz6I8prUkeH2eboKS2DiY=;
        b=iFcQ5m/inP77H+gA39napKi1q9Mw1RNX9Q90XNPK+s5NiyiXgtb5FuGaCDUAg6xHrJoBjW
        4wfPwaWtbmXN+i9bQrYejU2XQ/3bUsjWsuawYZsXCp/3xyBTxAeI3KN7Qnu0ju0pbytZVW
        /yux4RvsmijW2t+RLy56+DqqB+QEEKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-EzxS94tKO2SDMFrMJ9bkTw-1; Mon, 28 Feb 2022 04:05:59 -0500
X-MC-Unique: EzxS94tKO2SDMFrMJ9bkTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873141854E21;
        Mon, 28 Feb 2022 09:05:58 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1D096F968;
        Mon, 28 Feb 2022 09:05:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/6] blk-mq: manage hctx map via xarray
Date:   Mon, 28 Feb 2022 17:04:30 +0800
Message-Id: <20220228090430.1064267-7-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Firstly code becomes more clean by switching to xarray from plain array.

Secondly use-after-free on q->queue_hw_ctx can be fixed because
queue_for_each_hw_ctx() may be run when updating nr_hw_queues is
in-progress. With this patch, q->hctx_table is defined as xarray, and
this structure will share same lifetime with request queue, so
queue_for_each_hw_ctx() can use q->hctx_table to lookup hctx reliably.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 48 +++++++++++++++++-------------------------
 include/linux/blk-mq.h |  4 ++--
 include/linux/blkdev.h |  2 +-
 4 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0fd409b8e86e..eb33667d63b2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -498,7 +498,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	/*
-	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
+	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
 	 * racing with it.
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d01c1693a3d4..273137dc3ffd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3437,6 +3437,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 
 	blk_mq_remove_cpuhp(hctx);
 
+	xa_erase(&q->hctx_table, hctx_idx);
+
 	spin_lock(&q->unused_hctx_lock);
 	list_add(&hctx->hctx_list, &q->unused_hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
@@ -3476,8 +3478,15 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
 				hctx->numa_node))
 		goto exit_hctx;
+
+	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
+		goto exit_flush_rq;
+
 	return 0;
 
+ exit_flush_rq:
+	if (set->ops->exit_request)
+		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -3855,7 +3864,7 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	kfree(q->queue_hw_ctx);
+	xa_destroy(&q->hctx_table);
 
 	/*
 	 * release .mq_kobj and sw queue's kobject now because
@@ -3945,45 +3954,26 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
 	int i, j, end;
-	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
-
-	if (q->nr_hw_queues < set->nr_hw_queues) {
-		struct blk_mq_hw_ctx **new_hctxs;
-
-		new_hctxs = kcalloc_node(set->nr_hw_queues,
-				       sizeof(*new_hctxs), GFP_KERNEL,
-				       set->numa_node);
-		if (!new_hctxs)
-			return;
-		if (hctxs)
-			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
-			       sizeof(*hctxs));
-		q->queue_hw_ctx = new_hctxs;
-		kfree(hctxs);
-		hctxs = new_hctxs;
-	}
 
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
-		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
+		struct blk_mq_hw_ctx *old_hctx = blk_mq_get_hctx(q, i);
 
 		if (old_hctx) {
 			old_node = old_hctx->numa_node;
 			blk_mq_exit_hctx(q, set, old_hctx, i);
 		}
 
-		hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i, node);
-		if (!hctxs[i]) {
+		if (!blk_mq_alloc_and_init_hctx(set, q, i, node)) {
 			if (!old_hctx)
 				break;
 			pr_warn("Allocate new hctx on node %d fails, fallback to previous one on node %d\n",
 					node, old_node);
-			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
-					old_node);
-			WARN_ON_ONCE(!hctxs[i]);
+			WARN_ON_ONCE(!blk_mq_alloc_and_init_hctx(set, q, i,
+						old_node));
 		}
 	}
 	/*
@@ -4000,12 +3990,10 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 
 	for (; j < end; j++) {
-		struct blk_mq_hw_ctx *hctx = hctxs[j];
+		struct blk_mq_hw_ctx *hctx = blk_mq_get_hctx(q, j);
 
-		if (hctx) {
+		if (hctx)
 			blk_mq_exit_hctx(q, set, hctx, j);
-			hctxs[j] = NULL;
-		}
 	}
 	mutex_unlock(&q->sysfs_lock);
 }
@@ -4045,6 +4033,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->unused_hctx_list);
 	spin_lock_init(&q->unused_hctx_lock);
 
+	xa_init(&q->hctx_table);
+
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
@@ -4074,7 +4064,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return 0;
 
 err_hctxs:
-	kfree(q->queue_hw_ctx);
+	xa_destroy(&q->hctx_table);
 	q->nr_hw_queues = 0;
 	blk_mq_sysfs_deinit(q);
 err_poll:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3d949b1968f3..b102ff64e56a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -919,12 +919,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 static inline struct blk_mq_hw_ctx *blk_mq_get_hctx(struct request_queue *q,
 		unsigned int hctx_idx)
 {
-	return q->queue_hw_ctx[hctx_idx];
+	return xa_load(&q->hctx_table, hctx_idx);
 }
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = blk_mq_get_hctx((q), (i)); 1; }); (i)++)
+	     (hctx = blk_mq_get_hctx((q), (i))); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f757f9c2871f..a53ae40aaded 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -355,7 +355,7 @@ struct request_queue {
 	unsigned int		queue_depth;
 
 	/* hw dispatch queues */
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct xarray		hctx_table;
 	unsigned int		nr_hw_queues;
 
 	/*
-- 
2.31.1

