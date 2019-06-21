Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B1DC43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262482083B
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="d3qDl7gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFUNHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:07:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFUNHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 09:07:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so5937788ljg.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vhySjd6HyAQGz86wftxAId7gw5oA1TV6yT5lbqXCs8=;
        b=d3qDl7gtl1j+Hk3gb4K9KzB8LgwmlfJO9/Yo2ozFsDzcLkQTT7WxQR8Xj2jQC6naSF
         1d5MH4Hg/i/lDsXxqSx1YKJCpvMaAYROYH+kzVZGWYebgZj+2M7XyZwqiyv6R8pMQijt
         QekloHa3XLx2rYBXWeh0hYlfYHO5RtIHnNrPiaHKmAeHsIJgszBNpLpg2c9pc3h0pucO
         jKelgmr4Hzo2RjY35WGuQwDh5TCTVbTZdWWx5PdBA+O2x8WkagZji9/C2bRtzvl4yKRK
         mUI21721hUJvD7/oFR2F/14ymv0qkzuNyn7SsvGbT8OqoY6IitKrsaFZRSQMDusYuH2Q
         /XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vhySjd6HyAQGz86wftxAId7gw5oA1TV6yT5lbqXCs8=;
        b=VpcjfVA1ZCWVxbffXJfWix4MRmSs5Rd6E/z+bqPSr32jDh5Fj9eogXiVnQKbSEnYms
         mSgGWGusZ9HQp+1imDrF2GVSUnkmvbcy8lLdRI9x+PBUIrwe2mWGiaWggEM2/ZiblbUc
         uBX0MDa3LbxtZHg+MAl9XU44L6rA9sBRhCJfDbN8AvyEoBQHIcnGLJZILwg3dBY5W7ji
         JKgnS5jjVnbs45fG0xv7cLEk/4hXKzIPDxsslaLWnwibLWsiKcOUsZHnGzU6OxdfHNEG
         JlIN0c0jgfuZ5Q9ycw1DvZAGQ7ev0SuktkIPyacLe/rhDRGBER9wWxIXDVzUqOcD7g5p
         mgsA==
X-Gm-Message-State: APjAAAU0xT2WJWxL/G01ZFRSfhrt5kKrVD4IOKd3nv3wQo43RrtXntDS
        Pz3a9ykrkKIGi2lOoGuGBLnbiA==
X-Google-Smtp-Source: APXvYqyaj5zE2Q4iZD1SSrYtvHM9/oy8VgGciJ2+N1JfUErT2t/do01rXTFk51qdeIQwjDJN9L3VMA==
X-Received: by 2002:a2e:650a:: with SMTP id z10mr32642486ljb.28.1561122449940;
        Fri, 21 Jun 2019 06:07:29 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:29 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/4] block: add zone open, close and finish support
Date:   Fri, 21 Jun 2019 15:07:08 +0200
Message-Id: <20190621130711.21986-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621130711.21986-1-mb@lightnvm.io>
References: <20190621130711.21986-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

Zoned block devices allows one to control zone transitions by using
explicit commands. The available transitions are:

  * Open zone: Transition a zone to open state.
  * Close zone: Transition a zone to closed state.
  * Finish zone: Transition a zone to full state.

Allow kernel to issue these transitions by introducing
blkdev_zones_mgmt_op() and add three new request opcodes:

  * REQ_IO_ZONE_OPEN, REQ_IO_ZONE_CLOSE, and REQ_OP_ZONE_FINISH

Allow user-space to issue the transitions through the following ioctls:

  * BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 block/blk-core.c              |  3 ++
 block/blk-zoned.c             | 51 ++++++++++++++++++++++---------
 block/ioctl.c                 |  5 ++-
 include/linux/blk_types.h     | 27 +++++++++++++++--
 include/linux/blkdev.h        | 57 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/blkzoned.h | 17 +++++++++--
 6 files changed, 133 insertions(+), 27 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8340f69670d8..c0f0dbad548d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -897,6 +897,9 @@ generic_make_request_checks(struct bio *bio)
 			goto not_supported;
 		break;
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
 		if (!blk_queue_is_zoned(q))
 			goto not_supported;
 		break;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..d0c933593b93 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -201,20 +201,22 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
 /**
- * blkdev_reset_zones - Reset zones write pointer
+ * blkdev_zones_mgmt_op - Perform the specified operation on the zone(s)
  * @bdev:	Target block device
- * @sector:	Start sector of the first zone to reset
- * @nr_sectors:	Number of sectors, at least the length of one zone
+ * @op:		Operation to be performed on the zone(s)
+ * @sector:	Start sector of the first zone to operate on
+ * @nr_sectors:	Number of sectors, at least the length of one zone and
+ *              must be zone size aligned.
  * @gfp_mask:	Memory allocation flags (for bio_alloc)
  *
  * Description:
- *    Reset the write pointer of the zones contained in the range
+ *    Perform the specified operation contained in the range
  *    @sector..@sector+@nr_sectors. Specifying the entire disk sector range
  *    is valid, but the specified range should not contain conventional zones.
  */
-int blkdev_reset_zones(struct block_device *bdev,
-		       sector_t sector, sector_t nr_sectors,
-		       gfp_t gfp_mask)
+int blkdev_zones_mgmt_op(struct block_device *bdev, enum req_opf op,
+			 sector_t sector, sector_t nr_sectors,
+			 gfp_t gfp_mask)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t zone_sectors;
@@ -226,6 +228,9 @@ int blkdev_reset_zones(struct block_device *bdev,
 	if (!blk_queue_is_zoned(q))
 		return -EOPNOTSUPP;
 
+	if (!op_is_zone_mgmt_op(op))
+		return -EOPNOTSUPP;
+
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
@@ -248,7 +253,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);
+		bio_set_op_attrs(bio, op, 0);
 
 		sector += zone_sectors;
 
@@ -264,7 +269,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blkdev_reset_zones);
+EXPORT_SYMBOL_GPL(blkdev_zones_mgmt_op);
 
 /*
  * BLKREPORTZONE ioctl processing.
@@ -329,15 +334,16 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 }
 
 /*
- * BLKRESETZONE ioctl processing.
+ * Zone operation (open, close, finish or reset) ioctl processing.
  * Called from blkdev_ioctl.
  */
-int blkdev_reset_zones_ioctl(struct block_device *bdev, fmode_t mode,
-			     unsigned int cmd, unsigned long arg)
+int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev, fmode_t mode,
+				unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct request_queue *q;
 	struct blk_zone_range zrange;
+	enum req_opf op;
 
 	if (!argp)
 		return -EINVAL;
@@ -358,8 +364,25 @@ int blkdev_reset_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
 		return -EFAULT;
 
-	return blkdev_reset_zones(bdev, zrange.sector, zrange.nr_sectors,
-				  GFP_KERNEL);
+	switch (cmd) {
+	case BLKRESETZONE:
+		op = REQ_OP_ZONE_RESET;
+		break;
+	case BLKOPENZONE:
+		op = REQ_OP_ZONE_OPEN;
+		break;
+	case BLKCLOSEZONE:
+		op = REQ_OP_ZONE_CLOSE;
+		break;
+	case BLKFINISHZONE:
+		op = REQ_OP_ZONE_FINISH;
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return blkdev_zones_mgmt_op(bdev, op, zrange.sector, zrange.nr_sectors,
+				    GFP_KERNEL);
 }
 
 static inline unsigned long *blk_alloc_zone_bitmap(int node,
diff --git a/block/ioctl.c b/block/ioctl.c
index 15a0eb80ada9..df7fe54db158 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -532,7 +532,10 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKREPORTZONE:
 		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKRESETZONE:
-		return blkdev_reset_zones_ioctl(bdev, mode, cmd, arg);
+	case BLKOPENZONE:
+	case BLKCLOSEZONE:
+	case BLKFINISHZONE:
+		return blkdev_zones_mgmt_op_ioctl(bdev, mode, cmd, arg);
 	case BLKGETZONESZ:
 		return put_uint(arg, bdev_zone_sectors(bdev));
 	case BLKGETNRZONES:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 95202f80676c..067ef9242275 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -284,13 +284,20 @@ enum req_opf {
 	REQ_OP_DISCARD		= 3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
-	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 
+	/* reset a zone write pointer */
+	REQ_OP_ZONE_RESET	= 16,
+	/* Open zone(s) */
+	REQ_OP_ZONE_OPEN	= 17,
+	/* Close zone(s) */
+	REQ_OP_ZONE_CLOSE	= 18,
+	/* Finish zone(s) */
+	REQ_OP_ZONE_FINISH	= 19,
+
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
 	REQ_OP_SCSI_OUT		= 33,
@@ -375,6 +382,22 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
 	bio->bi_opf = op | op_flags;
 }
 
+/*
+ * Check if the op is zoned operation.
+ */
+static inline bool op_is_zone_mgmt_op(enum req_opf op)
+{
+	switch (op) {
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline bool op_is_write(unsigned int op)
 {
 	return (op & 1);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..943084f9dc9c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -348,14 +348,15 @@ extern unsigned int blkdev_nr_zones(struct block_device *bdev);
 extern int blkdev_report_zones(struct block_device *bdev,
 			       sector_t sector, struct blk_zone *zones,
 			       unsigned int *nr_zones, gfp_t gfp_mask);
-extern int blkdev_reset_zones(struct block_device *bdev, sector_t sectors,
-			      sector_t nr_sectors, gfp_t gfp_mask);
 extern int blk_revalidate_disk_zones(struct gendisk *disk);
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
-extern int blkdev_reset_zones_ioctl(struct block_device *bdev, fmode_t mode,
-				    unsigned int cmd, unsigned long arg);
+extern int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev, fmode_t mode,
+					unsigned int cmd, unsigned long arg);
+extern int blkdev_zones_mgmt_op(struct block_device *bdev, enum req_opf op,
+				sector_t sector, sector_t nr_sectors,
+				gfp_t gfp_mask);
 
 #else /* CONFIG_BLK_DEV_ZONED */
 
@@ -376,15 +377,57 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 	return -ENOTTY;
 }
 
-static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
-					   fmode_t mode, unsigned int cmd,
-					   unsigned long arg)
+static inline int blkdev_zones_mgmt_op_ioctl(struct block_device *bdev,
+					     fmode_t mode, unsigned int cmd,
+					     unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static inline int blkdev_zones_mgmt_op(struct block_device *bdev,
+				       enum req_opf op,
+				       sector_t sector, sector_t nr_sectors,
+				       gfp_t gfp_mask)
 {
 	return -ENOTTY;
 }
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static inline int blkdev_reset_zones(struct block_device *bdev,
+				     sector_t sector, sector_t nr_sectors,
+				     gfp_t gfp_mask)
+{
+	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_RESET,
+				    sector, nr_sectors, gfp_mask);
+}
+
+static inline int blkdev_open_zones(struct block_device *bdev,
+				    sector_t sector, sector_t nr_sectors,
+				    gfp_t gfp_mask)
+{
+	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_OPEN,
+				    sector, nr_sectors, gfp_mask);
+}
+
+static inline int blkdev_close_zones(struct block_device *bdev,
+				     sector_t sector, sector_t nr_sectors,
+				     gfp_t gfp_mask)
+{
+	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_CLOSE,
+				    sector, nr_sectors,
+				    gfp_mask);
+}
+
+static inline int blkdev_finish_zones(struct block_device *bdev,
+				      sector_t sector, sector_t nr_sectors,
+				      gfp_t gfp_mask)
+{
+	return blkdev_zones_mgmt_op(bdev, REQ_OP_ZONE_FINISH,
+				    sector, nr_sectors,
+				    gfp_mask);
+}
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 498eec813494..701e0692b8d3 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -120,9 +120,11 @@ struct blk_zone_report {
 };
 
 /**
- * struct blk_zone_range - BLKRESETZONE ioctl request
- * @sector: starting sector of the first zone to issue reset write pointer
- * @nr_sectors: Total number of sectors of 1 or more zones to reset
+ * struct blk_zone_range - BLKRESETZONE/BLKOPENZONE/
+ *			   BLKCLOSEZONE/BLKFINISHZONE ioctl
+ *			   request
+ * @sector: starting sector of the first zone to operate on
+ * @nr_sectors: Total number of sectors of all zones to operate on
  */
 struct blk_zone_range {
 	__u64		sector;
@@ -139,10 +141,19 @@ struct blk_zone_range {
  *                sector range. The sector range must be zone aligned.
  * @BLKGETZONESZ: Get the device zone size in number of 512 B sectors.
  * @BLKGETNRZONES: Get the total number of zones of the device.
+ * @BLKOPENZONE: Open the zones in the specified sector range. The
+ *               sector range must be zone aligned.
+ * @BLKCLOSEZONE: Close the zones in the specified sector range. The
+ *                sector range must be zone aligned.
+ * @BLKFINISHZONE: Finish the zones in the specified sector range. The
+ *                 sector range must be zone aligned.
  */
 #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)
 #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)
 #define BLKGETZONESZ	_IOR(0x12, 132, __u32)
 #define BLKGETNRZONES	_IOR(0x12, 133, __u32)
+#define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
+#define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
+#define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
2.19.1

