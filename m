Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36127 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934900AbcIPMZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2016 08:25:36 -0400
Received: by mail-pa0-f65.google.com with SMTP id my20so451873pab.3
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2016 05:25:36 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 4/7] blk-mq: register device instead of disk
Date: Fri, 16 Sep 2016 14:25:06 +0200
Message-Id: <1474028709-30260-5-git-send-email-m@bjorling.me>
In-Reply-To: <1474028709-30260-1-git-send-email-m@bjorling.me>
References: <1474028709-30260-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enable devices without a gendisk instance to register itself with blk-mq
and expose the associated multi-queue sysfs entries.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 block/blk-mq-sysfs.c   | 17 +++++++----------
 block/blk-sysfs.c      |  4 ++--
 drivers/md/dm-rq.c     |  2 +-
 include/linux/blk-mq.h |  4 ++--
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index fe822aa..d998287 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -380,9 +380,8 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-static void __blk_mq_unregister_disk(struct gendisk *disk)
+static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
-	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	int i, j;
@@ -400,15 +399,15 @@ static void __blk_mq_unregister_disk(struct gendisk *disk)
 	kobject_del(&q->mq_kobj);
 	kobject_put(&q->mq_kobj);
 
-	kobject_put(&disk_to_dev(disk)->kobj);
+	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
 }
 
-void blk_mq_unregister_disk(struct gendisk *disk)
+void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
 	blk_mq_disable_hotplug();
-	__blk_mq_unregister_disk(disk);
+	__blk_mq_unregister_dev(dev, q);
 	blk_mq_enable_hotplug();
 }
 
@@ -430,10 +429,8 @@ static void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int blk_mq_register_disk(struct gendisk *disk)
+int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
-	struct device *dev = disk_to_dev(disk);
-	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
@@ -454,7 +451,7 @@ int blk_mq_register_disk(struct gendisk *disk)
 	}
 
 	if (ret)
-		__blk_mq_unregister_disk(disk);
+		__blk_mq_unregister_dev(dev, q);
 	else
 		q->mq_sysfs_init_done = true;
 out:
@@ -462,7 +459,7 @@ out:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_mq_register_disk);
+EXPORT_SYMBOL_GPL(blk_mq_register_dev);
 
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f87a7e7..9cc8d7c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -704,7 +704,7 @@ int blk_register_queue(struct gendisk *disk)
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
 	if (q->mq_ops)
-		blk_mq_register_disk(disk);
+		blk_mq_register_dev(dev, q);
 
 	if (!q->request_fn)
 		return 0;
@@ -729,7 +729,7 @@ void blk_unregister_queue(struct gendisk *disk)
 		return;
 
 	if (q->mq_ops)
-		blk_mq_unregister_disk(disk);
+		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
 	if (q->request_fn)
 		elv_unregister_queue(q);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1ca7463..ee48230 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -955,7 +955,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	dm_init_md_queue(md);
 
 	/* backfill 'mq' sysfs registration normally done in blk_register_queue */
-	blk_mq_register_disk(md->disk);
+	blk_mq_register_dev(disk_to_dev(md->disk), q);
 
 	return 0;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e1544f0..f03a59d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -179,8 +179,8 @@ enum {
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q);
-int blk_mq_register_disk(struct gendisk *);
-void blk_mq_unregister_disk(struct gendisk *);
+int blk_mq_register_dev(struct device *, struct request_queue *);
+void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
-- 
2.1.4

