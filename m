Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BAC48BD7
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3D204EC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qWYtrnKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFZBsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:48:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15693 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZBsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 21:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561513684; x=1593049684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfnOxqqnyea5FT+2FpWuq0wjXhpxLdHN1IJgQUBnGWQ=;
  b=qWYtrnKHv6o5Bu2s8Dfr0XVdnFEdJCcCp+j3kNfTfAvA3RtncwovzIpP
   j1+ANufNtF/fr8PN6qMBKipN7MgJnc0boI+MFQx89CjCAzQHvQXMNE5xx
   fTZStv9fyzp2reYqsa4uQp/3wArxH76GuG5oeY2O4b7ah0DTKYNK3dh69
   EtIDjR01pdn5cbPS/VHcP8m4I+mVaZAGNyKcGB1MpB138RGKkp4tQJz97
   8tKLAqfF3abTU7Kb1oh+xbMGKdgx446q+eAs+M2cKxhLoFRUT2GOoVI7u
   ham9GI/fdjI//x77/t3z86/nMHoXCrOSBJl93wUm17uS2ERWUCaTr7OS5
   w==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="116422527"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 09:48:04 +0800
IronPort-SDR: MkxmpOPsNGKc/xX0qhXYZBG8VMUiiiwjWU4PPTKsMvRUQI+23OHssZj99lOUCNLfh4N6+Z4YfO
 HKlVzqoMajdAWCdtuyu+LTJ4AsGJJtl4LqWEFud4qG9g5ookf8rcKqux0TkvrrhZ4CZL8FwVvB
 iJU0XelF2IiR4tBefRlHhX4jyKaH+UQzl/pVCW+B1Gs0ZRiDWmC4dnXmoFUPTqxpLEZTacUZSs
 rBdsJI3Qk90IigHX8Oj6LR6QF1UEnHW+Se9DBo0nwvmfuzZpEBI6Ovj6yLqeAtnQJW6ZiPVPpW
 z4kBE+qIYz2tqfQvZWnTCE9b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jun 2019 18:47:13 -0700
IronPort-SDR: k+atv8lUOwJJ0JuNHjltrebr5zpqjCP3g/Pb81tMc3Pdrz7uwLYoQ2sFKaR4QZGzv4xuFe8SJ9
 wq68+8bwEZD6XDAKhRXMq9H61QTttpfOe5HvK4nnWq1jzwHwMXAQNHPTy0rft/sCDsWRqeZjHb
 RvoajwP91g+WA2PwqCN6WNGdTx3LJzIanR/AoLjTlGZOvFNI6WbJ77YzIvMSXmKHHXi3PdH6Cp
 OjhheQs60N+s6JIj7lwALrCKDXRM2LlctWNqiHqjcdvpH+VATURdfV6lS++/T5EFuHYaSzqSPn
 9d0=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 18:48:02 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 2/3] sd_zbc: Fix report zones buffer allocation
Date:   Wed, 26 Jun 2019 10:47:58 +0900
Message-Id: <20190626014759.15285-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626014759.15285-1-damien.lemoal@wdc.com>
References: <20190626014759.15285-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During disk scan and revalidation done with sd_revalidate(), the zones
of a zoned disk are checked using the helper function
blk_revalidate_disk_zones() if a configuration change is detected
(change in the number of zones or zone size). The function
blk_revalidate_disk_zones() issues report_zones calls that are very
large, that is, to obtain zone information for all zones of the disk
with a single command. The size of the report zones command buffer
necessary for such large request generally is lower than the disk
max_hw_sectors and KMALLOC_MAX_SIZE (4MB) and succeeds on boot (no
memory fragmentation), but often fail at run time (e.g. hot-plug
event). This causes the disk revalidation to fail and the disk
capacity to be changed to 0.

This problem can be avoided by using vmalloc() instead of kmalloc() for
the buffer allocation. To limit the amount of memory to be allocated,
this patch also introduces the arbitrary SD_ZBC_REPORT_MAX_ZONES
maximum number of zones to report with a single report zones command.
This limit may be lowered further to satisfy the disk max_hw_sectors
limit. Finally, to ensure that the vmalloc-ed buffer can always be
mapped in a request, the buffer size is further limited to at most
queue_max_segments() pages, allowing successful mapping of the buffer
even in the worst case scenario where none of the buffer pages are
contiguous.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 80 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..f1474732784c 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/vmalloc.h>
 
 #include <asm/unaligned.h>
 
@@ -103,6 +104,48 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
 	return 0;
 }
 
+/*
+ * Maximum number of zones to get with one report zones command.
+ */
+#define SD_ZBC_REPORT_MAX_ZONES		8192U
+
+/**
+ * Allocate a buffer for report zones reply.
+ * @disk: The target disk
+ * @nr_zones: Maximum number of zones to report
+ * @buflen: Size of the buffer allocated
+ * @gfp_mask: Memory allocation mask
+ *
+ */
+static void *sd_zbc_alloc_report_buffer(struct request_queue *q,
+					unsigned int nr_zones, size_t *buflen,
+					gfp_t gfp_mask)
+{
+	size_t bufsize;
+	void *buf;
+
+	/*
+	 * Report zone buffer size should be at most 64B times the number of
+	 * zones requested plus the 64B reply header, but should be at least
+	 * SECTOR_SIZE for ATA devices.
+	 * Make sure that this size does not exceed the hardware capabilities.
+	 * Furthermore, since the report zone command cannot be split, make
+	 * sure that the allocated buffer can always be mapped by limiting the
+	 * number of pages allocated to the HBA max segments limit.
+	 */
+	nr_zones = min(nr_zones, SD_ZBC_REPORT_MAX_ZONES);
+	bufsize = roundup((nr_zones + 1) * 64, 512);
+	bufsize = min_t(size_t, bufsize,
+			queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+
+	buf = __vmalloc(bufsize, gfp_mask, PAGE_KERNEL);
+	if (buf)
+		*buflen = bufsize;
+
+	return buf;
+}
+
 /**
  * sd_zbc_report_zones - Disk report zones operation.
  * @disk: The target disk
@@ -118,9 +161,9 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			gfp_t gfp_mask)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	unsigned int i, buflen, nrz = *nr_zones;
+	unsigned int i, nrz = *nr_zones;
 	unsigned char *buf;
-	size_t offset = 0;
+	size_t buflen = 0, offset = 0;
 	int ret = 0;
 
 	if (!sd_is_zoned(sdkp))
@@ -132,16 +175,14 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	 * without exceeding the device maximum command size. For ATA disks,
 	 * buffers must be aligned to 512B.
 	 */
-	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
-		     roundup((nrz + 1) * 64, 512));
-	buf = kmalloc(buflen, gfp_mask);
+	buf = sd_zbc_alloc_report_buffer(disk->queue, nrz, &buflen, gfp_mask);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
 			sectors_to_logical(sdkp->device, sector), true);
 	if (ret)
-		goto out_free_buf;
+		goto out;
 
 	nrz = min(nrz, get_unaligned_be32(&buf[0]) / 64);
 	for (i = 0; i < nrz; i++) {
@@ -152,8 +193,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 
 	*nr_zones = nrz;
 
-out_free_buf:
-	kfree(buf);
+out:
+	kvfree(buf);
 
 	return ret;
 }
@@ -287,8 +328,6 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
 	return 0;
 }
 
-#define SD_ZBC_BUF_SIZE 131072U
-
 /**
  * sd_zbc_check_zones - Check the device capacity and zone sizes
  * @sdkp: Target disk
@@ -304,22 +343,23 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  */
 static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 {
+	size_t bufsize, buflen;
 	u64 zone_blocks = 0;
 	sector_t max_lba, block = 0;
 	unsigned char *buf;
 	unsigned char *rec;
-	unsigned int buf_len;
-	unsigned int list_length;
 	int ret;
 	u8 same;
 
 	/* Get a buffer */
-	buf = kmalloc(SD_ZBC_BUF_SIZE, GFP_KERNEL);
+	buf = sd_zbc_alloc_report_buffer(sdkp->disk->queue,
+					 SD_ZBC_REPORT_MAX_ZONES,
+					 &bufsize, GFP_NOIO);
 	if (!buf)
 		return -ENOMEM;
 
 	/* Do a report zone to get max_lba and the same field */
-	ret = sd_zbc_do_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE, 0, false);
+	ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, 0, false);
 	if (ret)
 		goto out_free;
 
@@ -355,12 +395,12 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 	do {
 
 		/* Parse REPORT ZONES header */
-		list_length = get_unaligned_be32(&buf[0]) + 64;
+		buflen = min_t(size_t, get_unaligned_be32(&buf[0]) + 64,
+			       bufsize);
 		rec = buf + 64;
-		buf_len = min(list_length, SD_ZBC_BUF_SIZE);
 
 		/* Parse zone descriptors */
-		while (rec < buf + buf_len) {
+		while (rec < buf + buflen) {
 			u64 this_zone_blocks = get_unaligned_be64(&rec[8]);
 
 			if (zone_blocks == 0) {
@@ -376,8 +416,8 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 		}
 
 		if (block < sdkp->capacity) {
-			ret = sd_zbc_do_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE,
-						     block, true);
+			ret = sd_zbc_do_report_zones(sdkp, buf, bufsize, block,
+						     true);
 			if (ret)
 				goto out_free;
 		}
@@ -408,7 +448,7 @@ static int sd_zbc_check_zones(struct scsi_disk *sdkp, u32 *zblocks)
 	}
 
 out_free:
-	kfree(buf);
+	kvfree(buf);
 
 	return ret;
 }
-- 
2.21.0

