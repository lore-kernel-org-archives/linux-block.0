Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/6] genhd: Add helper put_disk_and_module()
Date: Tue,  6 Feb 2018 17:05:26 +0100
Message-Id: <20180206160529.20713-4-jack@suse.cz>
In-Reply-To: <20180206160529.20713-1-jack@suse.cz>
References: <20180206160529.20713-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Add a proper counterpart to get_disk_and_module() -
put_disk_and_module(). Currently it is opencoded in several places.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-cgroup.c    | 11 ++---------
 block/genhd.c         | 20 ++++++++++++++++----
 fs/block_dev.c        | 19 +++++--------------
 include/linux/genhd.h |  1 +
 4 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4117524ca45b..c2033a232a44 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -812,7 +812,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
-	struct module *owner;
 	unsigned int major, minor;
 	int key_len, part, ret;
 	char *body;
@@ -904,9 +903,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 fail:
-	owner = disk->fops->owner;
-	put_disk(disk);
-	module_put(owner);
+	put_disk_and_module(disk);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -931,13 +928,9 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 	__releases(ctx->disk->queue->queue_lock) __releases(rcu)
 {
-	struct module *owner;
-
 	spin_unlock_irq(ctx->disk->queue->queue_lock);
 	rcu_read_unlock();
-	owner = ctx->disk->fops->owner;
-	put_disk(ctx->disk);
-	module_put(owner);
+	put_disk_and_module(ctx->disk);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
diff --git a/block/genhd.c b/block/genhd.c
index 058cf91f8d32..64c323549a22 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -802,10 +802,7 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 
 	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
-		struct module *owner = disk->fops->owner;
-
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 		disk = NULL;
 	}
 	return disk;
@@ -1468,6 +1465,21 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
+/*
+ * This is a counterpart of get_disk_and_module() and thus also of
+ * get_gendisk().
+ */
+void put_disk_and_module(struct gendisk *disk)
+{
+	if (disk) {
+		struct module *owner = disk->fops->owner;
+
+		put_disk(disk);
+		module_put(owner);
+	}
+}
+EXPORT_SYMBOL(put_disk_and_module);
+
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fcb5175..1dbbf847911a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1111,8 +1111,7 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 	else
 		whole = bdgrab(bdev);
 
-	module_put(disk->fops->owner);
-	put_disk(disk);
+	put_disk_and_module(disk);
 	if (!whole)
 		return ERR_PTR(-ENOMEM);
 
@@ -1407,7 +1406,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 {
 	struct gendisk *disk;
-	struct module *owner;
 	int ret;
 	int partno;
 	int perm = 0;
@@ -1433,7 +1431,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk = get_gendisk(bdev->bd_dev, &partno);
 	if (!disk)
 		goto out;
-	owner = disk->fops->owner;
 
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
@@ -1463,8 +1460,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 					bdev->bd_queue = NULL;
 					mutex_unlock(&bdev->bd_mutex);
 					disk_unblock_events(disk);
-					put_disk(disk);
-					module_put(owner);
+					put_disk_and_module(disk);
 					goto restart;
 				}
 			}
@@ -1525,8 +1521,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				goto out_unlock_bdev;
 		}
 		/* only one opener holds refs to the module and disk */
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 	}
 	bdev->bd_openers++;
 	if (for_part)
@@ -1546,8 +1541,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  out_unlock_bdev:
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
-	put_disk(disk);
-	module_put(owner);
+	put_disk_and_module(disk);
  out:
 	bdput(bdev);
 
@@ -1770,8 +1764,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 			disk->fops->release(disk, mode);
 	}
 	if (!bdev->bd_openers) {
-		struct module *owner = disk->fops->owner;
-
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
 		bdev->bd_disk = NULL;
@@ -1779,8 +1771,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
 
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 	}
 	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 12402912a86a..07b715cdeb93 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -597,6 +597,7 @@ extern void printk_all_partitions(void);
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
+extern void put_disk_and_module(struct gendisk *disk);
 extern void blk_register_region(dev_t devt, unsigned long range,
 			struct module *module,
 			struct kobject *(*probe)(dev_t, int *, void *),
-- 
2.13.6
