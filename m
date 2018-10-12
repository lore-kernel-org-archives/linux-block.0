Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6549 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeJLKAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Oct 2018 06:00:24 -0400
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH v3 03/11] scsi: sd_zbc: Fix sd_zbc_check_zones() error checks
Date: Fri, 12 Oct 2018 11:30:04 +0900
Message-Id: <20181012023012.29923-4-damien.lemoal@wdc.com>
In-Reply-To: <20181012023012.29923-1-damien.lemoal@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The 32 bits overflow check for the zone size value is already done
within sd_zbc_check_zones() with the test:

} else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {

so there is no need to check again for an out of range value in
sd_zbc_read_zones(). Simplify the code and fix sd_zbc_check_zones()
error return to -EFBIG instead of -ENODEV if the zone size is too large.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd_zbc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index ca73c46931c0..44b64b4a922a 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -373,7 +373,7 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  * Returns the zone size in number of blocks upon success or an error code
  * upon failure.
  */
-static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)
+static s32 sd_zbc_check_zones(struct scsi_disk *sdkp)
 {
 	u64 zone_blocks = 0;
 	sector_t max_lba, block = 0;
@@ -472,7 +472,7 @@ static s64 sd_zbc_check_zones(struct scsi_disk *sdkp)
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Zone size too large\n");
-		ret = -ENODEV;
+		ret = -EFBIG;
 	} else {
 		ret = zone_blocks;
 	}
@@ -668,8 +668,7 @@ static int sd_zbc_setup(struct scsi_disk *sdkp, u32 zone_blocks)
 
 int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 {
-	int64_t zone_blocks;
-	int ret;
+	int ret, zone_blocks;
 
 	if (!sd_is_zoned(sdkp))
 		/*
@@ -688,12 +687,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	 * an eventual last runt zone) that is a power of 2 are supported.
 	 */
 	zone_blocks = sd_zbc_check_zones(sdkp);
-	ret = -EFBIG;
-	if (zone_blocks != (u32)zone_blocks)
-		goto err;
-	ret = zone_blocks;
-	if (ret < 0)
+	if (zone_blocks < 0) {
+		ret = zone_blocks;
 		goto err;
+	}
 
 	/* The drive satisfies the kernel restrictions: set it up */
 	ret = sd_zbc_setup(sdkp, zone_blocks);
-- 
2.17.1
