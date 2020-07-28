Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249FCC433EA
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABD2206D4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA4G7dYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgG1NuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:50:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56193 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730018AbgG1NuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 09:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595944202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ka8lPsumPjqh07xwEZlW6I1tixWVMDmfz5WN8IM8vso=;
        b=RA4G7dYG5PUOFtxtYslPzPmuvZt8UFW87tqG2bbhmagLM9QGZCA5gT3qdnHDvY7/90QtgW
        aFLdm/MxXdbtxyMf30DNp0saa3tZ+F5DuF9AJvU5FkeUSJqVa2BJ1l8MO2ccf0xsbJ9rnY
        6ALgwqBv2Lh/P+ickFrktHmixEhDL+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-fgziwSPjOjGWbPBO0C138Q-1; Tue, 28 Jul 2020 09:49:58 -0400
X-MC-Unique: fgziwSPjOjGWbPBO0C138Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA555800477;
        Tue, 28 Jul 2020 13:49:56 +0000 (UTC)
Received: from localhost (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC2A519D7C;
        Tue, 28 Jul 2020 13:49:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Tue, 28 Jul 2020 21:49:38 +0800
Message-Id: <20200728134938.1505467-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
section during dispatching request, then request queue quiesce is based on
SRCU. What we want to get is low cost added in fast path.

However, from srcu_read_lock/srcu_read_unlock implementation, not see
it is quicker than percpu refcount, so use percpu_ref to implement
queue quiesce. This usage is cleaner and simpler & enough for implementing
queue quiesce. The main requirement is to make sure all read sections to observe
QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.

Also it becomes much easier to add interface of async queue quiesce.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c   |  2 -
 block/blk-mq.c         | 94 +++++++++++++++++++-----------------------
 block/blk-sysfs.c      |  6 ++-
 include/linux/blk-mq.h |  7 ----
 include/linux/blkdev.h |  4 ++
 5 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 062229395a50..799db7937105 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -38,8 +38,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 
 	cancel_delayed_work_sync(&hctx->run_work);
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
 	free_cpumask_var(hctx->cpumask);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3856377b961..ea75d8e005be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -220,19 +220,13 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-	bool rcu = false;
-
 	blk_mq_quiesce_queue_nowait(q);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(hctx->srcu);
-		else
-			rcu = true;
-	}
-	if (rcu)
+	if (q->tag_set->flags & BLK_MQ_F_BLOCKING) {
+		percpu_ref_kill(&q->dispatch_counter);
+		wait_event(q->mq_quiesce_wq,
+				percpu_ref_is_zero(&q->dispatch_counter));
+	} else
 		synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
@@ -248,6 +242,9 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 {
 	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 
+	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
+		percpu_ref_resurrect(&q->dispatch_counter);
+
 	/* dispatch requests which are inserted during quiescing */
 	blk_mq_run_hw_queues(q, true);
 }
@@ -699,24 +696,20 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
-	__releases(hctx->srcu)
+static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
 {
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
 		rcu_read_unlock();
 	else
-		srcu_read_unlock(hctx->srcu, srcu_idx);
+		percpu_ref_put(&hctx->queue->dispatch_counter);
 }
 
-static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
-	__acquires(hctx->srcu)
+static void hctx_lock(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		/* shut up gcc false positive */
-		*srcu_idx = 0;
+	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
 		rcu_read_lock();
-	} else
-		*srcu_idx = srcu_read_lock(hctx->srcu);
+	else
+		percpu_ref_get(&hctx->queue->dispatch_counter);
 }
 
 /**
@@ -1486,8 +1479,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
  */
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	int srcu_idx;
-
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
@@ -1521,9 +1512,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
+	hctx_lock(hctx);
 	blk_mq_sched_dispatch_requests(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 }
 
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
@@ -1635,7 +1626,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
  */
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	int srcu_idx;
 	bool need_run;
 
 	/*
@@ -1646,10 +1636,10 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	hctx_lock(hctx, &srcu_idx);
+	hctx_lock(hctx);
 	need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 
 	if (need_run)
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
@@ -2035,11 +2025,10 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
 	blk_status_t ret;
-	int srcu_idx;
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
+	hctx_lock(hctx);
 
 	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
@@ -2047,19 +2036,18 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	else if (ret != BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
 
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
-	int srcu_idx;
 	blk_qc_t unused_cookie;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	hctx_lock(hctx, &srcu_idx);
+	hctx_lock(hctx);
 	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 
 	return ret;
 }
@@ -2590,20 +2578,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
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
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
@@ -2641,7 +2615,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx *hctx;
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
+	hctx = kzalloc_node(sizeof(struct blk_mq_hw_ctx), gfp, node);
 	if (!hctx)
 		goto fail_alloc_hctx;
 
@@ -2683,8 +2657,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!hctx->fq)
 		goto free_bitmap;
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(hctx->srcu);
 	blk_mq_hctx_kobj_init(hctx);
 
 	return hctx;
@@ -3161,6 +3133,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
+static void blk_mq_dispatch_counter_release(struct percpu_ref *ref)
+{
+	struct request_queue *q = container_of(ref, struct request_queue,
+				dispatch_counter);
+	wake_up_all(&q->mq_quiesce_wq);
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q,
 						  bool elevator_init)
@@ -3177,6 +3156,14 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_ctxs(q))
 		goto err_poll;
 
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		init_waitqueue_head(&q->mq_quiesce_wq);
+		if (percpu_ref_init(&q->dispatch_counter,
+					blk_mq_dispatch_counter_release,
+					PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+			goto err_hctxs;
+	}
+
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
@@ -3185,7 +3172,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
-		goto err_hctxs;
+		goto err_dispatch_counter;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
@@ -3219,6 +3206,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	return q;
 
+err_dispatch_counter:
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		percpu_ref_exit(&q->dispatch_counter);
 err_hctxs:
 	kfree(q->queue_hw_ctx);
 	q->nr_hw_queues = 0;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index be67952e7be2..8f22de582874 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -914,9 +914,13 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_queue_free_zone_bitmaps(q);
 
-	if (queue_is_mq(q))
+	if (queue_is_mq(q)) {
 		blk_mq_release(q);
 
+		if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
+			percpu_ref_exit(&q->dispatch_counter);
+	}
+
 	blk_trace_shutdown(q);
 	mutex_lock(&q->debugfs_mutex);
 	debugfs_remove_recursive(q->debugfs_dir);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..70e64e87586c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -169,13 +169,6 @@ struct blk_mq_hw_ctx {
 	 * q->unused_hctx_list.
 	 */
 	struct list_head	hctx_list;
-
-	/**
-	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
-	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
-	 * blk_mq_hw_ctx_size().
-	 */
-	struct srcu_struct	srcu[];
 };
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 06995b96e946..32d6e194e6eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -567,6 +567,10 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
+	/* only used for BLK_MQ_F_BLOCKING */
+	struct percpu_ref	dispatch_counter;
+	wait_queue_head_t	mq_quiesce_wq;
+
 	struct dentry		*debugfs_dir;
 
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.25.2

