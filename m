Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62466 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbcLTSoy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2016 13:44:54 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
To: axboe@kernel.dk
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH] genhd: remove dead and duplicated scsi code
Date: Tue, 20 Dec 2016 14:38:14 -0700
Message-Id: <1482269894-14034-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_scsi_cmd_filter use was deprecated by 4beab5c6 and the SCSI macros
are duplicated in blkdev.h, both likely reintroduced by a bad merge from
540eed56.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 include/linux/genhd.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index e0341af..76f3975 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -146,15 +146,6 @@ enum {
 	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
 };
 
-#define BLK_SCSI_MAX_CMDS	(256)
-#define BLK_SCSI_CMD_PER_LONG	(BLK_SCSI_MAX_CMDS / (sizeof(long) * 8))
-
-struct blk_scsi_cmd_filter {
-	unsigned long read_ok[BLK_SCSI_CMD_PER_LONG];
-	unsigned long write_ok[BLK_SCSI_CMD_PER_LONG];
-	struct kobject kobj;
-};
-
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-- 
1.8.3.1

