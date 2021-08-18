Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73EFC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C266108E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhHRO4l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbhHRO4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:56:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1EC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b9mN09gS/ikMtMuuwj30sih1WzgUOqMQ0hKWLzxzUZU=; b=o38FQ+A+Hih2YFVQbdtQ+tmCAi
        A9tKBZQftoNmEJEvz5ohzzYr4k/+Ka7/eDx9tPDMSCTxmfrfb2kRvZxTvvTDPG/jsFXeeRD1admVK
        /QnOrhAou7eY7R0y2mloVH91TtXJY4klvjoAG/GJ1S2DxWuCD5ZMARxzRDlhFJ5NcDCUx4OWBpLgz
        78uhzJwnG8dLJ1oEYlHnGOR8rlUfvXdx73Wn5bTJEw/dW3OA2nZjPWuqcnx/p4sgpo24LlVPrN+va
        7dhz3cQkRVX8V1gM1EK6Jkyns9j1RgrGJSD81Y435WF6JQBzu6KAcTbic0dVr3YnL1bAOVjw5ejoX
        QK2ijS4g==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMxc-003wzy-Ft; Wed, 18 Aug 2021 14:54:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 09/11] block: add error handling for device_add_disk / add_disk
Date:   Wed, 18 Aug 2021 16:45:40 +0200
Message-Id: <20210818144542.19305-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Properly unwind on errors in device_add_disk.  This is the initial work
as drivers are not converted yet, which will follow in separate patches.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
[hch: major rebase.  All bugs are probably mine]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 92 +++++++++++++++++++++++++++----------------
 include/linux/genhd.h |  8 ++--
 2 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a54b4849242c..a925f773145f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -417,11 +417,8 @@ static void disk_scan_partitions(struct gendisk *disk)
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
- *
- * FIXME: error handling
  */
-
-void device_add_disk(struct device *parent, struct gendisk *disk,
+int device_add_disk(struct device *parent, struct gendisk *disk,
 		     const struct attribute_group **groups)
 
 {
@@ -444,7 +441,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	 * and all partitions from the extended dev_t space.
 	 */
 	if (disk->major) {
-		WARN_ON(!disk->minors);
+		if (WARN_ON(!disk->minors))
+			return -EINVAL;
 
 		if (disk->minors > DISK_MAX_PARTS) {
 			pr_err("block: can't allocate more than %d partitions\n",
@@ -452,19 +450,20 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 			disk->minors = DISK_MAX_PARTS;
 		}
 	} else {
-		WARN_ON(disk->minors);
+		if (WARN_ON(disk->minors))
+			return -EINVAL;
 
 		ret = blk_alloc_ext_minor();
-		if (ret < 0) {
-			WARN_ON(1);
-			return;
-		}
+		if (ret < 0)
+			return ret;
 		disk->major = BLOCK_EXT_MAJOR;
 		disk->first_minor = MINOR(ret);
 		disk->flags |= GENHD_FL_EXT_DEVT;
 	}
 
-	disk_alloc_events(disk);
+	ret = disk_alloc_events(disk);
+	if (ret)
+		goto out_free_ext_minor;
 
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
@@ -474,15 +473,14 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	dev_set_name(ddev, "%s", disk->disk_name);
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
-	if (device_add(ddev))
-		return;
+	ret = device_add(ddev);
+	if (ret)
+		goto out_disk_release_events;
 	if (!sysfs_deprecated) {
 		ret = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
-		if (ret) {
-			device_del(ddev);
-			return;
-		}
+		if (ret)
+			goto out_device_del;
 	}
 
 	/*
@@ -492,23 +490,25 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	blk_integrity_add(disk);
+	ret = blk_integrity_add(disk);
+	if (ret)
+		goto out_del_block_link;
 
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
+	if (!disk->part0->bd_holder_dir)
+		goto out_del_integrity;
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
+	if (!disk->slave_dir)
+		goto out_put_holder_dir;
 
-	/*
-	 * XXX: this is a mess, can't wait for real error handling in add_disk.
-	 * Make sure ->slave_dir is NULL if we failed some of the registration
-	 * so that the cleanup in bd_unlink_disk_holder works properly.
-	 */
-	if (bd_register_pending_holders(disk) < 0) {
-		kobject_put(disk->slave_dir);
-		disk->slave_dir = NULL;
-	}
+	ret = bd_register_pending_holders(disk);
+	if (ret < 0)
+		goto out_put_slave_dir;
 
-	blk_register_queue(disk);
+	ret = blk_register_queue(disk);
+	if (ret)
+		goto out_put_slave_dir;
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
@@ -520,13 +520,13 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	} else {
 		ret = bdi_register(disk->bdi, "%u:%u",
 				   disk->major, disk->first_minor);
-		WARN_ON(ret);
+		if (ret)
+			goto out_unregister_queue;
 		bdi_set_owner(disk->bdi, ddev);
-		if (disk->bdi->dev) {
-			ret = sysfs_create_link(&ddev->kobj,
-						&disk->bdi->dev->kobj, "bdi");
-			WARN_ON(ret);
-		}
+		ret = sysfs_create_link(&ddev->kobj,
+					&disk->bdi->dev->kobj, "bdi");
+		if (ret)
+			goto out_unregister_bdi;
 
 		bdev_add(disk->part0, ddev->devt);
 		disk_scan_partitions(disk);
@@ -541,6 +541,30 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_update_readahead(disk);
 	disk_add_events(disk);
+	return 0;
+
+out_unregister_bdi:
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		bdi_unregister(disk->bdi);
+out_unregister_queue:
+	blk_unregister_queue(disk);
+out_put_slave_dir:
+	kobject_put(disk->slave_dir);
+out_put_holder_dir:
+	kobject_put(disk->part0->bd_holder_dir);
+out_del_integrity:
+	blk_integrity_del(disk);
+out_del_block_link:
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(ddev));
+out_device_del:
+	device_del(ddev);
+out_disk_release_events:
+	disk_release_events(disk);
+out_free_ext_minor:
+	if (disk->major == BLOCK_EXT_MAJOR)
+		blk_free_ext_minor(disk->first_minor);
+	return WARN_ON_ONCE(ret); /* keep until all callers handle errors */
 }
 EXPORT_SYMBOL(device_add_disk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 55acefdd8a20..c68d83c87f83 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -214,11 +214,11 @@ static inline dev_t disk_devt(struct gendisk *disk)
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 /* block/genhd.c */
-extern void device_add_disk(struct device *parent, struct gendisk *disk,
-			    const struct attribute_group **groups);
-static inline void add_disk(struct gendisk *disk)
+int device_add_disk(struct device *parent, struct gendisk *disk,
+		const struct attribute_group **groups);
+static inline int add_disk(struct gendisk *disk)
 {
-	device_add_disk(NULL, disk, NULL);
+	return device_add_disk(NULL, disk, NULL);
 }
 extern void del_gendisk(struct gendisk *gp);
 
-- 
2.30.2

