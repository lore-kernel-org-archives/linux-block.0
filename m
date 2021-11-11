Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8836C4167B
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26AC6124C
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKKIzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:55:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63281 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhKKIza (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636620762; x=1668156762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YTbLrWvevpStI64/EccmmUkx4+kVhifRoS6F7yl/StI=;
  b=ChSQlUY/8USEUAfLjCaQmeLrH6Zgh3miQYSTgHKAD6kLA8G4PM+bjl+0
   esZO6TNJlmf0QgXSG9aMVix7zSaqmx6O79/PtdjJa3Fklv5/2MlVJkGcb
   yKPFb3lGgJVX/iqCZ/0Tp1oKxLisIEaBYw4UoIHTXPsttYD9ZVU3jClHb
   59bNHg60waa/gsvrUxPvuJ0kZ8ciBhlEV8UzuKek7l0tUeZHI90d9/lQ2
   a9LQ9d1OGwblNB2iVQU9fbxJ6Zj9PRkEmtCTq1zpornLJv3iZz8kGw7P0
   4Wqh0z2QlrzLVNmubWKa7KQlEgdu2jNwZHEF9ACkXKxf8FARxL8V3fcQe
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="184335201"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 16:52:39 +0800
IronPort-SDR: BJzveJY4kjU56mT1bfssTAPLax6SRAya+N2nDKedDbQPkHKywZ96t70kvhrfmiZJYKv6lOz1ez
 oH+BkRzGtqFBEzjdGRiP65TKsRvNVW+MCrtfqqqAf7aZxpYqhiCa45hCPM7kEK+72tymFY+mdg
 +sTaV2qHQSJsx+B9Iz7HaqOcH2NspTYBA8dJ+MBWRuK4AMa8XxyzaM1jDi+kHDAztsciH606UR
 o8vWgq08XdEvHwXDdcDcn4Iq7xl18Kcwd1Fsos2pyTDrSmLINakKBOhcB8yJG0dcQ6rgM55cgE
 JD7TePFuEUdghTehRtC03DjL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:27:49 -0800
IronPort-SDR: JseW3Th3rXNecIo7YCp6m44OW3oAk9zL2tiK4R8XRia75UgteERDsyHLdScGRxwhKv/TRqRhNJ
 2ckHFvNw1zliTiqRZZrX9PdEDcM/gEpu0aCv9tHJuUyEGnv6wHKpcdQ6QLejaw99hAztp2u+Bh
 o3CVFRfv4cw8zmtnEphxAXTPqXjvZqIcyk1n0Ud79/eFpmnLJynEDLZtAUkJQmAc4Epuze97h9
 VMIEmJp1+eYBcV8QoGmDX6Xt9uLddcZfTn09vWcuatxZ6JWd4Px39h8iKQM+pCiYeG+qiWAMhY
 cmc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2021 00:52:39 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Hold invalidate_lock in BLKRESETZONE ioctl
Date:   Thu, 11 Nov 2021 17:52:38 +0900
Message-Id: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When BLKRESETZONE ioctl and data read race, the data read leaves stale
page cache. The commit e5113505904e ("block: Discard page cache of zone
reset target range") added page cache truncation to avoid stale page
cache after the ioctl. However, the stale page cache still can be read
during the reset zone operation for the ioctl. To avoid the stale page
cache completely, hold invalidate_lock of the block device file mapping.

Fixes: e5113505904e ("block: Discard page cache of zone reset target range")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.15
---
 block/blk-zoned.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1d0c76c18fc5..774ecc598bee 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -429,9 +429,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
+		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
-			return ret;
+			goto fail;
 		break;
 	case BLKOPENZONE:
 		op = REQ_OP_ZONE_OPEN;
@@ -449,15 +450,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
 			       GFP_KERNEL);
 
-	/*
-	 * Invalidate the page cache again for zone reset: writes can only be
-	 * direct for zoned devices so concurrent writes would not add any page
-	 * to the page cache after/during reset. The page cache may be filled
-	 * again due to concurrent reads though and dropping the pages for
-	 * these is fine.
-	 */
-	if (!ret && cmd == BLKRESETZONE)
-		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
+fail:
+	if (cmd == BLKRESETZONE)
+		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
 
 	return ret;
 }
-- 
2.33.1

