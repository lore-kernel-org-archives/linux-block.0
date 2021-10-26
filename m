Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B637C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 06:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E10561039
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 06:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhJZGDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:03:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24404 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhJZGDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 02:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635228077; x=1666764077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Ime7Lhbh1sTmArkCqw8XFr7Sj+DW3q0oFjDWU/JzhM=;
  b=i9iNC3eTE95RqtfVx5M2wkvou5nsDEvueetkFkVSJQFYprb4PNORrxJI
   QeaMHuZlzkVPHVHPbZsRjvZuPtFbDwgUM3pAWe7mHGayJlke2a8uepVuP
   TQgS3lr6EfGo8Yw8nkNMdjwKjwMFJ7w1DhqC62inTwEBv35JDvhsKivKy
   g6foRvMoufjL0L1Q3Q1qW/z23qok686GIN3A0+I6RUzSrrhcRE5luf/Ng
   DQP+rdQkZxwtFgMNLBnUNGms6JcUnWl8YhCLm/PGaz5NNVlMbPi6CRQ2j
   yJuV6gXROGhLa7IdadOtiuB944h/HZMO1LjLG2GsZHrfy3ooWtsqk42h6
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,182,1631548800"; 
   d="scan'208";a="182852172"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 14:01:17 +0800
IronPort-SDR: DVWRz76JbenA1T6FPSWUBI/r3i6jeXh/0YAFRB1AW593YFV/+YU7B67HvhLseqi7z2KT2vRWoZ
 j+kZhpmw2ddJTXXteuSze7GdG2lmBmGabi8mkaXZjO++Rfnzs8LhF+9Ja2lb7MUxOrYzTxFQWy
 P+3yCLS2GFMFiEYa5hPNdxTyvuVFp1oTTtSVJt79no5hT0SVrAboE5QG91lwdiIeysTmb5e7oU
 owH6petmdzNoWP9ZZlhxZWpDl4hXPqup9dY+3Tm4km8jdVfPKa0C33LpTchH+vyx4uJL5UXgyU
 RY+8YdAuovGfvDCVtqpp2t4I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 22:35:14 -0700
IronPort-SDR: BStaZxrPcq/SrghmFSZu/UCom71ePjIGYa/bB+qZF2nSKAZfqUdgu6LJpkugybGdex10orMTUt
 EdgTFS3NaLjIanIJMg6QL7BZGD7kIw4z7XINf6T++zQLTEuZzvbPyjRPqPeDgPd485I02dq3pe
 Thb2VFnSz2as75PIXavRi0KIP8DGN7AwbDAPvDpzMn/WH9JSwPb2lou+b9dExPNEgQ6Em9ntcF
 4rrqRBCjG0jJ66BcHiF8hf7sOj6Ac01L8IzPP6a4hcUpUMcLRlApwOV7vCxs0sr24HQbv/a4oz
 DyA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2021 23:01:16 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: Fix partition check for host-aware zoned block devices
Date:   Tue, 26 Oct 2021 15:01:15 +0900
Message-Id: <20211026060115.753746-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") modified
the method to check partition existence in host-aware zoned block
devices from disk_has_partitions() helper function call to empty check
of xarray disk->part_tbl. However, disk->part_tbl always has single
entry for disk->part0 and never becomes empty. This resulted in the
host-aware zoned devices always judged to have partitions, and it made
the sysfs queue/zoned attribute to be "none" instead of "host-aware"
regardless of partition existence in the devices.

This also caused DEBUG_LOCKS_WARN_ON(lock->magic != lock) for
sdkp->rev_mutex in scsi layer when the kernel detects host-aware zoned
device. Since block layer handled the host-aware zoned devices as non-
zoned devices, scsi layer did not have chance to initialize the mutex
for zone revalidation. Therefore, the warning was triggered.

To fix the issues, call the helper function disk_has_partitions() in
place of disk->part_tbl empty check. Since the function was removed with
the commit a33df75c6328, reimplement it to walk through entries in the
xarray disk->part_tbl.

Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.14+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes from v1:
* Added Reviewed-by tags

 block/blk-settings.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a7c857ad7d10..b880c70e22e4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -842,6 +842,24 @@ bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
 
+static bool disk_has_partitions(struct gendisk *disk)
+{
+	unsigned long idx;
+	struct block_device *part;
+	bool ret = false;
+
+	rcu_read_lock();
+	xa_for_each(&disk->part_tbl, idx, part) {
+		if (bdev_is_partition(part)) {
+			ret = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /**
  * blk_queue_set_zoned - configure a disk queue zoned model.
  * @disk:	the gendisk of the queue to configure
@@ -876,7 +894,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 * we do nothing special as far as the block layer is concerned.
 		 */
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
-		    !xa_empty(&disk->part_tbl))
+		    disk_has_partitions(disk))
 			model = BLK_ZONED_NONE;
 		break;
 	case BLK_ZONED_NONE:
-- 
2.31.1

