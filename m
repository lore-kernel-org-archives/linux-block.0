Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E2C432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364F4610D2
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhHROuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhHROuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:50:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF31AC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oSraqT5Od7AFAD1YVJjRhxExyuP9kDMh/G943lpHfAA=; b=Ba7xAVBLMKM8HaH25kl/b5XFOc
        PqeyIgCtd8ntY7SPONiHtgxkjobCq9a+qwzqXAzEb1ZOJY4iqZtssAh+2TjxzOnGYZtnBsXDwNV+U
        +tMn5raDTCPF6jq7pRjOaN1NHP7ljez8L2SToH8/AkDAQIbq+5JVgpRbqORl2veZOWP/mbgG4+4UZ
        HYsg6droeWs5NjLIYxOatXnwMxxYV7VKVafvWs5CFf1vhcR3rxFGyVzYzxoYTK1xRk635n4mw2BWR
        DQDDvFDgLmR/AFPGBC5enA4JedBuFhaV0zutupog4Oz79OoC/ZDetej/cReYBb8haJTFTj3C+Lg9G
        NEirPBhQ==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMrI-003wdU-V7; Wed, 18 Aug 2021 14:48:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 02/11] block: fold register_disk into device_add_disk
Date:   Wed, 18 Aug 2021 16:45:33 +0200
Message-Id: <20210818144542.19305-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no real reason these should be separate.  Also simplify the
groups assignment a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 131 +++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 71 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 935f74c652f1..ec4be5889fbf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -409,71 +409,6 @@ static void disk_scan_partitions(struct gendisk *disk)
 		blkdev_put(bdev, FMODE_READ);
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk,
-			  const struct attribute_group **groups)
-{
-	struct device *ddev = disk_to_dev(disk);
-	int err;
-
-	ddev->parent = parent;
-
-	dev_set_name(ddev, "%s", disk->disk_name);
-
-	/* delay uevents, until we scanned partition table */
-	dev_set_uevent_suppress(ddev, 1);
-
-	if (groups) {
-		WARN_ON(ddev->groups);
-		ddev->groups = groups;
-	}
-	if (device_add(ddev))
-		return;
-	if (!sysfs_deprecated) {
-		err = sysfs_create_link(block_depr, &ddev->kobj,
-					kobject_name(&ddev->kobj));
-		if (err) {
-			device_del(ddev);
-			return;
-		}
-	}
-
-	/*
-	 * avoid probable deadlock caused by allocating memory with
-	 * GFP_KERNEL in runtime_resume callback of its all ancestor
-	 * devices
-	 */
-	pm_runtime_set_memalloc_noio(ddev, true);
-
-	disk->part0->bd_holder_dir =
-		kobject_create_and_add("holders", &ddev->kobj);
-	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
-
-	/*
-	 * XXX: this is a mess, can't wait for real error handling in add_disk.
-	 * Make sure ->slave_dir is NULL if we failed some of the registration
-	 * so that the cleanup in bd_unlink_disk_holder works properly.
-	 */
-	if (bd_register_pending_holders(disk) < 0) {
-		kobject_put(disk->slave_dir);
-		disk->slave_dir = NULL;
-	}
-
-	if (disk->flags & GENHD_FL_HIDDEN)
-		return;
-
-	disk_scan_partitions(disk);
-
-	/* announce the disk and partitions after all partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	disk_uevent(disk, KOBJ_ADD);
-
-	if (disk->bdi->dev) {
-		err = sysfs_create_link(&ddev->kobj, &disk->bdi->dev->kobj,
-					"bdi");
-		WARN_ON(err);
-	}
-}
-
 /**
  * device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
@@ -490,6 +425,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		     const struct attribute_group **groups)
 
 {
+	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
 	/*
@@ -538,17 +474,70 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
-		struct device *dev = disk_to_dev(disk);
-
 		/* Register BDI before referencing it from bdev */
-		dev->devt = MKDEV(disk->major, disk->first_minor);
+		ddev->devt = MKDEV(disk->major, disk->first_minor);
 		ret = bdi_register(disk->bdi, "%u:%u",
 				   disk->major, disk->first_minor);
 		WARN_ON(ret);
-		bdi_set_owner(disk->bdi, dev);
-		bdev_add(disk->part0, dev->devt);
+		bdi_set_owner(disk->bdi, ddev);
+		bdev_add(disk->part0, ddev->devt);
+	}
+
+	/* delay uevents, until we scanned partition table */
+	dev_set_uevent_suppress(ddev, 1);
+
+	ddev->parent = parent;
+	ddev->groups = groups;
+	dev_set_name(ddev, "%s", disk->disk_name);
+	if (device_add(ddev))
+		return;
+	if (!sysfs_deprecated) {
+		ret = sysfs_create_link(block_depr, &ddev->kobj,
+					kobject_name(&ddev->kobj));
+		if (ret) {
+			device_del(ddev);
+			return;
+		}
 	}
-	register_disk(parent, disk, groups);
+
+	/*
+	 * avoid probable deadlock caused by allocating memory with
+	 * GFP_KERNEL in runtime_resume callback of its all ancestor
+	 * devices
+	 */
+	pm_runtime_set_memalloc_noio(ddev, true);
+
+	disk->part0->bd_holder_dir =
+		kobject_create_and_add("holders", &ddev->kobj);
+	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
+
+	/*
+	 * XXX: this is a mess, can't wait for real error handling in add_disk.
+	 * Make sure ->slave_dir is NULL if we failed some of the registration
+	 * so that the cleanup in bd_unlink_disk_holder works properly.
+	 */
+	if (bd_register_pending_holders(disk) < 0) {
+		kobject_put(disk->slave_dir);
+		disk->slave_dir = NULL;
+	}
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		disk_scan_partitions(disk);
+
+		/*
+		 * Announce the disk and partitions after all partitions are
+		 * created.
+		 */
+		dev_set_uevent_suppress(ddev, 0);
+		disk_uevent(disk, KOBJ_ADD);
+
+		if (disk->bdi->dev) {
+			ret = sysfs_create_link(&ddev->kobj,
+						&disk->bdi->dev->kobj, "bdi");
+			WARN_ON(ret);
+		}
+	}
+
 	blk_register_queue(disk);
 
 	disk_add_events(disk);
-- 
2.30.2

