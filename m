Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18093C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B3320838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n0YAi/xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfHAR1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:27:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47187 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 13:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564680438; x=1596216438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=C+H5gUGHdpr37/tOvEeOA73qgjfRJSOePkW4JUKuD5s=;
  b=n0YAi/xGwv6RHAPdIaD8Um1ulev5PIyPQdK5wEtREEeyeGWCtg7SqlQZ
   46SdS6vCmbh4zNz/s+HYDNsDPlLIv/HNXSYRFZunyiiNdxqdPq9n85HhO
   YiTuCSgscD5lKQNlz3GmX70d7yk9HU1OBx/o3kJvNEINrr3GYAMN7HGHP
   k7JvhuLth1fMU5u34avU5EW19UHcEkq5vAAs9hfMe0A9bdcXB/8AtnZWV
   yUXJqKzhTaw0FPyA94ImlK2bW1vwAZ6vJlGkjQpqMXg77Z9luMsLAjRLR
   oMazUhMQI9zVDGZILnT7wI2+FWUzgZaKwiExmbqJlBQ7itWVokZvC2Bjp
   A==;
IronPort-SDR: /UwQpoDUY4A7IqpnLY1+rKOT/dMJEIk7eNKtvaTK5Y6fgOtOl59DTelMc3PQe7T+1UqtiQfgOZ
 okJtxYWAAg/nV08zLSKEFLhhOQLi1f+HHmC/QYewTriWlxflnixWO4UzWuyAmOQL7ls0HPrclU
 piVA8ePVmWKAOWiuk5YW4QwesUwlxTdpRy0rz7tUbJKIAyqXsM6a7LCwOYFSBEOQyIBQryeFOp
 Z/3VLVOoBfsh7AaRxGuIWz36DeWGrukvMwYTDnwPcZeyPYrED9/vi3garGkJG8oD11GpDEe16w
 5ow=
X-IronPort-AV: E=Sophos;i="5.64,334,1559491200"; 
   d="scan'208";a="119390131"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 01:27:18 +0800
IronPort-SDR: b2upGwq+GyCyrUQUrw50XZd0tc3XTJgb3R4ydCGf4pC2soprbE0EX/+KUYQ3ZVvzJwal5pbRm4
 VETGmbwOnSMKVsjqtIi+3h4QRlUAp+lhrkZoA1I3/FfwxweSPg/hVHfGX6+AOX+dK9nIXhpnDx
 +58b97nn8oNh/7uHkjYegcEr+Tm0DHIQQJ+gmxfVn4HLDGcqV8hNobRb/HQe+YfKaZ0aTNY7sV
 QBx3t5gYbA8RRySesTfyA0rhyvTavAU2FnGQnYU7vec8PIkgoed9O6f6mbsbqTY/OsWasMnCy2
 b/BsUQG91djlEw5ikx86Mfvr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:25:16 -0700
IronPort-SDR: +ufA1CYTZ8W1Duj6KnJzcBk0Zb6LUDEPMdG1ySwXrqU3cBe6Cq39sSFE6LMo5lQS9TNbIu0SGQ
 5Lw4pEdAl1EntNM/u/hhAKt5cgqYeveG56K57lSNuyebZzPWzNjy2OHKAooVjlJA4dnPWM5QDd
 NzEETOvOGRmiEHfTNw6UYhE5gWvvmz4wjp3WznMrxkuVIytFHBcbu87d/AsFbZFMPzXuxeew7h
 3AAUw+yELdGYjFMyL0TP5F4EZuaEYoLnUB0sty2Kqxn5VurKLfjCTBpwqz3RQIrLv4FzWUuTsL
 IiQ=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 10:27:18 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Date:   Thu,  1 Aug 2019 10:26:36 -0700
Message-Id: <20190801172638.4060-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This implements REQ_OP_ZONE_RESET_ALL as a special case of the block
device zone reset operations where we just simply issue bio with the
newly introduced req op.

We issue this req op when the number of sectors is equal to the device's
partition's number of sectors and device has no partitions.

We also add support so that blk_op_str() can print the new reset-all
zone operation.

This patch also adds a generic make request check for newly
introduced REQ_OP_ZONE_RESET_ALL req_opf. We simply return error
when queue is zoned and reset-all flag is not set for
REQ_OP_ZONE_RESET_ALL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c  |  5 +++++
 block/blk-zoned.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..1b53ab56228b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -129,6 +129,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(DISCARD),
 	REQ_OP_NAME(SECURE_ERASE),
 	REQ_OP_NAME(ZONE_RESET),
+	REQ_OP_NAME(ZONE_RESET_ALL),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(SCSI_IN),
@@ -931,6 +932,10 @@ generic_make_request_checks(struct bio *bio)
 		if (!blk_queue_is_zoned(q))
 			goto not_supported;
 		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
+			goto not_supported;
+		break;
 	case REQ_OP_WRITE_ZEROES:
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6c503824ba3f..4bc5f260248a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -202,6 +202,42 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
+/*
+ * Special case of zone reset operation to reset all zones in one command,
+ * useful for applications like mkfs.
+ */
+static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_mask)
+{
+	struct bio *bio = bio_alloc(gfp_mask, 0);
+	int ret;
+
+	/* across the zones operations, don't need any sectors */
+	bio_set_dev(bio, bdev);
+	bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);
+
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return ret;
+}
+
+static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
+						sector_t nr_sectors)
+{
+	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
+		return false;
+
+	if (nr_sectors != part_nr_sects_read(bdev->bd_part))
+		return false;
+	/*
+	 * REQ_OP_ZONE_RESET_ALL can be executed only if the block device is
+	 * the entire disk, that is, if the blocks device start offset is 0 and
+	 * its capacity is the same as the entire disk.
+	 */
+	return get_start_sect(bdev) == 0 &&
+	       part_nr_sects_read(bdev->bd_part) == get_capacity(bdev->bd_disk);
+}
+
 /**
  * blkdev_reset_zones - Reset zones write pointer
  * @bdev:	Target block device
@@ -235,6 +271,9 @@ int blkdev_reset_zones(struct block_device *bdev,
 		/* Out of range */
 		return -EINVAL;
 
+	if (blkdev_allow_reset_all_zones(bdev, nr_sectors))
+		return  __blkdev_reset_all_zones(bdev, gfp_mask);
+
 	/* Check alignment (handle eventual smaller last zone) */
 	zone_sectors = blk_queue_zone_sectors(q);
 	if (sector & (zone_sectors - 1))
-- 
2.17.0

