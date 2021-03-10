Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73455C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 06:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8AB64FE8
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 06:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhCJGuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:50:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41617 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhCJGuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 01:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615359005; x=1646895005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vP8TRs98XOkviyo5dbhbj6Fg8tmTlWJScboHbl7J33Q=;
  b=I5jgM12GBZQZBTwiUeFpDyNDgwvRtlmoL8dIII7nMsEtJLIVpxqOv82z
   n5c/BjHBVi4pYePD22prDek/QgxHQEiGvzqSfgK49cceicrrxhKd/DRoI
   80MYQG/gML2mI5nv01x+wra+ds6uF4ZXKYguczVgFtYEyjKII8+udO2El
   Oe7YKqki+h0HjI2x9/JSJhz2NkxwY7k72sdp0lc60lyKYU0XTCj1IeqAZ
   cIfk3T6/lf4Y94EEi3g8AVafHOzmSbcscbuc++uP17PpkBPx0TbHmLfBX
   EFa5Sc8jn3NkNvI1BQ0ZP2Mr3Ax1b4wxCZ/KUyO/TesSBSqtaNJhPRb+N
   g==;
IronPort-SDR: Eskj8ojSBxZgDxL05v5oQzjApC95cBXWxnG6fam3lEfqmjkZ3HjmJW7psItzWUCc7Wwxj+xPNO
 z2wt7uGFaMHIR5xW2aDQl9PVeXV+geTZtfJiZESRomjuN4c9SbWWlfLsyoc9BdgBARaYe0M/c8
 I6rW+wztOwNd2ZC/g2cD0PLamYBBZv+iNr7fEV40YTaUV9vPJjzOpPy0Ge2F0r9ZYjmqjmwsKJ
 HgEVG+aoSkNX0z1xniwmTyg5YHFpaz6RU5pG3oPrEZ7cut8jCmIbwmYjuAUFMxKGc9nZjjJXrK
 +3Y=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; 
   d="scan'208";a="272472953"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 14:50:05 +0800
IronPort-SDR: gcLLmM2clSuIsX+wc+HuJg1SW+Z2s093Ok/5RWeO0jBKH7QEvZp+usKPWHC8Eb395xhU61m1ah
 mcPzbovT2j0ZxdBZ0tazvFQPIicYqrGF8DA3xL0Ug6GfRapP4+Xy0B/oMvWBB0MlT6+/EXHUhc
 JmSsO2el0pFO0YYek1oOK728hTPrsF1bTwgMdNpKE2VRHwSFxCPrSQLMqZqC7D9VXoO+QFcqDb
 yv+v6GWdm+tJy6zrcvnAfytAa8Wo79Z0BL8A59ceK9eNvWtMSjCu3KGPxht2UMv4x7MwFlOREG
 8ulqWvhXfuNJhUfskv8HVoXI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 22:31:02 -0800
IronPort-SDR: z04wwnuox1kKotR87+w5Hu5MyGy+svvahtnZN6fTTcbN8hoeRDI80+5nk7ItEbwS/UtdK0d4Cy
 vG2oZs/N3DJyaW9BK1cd0dGTcqga2hQ4Ds80yPUYPK2ojaDVUg6sYTncOAfIc4Y6ltHcHUxJgb
 TTiMUet7deVBrTvn4c4Mx0VUGQVsx85uq+/vYHwd0g2uRdLPEk9kK6+mBEe8ACWDPJAgPpA+gI
 kWmRYdSQZ8H4VUl7Cra51LuOQh4kzhlXWWQYtsSagJ/D0+5BDTX6tIvfYtU70CLPURC2rFWbD0
 z/Y=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2021 22:50:05 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: Discard page cache of zone reset target range
Date:   Wed, 10 Mar 2021 15:50:03 +0900
Message-Id: <20210310065003.573474-1-shinichiro.kawasaki@wdc.com>
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
page cache of reset target zones. In same manner as fallocate, call the
function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and
after zone reset to ensure the page cache discarded.

This patch can be applied back to the stable kernel version v5.10.y.
Rework is needed for older stable kernels.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
Cc: <stable@vger.kernel.org> # 5.10+
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes from v1:
* Addressed comments on the list

 block/blk-zoned.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e60..c2357e1eda18 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	struct request_queue *q;
 	struct blk_zone_range zrange;
 	enum req_opf op;
+	sector_t capacity;
+	loff_t start, end;
+	int ret;
 
 	if (!argp)
 		return -EINVAL;
@@ -352,6 +355,20 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	switch (cmd) {
 	case BLKRESETZONE:
 		op = REQ_OP_ZONE_RESET;
+
+		capacity = get_capacity(bdev->bd_disk);
+		if (zrange.sector + zrange.nr_sectors <= zrange.sector ||
+		    zrange.sector + zrange.nr_sectors > capacity)
+			/* Out of range */
+			return -EINVAL;
+
+		start = zrange.sector << SECTOR_SHIFT;
+		end = ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;
+
+		/* Invalidate the page cache, including dirty pages. */
+		ret = truncate_bdev_range(bdev, mode, start, end);
+		if (ret)
+			return ret;
 		break;
 	case BLKOPENZONE:
 		op = REQ_OP_ZONE_OPEN;
@@ -366,8 +383,20 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
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
+		ret = truncate_bdev_range(bdev, mode, start, end);
+
+	return ret;
 }
 
 static inline unsigned long *blk_alloc_zone_bitmap(int node,
-- 
2.29.2

