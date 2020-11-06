Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EFC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587D420735
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 11:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jGdh9LDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgKFLBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:01:45 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38950 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFLBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 06:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604660504; x=1636196504;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oj+zkZJCEF9GpFAXd7uZdr4k53Hqvnua972ne0jLjzQ=;
  b=jGdh9LDqBSpvJra+1GRixgo0X0TL8KzfQZA8Wnt2CemxjPDgIbDjCVec
   NQuUk0Oi7egYqQVZossoRvVD+t1il/rG1qLs4z1opVA0T493fFmQ1NE/x
   2VyFTKirUs3M1EHU0snb+qMCwTBliz2U77GUmM4tLJz4ce7lFkYsiro5Z
   7VKPzU4DiNYg59kX7V2v7GyobZL26mSUP4eIEIfBYFxIylZGEB0rNDlxe
   Hin200J6+cqLUFebExQwlTOtZqRahqF+1Zhs2Yz032lC2ol19JzBXskup
   K+V4GD0o4thPNwqJ+DFcLNF/LWNJnuVk7czUr9xc8ZTLpIaPPnwQcQcJu
   Q==;
IronPort-SDR: qwmP6iLk4LJkG+I+LfrE6Ns6VmrvxMIdxCAymmxbx05uzUBfAbfzkAEQXKnvC390XtXunJRcAH
 huPlGT3kS7zQdaFTr73DmFL3VrNW0QFhtMjQsuijdeZWX7y/GcxYwfAxc1zbh7TihZQz8rGO5G
 lqxWJMFRiSkUQgYpE73yGIAXkeLeuiXqyZ4PLPYvoxy+7MSam8HaEHImmAvtUWUTDckwNh7f7Q
 TS81Ky7mIHEtSjPuaJpvG8IHqs3+ekMU4r+IeRb0oby2iSsH16TLx5vcMY//qo9x4PRTV8otIw
 28Y=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="151916894"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 19:01:44 +0800
IronPort-SDR: f8eUAyym/Nn6Xjuhp0lbxfp7rN7RZTy1fmh+6p26dAF48vaa6dYAvaHJsaTTTolWwFcEbwUNpt
 +Rzk1JkrVdR7k8MPghVKLP36i/s6a5SQNzZznEUCN8dnVlnofS9wU05DuGonaJLDE43vcww/DU
 qGncWBXBEowr7LEXb64WafjYnPOiCh/pAY5lZMr8F+nFAyKtqcDaiRlPhtf4B/RKGS7HbjqjMt
 ELDuRY6e8zwmy9Rn01JnoLC9xD2cg6y5fYxT2qS+WfSBlqmMqJ9/CYd8AYMg+cwjy42JLHqlsx
 jXaR2YNhakkkFtjDdGaEVIBA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:47:50 -0800
IronPort-SDR: mp/VOALfmfVYEQViUy5cyqjVgERaqgZDY8iz/BdDTQWNK4ttz2Q0GTtkc4XUWuNmUJM0bWQPxt
 PQjsVf+jD0dD767UMQEyY6lECWb+NOwLWmLmTurDKhuF9us3FxA0Nv+T6cIQXP+bhXWKHrUrI+
 QKltM0UYwJAF7rwzLfp0Sjb0+oubgVCoPibOyApzLwe4BpoqO4JM1kabVxgfwNh+Ri2tW0muuZ
 VXrVKXb4axmYJhw8KG6KuIyFvtO+fy+yru1MnLQ4u3FK+e15EVPHoZC0SwQOMOPPSQgohaqp0k
 eSA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Nov 2020 03:01:43 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Date:   Fri,  6 Nov 2020 20:01:41 +0900
Message-Id: <20201106110141.5887-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed
zone locking to using the potentially sleeping wait_on_bit_io()
function. This is acceptable when memory backing is enabled as the
device queue is in that case marked as blocking, but this triggers a
scheduling while in atomic context with memory backing disabled.

Fix this by relying solely on the device zone spinlock for zone
information protection without temporarily releasing this lock around
null_process_cmd() execution in null_zone_write(). This is OK to do
since when memory backing is disabled, command processing does not
block and the memory backing lock nullb->lock is unused. This solution
avoids the overhead of having to mark a zoned null_blk device queue as
blocking when memory backing is unused.

This patch also adds comments to the zone locking code to explain the
unusual locking scheme.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: aa1c09cb65e2 ("null_blk: Fix locking in zoned mode")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       |  2 +-
 drivers/block/null_blk_zoned.c | 47 ++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index cfd00ad40355..c24d9b5ad81a 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -47,7 +47,7 @@ struct nullb_device {
 	unsigned int nr_zones_closed;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
-	spinlock_t zone_dev_lock;
+	spinlock_t zone_lock;
 	unsigned long *zone_locks;
 
 	unsigned long size; /* device size in MB */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 8775acbb4f8f..beb34b4f76b0 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -46,11 +46,20 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (!dev->zones)
 		return -ENOMEM;
 
-	spin_lock_init(&dev->zone_dev_lock);
-	dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
-	if (!dev->zone_locks) {
-		kvfree(dev->zones);
-		return -ENOMEM;
+	/*
+	 * With memory backing, the zone_lock spinlock needs to be temporarily
+	 * released to avoid scheduling in atomic context. To guarantee zone
+	 * information protection, use a bitmap to lock zones with
+	 * wait_on_bit_lock_io(). Sleeping on the lock is OK as memory backing
+	 * implies that the queue is marked with BLK_MQ_F_BLOCKING.
+	 */
+	spin_lock_init(&dev->zone_lock);
+	if (dev->memory_backed) {
+		dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
+		if (!dev->zone_locks) {
+			kvfree(dev->zones);
+			return -ENOMEM;
+		}
 	}
 
 	if (dev->zone_nr_conv >= dev->nr_zones) {
@@ -137,12 +146,17 @@ void null_free_zoned_dev(struct nullb_device *dev)
 
 static inline void null_lock_zone(struct nullb_device *dev, unsigned int zno)
 {
-	wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
+	if (dev->memory_backed)
+		wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
+	spin_lock_irq(&dev->zone_lock);
 }
 
 static inline void null_unlock_zone(struct nullb_device *dev, unsigned int zno)
 {
-	clear_and_wake_up_bit(zno, dev->zone_locks);
+	spin_unlock_irq(&dev->zone_lock);
+
+	if (dev->memory_backed)
+		clear_and_wake_up_bit(zno, dev->zone_locks);
 }
 
 int null_report_zones(struct gendisk *disk, sector_t sector,
@@ -322,7 +336,6 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 
 	null_lock_zone(dev, zno);
-	spin_lock(&dev->zone_dev_lock);
 
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
@@ -375,9 +388,17 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
-	spin_unlock(&dev->zone_dev_lock);
+	/*
+	 * Memory backing allocation may sleep: release the zone_lock spinlock
+	 * to avoid scheduling in atomic context. Zone operation atomicity is
+	 * still guaranteed through the zone_locks bitmap.
+	 */
+	if (dev->memory_backed)
+		spin_unlock_irq(&dev->zone_lock);
 	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-	spin_lock(&dev->zone_dev_lock);
+	if (dev->memory_backed)
+		spin_lock_irq(&dev->zone_lock);
+
 	if (ret != BLK_STS_OK)
 		goto unlock;
 
@@ -392,7 +413,6 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	ret = BLK_STS_OK;
 
 unlock:
-	spin_unlock(&dev->zone_dev_lock);
 	null_unlock_zone(dev, zno);
 
 	return ret;
@@ -516,9 +536,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 			null_lock_zone(dev, i);
 			zone = &dev->zones[i];
 			if (zone->cond != BLK_ZONE_COND_EMPTY) {
-				spin_lock(&dev->zone_dev_lock);
 				null_reset_zone(dev, zone);
-				spin_unlock(&dev->zone_dev_lock);
 				trace_nullb_zone_op(cmd, i, zone->cond);
 			}
 			null_unlock_zone(dev, i);
@@ -530,7 +548,6 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	zone = &dev->zones[zone_no];
 
 	null_lock_zone(dev, zone_no);
-	spin_lock(&dev->zone_dev_lock);
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET:
@@ -550,8 +567,6 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 		break;
 	}
 
-	spin_unlock(&dev->zone_dev_lock);
-
 	if (ret == BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
 
-- 
2.26.2

