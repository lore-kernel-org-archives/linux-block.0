Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA422C1B0F7
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C68B2086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 21:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfARVdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:33:00 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:51676 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbfARVc6 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 18 Jan 2019 16:32:58 -0500
Received: from apollon.suse.de.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 18 Jan 2019 14:32:45 -0700
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Martin Wilck <mwilck@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: [PATCH 4/4] block: check_events: don't bother with events if unsupported
Date:   Fri, 18 Jan 2019 22:32:07 +0100
Message-Id: <20190118213207.2309-5-mwilck@suse.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118213207.2309-1-mwilck@suse.com>
References: <20190118213207.2309-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers now report to the block layer if they support media change
events. If this is not the case, there's no need to allocate
the event structure, and all event handling code can effectively
be skipped. This simplifies code flow in particular for
non-removable sd devices.

This effectively reverts commit 75e3f3ee3c64 ("block: always allocate
genhd->ev if check_events is implemented").

The sysfs files for the events are kept in place even if no events
are supported, as user space may rely on them being present. The only
difference is that an error code is now returned if the user tries
to set poll_msecs.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index bcd16f6..55b6570 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1909,6 +1909,9 @@ static ssize_t disk_events_poll_msecs_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (!disk->ev)
+		return sprintf(buf, "-1\n");
+
 	return sprintf(buf, "%ld\n", disk->ev->poll_msecs);
 }
 
@@ -1925,6 +1928,9 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
 	if (intv < 0 && intv != -1)
 		return -EINVAL;
 
+	if (!disk->ev)
+		return -ENODEV;
+
 	disk_block_events(disk);
 	disk->ev->poll_msecs = intv;
 	__disk_unblock_events(disk, true);
@@ -1989,7 +1995,8 @@ static void disk_alloc_events(struct gendisk *disk)
 {
 	struct disk_events *ev;
 
-	if (!disk->fops->check_events)
+	if (!disk->fops->check_events ||
+	    !(disk->events & DISK_EVENT_TYPES_MASK))
 		return;
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
@@ -2011,14 +2018,14 @@ static void disk_alloc_events(struct gendisk *disk)
 
 static void disk_add_events(struct gendisk *disk)
 {
-	if (!disk->ev)
-		return;
-
 	/* FIXME: error handling */
 	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
 		pr_warn("%s: failed to create sysfs files for events\n",
 			disk->disk_name);
 
+	if (!disk->ev)
+		return;
+
 	mutex_lock(&disk_events_mutex);
 	list_add_tail(&disk->ev->node, &disk_events);
 	mutex_unlock(&disk_events_mutex);
@@ -2032,14 +2039,13 @@ static void disk_add_events(struct gendisk *disk)
 
 static void disk_del_events(struct gendisk *disk)
 {
-	if (!disk->ev)
-		return;
+	if (disk->ev) {
+		disk_block_events(disk);
 
-	disk_block_events(disk);
-
-	mutex_lock(&disk_events_mutex);
-	list_del_init(&disk->ev->node);
-	mutex_unlock(&disk_events_mutex);
+		mutex_lock(&disk_events_mutex);
+		list_del_init(&disk->ev->node);
+		mutex_unlock(&disk_events_mutex);
+	}
 
 	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
 }
-- 
2.19.2

