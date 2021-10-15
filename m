Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1DAC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 02:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C2360F4A
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 02:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJOCJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:09:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61131 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhJOCJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 22:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634263663; x=1665799663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l4sxWpef19AH5gHAUrhEssE7h2mlb15v8sz2l4ASCkY=;
  b=DnGKGUC5/+0kvWHIgPwfiLLPTSk9bbSgxRwvzfhkAVeIcKMAE/bqZHD9
   vwkqy2OnQJh44s6u2exIISBqXSZPZgGkpRXrv0fNGP6Bs3GkSsE5AHS/9
   +ElyGErvYjiOERGMXQpOLo6lxePAbipWVbxWATTr2/uY4OsRjb2vY/GCo
   JU7OSaPXsBN46pBEFo1Kk4BRrfJLcz+4D9Gtwb+w9UIexPUKYWdTzcVIM
   Xdh65tZcwyzZttqpDiHBXzQfGEvo7irBjFRZX6IyJh18XoHUwXZUa6K0g
   eAMpUysC5kIORh+SC4EDAzR7JmSaYlWtj286nSmNgxLbfVmhTd7iMS43w
   A==;
X-IronPort-AV: E=Sophos;i="5.85,374,1624291200"; 
   d="scan'208";a="294637511"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 10:07:42 +0800
IronPort-SDR: k9TkPPJyW8YxkGNOy/eRxM4/B/mGbVRXPqb6E3bMIsmTO0qXcwGUMfShewG2tAQgOSgAHJQFsc
 yPTyI2nIzI9Ll0WogNgXIvdgahp3SeyCkQuEGrJ+vdDRVNWPF93oNPP194eX5PVclnYJYAz+Wn
 XxjvNHwqfYdGBgemi5i9ylQ/gQxB0KEaF0w9XFAy11pD0oxpcxyzyCHWqm/Am1rKAfSkv//aIB
 gHHpPK+PSaNmaW2BWZx3iIZ77NB2vwUeavuhe2phVzJNdx7JjvULBVOUi0M/zNLc4cLD1QBr2G
 ouwcTwNp5JPGYzkP96s9pZJp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:41:53 -0700
IronPort-SDR: 5YC0xryhlk8T1ww6rRBjjAtJRzVKeqyn0VhweC+sI21X4Eg1jLqHeZQ7Dsu/YRsLcTXqkiWQMM
 Y9cf/m0huEZock4epc2ZgGA1C3DyFofMynGn95BAyuhzQNHHNUh3vieuxPuTYkI8NMqVOYXqEC
 d7b6eXtvOhjyEUoOH5LKwo6MO0PdXUiorzdieBZI/DVDAiZaOtflpinuDHIkO/agK/+0mVnmPu
 fFwVWm9l7M5WEa6CMA0dC2VEj2oJ8UySuOd45wZbBAUu+dYWKFBm706RqnlgrUo80cTTX4mXJl
 /dU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Oct 2021 19:07:40 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Fix partition check for host-aware zoned block devices
Date:   Fri, 15 Oct 2021 11:07:40 +0900
Message-Id: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
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
---
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

