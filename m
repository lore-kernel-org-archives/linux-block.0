Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E249AC433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 03:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E18464DC4
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 03:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCHDdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 22:33:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61173 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhCHDce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 22:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615174354; x=1646710354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZLYpfsBunXPjoH/l4CgkX+WnsZPOk4D4KV7gY9cYMw=;
  b=bIrVwDDlnA3o5nq759hS0aGoEeC/dyNlNzLWkvAKxndd4RkiqmrXDQiG
   X/klA4dr6qyM0oet4HSm7TVKenDatptXRbBzOCJzQnI+1MHt6/yzErVoQ
   y3YZaFw+qZgs0JadqmjADdynEsPSsKCU1lahavjVQ/s6XSWAo1mNXCrJR
   TQBFrSVP1C7qhhp58z2d7DhSh6ivYjau64coxnWNUqtHSrVhwD3de0aL/
   hR0MD/swrjV2AAH2o76N4tcT/D24Wqix8z2l0+tPeghsMJwcN9U1d4pKt
   8cXt8i+aII9RqgXHj3vsWaMMxos2b0U+o91k+zuduyPuJ1s0wQAe41SIN
   w==;
IronPort-SDR: bO+jjx8QKbMRQyJG718DCnAfC1NIyOsxwdEDmh5MpvOq4gqc9ETCgQU/ZRl5OoK3slY9SYLXvX
 d/6zJKrhrkto68MbC+zJOxDkJyvfr8mvFglAsuilhdDe2iUtRXp9FHogQtoifSW5DPFygZ2fTq
 vgzt3Tnk+fOapuZHmdJMDJfXXCvkG5VdiOaHipahX4ak1fRxY1RwaIgpMIm09+WeHg7bzs8qVh
 iwI3P/CWpKvGzF+cV7G7p923k2zpwnryKOTsPaVm5HbMD9OM4l1o24MnzckrWX8x+m3z7LYIjW
 Y7w=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; 
   d="scan'208";a="161573317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 11:32:34 +0800
IronPort-SDR: b6Dm1cXom6mr9vRHa7IzmEwa9Gjy7fcGS8CBu3wVCsTXfnURXwIpUp7zaGp79SVveDMl1eepoo
 YoGGXC6IZfFw8+k6wzCyBLwsfYzPQsf9kbeaBoPjupIKAPGiW9kQdsbEFhX5aO3pJY5kdAyBsO
 AATNK/2B1dpSRLMGikK+Xv7p1vpBg/hJ23oATsf/YGPrWJ0RvtBsweMzXYArIr5p2CN6vhPIX8
 FtepHw9GxbAZ6lJAwymk9mxbDEtgF+t+pzfDnXxI2hWgSg2mLAqO+k9QGBWpExBYy94h+a7id3
 zzi4OQt36mgSZZP82WeU9HPo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 19:15:18 -0800
IronPort-SDR: 1HtzEEjhfHmmQ8lhbVEwMndDwMIVkvKCcrCLnfrg+EomCOCOqXp4qxGkxUba1HBnouEBeWUW2q
 nsSvc2Lqa6C6fqinMhcNeQ0yqN8xFZ0jTxRQ8P/QOprMz0ipDzZWpoB3xmvM0mTgzJwzUx41lp
 WGcrX/4z83klRris2yiDVmsL4UG8BNlpf3KRoPhE0phibvzdsjiBBtKaNc8WC2geTQ0JLhpu+0
 PQ9QpGStJowI7eh7ouP7HqSscqZIaTUYIIE6F2X8calxHKOc5TDYPvLsgmzKntcAPvcKQBZDbG
 VUI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Mar 2021 19:32:33 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Discard page cache of zone reset target range
Date:   Mon,  8 Mar 2021 12:32:32 +0900
Message-Id: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
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
---
 block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e60..990a36be2927 100644
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
@@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
 		return -EFAULT;
 
+	capacity = get_capacity(bdev->bd_disk);
+	if (zrange.sector + zrange.nr_sectors <= zrange.sector ||
+	    zrange.sector + zrange.nr_sectors > capacity)
+		/* Out of range */
+		return -EINVAL;
+
+	start = zrange.sector << SECTOR_SHIFT;
+	end = ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;
+
 	switch (cmd) {
 	case BLKRESETZONE:
 		op = REQ_OP_ZONE_RESET;
+		/* Invalidate the page cache, including dirty pages. */
+		ret = truncate_bdev_range(bdev, mode, start, end);
+		if (ret)
+			return ret;
 		break;
 	case BLKOPENZONE:
 		op = REQ_OP_ZONE_OPEN;
@@ -366,8 +382,18 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		return -ENOTTY;
 	}
 
-	return blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
-				GFP_KERNEL);
+	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
+			       GFP_KERNEL);
+
+	/*
+	 * Invalidate the page cache again for zone reset; if someone wandered
+	 * in and dirtied a page, we just discard it - userspace has no way of
+	 * knowing whether the write happened before or after reset completing.
+	 */
+	if (!ret && cmd == BLKRESETZONE)
+		ret = truncate_bdev_range(bdev, mode, start, end);
+
+	return ret;
 }
 
 static inline unsigned long *blk_alloc_zone_bitmap(int node,
-- 
2.29.2

