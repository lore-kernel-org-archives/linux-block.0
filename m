Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 25/25] bdi: Drop 'parent' argument from bdi_register[_va]()
Date: Wed, 12 Apr 2017 12:24:49 +0200
Message-Id: <20170412102449.16901-26-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Drop 'parent' argument of bdi_register() and bdi_register_va().  It is
always NULL.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/mtd/mtdcore.c       |  2 +-
 fs/super.c                  |  2 +-
 include/linux/backing-dev.h |  9 ++++-----
 mm/backing-dev.c            | 13 +++++--------
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 23e2e56ca54e..1517da3ddd7d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1782,7 +1782,7 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	 * We put '-0' suffix to the name to get the same name format as we
 	 * used to get. Since this is called only once, we get a unique name. 
 	 */
-	ret = bdi_register(bdi, NULL, "%.28s-0", name);
+	ret = bdi_register(bdi, "%.28s-0", name);
 	if (ret)
 		bdi_put(bdi);
 
diff --git a/fs/super.c b/fs/super.c
index 8444d26926ef..adb0c0de428c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1272,7 +1272,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	bdi->name = sb->s_type->name;
 
 	va_start(args, fmt);
-	err = bdi_register_va(bdi, NULL, fmt, args);
+	err = bdi_register_va(bdi, fmt, args);
 	va_end(args);
 	if (err) {
 		bdi_put(bdi);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index aaeb2ec5d33c..557d84063934 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -25,11 +25,10 @@ static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 
 void bdi_put(struct backing_dev_info *bdi);
 
-__printf(3, 4)
-int bdi_register(struct backing_dev_info *bdi, struct device *parent,
-		const char *fmt, ...);
-int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
-		const char *fmt, va_list args);
+__printf(2, 3)
+int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
+int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
+		    va_list args);
 int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4dcd56947f2a..f028a9a472fd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -856,15 +856,14 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 }
 EXPORT_SYMBOL(bdi_alloc_node);
 
-int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
-		const char *fmt, va_list args)
+int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 {
 	struct device *dev;
 
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	dev = device_create_vargs(bdi_class, parent, MKDEV(0, 0), bdi, fmt, args);
+	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
@@ -883,14 +882,13 @@ int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
 }
 EXPORT_SYMBOL(bdi_register_va);
 
-int bdi_register(struct backing_dev_info *bdi, struct device *parent,
-		const char *fmt, ...)
+int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 {
 	va_list args;
 	int ret;
 
 	va_start(args, fmt);
-	ret = bdi_register_va(bdi, parent, fmt, args);
+	ret = bdi_register_va(bdi, fmt, args);
 	va_end(args);
 	return ret;
 }
@@ -900,8 +898,7 @@ int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
 {
 	int rc;
 
-	rc = bdi_register(bdi, NULL, "%u:%u", MAJOR(owner->devt),
-			MINOR(owner->devt));
+	rc = bdi_register(bdi, "%u:%u", MAJOR(owner->devt), MINOR(owner->devt));
 	if (rc)
 		return rc;
 	/* Leaking owner reference... */
-- 
2.12.0
