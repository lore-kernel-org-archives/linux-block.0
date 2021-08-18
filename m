Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E346C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5762B610E7
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhHROux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhHROuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:50:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBCBC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uwDZOjKwRsV1f7zGsAa+q2vxp2oFRpQ5/atld9PpQyE=; b=OoKmycKyyhgyIAnwtSr4YbOpIw
        xTBCMtVz1MIIFtVjqKE2gWfXj2s3G2iJFy3CW+2Lw0G2kGu3bI4o1ENtdHpfX7vln3PLnDRNU8FoY
        drUSRMya6Ou3DZFxKxw2INoBoEhGrPCP1tHAMjeSM+yfBxs8VJ4Uj2ZVOZVTg6zdmGB3xaYWkNUr9
        kq27323C8W4jOSUHLxeg1N/Qazb/P9+N4ZvNbSSshaQgHAcpf+durv6pWjYVVqPthT4Os/5CLbV4X
        MkgPScnZm83rvtNvQKuxUlwwoAxlXMY4wc102PIBqmFMW3Xo5NauFSgeimjC7fKwsf38ON+i7ApFN
        6BqVGlwA==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMsO-003whz-AS; Wed, 18 Aug 2021 14:49:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/11] block: call bdev_add later in device_add_disk
Date:   Wed, 18 Aug 2021 16:45:34 +0200
Message-Id: <20210818144542.19305-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once bdev_add is called userspace can open the block device.  Ensure
that the struct device, which is used for refcounting of the disk
besides various other things, is fully setup at that point.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ec4be5889fbf..ab455f110be2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -466,29 +466,14 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_alloc_events(disk);
 
-	if (disk->flags & GENHD_FL_HIDDEN) {
-		/*
-		 * Don't let hidden disks show up in /proc/partitions,
-		 * and don't bother scanning for partitions either.
-		 */
-		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
-		disk->flags |= GENHD_FL_NO_PART_SCAN;
-	} else {
-		/* Register BDI before referencing it from bdev */
-		ddev->devt = MKDEV(disk->major, disk->first_minor);
-		ret = bdi_register(disk->bdi, "%u:%u",
-				   disk->major, disk->first_minor);
-		WARN_ON(ret);
-		bdi_set_owner(disk->bdi, ddev);
-		bdev_add(disk->part0, ddev->devt);
-	}
-
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
 	ddev->parent = parent;
 	ddev->groups = groups;
 	dev_set_name(ddev, "%s", disk->disk_name);
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	if (device_add(ddev))
 		return;
 	if (!sysfs_deprecated) {
@@ -521,12 +506,25 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->slave_dir = NULL;
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+	if (disk->flags & GENHD_FL_HIDDEN) {
+		/*
+		 * Don't let hidden disks show up in /proc/partitions,
+		 * and don't bother scanning for partitions either.
+		 */
+		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
+		disk->flags |= GENHD_FL_NO_PART_SCAN;
+	} else {
+		ret = bdi_register(disk->bdi, "%u:%u",
+				   disk->major, disk->first_minor);
+		WARN_ON(ret);
+		bdi_set_owner(disk->bdi, ddev);
+		bdev_add(disk->part0, ddev->devt);
+
 		disk_scan_partitions(disk);
 
 		/*
 		 * Announce the disk and partitions after all partitions are
-		 * created.
+		 * created. (for hidden disks uevents remain suppressed forever)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
-- 
2.30.2

