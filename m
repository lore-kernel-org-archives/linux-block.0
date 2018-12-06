Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9DC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C17B20878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C17B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbeLFQsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:48:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeLFQsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:48:23 -0500
Received: from [191.13.27.189] (helo=calabresa.spo.virtua.com.br)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gUwp2-0000io-Ep; Thu, 06 Dec 2018 16:48:20 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/4] block: move holder tracking from struct block_device to hd_struct
Date:   Thu,  6 Dec 2018 14:48:09 -0200
Message-Id: <20181206164812.30925-2-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

We'd like to track the slaves and holder for nvme multipath devices
in the same standard fashion as all the other stacked block devices
to make the life for things like distro installers easy.

But struct block_device only exists while we have open instances,
which we never have for the underlying devices of a nvme-multipath
setup.  But we can easily move the older list into struct hd_struct
which exists all the time the block device exists, the only interesting
bit is that we need a new mutex for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c                |  4 +++
 block/partition-generic.c    |  4 +++
 drivers/block/drbd/drbd_nl.c |  4 +--
 drivers/md/bcache/super.c    |  8 +++---
 drivers/md/dm.c              |  4 +--
 drivers/md/md.c              |  4 +--
 fs/block_dev.c               | 48 ++++++++++++++++--------------------
 include/linux/fs.h           | 11 +++------
 include/linux/genhd.h        |  4 +++
 9 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0145bcb0cc76..7674fce32fca 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1468,6 +1468,10 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 		disk->minors = minors;
 		rand_initialize_disk(disk);
+#ifdef CONFIG_SYSFS
+		INIT_LIST_HEAD(&disk->part0.holder_disks);
+		mutex_init(&disk->part0.holder_mutex);
+#endif
 		disk_to_dev(disk)->class = &block_class;
 		disk_to_dev(disk)->type = &disk_type;
 		device_initialize(disk_to_dev(disk));
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5f8db5c5140f..83edc23ff1e8 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -333,6 +333,10 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	}
 
 	seqcount_init(&p->nr_sects_seq);
+#ifdef CONFIG_SYSFS
+	INIT_LIST_HEAD(&p->holder_disks);
+	mutex_init(&p->holder_mutex);
+#endif
 	pdev = part_to_dev(p);
 
 	p->start_sect = start;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d15703b1ffe8..42354e34b565 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1670,7 +1670,7 @@ static struct block_device *open_backing_dev(struct drbd_device *device,
 	if (!do_bd_link)
 		return bdev;
 
-	err = bd_link_disk_holder(bdev, device->vdisk);
+	err = bd_link_disk_holder(bdev->bd_part, device->vdisk);
 	if (err) {
 		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
@@ -1719,7 +1719,7 @@ static void close_backing_dev(struct drbd_device *device, struct block_device *b
 	if (!bdev)
 		return;
 	if (do_bd_unlink)
-		bd_unlink_disk_holder(bdev, device->vdisk);
+		bd_unlink_disk_holder(bdev->bd_part, device->vdisk);
 	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
 }
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 7bbd670a5a84..e49b177b1c60 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -677,7 +677,7 @@ static void bcache_device_unlink(struct bcache_device *d)
 		sysfs_remove_link(&d->kobj, "cache");
 
 		for_each_cache(ca, d->c, i)
-			bd_unlink_disk_holder(ca->bdev, d->disk);
+			bd_unlink_disk_holder(ca->bdev->bd_part, d->disk);
 	}
 }
 
@@ -688,7 +688,7 @@ static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
 	struct cache *ca;
 
 	for_each_cache(ca, d->c, i)
-		bd_link_disk_holder(ca->bdev, d->disk);
+		bd_link_disk_holder(ca->bdev->bd_part, d->disk);
 
 	snprintf(d->name, BCACHEDEVNAME_SIZE,
 		 "%s%u", name, d->id);
@@ -936,7 +936,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	}
 
 	add_disk(d->disk);
-	bd_link_disk_holder(dc->bdev, dc->disk.disk);
+	bd_link_disk_holder(dc->bdev->bd_part, dc->disk.disk);
 	/*
 	 * won't show up in the uevent file, use udevadm monitor -e instead
 	 * only class / kset properties are persistent
@@ -1199,7 +1199,7 @@ static void cached_dev_free(struct closure *cl)
 		kthread_stop(dc->status_update_thread);
 
 	if (atomic_read(&dc->running))
-		bd_unlink_disk_holder(dc->bdev, dc->disk.disk);
+		bd_unlink_disk_holder(dc->bdev->bd_part, dc->disk.disk);
 	bcache_device_free(&dc->disk);
 	list_del(&dc->list);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ab72d79775ee..823b592f066b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -770,7 +770,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	r = bd_link_disk_holder(bdev, dm_disk(md));
+	r = bd_link_disk_holder(bdev->bd_part, dm_disk(md));
 	if (r) {
 		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
 		return r;
@@ -789,7 +789,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 	if (!td->dm_dev.bdev)
 		return;
 
-	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
+	bd_unlink_disk_holder(td->dm_dev.bdev->bd_part, dm_disk(md));
 	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
 	put_dax(td->dm_dev.dax_dev);
 	td->dm_dev.bdev = NULL;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc488cb30a94..53ee747ba44d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2240,7 +2240,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	rdev->sysfs_state = sysfs_get_dirent_safe(rdev->kobj.sd, "state");
 
 	list_add_rcu(&rdev->same_set, &mddev->disks);
-	bd_link_disk_holder(rdev->bdev, mddev->gendisk);
+	bd_link_disk_holder(rdev->bdev->bd_part, mddev->gendisk);
 
 	/* May as well allow recovery to be retried once */
 	mddev->recovery_disabled++;
@@ -2264,7 +2264,7 @@ static void unbind_rdev_from_array(struct md_rdev *rdev)
 {
 	char b[BDEVNAME_SIZE];
 
-	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
+	bd_unlink_disk_holder(rdev->bdev->bd_part, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%s>\n", bdevname(rdev->bdev,b));
 	rdev->mddev = NULL;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e1886cc7048f..06323d1bd4b5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -780,9 +780,6 @@ static void init_once(void *foo)
 	memset(bdev, 0, sizeof(*bdev));
 	mutex_init(&bdev->bd_mutex);
 	INIT_LIST_HEAD(&bdev->bd_list);
-#ifdef CONFIG_SYSFS
-	INIT_LIST_HEAD(&bdev->bd_holder_disks);
-#endif
 	bdev->bd_bdi = &noop_backing_dev_info;
 	inode_init_once(&ei->vfs_inode);
 	/* Initialize mutex for freeze. */
@@ -1187,12 +1184,12 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
-static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
+static struct bd_holder_disk *bd_find_holder_disk(struct hd_struct *part,
 						  struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 
-	list_for_each_entry(holder, &bdev->bd_holder_disks, list)
+	list_for_each_entry(holder, &part->holder_disks, list)
 		if (holder->disk == disk)
 			return holder;
 	return NULL;
@@ -1210,7 +1207,7 @@ static void del_symlink(struct kobject *from, struct kobject *to)
 
 /**
  * bd_link_disk_holder - create symlinks between holding disk and slave bdev
- * @bdev: the claimed slave bdev
+ * @part: the claimed slave hd_struct
  * @disk: the holding disk
  *
  * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
@@ -1236,20 +1233,18 @@ static void del_symlink(struct kobject *from, struct kobject *to)
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
+int bd_link_disk_holder(struct hd_struct *part, struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 	int ret = 0;
 
-	mutex_lock(&bdev->bd_mutex);
-
-	WARN_ON_ONCE(!bdev->bd_holder);
+	mutex_lock(&part->holder_mutex);
 
 	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!disk->slave_dir || !bdev->bd_part->holder_dir))
+	if (WARN_ON(!disk->slave_dir || !part->holder_dir))
 		goto out_unlock;
 
-	holder = bd_find_holder_disk(bdev, disk);
+	holder = bd_find_holder_disk(part, disk);
 	if (holder) {
 		holder->refcnt++;
 		goto out_unlock;
@@ -1265,28 +1260,28 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder->disk = disk;
 	holder->refcnt = 1;
 
-	ret = add_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	ret = add_symlink(disk->slave_dir, &part_to_dev(part)->kobj);
 	if (ret)
 		goto out_free;
 
-	ret = add_symlink(bdev->bd_part->holder_dir, &disk_to_dev(disk)->kobj);
+	ret = add_symlink(part->holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del;
 	/*
-	 * bdev could be deleted beneath us which would implicitly destroy
+	 * part could be deleted beneath us which would implicitly destroy
 	 * the holder directory.  Hold on to it.
 	 */
-	kobject_get(bdev->bd_part->holder_dir);
+	kobject_get(part->holder_dir);
 
-	list_add(&holder->list, &bdev->bd_holder_disks);
+	list_add(&holder->list, &part->holder_disks);
 	goto out_unlock;
 
 out_del:
-	del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	del_symlink(disk->slave_dir, &part_to_dev(part)->kobj);
 out_free:
 	kfree(holder);
 out_unlock:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&part->holder_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(bd_link_disk_holder);
@@ -1301,24 +1296,23 @@ EXPORT_SYMBOL_GPL(bd_link_disk_holder);
  * CONTEXT:
  * Might sleep.
  */
-void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
+void bd_unlink_disk_holder(struct hd_struct *part, struct gendisk *disk)
 {
 	struct bd_holder_disk *holder;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&part->holder_mutex);
 
-	holder = bd_find_holder_disk(bdev, disk);
+	holder = bd_find_holder_disk(part, disk);
 
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
-		del_symlink(bdev->bd_part->holder_dir,
-			    &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_part->holder_dir);
+		del_symlink(disk->slave_dir, &part_to_dev(part)->kobj);
+		del_symlink(part->holder_dir, &disk_to_dev(disk)->kobj);
+		kobject_put(part->holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
 
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&part->holder_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a1ab233e6469..324261460e3e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -455,9 +455,6 @@ struct block_device {
 	void *			bd_holder;
 	int			bd_holders;
 	bool			bd_write_holder;
-#ifdef CONFIG_SYSFS
-	struct list_head	bd_holder_disks;
-#endif
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
 	u8			bd_partno;
@@ -2596,16 +2593,16 @@ extern int __blkdev_reread_part(struct block_device *bdev);
 extern int blkdev_reread_part(struct block_device *bdev);
 
 #ifdef CONFIG_SYSFS
-extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
-extern void bd_unlink_disk_holder(struct block_device *bdev,
+extern int bd_link_disk_holder(struct hd_struct *part, struct gendisk *disk);
+extern void bd_unlink_disk_holder(struct hd_struct *part,
 				  struct gendisk *disk);
 #else
-static inline int bd_link_disk_holder(struct block_device *bdev,
+static inline int bd_link_disk_holder(struct hd_struct *part,
 				      struct gendisk *disk)
 {
 	return 0;
 }
-static inline void bd_unlink_disk_holder(struct block_device *bdev,
+static inline void bd_unlink_disk_holder(struct hd_struct *part,
 					 struct gendisk *disk)
 {
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0c5ee17b4d88..e516e95bb8cf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -130,6 +130,10 @@ struct hd_struct {
 #endif
 	struct percpu_ref ref;
 	struct rcu_work rcu_work;
+#ifdef CONFIG_SYSFS
+	struct list_head	holder_disks;
+	struct mutex		holder_mutex;
+#endif
 };
 
 #define GENHD_FL_REMOVABLE			1
-- 
2.19.1

