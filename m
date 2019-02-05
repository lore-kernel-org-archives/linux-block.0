Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D94C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E759020821
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBELi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:38:26 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:57368 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBELiS (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 5 Feb 2019 06:38:18 -0500
Received: from apollon.suse.de.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 05 Feb 2019 04:38:11 -0700
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2 3/5] Revert "ide: unexport DISK_EVENT_MEDIA_CHANGE for ide-gd and ide-cd"
Date:   Tue,  5 Feb 2019 12:37:39 +0100
Message-Id: <20190205113741.11267-4-mwilck@suse.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113741.11267-1-mwilck@suse.com>
References: <20190205113741.11267-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 7eec77a1816a7042591a6cbdb4820e9e7ebffe0e.

Instead of leaving disk->events completely empty, we now export the
supported events again, and tell the block layer not to forward events to
user space by not setting DISK_EVENT_FLAG_UEVENT. This allows the block
layer to distinguish between devices that for which events should be
handled in kernel only, and devices which don't support any meda change
events at all.

Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/ide/ide-cd.c       | 1 +
 drivers/ide/ide-cd_ioctl.c | 5 +++--
 drivers/ide/ide-gd.c       | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 1f03884..3b15adc 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1797,6 +1797,7 @@ static int ide_cd_probe(ide_drive_t *drive)
 	ide_cd_read_toc(drive);
 	g->fops = &idecd_ops;
 	g->flags |= GENHD_FL_REMOVABLE | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
+	g->events = DISK_EVENT_MEDIA_CHANGE;
 	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 4a6e1a4..f9f4bac 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -82,8 +82,9 @@ int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 
 /*
  * ide-cd always generates media changed event if media is missing, which
- * makes it impossible to use for proper event reporting, so disk->events
- * is cleared to 0 and the following function is used only to trigger
+ * makes it impossible to use for proper event reporting, so
+ * DISK_EVENT_FLAG_UEVENT is cleared in disk->events
+ * and the following function is used only to trigger
  * revalidation and never propagated to userland.
  */
 unsigned int ide_cdrom_check_events_real(struct cdrom_device_info *cdi,
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 04e008e..0079bb8 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -299,8 +299,9 @@ static unsigned int ide_gd_check_events(struct gendisk *disk,
 	/*
 	 * The following is used to force revalidation on the first open on
 	 * removeable devices, and never gets reported to userland as
-	 * genhd->events is 0.  This is intended as removeable ide disk
-	 * can't really detect MEDIA_CHANGE events.
+	 * DISK_EVENT_FLAG_UEVENT isn't set in genhd->events.
+	 * This is intended as removable ide disk can't really detect
+	 * MEDIA_CHANGE events.
 	 */
 	ret = drive->dev_flags & IDE_DFLAG_MEDIA_CHANGED;
 	drive->dev_flags &= ~IDE_DFLAG_MEDIA_CHANGED;
@@ -416,6 +417,7 @@ static int ide_gd_probe(ide_drive_t *drive)
 	if (drive->dev_flags & IDE_DFLAG_REMOVABLE)
 		g->flags = GENHD_FL_REMOVABLE;
 	g->fops = &ide_gd_ops;
+	g->events = DISK_EVENT_MEDIA_CHANGE;
 	device_add_disk(&drive->gendev, g, NULL);
 	return 0;
 
-- 
2.20.1

