Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 24/24] block: Remove unused functions
Date: Thu,  2 Feb 2017 18:34:22 +0100
Message-Id: <20170202173422.3240-25-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Now that all backing_dev_info structure are allocated separately, we can
drop some unused functions.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev.h |  5 -----
 mm/backing-dev.c            | 54 +++++----------------------------------------
 2 files changed, 5 insertions(+), 54 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 6865b1c8b122..f39822a06305 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -17,8 +17,6 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
-int __must_check bdi_init(struct backing_dev_info *bdi);
-
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
@@ -32,12 +30,9 @@ int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...);
 int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, va_list args);
-int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev);
 int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
-int __must_check bdi_setup_and_register(struct backing_dev_info *, char *);
-void bdi_destroy(struct backing_dev_info *bdi);
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
 struct backing_dev_info *bdi_alloc(gfp_t gfp_mask);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 82fee0f52d06..38b1197f7479 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -12,8 +12,6 @@
 #include <linux/device.h>
 #include <trace/events/writeback.h>
 
-static atomic_long_t bdi_seq = ATOMIC_LONG_INIT(0);
-
 struct backing_dev_info noop_backing_dev_info = {
 	.name		= "noop",
 	.capabilities	= BDI_CAP_NO_ACCT_AND_WRITEBACK,
@@ -242,6 +240,8 @@ static __init int bdi_class_init(void)
 }
 postcore_initcall(bdi_class_init);
 
+static int bdi_init(struct backing_dev_info *bdi);
+
 static int __init default_bdi_init(void)
 {
 	int err;
@@ -771,7 +771,7 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi) { }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-int bdi_init(struct backing_dev_info *bdi)
+static int bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
 
@@ -791,7 +791,6 @@ int bdi_init(struct backing_dev_info *bdi)
 
 	return ret;
 }
-EXPORT_SYMBOL(bdi_init);
 
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 {
@@ -864,12 +863,6 @@ int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 }
 EXPORT_SYMBOL(bdi_register);
 
-int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev)
-{
-	return bdi_register(bdi, NULL, "%u:%u", MAJOR(dev), MINOR(dev));
-}
-EXPORT_SYMBOL(bdi_register_dev);
-
 int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
 {
 	int rc;
@@ -923,19 +916,14 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	}
 }
 
-static void bdi_exit(struct backing_dev_info *bdi)
-{
-	WARN_ON_ONCE(bdi->dev);
-	wb_exit(&bdi->wb);
-}
-
 static void release_bdi(struct kref *ref)
 {
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
 	bdi_unregister(bdi);
-	bdi_exit(bdi);
+	WARN_ON_ONCE(bdi->dev);
+	wb_exit(&bdi->wb);
 	kfree(bdi);
 }
 
@@ -944,38 +932,6 @@ void bdi_put(struct backing_dev_info *bdi)
 	kref_put(&bdi->refcnt, release_bdi);
 }
 
-void bdi_destroy(struct backing_dev_info *bdi)
-{
-	bdi_unregister(bdi);
-	bdi_exit(bdi);
-}
-EXPORT_SYMBOL(bdi_destroy);
-
-/*
- * For use from filesystems to quickly init and register a bdi associated
- * with dirty writeback
- */
-int bdi_setup_and_register(struct backing_dev_info *bdi, char *name)
-{
-	int err;
-
-	bdi->name = name;
-	bdi->capabilities = 0;
-	err = bdi_init(bdi);
-	if (err)
-		return err;
-
-	err = bdi_register(bdi, NULL, "%.28s-%ld", name,
-			   atomic_long_inc_return(&bdi_seq));
-	if (err) {
-		bdi_destroy(bdi);
-		return err;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(bdi_setup_and_register);
-
 static wait_queue_head_t congestion_wqh[2] = {
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
-- 
2.10.2
