Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C0C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6D820B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rs2ImELY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGAFJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:09:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfGAFJZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 01:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561957765; x=1593493765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uJqHrInudGIFXnnjRGPqz/V8lQGss+rD2d1MEJ48FFQ=;
  b=Rs2ImELYY6h/ablV6T3v8zs2dEWjPjsSIYzWYtpLLpvt9snIRA0oEfyL
   7UVhzTAo5zvbLeDitvJSueHdQObmbNfrmsTtooUh9lC50ZB0ktzVPiJt0
   NRgHAkYSkdhyP1IksRu7iO1b1Lkeq4uXu3C22bret7wVzZF4p0iqwyEG6
   L07DsNDgn1osCUyD3p98IdtbhIzgRBHc7wQD5BlWqsOjkw3SOLtJmWFmQ
   6Hz/fyQpSXIQ6YfGv+lIr3naU6GZC3NznJz9C8khKq4jpQORSCPRfWR0k
   CQlFyR2LxjajpSezSjPnRBsU0jQuzWsW0veNBY90SeVSOkb36hpeW1qY+
   g==;
X-IronPort-AV: E=Sophos;i="5.63,437,1557158400"; 
   d="scan'208";a="116777210"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 13:09:25 +0800
IronPort-SDR: VlnUVTelrlxSdW6RCzT9QwRa0PDN0SRAQI2E1KFifzQNkY1c8z99MBD/1VV2POWaCg5j24zjQD
 VS8uuBxn8rskjhgqcBTA2nukNIUDCiUWAkXScIt8embmCc2JIatM5cUNBc/RKZn2tSNhUgLkJf
 u2T+O2mqARYr6BMUpqfAnVaRAN66EC8KCT275ykR7ZcQrD7CconUzYCL6DOwGJjNb8ICA71Mwq
 +8atRUdI3VrgH+KVNQqHAowmY+vlEmCHNbRG3heNMuHHyV8ZwVNqU51Z5QUpxqQ/djiDneBa6M
 Ws9pv7+VGjcb8tc7ExZuDh2g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jun 2019 22:08:28 -0700
IronPort-SDR: jPdBIhl8BVP9TDoBYR4WdKBPVgW+MM6Z860u2guGprLcLuKyL2QNez0NrV5o81slwg83Z6rc4Z
 9LWVJGLulgih6q0e4E+zXyAq1VQYknZeUT5d/vRWagjKyCvwoZ9DAzli9AKxkdFUuxKUPrRnR2
 zLoT8HJ1J8zbQUXJ6PZUpjdD+ArPzu0qeA2446jYArhB9+2VJUTb/t9G4hmK7MSRZPm9v9pAiZ
 9RaQ2qMkzsg5A+lF/0v2czJX0o7fd7TgkdPlRJehuKUnLAVTRdohgkkv0CAnLh/ppXHbfpduFQ
 7ks=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2019 22:09:22 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V6 2/4] block: Kill gfp_t argument of blkdev_report_zones()
Date:   Mon,  1 Jul 2019 14:09:16 +0900
Message-Id: <20190701050918.27511-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701050918.27511-1-damien.lemoal@wdc.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only GFP_KERNEL and GFP_NOIO are used with blkdev_report_zones(). In
preparation of using vmalloc() for large report buffer and zone array
allocations used by this function, remove its "gfp_t gfp_mask" argument
and rely on the caller context to use memalloc_noio_save/restore() where
necessary (block layer zone revalidation and dm-zoned I/O error path).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c              | 31 +++++++++++++++++++------------
 drivers/block/null_blk.h       |  3 +--
 drivers/block/null_blk_zoned.c |  3 +--
 drivers/md/dm-flakey.c         |  5 ++---
 drivers/md/dm-linear.c         |  5 ++---
 drivers/md/dm-zoned-metadata.c | 16 ++++++++++++----
 drivers/md/dm.c                |  6 ++----
 drivers/scsi/sd.h              |  3 +--
 drivers/scsi/sd_zbc.c          |  6 ++----
 fs/f2fs/super.c                |  4 +---
 include/linux/blkdev.h         |  5 ++---
 include/linux/device-mapper.h  |  3 +--
 12 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ae7e91bd0618..60dfc3f22350 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/sched/mm.h>
 
 #include "blk.h"
 
@@ -117,8 +118,7 @@ static bool blkdev_report_zone(struct block_device *bdev, struct blk_zone *rep)
 }
 
 static int blk_report_zones(struct gendisk *disk, sector_t sector,
-			    struct blk_zone *zones, unsigned int *nr_zones,
-			    gfp_t gfp_mask)
+			    struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct request_queue *q = disk->queue;
 	unsigned int z = 0, n, nrz = *nr_zones;
@@ -127,8 +127,7 @@ static int blk_report_zones(struct gendisk *disk, sector_t sector,
 
 	while (z < nrz && sector < capacity) {
 		n = nrz - z;
-		ret = disk->fops->report_zones(disk, sector, &zones[z], &n,
-					       gfp_mask);
+		ret = disk->fops->report_zones(disk, sector, &zones[z], &n);
 		if (ret)
 			return ret;
 		if (!n)
@@ -149,17 +148,18 @@ static int blk_report_zones(struct gendisk *disk, sector_t sector,
  * @sector:	Sector from which to report zones
  * @zones:	Array of zone structures where to return the zones information
  * @nr_zones:	Number of zone structures in the zone array
- * @gfp_mask:	Memory allocation flags (for bio_alloc)
  *
  * Description:
  *    Get zone information starting from the zone containing @sector.
  *    The number of zone information reported may be less than the number
  *    requested by @nr_zones. The number of zones actually reported is
  *    returned in @nr_zones.
+ *    The caller must use memalloc_noXX_save/restore() calls to control
+ *    memory allocations done within this function (zone array and command
+ *    buffer allocation by the device driver).
  */
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
-			struct blk_zone *zones, unsigned int *nr_zones,
-			gfp_t gfp_mask)
+			struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int i, nrz;
@@ -184,7 +184,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	nrz = min(*nr_zones,
 		  __blkdev_nr_zones(q, bdev->bd_part->nr_sects - sector));
 	ret = blk_report_zones(bdev->bd_disk, get_start_sect(bdev) + sector,
-			       zones, &nrz, gfp_mask);
+			       zones, &nrz);
 	if (ret)
 		return ret;
 
@@ -305,9 +305,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!zones)
 		return -ENOMEM;
 
-	ret = blkdev_report_zones(bdev, rep.sector,
-				  zones, &rep.nr_zones,
-				  GFP_KERNEL);
+	ret = blkdev_report_zones(bdev, rep.sector, zones, &rep.nr_zones);
 	if (ret)
 		goto out;
 
@@ -415,6 +413,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	unsigned long *seq_zones_wlock = NULL, *seq_zones_bitmap = NULL;
 	unsigned int i, rep_nr_zones = 0, z = 0, nrz;
 	struct blk_zone *zones = NULL;
+	unsigned int noio_flag;
 	sector_t sector = 0;
 	int ret = 0;
 
@@ -427,6 +426,12 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		return 0;
 	}
 
+	/*
+	 * Ensure that all memory allocations in this context are done as
+	 * if GFP_NOIO was specified.
+	 */
+	noio_flag = memalloc_noio_save();
+
 	if (!blk_queue_is_zoned(q) || !nr_zones) {
 		nr_zones = 0;
 		goto update;
@@ -449,7 +454,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	while (z < nr_zones) {
 		nrz = min(nr_zones - z, rep_nr_zones);
-		ret = blk_report_zones(disk, sector, zones, &nrz, GFP_NOIO);
+		ret = blk_report_zones(disk, sector, zones, &nrz);
 		if (ret)
 			goto out;
 		if (!nrz)
@@ -480,6 +485,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	blk_mq_unfreeze_queue(q);
 
 out:
+	memalloc_noio_restore(noio_flag);
+
 	free_pages((unsigned long)zones,
 		   get_order(rep_nr_zones * sizeof(struct blk_zone)));
 	kfree(seq_zones_wlock);
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..4b9bbe3bb5a1 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -89,8 +89,7 @@ struct nullb {
 int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
 int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones,
-		     gfp_t gfp_mask);
+		     struct blk_zone *zones, unsigned int *nr_zones);
 void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			unsigned int nr_sectors);
 void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index fca0c97ff1aa..cb28d93f2bd1 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -67,8 +67,7 @@ void null_zone_exit(struct nullb_device *dev)
 }
 
 int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones,
-		     gfp_t gfp_mask)
+		     struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a9bc518156f2..2900fbde89b3 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -461,15 +461,14 @@ static int flakey_prepare_ioctl(struct dm_target *ti, struct block_device **bdev
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static int flakey_report_zones(struct dm_target *ti, sector_t sector,
-			       struct blk_zone *zones, unsigned int *nr_zones,
-			       gfp_t gfp_mask)
+			       struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct flakey_c *fc = ti->private;
 	int ret;
 
 	/* Do report and remap it */
 	ret = blkdev_report_zones(fc->dev->bdev, flakey_map_sector(ti, sector),
-				  zones, nr_zones, gfp_mask);
+				  zones, nr_zones);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index ad980a38fb1e..ecefe6703736 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -137,15 +137,14 @@ static int linear_prepare_ioctl(struct dm_target *ti, struct block_device **bdev
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static int linear_report_zones(struct dm_target *ti, sector_t sector,
-			       struct blk_zone *zones, unsigned int *nr_zones,
-			       gfp_t gfp_mask)
+			       struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
 	int ret;
 
 	/* Do report and remap it */
 	ret = blkdev_report_zones(lc->dev->bdev, linear_map_sector(ti, sector),
-				  zones, nr_zones, gfp_mask);
+				  zones, nr_zones);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index d8334cd45d7c..9faf3e49c7af 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/crc32.h>
+#include <linux/sched/mm.h>
 
 #define	DM_MSG_PREFIX		"zoned metadata"
 
@@ -1162,8 +1163,7 @@ static int dmz_init_zones(struct dmz_metadata *zmd)
 	while (sector < dev->capacity) {
 		/* Get zone information */
 		nr_blkz = DMZ_REPORT_NR_ZONES;
-		ret = blkdev_report_zones(dev->bdev, sector, blkz,
-					  &nr_blkz, GFP_KERNEL);
+		ret = blkdev_report_zones(dev->bdev, sector, blkz, &nr_blkz);
 		if (ret) {
 			dmz_dev_err(dev, "Report zones failed %d", ret);
 			goto out;
@@ -1201,12 +1201,20 @@ static int dmz_init_zones(struct dmz_metadata *zmd)
 static int dmz_update_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 {
 	unsigned int nr_blkz = 1;
+	unsigned int noio_flag;
 	struct blk_zone blkz;
 	int ret;
 
-	/* Get zone information from disk */
+	/*
+	 * Get zone information from disk. Since blkdev_report_zones() uses
+	 * GFP_KERNEL by default for memory allocations, set the per-task
+	 * PF_MEMALLOC_NOIO flag so that all allocations are done as if
+	 * GFP_NOIO was specified.
+	 */
+	noio_flag = memalloc_noio_save();
 	ret = blkdev_report_zones(zmd->dev->bdev, dmz_start_sect(zmd, zone),
-				  &blkz, &nr_blkz, GFP_NOIO);
+				  &blkz, &nr_blkz);
+	memalloc_noio_restore(noio_flag);
 	if (!nr_blkz)
 		ret = -EIO;
 	if (ret) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5475081dcbd6..61f1152b74e9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -441,8 +441,7 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-			       struct blk_zone *zones, unsigned int *nr_zones,
-			       gfp_t gfp_mask)
+			       struct blk_zone *zones, unsigned int *nr_zones)
 {
 #ifdef CONFIG_BLK_DEV_ZONED
 	struct mapped_device *md = disk->private_data;
@@ -480,8 +479,7 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 	 * So there is no need to loop here trying to fill the entire array
 	 * of zones.
 	 */
-	ret = tgt->type->report_zones(tgt, sector, zones,
-				      nr_zones, gfp_mask);
+	ret = tgt->type->report_zones(tgt, sector, zones, nr_zones);
 
 out:
 	dm_put_live_table(md, srcu_idx);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5796ace76225..38c50946fc42 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -213,8 +213,7 @@ extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
 extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			    struct scsi_sense_hdr *sshdr);
 extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
-			       struct blk_zone *zones, unsigned int *nr_zones,
-			       gfp_t gfp_mask);
+			       struct blk_zone *zones, unsigned int *nr_zones);
 
 #else /* CONFIG_BLK_DEV_ZONED */
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..ec3764c8f3f1 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -109,13 +109,11 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
  * @sector: Start 512B sector of the report
  * @zones: Array of zone descriptors
  * @nr_zones: Number of descriptors in the array
- * @gfp_mask: Memory allocation mask
  *
  * Execute a report zones command on the target disk.
  */
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
-			struct blk_zone *zones, unsigned int *nr_zones,
-			gfp_t gfp_mask)
+			struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	unsigned int i, buflen, nrz = *nr_zones;
@@ -134,7 +132,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	 */
 	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
 		     roundup((nrz + 1) * 64, 512));
-	buf = kmalloc(buflen, gfp_mask);
+	buf = kmalloc(buflen, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6b959bbb336a..4e91ba6c8a2e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2841,9 +2841,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	while (zones && sector < nr_sectors) {
 
 		nr_zones = F2FS_REPORT_NR_ZONES;
-		err = blkdev_report_zones(bdev, sector,
-					  zones, &nr_zones,
-					  GFP_KERNEL);
+		err = blkdev_report_zones(bdev, sector, zones, &nr_zones);
 		if (err)
 			break;
 		if (!nr_zones) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..472ba74ca968 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -347,7 +347,7 @@ struct queue_limits {
 extern unsigned int blkdev_nr_zones(struct block_device *bdev);
 extern int blkdev_report_zones(struct block_device *bdev,
 			       sector_t sector, struct blk_zone *zones,
-			       unsigned int *nr_zones, gfp_t gfp_mask);
+			       unsigned int *nr_zones);
 extern int blkdev_reset_zones(struct block_device *bdev, sector_t sectors,
 			      sector_t nr_sectors, gfp_t gfp_mask);
 extern int blk_revalidate_disk_zones(struct gendisk *disk);
@@ -1684,8 +1684,7 @@ struct block_device_operations {
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-			    struct blk_zone *zones, unsigned int *nr_zones,
-			    gfp_t gfp_mask);
+			    struct blk_zone *zones, unsigned int *nr_zones);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index e1f51d607cc5..3b470cb03b66 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -95,8 +95,7 @@ typedef int (*dm_prepare_ioctl_fn) (struct dm_target *ti, struct block_device **
 
 typedef int (*dm_report_zones_fn) (struct dm_target *ti, sector_t sector,
 				   struct blk_zone *zones,
-				   unsigned int *nr_zones,
-				   gfp_t gfp_mask);
+				   unsigned int *nr_zones);
 
 /*
  * These iteration functions are typically used to check (and combine)
-- 
2.21.0

