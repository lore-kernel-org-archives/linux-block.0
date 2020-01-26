Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A50C2D0DB
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F5320708
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UhBUBIwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgAZNF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jan 2020 08:05:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgAZNF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 08:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TTRjn2cNHooXij0AA9TKQxxBeOg+hqwlpNrsvUKzgLA=; b=UhBUBIwREdC5GDAQOnDrSOREM
        3B1C2slATFU2RaM6j9C7J+rIlz91aTjeLCRxlVuyXiV1LLmw62nIHyyKxkKHK1n/J3C/rkEGxkCAD
        SZ/ie/VW8hHRsXwUl01cPZtaITFpgdd1kSJqiI9DIS8lkz1//bBbAse/Mea5UfyR9sqg+UD34o8KS
        54I2HrSiSUKxJwDlcEXw2UXD/Tag3h+b20BUaS3tvTx5lUYaMmnmNUWjfzi7G4UFCcjZVrZ8XnY9a
        A/S31R6LUBYmMaTbcV5wZUFb+q1JJpPC9lHQSx/wqn1RdW4QYAK+njPAWU9SbuPxVCtr+dlFeDCqA
        kZreoXz7Q==;
Received: from [46.189.28.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivhbu-0000UK-7Z; Sun, 26 Jan 2020 13:05:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     bp@suse.de, damien.lemoal@wdc.com, linux-block@vger.kernel.org
Subject: [PATCH] block: allow partitions on host aware zone devices
Date:   Sun, 26 Jan 2020 14:05:43 +0100
Message-Id: <20200126130543.798869-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Host-aware SMR drives can be used with the commands to explicitly manage
zone state, but they can also be used as normal disks.  In the former
case it makes perfect sense to allow partitions on them, in the latter
it does not, just like for host managed devices.  Add a check to
add_partition to allow partitions on host aware devices, but give
up any zone management capabilities in that case, which also catches
the previously missed case of adding a partition vs just scanning it.

Because sd can rescan the attribute at runtime it needs to check if
a disk has partitions, for which a new helper is added to genhd.h.

Fixes: 5eac3eb30c9a ("block: Remove partition support for zoned block devices")
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/partition-generic.c | 26 ++++++++++++++++++++++----
 drivers/scsi/sd.c         |  9 +++++----
 include/linux/genhd.h     | 12 ++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1d20c9cf213f..564fae77711d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -321,6 +321,24 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	const char *dname;
 	int err;
 
+	/*
+	 * Partitions are not supported on zoned block devices that are used as
+	 * such.
+	 */
+	switch (disk->queue->limits.zoned) {
+	case BLK_ZONED_HM:
+		pr_warn("%s: partitions not supported on host managed zoned block device\n",
+			disk->disk_name);
+		return ERR_PTR(-ENXIO);
+	case BLK_ZONED_HA:
+		pr_info("%s: disabling host aware zoned block device support due to partitions\n",
+			disk->disk_name);
+		disk->queue->limits.zoned = BLK_ZONED_NONE;
+		break;
+	case BLK_ZONED_NONE:
+		break;
+	}
+
 	err = disk_expand_part_tbl(disk, partno);
 	if (err)
 		return ERR_PTR(err);
@@ -501,7 +519,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
 			     &state->parts[p].info);
-	if (IS_ERR(part)) {
+	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
 		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
 		       disk->disk_name, p, -PTR_ERR(part));
 		return true;
@@ -540,10 +558,10 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	}
 
 	/*
-	 * Partitions are not supported on zoned block devices.
+	 * Partitions are not supported on host managed zoned block devices.
 	 */
-	if (bdev_is_zoned(bdev)) {
-		pr_warn("%s: ignoring partition table on zoned block device\n",
+	if (disk->queue->limits.zoned == BLK_ZONED_HM) {
+		pr_warn("%s: ignoring partition table on host managed zoned block device\n",
 			disk->disk_name);
 		ret = 0;
 		goto out_free_state;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 65ce10c7989c..902b649fc8ef 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2958,15 +2958,16 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 		q->limits.zoned = BLK_ZONED_HM;
 	} else {
 		sdkp->zoned = (buffer[8] >> 4) & 3;
-		if (sdkp->zoned == 1)
+		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
 			/* Host-aware */
 			q->limits.zoned = BLK_ZONED_HA;
-		else
+		} else {
 			/*
-			 * Treat drive-managed devices as
-			 * regular block devices.
+			 * Treat drive-managed devices and host-aware devices
+			 * with partitions as regular block devices.
 			 */
 			q->limits.zoned = BLK_ZONED_NONE;
+		}
 	}
 	if (blk_queue_is_zoned(q) && sdkp->first_scan)
 		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..ea4c133b4139 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -245,6 +245,18 @@ static inline bool disk_part_scan_enabled(struct gendisk *disk)
 		!(disk->flags & GENHD_FL_NO_PART_SCAN);
 }
 
+static inline bool disk_has_partitions(struct gendisk *disk)
+{
+	bool ret = false;
+
+	rcu_read_lock();
+	if (rcu_dereference(disk->part_tbl)->len > 1)
+		ret = true;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static inline dev_t disk_devt(struct gendisk *disk)
 {
 	return MKDEV(disk->major, disk->first_minor);
-- 
2.24.1

