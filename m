Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35815 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbcFFOqM (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 10:46:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so10680413wme.2
        for <linux-block@vger.kernel.org>; Mon, 06 Jun 2016 07:46:11 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 3/6] blk-mq: register device instead of disk
Date: Mon,  6 Jun 2016 16:46:00 +0200
Message-Id: <1465224363-25797-4-git-send-email-m@bjorling.me>
In-Reply-To: <1465224363-25797-1-git-send-email-m@bjorling.me>
References: <1465224363-25797-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enable devices without a gendisk instance to register itself with blk-mq
and expose the associated multi-queue sysfs entries.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 block/blk-mq-sysfs.c   | 13 +++++--------
 block/blk-sysfs.c      |  4 ++--
 drivers/md/dm.c        |  2 +-
 include/linux/blk-mq.h |  4 ++--
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 4ea4dd8..f67b5c1 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -380,9 +380,8 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-void blk_mq_unregister_disk(struct gendisk *disk)
+void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
-	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	int i, j;
@@ -402,7 +401,7 @@ void blk_mq_unregister_disk(struct gendisk *disk)
 	kobject_del(&q->mq_kobj);
 	kobject_put(&q->mq_kobj);
 
-	kobject_put(&disk_to_dev(disk)->kobj);
+	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
 	blk_mq_enable_hotplug();
@@ -426,10 +425,8 @@ static void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int blk_mq_register_disk(struct gendisk *disk)
+int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
-	struct device *dev = disk_to_dev(disk);
-	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
@@ -450,7 +447,7 @@ int blk_mq_register_disk(struct gendisk *disk)
 	}
 
 	if (ret)
-		blk_mq_unregister_disk(disk);
+		blk_mq_unregister_dev(dev, q);
 	else
 		q->mq_sysfs_init_done = true;
 out:
@@ -458,7 +455,7 @@ out:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_mq_register_disk);
+EXPORT_SYMBOL_GPL(blk_mq_register_dev);
 
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 995b58d..a998c54 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -654,7 +654,7 @@ int blk_register_queue(struct gendisk *disk)
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
 	if (q->mq_ops)
-		blk_mq_register_disk(disk);
+		blk_mq_register_dev(disk_to_dev(disk), q);
 
 	if (!q->request_fn)
 		return 0;
@@ -679,7 +679,7 @@ void blk_unregister_queue(struct gendisk *disk)
 		return;
 
 	if (q->mq_ops)
-		blk_mq_unregister_disk(disk);
+		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
 	if (q->request_fn)
 		elv_unregister_queue(q);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3d3ac13..6a4b596 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2797,7 +2797,7 @@ static int dm_mq_init_request_queue(struct mapped_device *md,
 	dm_init_md_queue(md);
 
 	/* backfill 'mq' sysfs registration normally done in blk_register_queue */
-	blk_mq_register_disk(md->disk);
+	blk_mq_register_dev(disk_to_dev(md->disk), q);
 
 	return 0;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9ac9799..9a37515 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -176,8 +176,8 @@ enum {
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

