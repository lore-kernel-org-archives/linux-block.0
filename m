Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D19AC4338F
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116A360F11
	for <linux-block@archiver.kernel.org>; Sun, 25 Jul 2021 05:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhGYFRs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:17:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA4C061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GO9nEZCe8joo7ZVWHyan42jrqsSCLDjd4CbOG0x53/Y=; b=Wh0H4Stpi7JMDv8mXHqBFWq84l
        oI0QbnqhwH7v0120E9B+Ci5I9OAiVVUmBY7jRiVaJDkO04M4ax3z10QBIVICY+QTY7xrmozzwXFVe
        cKRCrPnPDbeeNRAeDlzOLs91m7/ae024QtS6Sop3JdV1Xcarmq4Awz5Yx32afw8z0Xzn4YPE8ibHE
        pFyiaxQUpACHlsjPzXk+afkHJonHzJ7/DH8pZlvaHDVj+prFhZZ8cKmPsq3VNczrMakZ3mswr6DZQ
        j0cITtNv4CdzUdH7xfQEm1oq4aKCBtdBr+ROmSRJOfdTBp41KDSc4K+fr76pCd8IpyEx8WxwoVLlB
        Zgz2gKDg==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X94-00Cpqe-4G; Sun, 25 Jul 2021 05:58:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: remove support for delayed queue registrations
Date:   Sun, 25 Jul 2021 07:54:58 +0200
Message-Id: <20210725055458.29008-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that device mapper has been changed to register the disk once
it is fully ready all this code is unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c      |  1 -
 block/genhd.c         | 29 +++++++----------------------
 include/linux/genhd.h |  6 ------
 3 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..706d5a64508d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -702,7 +702,6 @@ void elevator_init_mq(struct request_queue *q)
 		elevator_put(e);
 	}
 }
-EXPORT_SYMBOL_GPL(elevator_init_mq); /* only for dm-rq */
 
 /*
  * switch to new_e io scheduler. be careful not to introduce deadlocks -
diff --git a/block/genhd.c b/block/genhd.c
index e3d93b868ec5..3cd9f165a5a7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -457,20 +457,20 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 }
 
 /**
- * __device_add_disk - add disk information to kernel list
+ * device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
  * @disk: per-device partitioning information
  * @groups: Additional per-device sysfs groups
- * @register_queue: register the queue if set to true
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
  * FIXME: error handling
  */
-static void __device_add_disk(struct device *parent, struct gendisk *disk,
-			      const struct attribute_group **groups,
-			      bool register_queue)
+
+void device_add_disk(struct device *parent, struct gendisk *disk,
+		     const struct attribute_group **groups)
+
 {
 	int ret;
 
@@ -480,8 +480,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * elevator if one is needed, that is, for devices requesting queue
 	 * registration.
 	 */
-	if (register_queue)
-		elevator_init_mq(disk->queue);
+	elevator_init_mq(disk->queue);
 
 	/*
 	 * If the driver provides an explicit major number it also must provide
@@ -535,8 +534,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		bdev_add(disk->part0, dev->devt);
 	}
 	register_disk(parent, disk, groups);
-	if (register_queue)
-		blk_register_queue(disk);
+	blk_register_queue(disk);
 
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
@@ -550,21 +548,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-
-void device_add_disk(struct device *parent, struct gendisk *disk,
-		     const struct attribute_group **groups)
-
-{
-	__device_add_disk(parent, disk, groups, true);
-}
 EXPORT_SYMBOL(device_add_disk);
 
-void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
-{
-	__device_add_disk(parent, disk, NULL, false);
-}
-EXPORT_SYMBOL(device_add_disk_no_queue_reg);
-
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index dd95d53c75fa..fbc4bf269f63 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -218,12 +218,6 @@ static inline void add_disk(struct gendisk *disk)
 {
 	device_add_disk(NULL, disk, NULL);
 }
-extern void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
-static inline void add_disk_no_queue_reg(struct gendisk *disk)
-{
-	device_add_disk_no_queue_reg(NULL, disk);
-}
-
 extern void del_gendisk(struct gendisk *gp);
 
 void set_disk_ro(struct gendisk *disk, bool read_only);
-- 
2.30.2

