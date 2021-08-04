Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FDC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A845960F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhHDJna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhHDJn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:43:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF89C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ypUfuBtNlMUUhDnltGc1peZ5SIUGrl9Xz13vyKmRMnw=; b=Wme8j3dUl6hqqYtnAFhnDn1AoB
        Lub6LyDDmpfw+d3zzqf9EGeWGyoe4MoZzn14h7jciS53MuJsyHw7gwmCWQRsnD+xZdQl4Su/Ja+Gl
        Vi4fPK6WaAhrmThHvztbS5k+WzKAY1RW1XtDRcSQa+45jEeD2Yd3CM4vcIynvtSGrxRWsMK6rQ9ZQ
        yQdPaoZJjuMMe4bxB5vh3jnhH/jh47ywO+4I43m6+UjFwKWL86uDGwOkN9ub1Q8GeZxD3BF6HKbnH
        zS+3YuJ3BgmoIIuHXrmQDn1SZ6ePX8xB/4HHts7gnAmAskwORjYCsbZNqgtGBSezHbbLRZJWyYP0C
        xWJEVDpA==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDPs-005dxi-Ni; Wed, 04 Aug 2021 09:42:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: make the block holder code optional
Date:   Wed,  4 Aug 2021 11:41:40 +0200
Message-Id: <20210804094147.459763-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the block holder code into a separate file as it is not in any way
related to the other block_dev.c code, and add a new selectable config
option for it so that we don't have to build it without any remapped
drivers selected.

The Kconfig symbol contains a _DEPRECATED suffix to match the comments
added in commit 49731baa41df
("block: restore multiple bd_link_disk_holder() support").

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 block/Kconfig             |   4 ++
 block/Makefile            |   1 +
 block/holder.c            | 139 ++++++++++++++++++++++++++++++++++++
 drivers/md/Kconfig        |   2 +
 drivers/md/bcache/Kconfig |   1 +
 fs/block_dev.c            | 144 +-------------------------------------
 include/linux/blk_types.h |   2 +-
 include/linux/genhd.h     |   4 +-
 8 files changed, 151 insertions(+), 146 deletions(-)
 create mode 100644 block/holder.c

diff --git a/block/Kconfig b/block/Kconfig
index 15dfb7660645..bac87d773c54 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -241,4 +241,8 @@ config BLK_MQ_RDMA
 config BLK_PM
 	def_bool BLOCK && PM
 
+# do not use in new code
+config BLOCK_HOLDER_DEPRECATED
+	bool
+
 source "block/Kconfig.iosched"
diff --git a/block/Makefile b/block/Makefile
index c72592b4cf31..0d951adce796 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o blk-crypto.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
+obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
diff --git a/block/holder.c b/block/holder.c
new file mode 100644
index 000000000000..904a1dcd5c12
--- /dev/null
+++ b/block/holder.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/genhd.h>
+
+struct bd_holder_disk {
+	struct list_head	list;
+	struct gendisk		*disk;
+	int			refcnt;
+};
+
+static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
+						  struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+
+	list_for_each_entry(holder, &bdev->bd_holder_disks, list)
+		if (holder->disk == disk)
+			return holder;
+	return NULL;
+}
+
+static int add_symlink(struct kobject *from, struct kobject *to)
+{
+	return sysfs_create_link(from, to, kobject_name(to));
+}
+
+static void del_symlink(struct kobject *from, struct kobject *to)
+{
+	sysfs_remove_link(from, kobject_name(to));
+}
+
+/**
+ * bd_link_disk_holder - create symlinks between holding disk and slave bdev
+ * @bdev: the claimed slave bdev
+ * @disk: the holding disk
+ *
+ * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
+ *
+ * This functions creates the following sysfs symlinks.
+ *
+ * - from "slaves" directory of the holder @disk to the claimed @bdev
+ * - from "holders" directory of the @bdev to the holder @disk
+ *
+ * For example, if /dev/dm-0 maps to /dev/sda and disk for dm-0 is
+ * passed to bd_link_disk_holder(), then:
+ *
+ *   /sys/block/dm-0/slaves/sda --> /sys/block/sda
+ *   /sys/block/sda/holders/dm-0 --> /sys/block/dm-0
+ *
+ * The caller must have claimed @bdev before calling this function and
+ * ensure that both @bdev and @disk are valid during the creation and
+ * lifetime of these symlinks.
+ *
+ * CONTEXT:
+ * Might sleep.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+	int ret = 0;
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+
+	WARN_ON_ONCE(!bdev->bd_holder);
+
+	/* FIXME: remove the following once add_disk() handles errors */
+	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
+		goto out_unlock;
+
+	holder = bd_find_holder_disk(bdev, disk);
+	if (holder) {
+		holder->refcnt++;
+		goto out_unlock;
+	}
+
+	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
+	if (!holder) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	INIT_LIST_HEAD(&holder->list);
+	holder->disk = disk;
+	holder->refcnt = 1;
+
+	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
+	if (ret)
+		goto out_free;
+
+	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+	if (ret)
+		goto out_del;
+	/*
+	 * bdev could be deleted beneath us which would implicitly destroy
+	 * the holder directory.  Hold on to it.
+	 */
+	kobject_get(bdev->bd_holder_dir);
+
+	list_add(&holder->list, &bdev->bd_holder_disks);
+	goto out_unlock;
+
+out_del:
+	del_symlink(disk->slave_dir, bdev_kobj(bdev));
+out_free:
+	kfree(holder);
+out_unlock:
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bd_link_disk_holder);
+
+/**
+ * bd_unlink_disk_holder - destroy symlinks created by bd_link_disk_holder()
+ * @bdev: the calimed slave bdev
+ * @disk: the holding disk
+ *
+ * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
+ *
+ * CONTEXT:
+ * Might sleep.
+ */
+void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	holder = bd_find_holder_disk(bdev, disk);
+	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
+		del_symlink(disk->slave_dir, bdev_kobj(bdev));
+		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+		kobject_put(bdev->bd_holder_dir);
+		list_del_init(&holder->list);
+		kfree(holder);
+	}
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+}
+EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 0602e82a9516..f821dae101a9 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -15,6 +15,7 @@ if MD
 
 config BLK_DEV_MD
 	tristate "RAID support"
+	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	help
 	  This driver lets you combine several hard disk partitions into one
 	  logical block device. This can be used to simply append one
@@ -201,6 +202,7 @@ config BLK_DEV_DM_BUILTIN
 
 config BLK_DEV_DM
 	tristate "Device mapper support"
+	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select BLK_DEV_DM_BUILTIN
 	depends on DAX || DAX=n
 	help
diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index d1ca4d059c20..cf3e8096942a 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -2,6 +2,7 @@
 
 config BCACHE
 	tristate "Block device as cache"
+	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select CRC64
 	help
 	Allows a block device to be used as cache for other devices; uses
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6658f40ae492..ae9651cad923 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -902,7 +902,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
-#ifdef CONFIG_SYSFS
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
@@ -1063,148 +1063,6 @@ void bd_abort_claiming(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(bd_abort_claiming);
 
-#ifdef CONFIG_SYSFS
-struct bd_holder_disk {
-	struct list_head	list;
-	struct gendisk		*disk;
-	int			refcnt;
-};
-
-static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
-						  struct gendisk *disk)
-{
-	struct bd_holder_disk *holder;
-
-	list_for_each_entry(holder, &bdev->bd_holder_disks, list)
-		if (holder->disk == disk)
-			return holder;
-	return NULL;
-}
-
-static int add_symlink(struct kobject *from, struct kobject *to)
-{
-	return sysfs_create_link(from, to, kobject_name(to));
-}
-
-static void del_symlink(struct kobject *from, struct kobject *to)
-{
-	sysfs_remove_link(from, kobject_name(to));
-}
-
-/**
- * bd_link_disk_holder - create symlinks between holding disk and slave bdev
- * @bdev: the claimed slave bdev
- * @disk: the holding disk
- *
- * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
- *
- * This functions creates the following sysfs symlinks.
- *
- * - from "slaves" directory of the holder @disk to the claimed @bdev
- * - from "holders" directory of the @bdev to the holder @disk
- *
- * For example, if /dev/dm-0 maps to /dev/sda and disk for dm-0 is
- * passed to bd_link_disk_holder(), then:
- *
- *   /sys/block/dm-0/slaves/sda --> /sys/block/sda
- *   /sys/block/sda/holders/dm-0 --> /sys/block/dm-0
- *
- * The caller must have claimed @bdev before calling this function and
- * ensure that both @bdev and @disk are valid during the creation and
- * lifetime of these symlinks.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
-{
-	struct bd_holder_disk *holder;
-	int ret = 0;
-
-	mutex_lock(&bdev->bd_disk->open_mutex);
-
-	WARN_ON_ONCE(!bdev->bd_holder);
-
-	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
-		goto out_unlock;
-
-	holder = bd_find_holder_disk(bdev, disk);
-	if (holder) {
-		holder->refcnt++;
-		goto out_unlock;
-	}
-
-	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
-	if (!holder) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	INIT_LIST_HEAD(&holder->list);
-	holder->disk = disk;
-	holder->refcnt = 1;
-
-	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
-	if (ret)
-		goto out_free;
-
-	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-	if (ret)
-		goto out_del;
-	/*
-	 * bdev could be deleted beneath us which would implicitly destroy
-	 * the holder directory.  Hold on to it.
-	 */
-	kobject_get(bdev->bd_holder_dir);
-
-	list_add(&holder->list, &bdev->bd_holder_disks);
-	goto out_unlock;
-
-out_del:
-	del_symlink(disk->slave_dir, bdev_kobj(bdev));
-out_free:
-	kfree(holder);
-out_unlock:
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bd_link_disk_holder);
-
-/**
- * bd_unlink_disk_holder - destroy symlinks created by bd_link_disk_holder()
- * @bdev: the calimed slave bdev
- * @disk: the holding disk
- *
- * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
- *
- * CONTEXT:
- * Might sleep.
- */
-void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
-{
-	struct bd_holder_disk *holder;
-
-	mutex_lock(&bdev->bd_disk->open_mutex);
-
-	holder = bd_find_holder_disk(bdev, disk);
-
-	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_holder_dir);
-		list_del_init(&holder->list);
-		kfree(holder);
-	}
-
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-}
-EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-#endif
-
 static void blkdev_flush_mapping(struct block_device *bdev)
 {
 	WARN_ON_ONCE(bdev->bd_holders);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 290f9061b29a..7a4e139d24ef 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -34,7 +34,7 @@ struct block_device {
 	void *			bd_holder;
 	int			bd_holders;
 	bool			bd_write_holder;
-#ifdef CONFIG_SYSFS
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	struct list_head	bd_holder_disks;
 #endif
 	struct kobject		*bd_holder_dir;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 849486de81c6..e21a91c16a79 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -318,7 +318,7 @@ void set_capacity(struct gendisk *disk, sector_t size);
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
 long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 
-#ifdef CONFIG_SYSFS
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
 #else
@@ -331,7 +331,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 					 struct gendisk *disk)
 {
 }
-#endif /* CONFIG_SYSFS */
+#endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
 void inc_diskseq(struct gendisk *disk);
-- 
2.30.2

