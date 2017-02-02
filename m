Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] block: Dynamically allocate and refcount backing_dev_info
Date: Thu,  2 Feb 2017 15:56:51 +0100
Message-Id: <20170202145653.19614-4-jack@suse.cz>
In-Reply-To: <20170202145653.19614-1-jack@suse.cz>
References: <20170202145653.19614-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Instead of storing backing_dev_info inside struct request_queue,
allocate it dynamically, reference count it, and free it when the last
reference is dropped. Currently only request_queue holds the reference
but in the following patch we add other users referencing
backing_dev_info.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c                 | 12 +++++-------
 block/blk-sysfs.c                |  2 +-
 include/linux/backing-dev-defs.h |  2 ++
 include/linux/backing-dev.h      | 10 +++++++++-
 include/linux/blkdev.h           |  1 -
 mm/backing-dev.c                 | 34 +++++++++++++++++++++++++++++++++-
 6 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a9ff1b919ae7..545ccb4b96f3 100644
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
@@ -769,7 +767,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 fail_ref:
 	percpu_ref_exit(&q->q_usage_counter);
 fail_bdi:
-	bdi_destroy(q->backing_dev_info);
+	bdi_put(q->backing_dev_info);
 fail_split:
 	bioset_free(q->bio_split);
 fail_id:
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
index e850e76acaaf..ad955817916d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -10,6 +10,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 
 struct page;
 struct device;
@@ -144,6 +145,7 @@ struct backing_dev_info {
 
 	char *name;
 
+	struct kref refcnt;	/* Reference counter for the structure */
 	unsigned int capabilities; /* Device capabilities */
 	unsigned int min_ratio;
 	unsigned int max_ratio, max_prop_frac;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 43b93a947e61..efb6ca992d05 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -18,7 +18,14 @@
 #include <linux/slab.h>
 
 int __must_check bdi_init(struct backing_dev_info *bdi);
-void bdi_exit(struct backing_dev_info *bdi);
+
+static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
+{
+	kref_get(&bdi->refcnt);
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
index 3bfed5ab2475..28ce6cf7b2ff 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -237,6 +237,7 @@ static __init int bdi_class_init(void)
 
 	bdi_class->dev_groups = bdi_dev_groups;
 	bdi_debug_init();
+
 	return 0;
 }
 postcore_initcall(bdi_class_init);
@@ -776,6 +777,7 @@ int bdi_init(struct backing_dev_info *bdi)
 
 	bdi->dev = NULL;
 
+	kref_init(&bdi->refcnt);
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
@@ -791,6 +793,22 @@ int bdi_init(struct backing_dev_info *bdi)
 }
 EXPORT_SYMBOL(bdi_init);
 
+struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
+{
+	struct backing_dev_info *bdi;
+
+	bdi = kmalloc_node(sizeof(struct backing_dev_info),
+			   gfp_mask | __GFP_ZERO, node_id);
+	if (!bdi)
+		return NULL;
+
+	if (bdi_init(bdi)) {
+		kfree(bdi);
+		return NULL;
+	}
+	return bdi;
+}
+
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...)
 {
@@ -871,12 +889,26 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	}
 }
 
-void bdi_exit(struct backing_dev_info *bdi)
+static void bdi_exit(struct backing_dev_info *bdi)
 {
 	WARN_ON_ONCE(bdi->dev);
 	wb_exit(&bdi->wb);
 }
 
+static void release_bdi(struct kref *ref)
+{
+	struct backing_dev_info *bdi =
+			container_of(ref, struct backing_dev_info, refcnt);
+
+	bdi_exit(bdi);
+	kfree(bdi);
+}
+
+void bdi_put(struct backing_dev_info *bdi)
+{
+	kref_put(&bdi->refcnt, release_bdi);
+}
+
 void bdi_destroy(struct backing_dev_info *bdi)
 {
 	bdi_unregister(bdi);
-- 
2.10.2
