Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CC75817
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404868; cv=none; b=KLx+6EkIQxYPZTkWZnw/s7VKuQwKPMhu2W1HFwnJCnWUbcg2PZeWcKuSQBM/hD4ad51A8RcA5V5OBmB+6BB/9AWkPxXM3V33LRnRlbGyvzr1/nlpHXM7BPhG8Zqpl+QeMgGZpcvLQHT1UBF16MXDDM8v4uf7CwnSUl6+ZWBu3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404868; c=relaxed/simple;
	bh=skSFpPbhU/S8v2RyvuPARushukrPzA+Ar8CDzdkr/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUmkwhNNla9wL64QL36+omQv9viXhKlDG2aeBXGFOuC1fws52kZgV+3Pn779+RgrgbOu0P6S4ajfxoeOXmJizMEYtb8/zD4y2JwE2PmL8ych47aCiRr3b4SNdhQmk1m2iSrcgGVHtERvTSpFNF/ds0co8GZBeUAE1c9C0NVOG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3336152b3a.1
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 15:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404866; x=1712009666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGK8KEjQPqMMD51Q6erQjJ4SrmfcpMd4c4lhy8sXFFU=;
        b=Wrxo1rIwuOcriBLgKx5i3HzTWYa9BaKU3BkTdERI74NO5EKLV6sPnp5iT130burwUk
         GEMCZmYsiGPeJUHhguN48Uv0bPgJlWhxZu/4w82ivtFWl9ZjXETL/Tka9duzzcVwzqh/
         jvVDZjIDflFucET780UxH1yHcUY7dvdoeQrkaUDnLVMSomlD1eHZqgpxvbQ4zZd9LJBU
         Nti73EmZqq68AXLVQKc7O/qXb5Lkv6RwyM32FjlaIY4T4w9dKZwujb1NtGR+Zv6LdegB
         Lx2VLECr7z+JanCtqFo1YzMGH/1yKiL4n2rCyK31yL8r+WzlIyc5jHMeZYrdoBrGC0SW
         Hgkg==
X-Gm-Message-State: AOJu0Ywf1mKJ6omSmVjno9ON+JUGue4Ru/ApOqCpI/CuMraaCwrhFos3
	cFB1Zq7A7nCHtwthTerzWt8A1L3YPqJ4QoK8MHCZeX1QKryPA/OP
X-Google-Smtp-Source: AGHT+IGb9lNXTAcLd1eK52zEGoPPtHmBOtPuNgbrklCnOGL+FIIu/LRq55MU1k8vky5gOkyvW1YJSw==
X-Received: by 2002:a05:6a00:398f:b0:6e6:2dc9:dcbc with SMTP id fi15-20020a056a00398f00b006e62dc9dcbcmr10431616pfb.10.1711404866230;
        Mon, 25 Mar 2024 15:14:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:262:e41e:a4dd:81c6])
        by smtp.gmail.com with ESMTPSA id a6-20020a637f06000000b005dc491ccdcesm6173291pgd.14.2024.03.25.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:14:25 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2] block: Improve IOPS by removing the fairness code
Date: Mon, 25 Mar 2024 15:14:19 -0700
Message-ID: <20240325221420.1468801-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an algorithm in the block layer for maintaining fairness
across queues that share a tag set. The sbitmap implementation has
improved so much that we don't need the block layer fairness algorithm
anymore and that we can rely on the sbitmap implementation to guarantee
fairness.

This patch removes the following code and structure members:
- The function hctx_may_queue().
- blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tags
  and also all the code that modifies these two member variables.

On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% more
IOPS. IOPS have been measured as follows:

$ modprobe null_blk nr_devices=1 completion_nsec=0
$ fio --bs=4096 --disable_clat=1 --disable_slat=1 --group_reporting=1 \
      --gtod_reduce=1 --invalidate=1 --ioengine=psync --ioscheduler=none \
      --norandommap --runtime=60 --rw=randread --thread --time_based=1 \
      --buffered=0 --numjobs=64 --name=/dev/nullb0 --filename=/dev/nullb0

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared with v1: changed a blk_mq_tagset_busy_iter() call into a
  blk_mq_all_tag_iter() call in the debugfs code to preserve the current
  semantics of the 'active' attribute.

 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |  22 ++++++++-
 block/blk-mq-tag.c     |   4 --
 block/blk-mq.c         |  17 +------
 block/blk-mq.h         | 100 -----------------------------------------
 include/linux/blk-mq.h |   6 ---
 include/linux/blkdev.h |   2 -
 7 files changed, 22 insertions(+), 131 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..57dfa4612b43 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -425,8 +425,6 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->nr_active_requests_shared_tags, 0);
-
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..8e0c7774d6ec 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -479,11 +479,31 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	return res;
 }
 
+struct count_active_params {
+	struct blk_mq_hw_ctx	*hctx;
+	int			*active;
+};
+
+static bool hctx_count_active(struct request *rq, void *data)
+{
+	const struct count_active_params *params = data;
+
+	if (rq->mq_hctx == params->hctx)
+		(*params->active)++;
+
+	return true;
+}
+
 static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
+	int active = 0;
+	struct count_active_params params = { .hctx = hctx, .active = &active };
+
+	blk_mq_all_tag_iter(hctx->sched_tags ?: hctx->tags, hctx_count_active,
+			    &params);
 
-	seq_printf(m, "%d\n", __blk_mq_active_requests(hctx));
+	seq_printf(m, "%d\n", active);
 	return 0;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..25334bfcabf8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -105,10 +105,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
-			!hctx_may_queue(data->hctx, bt))
-		return BLK_MQ_NO_TAG;
-
 	if (data->shallow_depth)
 		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..46c1252a38da 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -424,8 +424,6 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 		rq_list_add(data->cached_rq, rq);
 		nr++;
 	}
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_add_active_requests(data->hctx, nr);
 	/* caller already holds a reference, add for remainder */
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -= nr;
@@ -510,8 +508,6 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
-	if (!(data->rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data->hctx);
 	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	return rq;
@@ -671,8 +667,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	if (!(data.rq_flags & RQF_SCHED_TAGS))
-		blk_mq_inc_active_requests(data.hctx);
 	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len = 0;
@@ -712,10 +706,8 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 
-	if (rq->tag != BLK_MQ_NO_TAG) {
-		blk_mq_dec_active_requests(hctx);
+	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
@@ -1069,8 +1061,6 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 
-	blk_mq_sub_active_requests(hctx, nr_tags);
-
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
 }
@@ -1765,9 +1755,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
 
 	tag = __sbitmap_queue_get(bt);
@@ -1775,7 +1762,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 		return false;
 
 	rq->tag = tag + tag_offset;
-	blk_mq_inc_active_requests(rq->mq_hctx);
 	return true;
 }
 
@@ -3708,7 +3694,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
 
-	atomic_set(&hctx->nr_active, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..ac29a30e4322 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -271,70 +271,9 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 	return -1;
 }
 
-static inline void __blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
-						int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_add(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_add(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	__blk_mq_add_active_requests(hctx, 1);
-}
-
-static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
-		int val)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_sub(val, &hctx->nr_active);
-}
-
-static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	__blk_mq_sub_active_requests(hctx, 1);
-}
-
-static inline void blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_add_active_requests(hctx, val);
-}
-
-static inline void blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_inc_active_requests(hctx);
-}
-
-static inline void blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
-					      int val)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_sub_active_requests(hctx, val);
-}
-
-static inline void blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_dec_active_requests(hctx);
-}
-
-static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
-{
-	if (blk_mq_is_shared_tags(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
-	return atomic_read(&hctx->nr_active);
-}
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_dec_active_requests(hctx);
 	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = BLK_MQ_NO_TAG;
 }
@@ -407,45 +346,6 @@ static inline void blk_mq_free_requests(struct list_head *list)
 	}
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
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return true;
-
-	/*
-	 * Don't try dividing an ant
-	 */
-	if (bt->sb.depth == 1)
-		return true;
-
-	if (blk_mq_is_shared_tags(hctx->flags)) {
-		struct request_queue *q = hctx->queue;
-
-		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
-			return true;
-	} else {
-		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-			return true;
-	}
-
-	users = READ_ONCE(hctx->tags->active_queues);
-	if (!users)
-		return true;
-
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return __blk_mq_active_requests(hctx) < depth;
-}
-
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d3d8fd8e229b..a066ea77148f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -398,12 +398,6 @@ struct blk_mq_hw_ctx {
 	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
 
-	/**
-	 * @nr_active: Number of active requests. Only used when a tag set is
-	 * shared across request queues.
-	 */
-	atomic_t		nr_active;
-
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab0..9b1d2eb3eb6b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -445,8 +445,6 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
-
 	unsigned int		required_elevator_features;
 
 	struct blk_mq_tags	*sched_shared_tags;
