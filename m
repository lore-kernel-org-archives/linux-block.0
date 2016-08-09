Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34429 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbcHIOpy (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2016 10:45:54 -0400
From: tom.ty89@gmail.com
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 1/2] libata-scsi: set max_hw_sectors again only when dev->max_sectors is set
Date: Tue,  9 Aug 2016 22:45:46 +0800
Message-Id: <5eceeb9ad825beb87db03b0989f746dfbe0cf3fe.1470753817.git.tom.ty89@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tom Yan <tom.ty89@gmail.com>

When the request queue is initialized (see __scsi_init_queue() in
scsi_lib.c), the block layer limit max_hw_sectors is set to
shost->max_sectors, which will be set to the "machine infinity"
SCSI_DEFAULT_MAX_SECTORS (currently 1024) if sht->max_sectors is
not set (see scsi_host_alloc() in hosts.c).

Therefore, if dev->max_sectors is not set (or, initialized to 0),
we do not call blk_queue_max_hw_sectors() again with that.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2bdb5da..6fee950 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1205,7 +1205,8 @@ static int ata_scsi_dev_config(struct scsi_device *sdev,
 		dev->flags |= ATA_DFLAG_NO_UNLOAD;
 
 	/* configure max sectors */
-	blk_queue_max_hw_sectors(q, dev->max_sectors);
+	if (dev->max_sectors)
+		blk_queue_max_hw_sectors(q, dev->max_sectors);
 
 	if (dev->class == ATA_DEV_ATAPI) {
 		void *buf;
-- 
2.9.2

