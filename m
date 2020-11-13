Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E2C63699
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C452A20709
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+oaMvfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMIrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgKMIrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 03:47:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078EC0617A7
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vYddKosE6Dx5+s3L5inGbMZIbhgZeV1LQhfvLQNaL7g=; b=j+oaMvfxDhhQnDEW6NhNaGQgzA
        DYHHebeL0FQi0xZKzGB0sbHEERYqsNnMI8lMO5b8iEV4xVVoigzgx6ULnJmHrZ9fm5AZKF75Dmzo+
        luNPoYhY2YYB/Uyb6ItpVd+aota9pPXUS14/31AC11YVx2MnFypnTWuEEMTpU6B0+lSl/INzIJZEQ
        N/d/wIDLU4e7PXVYKwV3CTCQ4hDDOV+suE6ANHaSped6RqRP8E5fi3zPNSZpz8tB3j7e/7tXZrvRS
        lQPAYjtK29ZppYF4xd6BkSXzov+QhUFcL0dasDTe1tH3QRmdyu1krzv7DruQSvAuaai97tJX68zhG
        cagHGqCw==;
Received: from [2001:4bb8:180:6600:bcb2:53c8:d87f:72a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUjY-0000QS-F6; Fri, 13 Nov 2020 08:47:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: Fix read-only block device setting after revalidate
Date:   Fri, 13 Nov 2020 09:47:00 +0100
Message-Id: <20201113084702.4164912-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113084702.4164912-1-hch@lst.de>
References: <20201113084702.4164912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Martin K. Petersen" <martin.petersen@oracle.com>

Commit 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading
partition") addressed a long-standing problem with user read-only
policy being overridden as a result of a device-initiated revalidate.
The commit has since been reverted due to a regression that left some
USB devices read-only indefinitely.

To fix the underlying problems with revalidate we need to keep track
of hardware state and user policy separately. Every time the state is
changed, either via a hardware event or the BLKROSET ioctl, the
per-partition read-only state is updated based on the combination of
device state and policy. The resulting active state is stored in a
separate hd_struct flag to avoid introducing additional lookups in the
I/O hot path.

The gendisk has been updated to reflect the current hardware state set
by the device driver. This is done to allow returning the device to
the hardware state once the user clears the BLKROSET flag.

For partitions, the existing hd_struct 'policy' flag is replaced with a
new HD_RO_POLICY flag in a new state variable and changed to only
indicate whether the user has administratively set partition read-only
via the BLKROSET ioctl.

The bdev_read_only helper and its open coded variants also check the
whole device administratively policy as well as the hardware state.

The resulting semantics are as follows:

 - If BLKROSET is used to set a whole-disk device read-only, any
   partitions will end up in a read-only state until the user
   explicitly clears the flag.

 - If BLKROSET sets a given partition read-only, that partition will
   remain read-only even if the underlying storage stack initiates a
   revalidate. However, the BLKRRPART ioctl will cause the partition
   table to be dropped and any user policy on partitions will be lost.

 - If BLKROSET has not been set, both the whole disk device and any
   partitions will reflect the current write-protect state of the
   underlying device.

Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[hch: rebased.  don't mirror the compound read-only flag into a field,
	use flag instead of bools]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c        |  4 ++-
 block/blk.h             |  3 +++
 block/genhd.c           | 59 ++++++++++++++++++++++++++++++++---------
 block/ioctl.c           |  5 +++-
 block/partitions/core.c |  7 +++--
 include/linux/genhd.h   | 10 ++++---
 6 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2db8bda43b6e6d..b6dea07e08c9c7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -695,7 +695,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && op_is_write(op)) {
+	if (op_is_write(op) &&
+	    (test_bit(GD_READ_ONLY, &bio->bi_disk->state) ||
+	     test_bit(HD_RO_POLICY, &part->state))) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9a5..446776853cedd9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -444,4 +444,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+void update_part_ro_state(struct hd_struct *part, bool read_only);
+void update_all_part_ro_state(struct gendisk *disk, bool read_only);
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 15b90e56a1a6ea..65f6b744f4ebd5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1835,31 +1835,66 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_disk_ro(struct gendisk *disk, int flag)
+void update_part_ro_state(struct hd_struct *part, bool read_only)
 {
-	struct disk_part_iter piter;
-	struct hd_struct *part;
+	if (read_only)
+		set_bit(HD_RO_POLICY, &part->state);
+	else
+		clear_bit(HD_RO_POLICY, &part->state);
+}
 
-	if (disk->part0.policy != flag) {
-		set_disk_ro_uevent(disk, flag);
-		disk->part0.policy = flag;
-	}
+/**
+ * update_all_part_ro_state - iterate over partitions to update read-only state
+ * @disk:	The disk device
+ *
+ * This function updates the read-only state for all partitions on a
+ * given disk device. This is required every time a hardware event
+ * signals that the device write-protect state has changed. It is also
+ * necessary when the user sets or clears the read-only flag on the
+ * whole-disk device.
+ */
+void update_all_part_ro_state(struct gendisk *disk, bool read_only)
+{
+ 	struct disk_part_iter piter;
+ 	struct hd_struct *part;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY_PART0);
 	while ((part = disk_part_iter_next(&piter)))
-		part->policy = flag;
-	disk_part_iter_exit(&piter);
+		update_part_ro_state(part, read_only);
+ 	disk_part_iter_exit(&piter);
 }
 
+/**
+ * set_disk_ro - set a gendisk read-only
+ * @disk:	The disk device
+ * @state:	true or false
+ *
+ * This function is used to indicate whether a given disk device
+ * should have its read-only flag set. set_disk_ro() is typically used
+ * by device drivers to indicate whether the underlying physical
+ * device is write-protected.
+ */
+void set_disk_ro(struct gendisk *disk, bool read_only)
+{
+	if (read_only) {
+		if (test_and_set_bit(GD_READ_ONLY, &disk->state))
+			return;
+	} else {
+		if (!test_and_clear_bit(GD_READ_ONLY, &disk->state))
+			return;
+	}
+	update_all_part_ro_state(disk, read_only);
+	set_disk_ro_uevent(disk, read_only);
+}
 EXPORT_SYMBOL(set_disk_ro);
 
 int bdev_read_only(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return bdev->bd_part->policy;
+	return test_bit(GD_READ_ONLY, &bdev->bd_disk->state) ||
+		test_bit(HD_RO_POLICY, &bdev->bd_part->state);
 }
-
 EXPORT_SYMBOL(bdev_read_only);
 
 /*
diff --git a/block/ioctl.c b/block/ioctl.c
index 6b785181344fe1..ce3c9a4dd66d34 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -354,7 +354,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_part->policy = n;
+	if (bdev_is_partition(bdev))
+		update_part_ro_state(bdev->bd_part, n);
+	else
+		update_all_part_ro_state(bdev->bd_disk, n);
 	return 0;
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index a02e224115943d..aabf9d6d39e59e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -192,7 +192,9 @@ static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%d\n", p->policy ? 1 : 0);
+	return sprintf(buf, "%d\n",
+		    	test_bit(GD_READ_ONLY, &part_to_disk(p)->state) ||
+		    	test_bit(HD_RO_POLICY, &p->state));
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
@@ -414,7 +416,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	p->start_sect = start;
 	p->nr_sects = len;
 	p->partno = partno;
-	p->policy = get_disk_ro(disk);
+	if (get_disk_ro(disk))
+		set_bit(HD_RO_POLICY, &p->state);
 
 	if (info) {
 		struct partition_meta_info *pinfo;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 79e334159778a5..2609bc78ff131b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -67,7 +67,9 @@ struct hd_struct {
 
 	struct device __dev;
 	struct kobject *holder_dir;
-	int policy, partno;
+	int partno;
+	unsigned long state;
+#define HD_RO_POLICY			0
 	struct partition_meta_info *info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
@@ -193,6 +195,7 @@ struct gendisk {
 	int flags;
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
+#define GD_READ_ONLY			1
 	struct rw_semaphore lookup_sem;
 	struct kobject *slave_dir;
 
@@ -304,11 +307,12 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_disk_ro(struct gendisk *disk, int flag);
+void set_disk_ro(struct gendisk *disk, bool read_only);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.policy;
+	return test_bit(GD_READ_ONLY, &disk->state) ||
+		test_bit(HD_RO_POLICY, &disk->part0.state);
 }
 
 extern void disk_block_events(struct gendisk *disk);
-- 
2.28.0

