Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA38C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiJTK47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJTK4t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 06:56:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECD1E0442
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=su8dk78VeWnwMgA5jO3ORUbOIIe7lsqjYjFr53M1vhU=; b=GsrUez3BzX5gj9N6oE7c3ZBlFw
        F+Zfx4JEzUQ4Z/ayGFfVcteWclRdn6w4by0BQymUQ/CwE5IACnsEZXpvTcoxEtMW+ChWu6MDlMjWM
        UK6dBZ4RgGYK/sfrlGvjwj5y8HQ45keNssHrx9OPn/gL0ZSrQbw0nb2D2+91HzMMX3VJmNX3d0SBp
        wwXN7d0s9CJIBO8ZIc73AsxM2w6XzheLdrYFnakssqBlecokzGu3YotvR55kUkgDwqTp3Nz2fI2is
        mhFORr8ZNnzR3cenNGZEKkfVIbWIMJmiKyjVYS9k41CB1qcy/OIBx/C89PGJ6UDXIe2r0NMf5HG5F
        tso8WnRA==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTDx-00Dqh7-J9; Thu, 20 Oct 2022 10:56:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to the tagset
Date:   Thu, 20 Oct 2022 12:56:03 +0200
Message-Id: <20221020105608.1581940-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All I/O submissions have fairly similar latencies, and a tagset-wide
quiesce is a fairly common operation.  Becuase there are a lot less
tagsets there is also no need for the variable size allocation trick.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 27 +++++----------------------
 block/blk-mq.c         | 25 +++++++++++++++++--------
 block/blk-mq.h         | 14 +++++++-------
 block/blk-sysfs.c      |  9 ++-------
 block/blk.h            |  9 +--------
 block/genhd.c          |  2 +-
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  9 ---------
 8 files changed, 37 insertions(+), 62 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e0..3a2ed8dadf738 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -65,7 +65,6 @@ DEFINE_IDA(blk_queue_ida);
  * For queue allocation
  */
 struct kmem_cache *blk_requestq_cachep;
-struct kmem_cache *blk_requestq_srcu_cachep;
 
 /*
  * Controlling structure to kblockd
@@ -373,26 +372,20 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
+struct request_queue *blk_alloc_queue(int node_id)
 {
 	struct request_queue *q;
 
-	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
-			GFP_KERNEL | __GFP_ZERO, node_id);
+	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
+				  node_id);
 	if (!q)
 		return NULL;
 
-	if (alloc_srcu) {
-		blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
-		if (init_srcu_struct(q->srcu) != 0)
-			goto fail_q;
-	}
-
 	q->last_merge = NULL;
 
 	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
 	if (q->id < 0)
-		goto fail_srcu;
+		goto fail_q;
 
 	q->stats = blk_alloc_queue_stats();
 	if (!q->stats)
@@ -435,11 +428,8 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	blk_free_queue_stats(q->stats);
 fail_id:
 	ida_free(&blk_queue_ida, q->id);
-fail_srcu:
-	if (alloc_srcu)
-		cleanup_srcu_struct(q->srcu);
 fail_q:
-	kmem_cache_free(blk_get_queue_kmem_cache(alloc_srcu), q);
+	kmem_cache_free(blk_requestq_cachep, q);
 	return NULL;
 }
 
@@ -1184,9 +1174,6 @@ int __init blk_dev_init(void)
 			sizeof_field(struct request, cmd_flags));
 	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
 			sizeof_field(struct bio, bi_opf));
-	BUILD_BUG_ON(ALIGN(offsetof(struct request_queue, srcu),
-			   __alignof__(struct request_queue)) !=
-		     sizeof(struct request_queue));
 
 	/* used for unplugging and affects IO latency/throughput - HIGHPRI */
 	kblockd_workqueue = alloc_workqueue("kblockd",
@@ -1197,10 +1184,6 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
-	blk_requestq_srcu_cachep = kmem_cache_create("request_queue_srcu",
-			sizeof(struct request_queue) +
-			sizeof(struct srcu_struct), 0, SLAB_PANIC, NULL);
-
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 
 	return 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df967c8af9fee..4a81a2da43328 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
  */
 void blk_mq_wait_quiesce_done(struct request_queue *q)
 {
-	if (blk_queue_has_srcu(q))
-		synchronize_srcu(q->srcu);
+	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
+		synchronize_srcu(&q->tag_set->srcu);
 	else
 		synchronize_rcu();
 }
@@ -3971,7 +3971,7 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node, set->flags & BLK_MQ_F_BLOCKING);
+	q = blk_alloc_queue(set->numa_node);
 	if (!q)
 		return ERR_PTR(-ENOMEM);
 	q->queuedata = queuedata;
@@ -4138,9 +4138,6 @@ static void blk_mq_update_poll_flag(struct request_queue *q)
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q)
 {
-	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
-			!!(set->flags & BLK_MQ_F_BLOCKING));
-
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -4398,9 +4395,16 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	 */
 	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
+ 
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		ret = init_srcu_struct(&set->srcu);
+		if (ret)
+			return ret;
+	}
 
-	if (blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues) < 0)
-		return -ENOMEM;
+	ret = blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues);
+	if (ret)
+		goto out_free_srcu;
 
 	ret = -ENOMEM;
 	for (i = 0; i < set->nr_maps; i++) {
@@ -4430,6 +4434,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	}
 	kfree(set->tags);
 	set->tags = NULL;
+out_free_srcu:
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		cleanup_srcu_struct(&set->srcu);
 	return ret;
 }
 EXPORT_SYMBOL(blk_mq_alloc_tag_set);
@@ -4469,6 +4476,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 
 	kfree(set->tags);
 	set->tags = NULL;
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		cleanup_srcu_struct(&set->srcu);
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0b2870839cdd6..06eb46d1d7a76 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -377,17 +377,17 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
-	if (!blk_queue_has_srcu(q)) {				\
-		rcu_read_lock();				\
-		(dispatch_ops);					\
-		rcu_read_unlock();				\
-	} else {						\
+	if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {		\
 		int srcu_idx;					\
 								\
 		might_sleep_if(check_sleep);			\
-		srcu_idx = srcu_read_lock((q)->srcu);		\
+		srcu_idx = srcu_read_lock(&((q)->tag_set->srcu)); \
 		(dispatch_ops);					\
-		srcu_read_unlock((q)->srcu, srcu_idx);		\
+		srcu_read_unlock(&((q)->tag_set->srcu), srcu_idx); \
+	} else {						\
+		rcu_read_lock();				\
+		(dispatch_ops);					\
+		rcu_read_unlock();				\
 	}							\
 } while (0)
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c0..e7871665825a3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -739,10 +739,8 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
-	struct request_queue *q = container_of(rcu_head, struct request_queue,
-					       rcu_head);
-
-	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
+	kmem_cache_free(blk_requestq_cachep,
+			container_of(rcu_head, struct request_queue, rcu_head));
 }
 
 /**
@@ -779,9 +777,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	if (blk_queue_has_srcu(q))
-		cleanup_srcu_struct(q->srcu);
-
 	ida_free(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
diff --git a/block/blk.h b/block/blk.h
index 5350bf363035e..b25e2d22f3725 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -27,7 +27,6 @@ struct blk_flush_queue {
 };
 
 extern struct kmem_cache *blk_requestq_cachep;
-extern struct kmem_cache *blk_requestq_srcu_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
@@ -420,13 +419,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
-static inline struct kmem_cache *blk_get_queue_kmem_cache(bool srcu)
-{
-	if (srcu)
-		return blk_requestq_srcu_cachep;
-	return blk_requestq_cachep;
-}
-struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu);
+struct request_queue *blk_alloc_queue(int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
 
diff --git a/block/genhd.c b/block/genhd.c
index 2877b5f905579..fd0b13d6175a3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1410,7 +1410,7 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node, false);
+	q = blk_alloc_queue(node);
 	if (!q)
 		return NULL;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799b..f040a7cab5dbf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -7,6 +7,7 @@
 #include <linux/lockdep.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
+#include <linux/srcu.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -501,6 +502,8 @@ enum hctx_type {
  * @tag_list_lock: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
+ * @srcu:	   Use as lock when type of the request queue is blocking
+ *		   (BLK_MQ_F_BLOCKING). Must be the last member
  */
 struct blk_mq_tag_set {
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
@@ -521,6 +524,7 @@ struct blk_mq_tag_set {
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+	struct srcu_struct	srcu;
 };
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d986..b15b6a011c028 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -22,7 +22,6 @@
 #include <linux/blkzoned.h>
 #include <linux/sched.h>
 #include <linux/sbitmap.h>
-#include <linux/srcu.h>
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 
@@ -543,18 +542,11 @@ struct request_queue {
 	struct mutex		debugfs_mutex;
 
 	bool			mq_sysfs_init_done;
-
-	/**
-	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
-	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member
-	 */
-	struct srcu_struct	srcu[];
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
-#define QUEUE_FLAG_HAS_SRCU	2	/* SRCU is allocated */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
@@ -590,7 +582,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
-#define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
-- 
2.30.2

