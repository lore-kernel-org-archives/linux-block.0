Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37BC433E6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CED64FAA
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 07:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCKH0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 02:26:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46730 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhCKHZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 02:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615447548; x=1646983548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FBGcvCEj254gZQUwFxXgLlHXamEzHqbmsASfYOOIP8I=;
  b=AQbsScV/Auqhm0QwCCt5O0y00orlnn8o23JcbqydcHl2FocdaFsYq42+
   lCvyYvHGcygLAv0qk5VM1a6clt+diJkOD+38DSJrK2oR8WxEWAN4G0L7j
   oTunOQAphYwupgUFizPSDmCO6aTOPxoGxXm/CkHR2kpzW5PfSblDTW7+w
   cOSDqTKpo3PcIavBTqoguSiRVYK5XJH5katjP1QaLVHCV02NNQLivGIjU
   CNrvnhIiSLcLhnXmML7WN5JniYFKny+NQcoCRoNNH7Rr9lefNCS6V4YuA
   N4OQON9Jme9AhQ0YHwrN+SPW5n599xH8wjRHiZYWFvK1nS+yLGQBW3rU/
   Q==;
IronPort-SDR: yluKivBy6CY07qUIDP19g0HtStm1bXZzdS1CzVikH6nL6HursA9TSBfHWIMxM2BiLbfFhiWy4r
 5USwyAf33NtMrlraMg9veeN+nTK2isGkrA6CuiuCWdhXvf4fw6nQFszWCHXQwRXnIw5T4atA+c
 q1PS4EOf26m2dhYkSngtpUZq+LWNTbRmm7Xbs7z3yI/81ws07Fz20XQd1dJOe4nbFlwI0I4ktg
 v/jo5O+XfM0fUtZFYEONNyZykNeNsp6OXCMwbZjHK7lkCpC6mhOsG3c6QwuLF0lXls2R6O68fH
 yxM=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; 
   d="scan'208";a="272577357"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 15:25:48 +0800
IronPort-SDR: 1RpPEcawbEseXY+v8wBZsiyu/5f6fXNdQQYvLAASGERuHjqm7yssYGHaUwcN8iFaKvnnZGI3A5
 nDKpdfKmyAKnVEpjf8P0WnC0qNl+dRc3JKZLatU9FQjo8di5E83epQt9V3wPljxlYk18+5c5jF
 AS8ee0FAVj9OumAYQYix3BS3/ZLb2yYRgQQLB/Jw8CBS76tkYmX34nHvx+ofZLJ0fPx8fLE+q+
 vOEQChmaIr1WqNQonyQTYmvu7vojVkZeEn3dz56JhGd7kmDnN0Lns8Wsz29gBb0eFCsrAn/4Jq
 Ix9wDQb4MnkxAHyxvusF7P2N
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:27 -0800
IronPort-SDR: 9ndqmu0z3TgdI22Ng5268iL2+xU4Bgvj//nAcLjAP+CLoF1ExSqcgF2q8R5rwZScViE3D4m3rK
 AMbYi899A7rPUkyFBiA3SudUauP0rbR3Fo5CiFEw1F52Qb1MK00Zc6lkRoc9MS/lvEwo8ebU5F
 L8QQr50MrHdxZtkKRixwgF+dVIjetMsrr6MXUvNnD0sC7RavvCV14eGscJLyzEVC8pfmAEUOvJ
 gSVmfgl6AmNI8X/B8eZGiViRcXSfJxQGVvWq43GIIuSRgNm6ydecEaMgAc5UiQY3QpFlL7E8q6
 YNs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 23:25:47 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] block: Discard page cache of zone reset target range
Date:   Thu, 11 Mar 2021 16:25:46 +0900
Message-Id: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When zone reset ioctl and data read race for a same zone on zoned block
devices, the data read leaves stale page cache even though the zone
reset ioctl zero clears all the zone data on the device. To avoid
non-zero data read from the stale page cache after zone reset, discard
page cache of reset target zones in blkdev_zone_mgmt_ioctl(). Introduce
the helper function blkdev_truncate_zone_range() to discard the page
cache. Ensure the page cache discarded by calling the helper function
before and after zone reset in same manner as fallocate does.

This patch can be applied back to the stable kernel version v5.10.y.
Rework is needed for older stable kernels.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
Cc: <stable@vger.kernel.org> # 5.10+
---
Changes from v2:
* Factored out blkdev_truncate_zone_range()

Changes from v1:
* Addressed comments on the list

 block/blk-zoned.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e60..03c3b8df2c0d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -318,6 +318,22 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	return 0;
 }
 
+static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mode,
+				      const struct blk_zone_range *zrange)
+{
+	loff_t start, end;
+
+	if (zrange->sector + zrange->nr_sectors <= zrange->sector ||
+	    zrange->sector + zrange->nr_sectors > get_capacity(bdev->bd_disk))
+		/* Out of range */
+		return -EINVAL;
+
+	start = zrange->sector << SECTOR_SHIFT;
+	end = ((zrange->sector + zrange->nr_sectors) << SECTOR_SHIFT) - 1;
+
+	return truncate_bdev_range(bdev, mode, start, end);
+}
+
 /*
  * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
  * Called from blkdev_ioctl.
@@ -329,6 +345,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	struct request_queue *q;
 	struct blk_zone_range zrange;
 	enum req_opf op;
+	int ret;
 
 	if (!argp)
 		return -EINVAL;
@@ -352,6 +369,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	switch (cmd) {
 	case BLKRESETZONE:
 		op = REQ_OP_ZONE_RESET;
+
+		/* Invalidate the page cache, including dirty pages. */
+		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
+		if (ret)
+			return ret;
 		break;
 	case BLKOPENZONE:
 		op = REQ_OP_ZONE_OPEN;
@@ -366,8 +388,20 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		return -ENOTTY;
 	}
 
-	return blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
-				GFP_KERNEL);
+	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
+			       GFP_KERNEL);
+
+	/*
+	 * Invalidate the page cache again for zone reset: writes can only be
+	 * direct for zoned devices so concurrent writes would not add any page
+	 * to the page cache after/during reset. The page cache may be filled
+	 * again due to concurrent reads though and dropping the pages for
+	 * these is fine.
+	 */
+	if (!ret && cmd == BLKRESETZONE)
+		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
+
+	return ret;
 }
 
 static inline unsigned long *blk_alloc_zone_bitmap(int node,
-- 
2.29.2

