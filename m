Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EECEC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhLCNTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:19:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352195AbhLCNTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638537359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+sPeXr31AzS1K7NbqBb8me02q1ZzeZGF6wX/JdI1g0=;
        b=it4/+0z80/hfPg/N3dz8YKATW/0lkFD7HGmU2WKF3pVjle4WNkHsnDAEJt3CzBwqkiE5yH
        yjuMmzY0EqH0AIzMwY6LVT7Pf3ZAEGNU4w7YPikp2VMAAKbcDnNh23mNkncQfq0tNTN7U4
        otENZL4TFrPTizmxVXiteyxuoLyEqj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-337-o1L0c5CCNvijnwXXxcqR2w-1; Fri, 03 Dec 2021 08:15:56 -0500
X-MC-Unique: o1L0c5CCNvijnwXXxcqR2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA17E1023F5A;
        Fri,  3 Dec 2021 13:15:55 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C152E19D9F;
        Fri,  3 Dec 2021 13:15:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
Date:   Fri,  3 Dec 2021 21:15:32 +0800
Message-Id: <20211203131534.3668411-3-ming.lei@redhat.com>
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of BLK_MQ_F_BLOCKING, per-hctx srcu is used to protect dispatch
critical area. However, this srcu instance stays at the end of hctx, and
it often takes standalone cacheline, often cold.

Inside srcu_read_lock() and srcu_read_unlock(), WRITE is always done on
the indirect percpu variable which is allocated from heap instead of
being embedded, srcu->srcu_idx is read only in srcu_read_lock(). It
doesn't matter if srcu structure stays in hctx or request queue.

So switch to per-request-queue srcu for protecting dispatch, and this
way simplifies quiesce a lot, not mention quiesce is always done on the
request queue wide.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 27 ++++++++++++++++++++++-----
 block/blk-mq-sysfs.c   |  2 --
 block/blk-mq.c         | 37 ++++++++-----------------------------
 block/blk-mq.h         |  4 ++--
 block/blk-sysfs.c      |  3 ++-
 block/blk.h            | 10 +++++++++-
 block/genhd.c          |  2 +-
 include/linux/blk-mq.h |  8 --------
 include/linux/blkdev.h |  9 +++++++++
 9 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b0660c9df852..10619fd83c1b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -66,6 +66,7 @@ DEFINE_IDA(blk_queue_ida);
  * For queue allocation
  */
 struct kmem_cache *blk_requestq_cachep;
+struct kmem_cache *blk_requestq_srcu_cachep;
 
 /*
  * Controlling structure to kblockd
@@ -437,21 +438,27 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
 	int ret;
 
-	q = kmem_cache_alloc_node(blk_requestq_cachep,
-				GFP_KERNEL | __GFP_ZERO, node_id);
+	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
+			GFP_KERNEL | __GFP_ZERO, node_id);
 	if (!q)
 		return NULL;
 
+	if (alloc_srcu) {
+		blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
+		if (init_srcu_struct(q->srcu) != 0)
+			goto fail_q;
+	}
+
 	q->last_merge = NULL;
 
 	q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
 	if (q->id < 0)
-		goto fail_q;
+		goto fail_srcu;
 
 	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
@@ -508,8 +515,11 @@ struct request_queue *blk_alloc_queue(int node_id)
 	bioset_exit(&q->bio_split);
 fail_id:
 	ida_simple_remove(&blk_queue_ida, q->id);
+fail_srcu:
+	if (alloc_srcu)
+		cleanup_srcu_struct(q->srcu);
 fail_q:
-	kmem_cache_free(blk_requestq_cachep, q);
+	kmem_cache_free(blk_get_queue_kmem_cache(alloc_srcu), q);
 	return NULL;
 }
 
@@ -1301,6 +1311,9 @@ int __init blk_dev_init(void)
 			sizeof_field(struct request, cmd_flags));
 	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
 			sizeof_field(struct bio, bi_opf));
+	BUILD_BUG_ON(ALIGN(offsetof(struct request_queue, srcu),
+			   __alignof__(struct request_queue)) !=
+		     sizeof(struct request_queue));
 
 	/* used for unplugging and affects IO latency/throughput - HIGHPRI */
 	kblockd_workqueue = alloc_workqueue("kblockd",
@@ -1311,6 +1324,10 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
+	blk_requestq_srcu_cachep = kmem_cache_create("request_queue_srcu",
+			sizeof(struct request_queue) +
+			sizeof(struct srcu_struct), 0, SLAB_PANIC, NULL);
+
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 
 	return 0;
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 253c857cba47..674786574075 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -36,8 +36,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
 	free_cpumask_var(hctx->cpumask);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9d69e1dea8b..2186971c683b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,17 +260,9 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
  */
 void blk_mq_wait_quiesce_done(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-	bool rcu = false;
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(hctx->srcu);
-		else
-			rcu = true;
-	}
-	if (rcu)
+	if (blk_queue_has_srcu(q))
+		synchronize_srcu(q->srcu);
+	else
 		synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
@@ -3400,20 +3392,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
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
@@ -3451,7 +3429,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx *hctx;
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 
-	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
+	hctx = kzalloc_node(sizeof(struct blk_mq_hw_ctx), gfp, node);
 	if (!hctx)
 		goto fail_alloc_hctx;
 
@@ -3493,8 +3471,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!hctx->fq)
 		goto free_bitmap;
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(hctx->srcu);
 	blk_mq_hctx_kobj_init(hctx);
 
 	return hctx;
@@ -3830,7 +3806,7 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
+	q = blk_alloc_queue(set->numa_node, set->flags & BLK_MQ_F_BLOCKING);
 	if (!q)
 		return ERR_PTR(-ENOMEM);
 	q->queuedata = queuedata;
@@ -3979,6 +3955,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q)
 {
+	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
+			!!(set->flags & BLK_MQ_F_BLOCKING));
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e4c396204928..792f0b29c6eb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -385,9 +385,9 @@ do {								\
 		int srcu_idx;					\
 								\
 		might_sleep();					\
-		srcu_idx = srcu_read_lock((hctx)->srcu);	\
+		srcu_idx = srcu_read_lock((hctx)->queue->srcu);	\
 		(dispatch_ops);					\
-		srcu_read_unlock((hctx)->srcu, srcu_idx);	\
+		srcu_read_unlock((hctx)->queue->srcu, srcu_idx); \
 	}							\
 } while (0)
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4622da4bb992..3e6357321225 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -735,7 +735,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
-	kmem_cache_free(blk_requestq_cachep, q);
+
+	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
 }
 
 /* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
diff --git a/block/blk.h b/block/blk.h
index a55d82c3d1c2..0114e18b9903 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -27,6 +27,7 @@ struct blk_flush_queue {
 };
 
 extern struct kmem_cache *blk_requestq_cachep;
+extern struct kmem_cache *blk_requestq_srcu_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
@@ -424,7 +425,14 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
-struct request_queue *blk_alloc_queue(int node_id);
+static inline struct kmem_cache *blk_get_queue_kmem_cache(bool srcu)
+{
+	if (srcu)
+		return blk_requestq_srcu_cachep;
+	return blk_requestq_cachep;
+}
+struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu);
+
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
 
 int disk_alloc_events(struct gendisk *disk);
diff --git a/block/genhd.c b/block/genhd.c
index 5179a4f00fba..3c139a1b6f04 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1338,7 +1338,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
+	q = blk_alloc_queue(node, false);
 	if (!q)
 		return NULL;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1b87b7c8bbff..bfc3cc61f653 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -4,7 +4,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
-#include <linux/srcu.h>
 #include <linux/lockdep.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
@@ -375,13 +374,6 @@ struct blk_mq_hw_ctx {
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
index 0a4416ef4fbf..c80cfaefc0a8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -16,6 +16,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/blkzoned.h>
 #include <linux/sbitmap.h>
+#include <linux/srcu.h>
 
 struct module;
 struct request_queue;
@@ -373,11 +374,18 @@ struct request_queue {
 	 * devices that do not have multiple independent access ranges.
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
+
+	/**
+	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
+	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member
+	 */
+	struct srcu_struct	srcu[];
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_HAS_SRCU	2	/* SRCU is allocated */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
@@ -415,6 +423,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
+#define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
 #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.31.1

