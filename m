Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297AC34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 04:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D32B20801
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 04:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lCIJVMj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBSE0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:26:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45545 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgBSE0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 23:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582086394; x=1613622394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/y8SME3FiOeVNdpwmZYMg41QjNzxYEYoPzaWj0kRXAk=;
  b=lCIJVMj+eQ70x9nsqxx90TZGMQ9F6pwCq5g7jei46QivRJ1I1Xwrk7a6
   kjntFD+1xuzh3qovbELCYmsCFyEMcHbVWJvlHY7D97PMq+oxnGFvxNzVW
   PjevkTkjlQmfTGiTdMEdbY7AEK28pNBHVD3GTa+tVRJAFS0MsMt5vBfhT
   +rBtGMbFhb0K9gFMYY+K+Rrg+/nD2+Wj4KdmHkn90qbpl7SrtbW2STgDm
   yQe8/RJ1+LBd7eNYuBXBO3Q5MDI1AZHs81gkGHVUga64DtZE2K/SwA6yJ
   VKcneSGYMbd9fbQyMOLd6vDD6V55Kr2HDoFuYMXc/PxgnhSs6+/9ZqGVO
   g==;
IronPort-SDR: DvHV/CSesg65G5HOavqGBv+7IEsykx9joHgLmPmI105Nv/u7000z+S6RCAL6agtSpvIdjBtpSp
 IhqZcSu9IlHh+b504iasiTFS2pw6gAnUjNdYxlvVURiC6pBgp2MNIX7XieZ9FJ7Jp3ebusuc1c
 g72g+F6T5+GPjb3DShijIqi9geJAQUnkFtNTZeWq+PCdEGRHon0zqW6w3V5g5LcAtLgwpY1ZBm
 nAqIWNiyjFbgIG3KQAfREUh0m9oaOwMVQ4gyjD1A1KzZh2rDiVmh6koNWTJfgAuSg4WmMvz5if
 scc=
X-IronPort-AV: E=Sophos;i="5.70,459,1574092800"; 
   d="scan'208";a="134512724"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 12:26:34 +0800
IronPort-SDR: 0G0vE0ty6oang2fm/NMkeWrKqY6pYIzyA7lPjUfqCQQz3anzQqkALIwLSzbZQZGcb6WKtIyMkR
 bcfUR9RwRV0U8P1OgQ8P4ua/UYhC31ZkHU629yBybvs+u03zhZjSZtz0Ou6bBqlr6Rx/dRiDE2
 BSXU+JUSEh3x9i6lC9lcBxcsuA/xN0/UVCXV7wCeSkzc462QqJs4JOguh0BD5Eth8OfvxE7PbU
 UnuvZqvIC3naVQXGrtbQJATwbxOCMCmODhj5btZ5+erQc7HKpf5rgSA86/oKgWl9yv/Zykm8kE
 D5nQRguaT58Amb82IXcKwYEK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 20:19:11 -0800
IronPort-SDR: uwiBeHrxHXHmUJCBqPBv4rx8tOiaAGFSaTUcEGSiYzB/eoeV7F1uiCA50HdEoi8HcTNJCF4zw5
 wY2GHW0eRp44j2/vxJGHQ/S560Vpk+DOhxhEccz7UZPTaTgvIzDFlnZLsRgzFh6RQ7uS1Of/vG
 vpMlr1soxWlzQZKBnwwC76ufZrfQoKXC559Ta+EQJqJ9tNB7a6DCJ/KU5+FnGmikFYFnz3P+er
 G0/7ZNyXlXJeEFfMrPPGiq+UUHz331wdghlip56QSjhGpHltpDBySWeGDE08I8db6TVnh50m/4
 27w=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2020 20:26:33 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: Fix partition support for host aware zoned block devices
Date:   Wed, 19 Feb 2020 13:26:32 +0900
Message-Id: <20200219042632.819101-1-shinichiro.kawasaki@wdc.com>
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
 block/genhd.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/genhd.h | 13 +------------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..ed8cdebc2cf0 100644
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
+	/* Iterate partitions skipping the holder device at index 0 */
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
index 6fbe58538ad6..f1b5c86b096a 100644
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
+extern bool disk_has_partitions(struct gendisk *disk);
 
 /*
  * Macros to operate on percpu disk statistics:
-- 
2.24.1

