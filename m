Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4173C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57D761178
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhGOHua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhGOHua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 03:50:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ED6C06175F;
        Thu, 15 Jul 2021 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t/GtyAHDP5R7bDqXQXeOux5v2ylrcWkxXlOfeLBFR7c=; b=hhiNJJvF++u93zDIoFJt4KYj6R
        LIeRC3SylkpPpRs1SFnaM9slpbRM/VQZVx1QkHiC1u/4o9uGyO7XdvJvLvkODNXjWjKdDEsGVRZuf
        SCIMdLj2emNTRFoZxkLxijZ7q1VY4TJeYEXL8Ml3CA3OIXu0Y6RpU5LZfmTQS+rFOXYUFl/YAN7iw
        yQ3Tw+kp3H8FqKyXwDzy00J7AuBySEkOSy48GXMWKhTRZE1VkhG+lJc4v8ohces3R4hvZHunSb8S9
        YgI7xdzH8zFUA+dOE/ucq9VHiNdYzqSWPSKvaIUjKvyuRWZ9LkXKXyH8EptATP7Zl4dBXH7gio8VR
        iQziDGQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3w4R-0036yY-PH; Thu, 15 Jul 2021 07:46:19 +0000
Date:   Thu, 15 Jul 2021 08:46:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] block: move disk invalidation from del_gendisk()
 into a helper
Message-ID: <YO/nw2qDRg3yQDJj@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't really like many of these helpers as they are rather
confusing.  Below is a patch ontop of your whole series that
massages it into something I find much easier to follow.
The big caveats are:

 - this moves the bdi link creation earlier, which is safe and probably
   preferable. (should go into a prep patch).
 - del_gendisk now needs to cope with not set up events and integrity
   kobject

I also have a bunch of changes to del_gendisk which might require
backporting, let me try to get those out ASAP.

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e46f47f2dec9..3135adab2e7c 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -446,6 +446,8 @@ int blk_integrity_add(struct gendisk *disk)
 
 void blk_integrity_del(struct gendisk *disk)
 {
+	if (!disk->integrity_kobj.state_initialized)
+		return;
 	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
 	kobject_del(&disk->integrity_kobj);
 	kobject_put(&disk->integrity_kobj);
diff --git a/block/disk-events.c b/block/disk-events.c
index 0262784be34c..af7d7249eefa 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -458,7 +458,8 @@ void disk_del_events(struct gendisk *disk)
 		disk_block_events(disk);
 
 		mutex_lock(&disk_events_mutex);
-		list_del_init(&disk->ev->node);
+		if (!list_empty(&disk->ev->node))
+			list_del_init(&disk->ev->node);
 		mutex_unlock(&disk_events_mutex);
 	}
 }
diff --git a/block/genhd.c b/block/genhd.c
index c6c9c196ff27..0c8c71d78536 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -390,68 +390,8 @@ static void disk_scan_partitions(struct gendisk *disk)
 		blkdev_put(bdev, FMODE_READ);
 }
 
-static void disk_announce(struct gendisk *disk)
-{
-	struct device *ddev = disk_to_dev(disk);
-
-	/* announce the disk and partitions after all partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	disk_uevent(disk, KOBJ_ADD);
-}
-
-static void unregister_disk_partitions(struct gendisk *disk)
-{
-	mutex_lock(&disk->open_mutex);
-	disk->flags &= ~GENHD_FL_UP;
-	blk_drop_partitions(disk);
-	mutex_unlock(&disk->open_mutex);
-
-	fsync_bdev(disk->part0);
-	__invalidate_device(disk->part0, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(disk->part0->bd_inode);
-
-	set_capacity(disk, 0);
-}
-
-static void disk_invalidate(struct gendisk *disk)
-{
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-
-		/*
-		 * Unregister bdi before releasing device numbers (as they can
-		 * get reused and we'd get clashes in sysfs).
-		 */
-		bdi_unregister(disk->queue->backing_dev_info);
-	}
-
-	blk_unregister_queue(disk);
-
-	kobject_put(disk->part0->bd_holder_dir);
-	kobject_put(disk->slave_dir);
-
-	part_stat_set_all(disk->part0, 0);
-	disk->part0->bd_stamp = 0;
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
-	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
-	device_del(disk_to_dev(disk));
-}
-
-static void unregister_disk(struct gendisk *disk)
-{
-	unregister_disk_partitions(disk);
-	disk_invalidate(disk);
-}
-
-static int __must_check register_disk(struct device *parent,
-				      struct gendisk *disk,
-				      const struct attribute_group **groups)
+static int register_disk(struct device *parent, struct gendisk *disk,
+		const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
 	int err;
@@ -498,20 +438,22 @@ static int __must_check register_disk(struct device *parent,
 	if (disk->flags & GENHD_FL_HIDDEN)
 		return 0;
 
-	disk_scan_partitions(disk);
-	disk_announce(disk);
-
 	if (disk->queue->backing_dev_info->dev) {
 		err = sysfs_create_link(&ddev->kobj,
-			  &disk->queue->backing_dev_info->dev->kobj,
-			  "bdi");
+			  &disk->queue->backing_dev_info->dev->kobj, "bdi");
 		if (WARN_ON(err))
 			goto exit_del_block_depr;
 	}
+
+	disk_scan_partitions(disk);
+
+	/* announce the disk and partitions after all partitions are created */
+	dev_set_uevent_suppress(ddev, 0);
+	disk_uevent(disk, KOBJ_ADD);
+
 	return 0;
 
 exit_del_block_depr:
-	unregister_disk_partitions(disk);
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 exit_del_device:
@@ -614,6 +556,7 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 		bdi_set_owner(bdi, dev);
 		bdev_add(disk->part0, dev->devt);
 	}
+
 	ret = register_disk(parent, disk, groups);
 	if (ret)
 		goto exit_unregister_bdi;
@@ -628,13 +571,11 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	ret = blk_integrity_add(disk);
 	if (ret)
-		goto exit_del_events;
+		goto exit_unregister_disk;
 
 	return 0;
-exit_del_events:
-	disk_del_events(disk);
 exit_unregister_disk:
-	unregister_disk(disk);
+	del_gendisk(disk);
 	return ret;
 
 exit_unregister_bdi:
@@ -691,7 +632,44 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_integrity_del(disk);
 	disk_del_events(disk);
-	unregister_disk(disk);
+
+	mutex_lock(&disk->open_mutex);
+	disk->flags &= ~GENHD_FL_UP;
+	blk_drop_partitions(disk);
+	mutex_unlock(&disk->open_mutex);
+
+	fsync_bdev(disk->part0);
+	__invalidate_device(disk->part0, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it can't be looked
+	 * up any more even if openers still hold references to it.
+	 */
+	remove_inode_hash(disk->part0->bd_inode);
+
+	set_capacity(disk, 0);
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+
+		/*
+		 * Unregister bdi before releasing device numbers (as they can
+		 * get reused and we'd get clashes in sysfs).
+		 */
+		bdi_unregister(disk->queue->backing_dev_info);
+	}
+
+	blk_unregister_queue(disk);
+
+	kobject_put(disk->part0->bd_holder_dir);
+	kobject_put(disk->slave_dir);
+
+	part_stat_set_all(disk->part0, 0);
+	disk->part0->bd_stamp = 0;
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
+	device_del(disk_to_dev(disk));
 }
 EXPORT_SYMBOL(del_gendisk);
 
