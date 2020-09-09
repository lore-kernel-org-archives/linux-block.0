Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6726C43461
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367E021D79
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEtT3A17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:42:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20200 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728363AbgIIKlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 06:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599648102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kefNDPb7yMymZ9RssYpo2CUBiok99oLdjp0+hiUvLc4=;
        b=AEtT3A17ZTPakzRDh+3+kV6S9hsBd7OzAHP3tZFVOJ5QECUFitpELS40dS2krFqsHfxcgQ
        3h29ngDx9I7605eLXuieoOz4iJTY2I9FciM9NdgMQSFlQLihZ3CTebm4tZ5thDrv9jklTX
        cMhwH5DkprkduESOuRcheggWyF6sEUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-dOhbhGkeP1yFecYemcknRQ-1; Wed, 09 Sep 2020 06:41:41 -0400
X-MC-Unique: dOhbhGkeP1yFecYemcknRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48A31017DC6;
        Wed,  9 Sep 2020 10:41:39 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C13A7E8D8;
        Wed,  9 Sep 2020 10:41:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
Date:   Wed,  9 Sep 2020 18:41:14 +0800
Message-Id: <20200909104116.1674592-3-ming.lei@redhat.com>
In-Reply-To: <20200909104116.1674592-1-ming.lei@redhat.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
section during dispatching request, then request queue quiesce is based on
SRCU. What we want to get is low cost added in fast path.

With percpu-ref, it is cleaner and simpler & enough for implementing queue
quiesce. The main requirement is to make sure all read sections to observe
QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.

Also it becomes much easier to add interface of async queue quiesce.

Meantime memory footprint can be reduced with per-request-queue percpu-ref.

From implementation viewpoint, in fast path, not see percpu_ref is
slower than SRCU, and srcu tree(default option in most distributions)
could be slower since memory barrier is required in both lock & unlock,
and rcu_read_lock()/rcu_read_unlock() should be much cheap than
smp_mb().

1) percpu_ref just hold the rcu_read_lock, then run a check &
   increase/decrease on the percpu variable:

   rcu_read_lock()
   if (__ref_is_percpu(ref, &percpu_count))
	this_cpu_inc(*percpu_count);
   rcu_read_unlock()

2) srcu tree:
        idx = READ_ONCE(ssp->srcu_idx) & 0x1;
        this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
        smp_mb(); /* B */  /* Avoid leaking the critical section. */

Also from my test on null_blk(blocking), not observe percpu-ref performs
worse than srcu, see the following test:

1) test steps:

rmmod null_blk > /dev/null 2>&1
modprobe null_blk nr_devices=1 submit_queues=1 blocking=1
fio --bs=4k --size=512G  --rw=randread --norandommap --direct=1 --ioengine=libaio \
	--iodepth=64 --runtime=60 --group_reporting=1  --name=nullb0 \
	--filename=/dev/nullb0 --numjobs=32

test machine: HP DL380, 16 cpu cores, 2 threads per core, dual
sockets/numa, Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz

2) test result:
- srcu quiesce: 6063K IOPS
- percpu-ref quiesce: 6113K IOPS

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-sysfs.c   |   2 -
 block/blk-mq.c         | 121 +++++++++++++++++++++--------------------
 block/blk-sysfs.c      |   6 +-
 include/linux/blk-mq.h |   8 ---
 include/linux/blkdev.h |   4 ++
 5 files changed, 72 insertions(+), 69 deletions(-)

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
index efd17a80fcdf..37263ed48a8a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -225,19 +225,16 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-	bool rcu = false;
+	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
+	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
 
-	__blk_mq_quiesce_queue_nowait(q);
+	if (!was_quiesced && blocking)
+		percpu_ref_kill(&q->dispatch_counter);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(hctx->srcu);
-		else
-			rcu = true;
-	}
-	if (rcu)
+	if (blocking)
+		wait_event(q->mq_quiesce_wq,
+				percpu_ref_is_zero(&q->dispatch_counter));
+	else
 		synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
@@ -251,7 +248,10 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q);
+	if (blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q)) {
+		if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
+			percpu_ref_resurrect(&q->dispatch_counter);
+	}
 
 	/* dispatch requests which are inserted during quiescing */
 	blk_mq_run_hw_queues(q, true);
@@ -704,24 +704,21 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
-	__releases(hctx->srcu)
+static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-		rcu_read_unlock();
+	if (hctx->flags & BLK_MQ_F_BLOCKING)
+		percpu_ref_put(&hctx->queue->dispatch_counter);
 	else
-		srcu_read_unlock(hctx->srcu, srcu_idx);
+		rcu_read_unlock();
 }
 
-static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
-	__acquires(hctx->srcu)
+/* Returning false means that queue is being quiesced */
+static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
 {
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		/* shut up gcc false positive */
-		*srcu_idx = 0;
-		rcu_read_lock();
-	} else
-		*srcu_idx = srcu_read_lock(hctx->srcu);
+	if (hctx->flags & BLK_MQ_F_BLOCKING)
+		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
+	rcu_read_lock();
+	return true;
 }
 
 /**
@@ -1500,8 +1497,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
  */
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	int srcu_idx;
-
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
@@ -1535,9 +1530,10 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
-	blk_mq_sched_dispatch_requests(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	if (hctx_lock(hctx)) {
+		blk_mq_sched_dispatch_requests(hctx);
+		hctx_unlock(hctx);
+	}
 }
 
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
@@ -1649,7 +1645,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
  */
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	int srcu_idx;
 	bool need_run;
 
 	/*
@@ -1660,10 +1655,12 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	hctx_lock(hctx, &srcu_idx);
+	if (!hctx_lock(hctx))
+		return;
+
 	need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 
 	if (need_run)
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
@@ -2003,7 +2000,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	bool run_queue = true;
 
 	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
+	 * hctx_lock() is needed before checking quiesced flag.
 	 *
 	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
 	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
@@ -2051,11 +2048,14 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
 	blk_status_t ret;
-	int srcu_idx;
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
+	/* Insert request to queue in case of being quiesced */
+	if (!hctx_lock(hctx)) {
+		blk_mq_sched_insert_request(rq, false, false, false);
+		return;
+	}
 
 	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
@@ -2063,19 +2063,22 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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
+	/* Insert request to queue in case of being quiesced */
+	if (!hctx_lock(hctx)) {
+		blk_mq_sched_insert_request(rq, false, false, false);
+		return BLK_STS_OK;
+	}
 	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
-	hctx_unlock(hctx, srcu_idx);
+	hctx_unlock(hctx);
 
 	return ret;
 }
@@ -2606,20 +2609,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
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
@@ -2657,7 +2646,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx *hctx;
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
+	hctx = kzalloc_node(sizeof(struct blk_mq_hw_ctx), gfp, node);
 	if (!hctx)
 		goto fail_alloc_hctx;
 
@@ -2700,8 +2689,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!hctx->fq)
 		goto free_bitmap;
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(hctx->srcu);
 	blk_mq_hctx_kobj_init(hctx);
 
 	return hctx;
@@ -3181,6 +3168,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
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
@@ -3197,6 +3191,14 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
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
 
@@ -3205,7 +3207,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
-		goto err_hctxs;
+		goto err_dispatch_counter;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
@@ -3239,6 +3241,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	return q;
 
+err_dispatch_counter:
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		percpu_ref_exit(&q->dispatch_counter);
 err_hctxs:
 	kfree(q->queue_hw_ctx);
 	q->nr_hw_queues = 0;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..56b6c045e30c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -941,9 +941,13 @@ static void blk_release_queue(struct kobject *kobj)
 
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
index b23eeca4d677..df642055f02c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -4,7 +4,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
-#include <linux/srcu.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -173,13 +172,6 @@ struct blk_mq_hw_ctx {
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
index 7b1e53084799..de8b51bd402b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -572,6 +572,10 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	/* only used for BLK_MQ_F_BLOCKING */
+	struct percpu_ref	dispatch_counter;
+	wait_queue_head_t	mq_quiesce_wq;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.25.2

