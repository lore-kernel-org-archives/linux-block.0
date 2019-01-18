Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A24C1B0FD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191BA20883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfARVcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:32:50 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:60515 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbfARVct (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 18 Jan 2019 16:32:49 -0500
Received: from apollon.suse.de.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 18 Jan 2019 14:32:42 -0700
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Martin Wilck <mwilck@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Jiri Kosina <jikos@kernel.org>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 3/4] Revert "block: unexport DISK_EVENT_MEDIA_CHANGE for legacy/fringe drivers"
Date:   Fri, 18 Jan 2019 22:32:06 +0100
Message-Id: <20190118213207.2309-4-mwilck@suse.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118213207.2309-1-mwilck@suse.com>
References: <20190118213207.2309-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 9fd097b14918875bd6f125ed699d7bbbba5893ee.

Instead of leaving disk->events completely empty, we now export the supported
events again, and tell the block layer not to forward events to user space by
not setting DISK_EVENT_FLAG_UEVENT. This allows the block layer to distinguish
between devices that for which events should be handled in kernel only, and
devices which don't support any meda change events at all.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Tim Waugh <tim@cyberelk.net>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/block/amiflop.c    | 1 +
 drivers/block/ataflop.c    | 1 +
 drivers/block/floppy.c     | 1 +
 drivers/block/paride/pcd.c | 1 +
 drivers/block/paride/pd.c  | 1 +
 drivers/block/paride/pf.c  | 1 +
 drivers/block/swim.c       | 1 +
 drivers/block/swim3.c      | 1 +
 drivers/block/xsysace.c    | 1 +
 drivers/cdrom/gdrom.c      | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 0903e08..92b930c 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1829,6 +1829,7 @@ static int __init fd_probe_drives(void)
 		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = drive;
 		disk->fops = &floppy_fops;
+		disk->events = DISK_EVENT_MEDIA_CHANGE;
 		sprintf(disk->disk_name, "fd%d", drive);
 		disk->private_data = &unit[drive];
 		set_capacity(disk, 880*2);
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index b0dbbdf..c7b5c46 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2028,6 +2028,7 @@ static int __init atari_floppy_init (void)
 		unit[i].disk->first_minor = i;
 		sprintf(unit[i].disk->disk_name, "fd%d", i);
 		unit[i].disk->fops = &floppy_fops;
+		unit[i].disk->events = DISK_EVENT_MEDIA_CHANGE;
 		unit[i].disk->private_data = &unit[i];
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
 		add_disk(unit[i].disk);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6f2856c..f95699e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4543,6 +4543,7 @@ static int __init do_floppy_init(void)
 		disks[drive]->major = FLOPPY_MAJOR;
 		disks[drive]->first_minor = TOMINOR(drive);
 		disks[drive]->fops = &floppy_fops;
+		disks[drive]->events = DISK_EVENT_MEDIA_CHANGE;
 		sprintf(disks[drive]->disk_name, "fd%d", drive);
 
 		timer_setup(&motor_off_timer[drive], motor_off_callback, 0);
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670ee..359a0d8 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -342,6 +342,7 @@ static void pcd_init_units(void)
 		strcpy(disk->disk_name, cd->name);	/* umm... */
 		disk->fops = &pcd_bdops;
 		disk->flags = GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
+		disk->events = DISK_EVENT_MEDIA_CHANGE;
 	}
 }
 
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 0ff9b12..6f9ad3f 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -897,6 +897,7 @@ static void pd_probe_drive(struct pd_unit *disk)
 	p->fops = &pd_fops;
 	p->major = major;
 	p->first_minor = (disk - pd) << PD_BITS;
+	p->events = DISK_EVENT_MEDIA_CHANGE;
 	disk->gd = p;
 	p->private_data = disk;
 
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8..52a74f9 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -319,6 +319,7 @@ static void __init pf_init_units(void)
 		disk->first_minor = unit;
 		strcpy(disk->disk_name, pf->name);
 		disk->fops = &pf_fops;
+		disk->events = DISK_EVENT_MEDIA_CHANGE;
 		if (!(*drives[unit])[D_PRT])
 			pf_drive_count++;
 	}
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3fa6fcc..67b5ec2 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -862,6 +862,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->first_minor = drive;
 		sprintf(swd->unit[drive].disk->disk_name, "fd%d", drive);
 		swd->unit[drive].disk->fops = &floppy_fops;
+		swd->unit[drive].disk->events = DISK_EVENT_MEDIA_CHANGE;
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		set_capacity(swd->unit[drive].disk, 2880);
 		add_disk(swd->unit[drive].disk);
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 1e2ae90d..cf42729 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1216,6 +1216,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->first_minor = floppy_count;
 	disk->fops = &floppy_fops;
 	disk->private_data = fs;
+	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", floppy_count);
 	set_capacity(disk, 2880);
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 87ccef4..8d29950 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1032,6 +1032,7 @@ static int ace_setup(struct ace_device *ace)
 	ace->gd->major = ace_major;
 	ace->gd->first_minor = ace->id * ACE_NUM_MINORS;
 	ace->gd->fops = &ace_fops;
+	ace->gd->events = DISK_EVENT_MEDIA_CHANGE;
 	ace->gd->queue = ace->queue;
 	ace->gd->private_data = ace;
 	snprintf(ace->gd->disk_name, 32, "xs%c", ace->id + 'a');
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index f8b7345..5cf3bad 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -786,6 +786,7 @@ static int probe_gdrom(struct platform_device *devptr)
 		goto probe_fail_cdrom_register;
 	}
 	gd.disk->fops = &gdrom_bdops;
+	gd.disk->events = DISK_EVENT_MEDIA_CHANGE;
 	/* latch on to the interrupt */
 	err = gdrom_set_interrupt_handlers();
 	if (err)
-- 
2.19.2

