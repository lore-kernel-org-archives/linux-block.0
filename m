Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD0C11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 01:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964F24650
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 01:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QqaSo8W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBUBhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:37:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36878 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBUBhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 20:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582249032; x=1613785032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=462vbniaZawS8uOtyx1fW2+OIO2eaPz59VquK7wsZSY=;
  b=QqaSo8W0Un5SbKBpTOt/x+m/nHEZEOfmWJTVWvCDfmIf66M9JMZL3LB2
   O5E3q0zp87zaZphgdqK+cb7ZdzfJl4I02TV7Ce+zzOX2dXKUQa7Chi/Rf
   ZjX47Vm1saMoZ9fj+YQUF5NtqlGOAkQ2biL9KpZeVXinqlLyvdSbx1bse
   XmxqYYdYAX8js9F+I3UeZn9n1lvO6AoHycMDf9nLWVMMZuXojXvVmlsfF
   HY8XTMYs/yvNGsNocyDx9p1PmWeMCJ3Vm9GwhYLz0jKvJqnu+O1V5PELI
   9v6QGR+73XBZv8ANE5eS6/NApMC4BlzOLRJST8nQKVne8VLXi+gi/WxGB
   w==;
IronPort-SDR: gqEhRJERCxNCOWF0pLGz4GAc8OQZGP+uqj+VAYirMyqFIO5A2YZR8gfUkz2Dz+2XHn2APhjFZu
 iefNFpuiyLOgwVEkUkGgvMLisgd8pOtPzm93Jw2zI7rEZC1yvaiFpEpPFuAmoa5up1MeVsZ7t1
 L7FOB+1+7FBMQcHoDv+/M2uljE2Kgl4YEhQRoGJF9QnGY3Ghgg0yitFsOdV/v1rEJOUmBP5tQ5
 q8sv2cURBxJWfSA3gy686cKjhH/2YEvcX+WTqEQa3XsTBbQuFZo9Vbc3OfD7ZVkmeZj0YKMsHf
 BUc=
X-IronPort-AV: E=Sophos;i="5.70,466,1574092800"; 
   d="scan'208";a="130323975"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 09:37:10 +0800
IronPort-SDR: UaNlLCfzBvUk+f3N0EcuPjVKDfOyrwB3vlz2u2z+jTSJoGFVG+hjz5GkxCQhUkyfIiwUdYLkQN
 ZGKDhXpsDaGcAPDdkCjmMEAX8Efcsq2MKL+9B1Kd3pMTshNBTzi3li6AzFrhWPappCkcj1EdYc
 SzIQs4G4/ZoARu57djkZuA6h2SY/p9E3t/GOvxKR1oyTkdAv9Lw2/dYQfIKaqzM3FCVTU/vn4K
 Bsik3ctoVxjk+YkQ+i5y5SruKlI5iMTmnTNF5RFzWfBztx+CGR7DUeQp6ssZwj4Wykx3QJgatu
 u6uk9fY35aF12ultrfe4Q5ja
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 17:29:45 -0800
IronPort-SDR: Ic3cJDDrfKqchgWOaAQPse0Uz30g0LcAFq6sd1mfPeerqT+DMV+TT0e5VJxRMjasLk/uL7ItF3
 b1rqZf0w6ZF8m8ZYogARTb2CYWt3FpbjCRDT+xgnO68bK7IfUEtLLsP8xLFuf7fCQdUXHb2SJ0
 Wrw7AfJAFuwEUzhn7QB49onm1PDhFV+GguUQVrjpmcZf777grLt5gwHQ7x1Ho9Xu7zZT9qh1j4
 w2abZw4HsTCn6N2AaPs0/hVEUHp+pAXYjc5T7aUeD+QdN8gSm6ydtINhNhLO7cw/ZHXb6AU7Bg
 wq8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2020 17:37:08 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: Fix partition support for host aware zoned block devices
Date:   Fri, 21 Feb 2020 10:37:08 +0900
Message-Id: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b72053072c0b ("block: allow partitions on host aware zone
devices") introduced the helper function disk_has_partitions() to check
if a given disk has valid partitions. However, since this function result
directly depends on the disk partition table length rather than the
actual existence of valid partitions in the table, it returns true even
after all partitions are removed from the disk. For host aware zoned
block devices, this results in zone management support to be kept
disabled even after removing all partitions.

Fix this by changing disk_has_partitions() to walk through the partition
table entries and return true if and only if a valid non-zero size
partition is found.

Fixes: b72053072c0b ("block: allow partitions on host aware zone devices")
Cc: stable@vger.kernel.org # 5.5
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Addressed comments on the list

 block/genhd.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/genhd.h | 13 +------------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..9c2e13ce0d19 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -301,6 +301,42 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 }
 EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
 
+/**
+ * disk_has_partitions
+ * @disk: gendisk of interest
+ *
+ * Walk through the partition table and check if valid partition exists.
+ *
+ * CONTEXT:
+ * Don't care.
+ *
+ * RETURNS:
+ * True if the gendisk has at least one valid non-zero size partition.
+ * Otherwise false.
+ */
+bool disk_has_partitions(struct gendisk *disk)
+{
+	struct disk_part_tbl *ptbl;
+	int i;
+	bool ret = false;
+
+	rcu_read_lock();
+	ptbl = rcu_dereference(disk->part_tbl);
+
+	/* Iterate partitions skipping the whole device at index 0 */
+	for (i = 1; i < ptbl->len; i++) {
+		if (rcu_dereference(ptbl->part[i])) {
+			ret = true;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(disk_has_partitions);
+
 /*
  * Can be deleted altogether. Later.
  *
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fbe58538ad6..07dc91835b98 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -245,18 +245,6 @@ static inline bool disk_part_scan_enabled(struct gendisk *disk)
 		!(disk->flags & GENHD_FL_NO_PART_SCAN);
 }
 
-static inline bool disk_has_partitions(struct gendisk *disk)
-{
-	bool ret = false;
-
-	rcu_read_lock();
-	if (rcu_dereference(disk->part_tbl)->len > 1)
-		ret = true;
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static inline dev_t disk_devt(struct gendisk *disk)
 {
 	return MKDEV(disk->major, disk->first_minor);
@@ -298,6 +286,7 @@ extern void disk_part_iter_exit(struct disk_part_iter *piter);
 
 extern struct hd_struct *disk_map_sector_rcu(struct gendisk *disk,
 					     sector_t sector);
+bool disk_has_partitions(struct gendisk *disk);
 
 /*
  * Macros to operate on percpu disk statistics:
-- 
2.24.1

