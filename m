Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] block: Dynamically allocate and refcount backing_dev_info
Date: Thu, 26 Jan 2017 18:45:31 +0100
Message-Id: <20170126174532.15189-4-jack@suse.cz>
In-Reply-To: <20170126174532.15189-1-jack@suse.cz>
References: <20170126174532.15189-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Instead of storing backing_dev_info inside struct request_queue,
allocate it dynamically, reference count it, and free it when the last
reference is dropped. Currently only request_queue holds the reference
but in the following patch we add other users referencing
backing_dev_info.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c                 | 10 ++++------
 block/blk-sysfs.c                |  2 +-
 include/linux/backing-dev-defs.h |  4 +++-
 include/linux/backing-dev.h      | 10 +++++++++-
 include/linux/blkdev.h           |  1 -
 mm/backing-dev.c                 | 35 +++++++++++++++++++++++++++++++----
 6 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a9ff1b919ae7..5613d3e0821e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -693,7 +693,6 @@ static void blk_rq_timed_out_timer(unsigned long data)
 struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
-	int err;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep,
 				gfp_mask | __GFP_ZERO, node_id);
@@ -708,17 +707,16 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (!q->bio_split)
 		goto fail_id;
 
-	q->backing_dev_info = &q->_backing_dev_info;
+	q->backing_dev_info = bdi_alloc_node(gfp_mask, node_id);
+	if (!q->backing_dev_info)
+		goto fail_split;
+
 	q->backing_dev_info->ra_pages =
 			(VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->backing_dev_info->name = "block";
 	q->node = node_id;
 
-	err = bdi_init(q->backing_dev_info);
-	if (err)
-		goto fail_split;
-
 	setup_timer(&q->backing_dev_info->laptop_mode_wb_timer,
 		    laptop_mode_timer_fn, (unsigned long) q);
 	setup_timer(&q->timeout, blk_rq_timed_out_timer, (unsigned long) q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 64fb54c6b41c..4cbaa519ec2d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -799,7 +799,7 @@ static void blk_release_queue(struct kobject *kobj)
 		container_of(kobj, struct request_queue, kobj);
 
 	wbt_exit(q);
-	bdi_exit(q->backing_dev_info);
+	bdi_put(q->backing_dev_info);
 	blkcg_exit_queue(q);
 
 	if (q->elevator) {
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index e850e76acaaf..4282f21b1611 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -144,7 +144,9 @@ struct backing_dev_info {
 
 	char *name;
 
-	unsigned int capabilities; /* Device capabilities */
+	atomic_t refcnt;	/* Reference counter for the structure */
+	unsigned int capabilities:31;	/* Device capabilities */
+	unsigned int free_on_put:1;	/* Structure will be freed on last bdi_put() */
 	unsigned int min_ratio;
 	unsigned int max_ratio, max_prop_frac;
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 43b93a947e61..c1601c23391a 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -18,7 +18,14 @@
 #include <linux/slab.h>
 
 int __must_check bdi_init(struct backing_dev_info *bdi);
-void bdi_exit(struct backing_dev_info *bdi);
+
+static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
+{
+	atomic_inc(&bdi->refcnt);
+	return bdi;
+}
+
+void bdi_put(struct backing_dev_info *bdi);
 
 __printf(3, 4)
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
@@ -29,6 +36,7 @@ void bdi_unregister(struct backing_dev_info *bdi);
 
 int __must_check bdi_setup_and_register(struct backing_dev_info *, char *);
 void bdi_destroy(struct backing_dev_info *bdi);
+struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
 
 void wb_start_writeback(struct bdi_writeback *wb, long nr_pages,
 			bool range_cyclic, enum wb_reason reason);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 069e4a102a73..de85701cc699 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -433,7 +433,6 @@ struct request_queue {
 	struct delayed_work	delay_work;
 
 	struct backing_dev_info	*backing_dev_info;
-	struct backing_dev_info	_backing_dev_info;
 
 	/*
 	 * The queue owner gets to use this for whatever they like.
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 3bfed5ab2475..14196e43b9ca 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -20,6 +20,8 @@ struct backing_dev_info noop_backing_dev_info = {
 };
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
+static struct kmem_cache *bdi_cachep;
+
 static struct class *bdi_class;
 
 /*
@@ -237,6 +239,9 @@ static __init int bdi_class_init(void)
 
 	bdi_class->dev_groups = bdi_dev_groups;
 	bdi_debug_init();
+
+	bdi_cachep = KMEM_CACHE(backing_dev_info, SLAB_PANIC);
+
 	return 0;
 }
 postcore_initcall(bdi_class_init);
@@ -776,6 +781,7 @@ int bdi_init(struct backing_dev_info *bdi)
 
 	bdi->dev = NULL;
 
+	atomic_set(&bdi->refcnt, 1);
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
@@ -791,6 +797,23 @@ int bdi_init(struct backing_dev_info *bdi)
 }
 EXPORT_SYMBOL(bdi_init);
 
+struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
+{
+	struct backing_dev_info *bdi;
+
+	bdi = kmem_cache_alloc_node(bdi_cachep, gfp_mask | __GFP_ZERO, node_id);
+	if (!bdi)
+		return NULL;
+
+	if (bdi_init(bdi)) {
+		kmem_cache_free(bdi_cachep, bdi);
+		return NULL;
+	}
+	bdi->free_on_put = 1;
+
+	return bdi;
+}
+
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...)
 {
@@ -871,16 +894,20 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	}
 }
 
-void bdi_exit(struct backing_dev_info *bdi)
+void bdi_put(struct backing_dev_info *bdi)
 {
-	WARN_ON_ONCE(bdi->dev);
-	wb_exit(&bdi->wb);
+	if (atomic_dec_and_test(&bdi->refcnt)) {
+		WARN_ON_ONCE(bdi->dev);
+		wb_exit(&bdi->wb);
+		if (bdi->free_on_put)
+			kmem_cache_free(bdi_cachep, bdi);
+	}
 }
 
 void bdi_destroy(struct backing_dev_info *bdi)
 {
 	bdi_unregister(bdi);
-	bdi_exit(bdi);
+	bdi_put(bdi);
 }
 EXPORT_SYMBOL(bdi_destroy);
 
-- 
2.10.2
