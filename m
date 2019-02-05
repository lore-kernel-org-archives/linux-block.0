Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526B8C282D7
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0912175B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfBELiS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:38:18 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:58697 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfBELiS (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 5 Feb 2019 06:38:18 -0500
Received: from apollon.suse.de.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 05 Feb 2019 04:38:08 -0700
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 2/5] block: disk_events: introduce event flags
Date:   Tue,  5 Feb 2019 12:37:38 +0100
Message-Id: <20190205113741.11267-3-mwilck@suse.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113741.11267-1-mwilck@suse.com>
References: <20190205113741.11267-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, an empty disk->events field tells the block layer not to forward
media change events to user space. This was done in
commit 7c88a168da80 ("block: don't propagate unlisted DISK_EVENTs to userland")
in order to avoid events from "fringe" drivers to be forwarded to user
space. By doing so, the block layer lost the information which events were
supported by a particular block device, and most importantly, whether or
not a given device supports media change events at all.

Prepare for not interpreting the "events" field this way in the future any
more. This is done by adding two flag bits that can be set to have the
device treated like one that has the "events" field set to a non-zero value
before. This applies only to the sd and sr drivers, which are changed to
set the new flags.

The new flags are DISK_EVENT_FLAG_POLL to enforce polling of the device for
synchronous events, and DISK_EVENT_FLAG_UEVENT to tell the blocklayer to
generate udev events from kernel events. They can easily be fit in the int
reserved for event bits.

This patch doesn't change behavior.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c         | 15 ++++++++++-----
 drivers/scsi/sd.c     |  3 ++-
 drivers/scsi/sr.c     |  3 ++-
 include/linux/genhd.h |  7 +++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 714459f..7f5a370 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1630,7 +1630,7 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
 	 */
 	if (ev->poll_msecs >= 0)
 		intv_msecs = ev->poll_msecs;
-	else if (disk->events)
+	else if (disk->events & DISK_EVENT_FLAG_POLL)
 		intv_msecs = disk_events_dfl_poll_msecs;
 
 	return msecs_to_jiffies(intv_msecs);
@@ -1840,11 +1840,13 @@ static void disk_check_events(struct disk_events *ev,
 
 	/*
 	 * Tell userland about new events.  Only the events listed in
-	 * @disk->events are reported.  Unlisted events are processed the
-	 * same internally but never get reported to userland.
+	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
+	 * is set. Otherwise, events are processed internally but never
+	 * get reported to userland.
 	 */
 	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
-		if (events & disk->events & (1 << i))
+		if (events & disk->events & (1 << i) &&
+		    disk->events & DISK_EVENT_FLAG_UEVENT)
 			envp[nr_events++] = disk_uevents[i];
 
 	if (nr_events)
@@ -1882,7 +1884,10 @@ static ssize_t disk_events_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return __disk_events_show(disk->events, buf);
+	if (!(disk->events & DISK_EVENT_FLAG_UEVENT))
+		return 0;
+
+	return __disk_events_show(disk->events & DISK_EVENT_TYPES_MASK, buf);
 }
 
 static ssize_t disk_events_async_show(struct device *dev,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b2da8a0..83e736e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3262,7 +3262,8 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 	gd->flags = GENHD_FL_EXT_DEVT;
 	if (sdp->removable) {
 		gd->flags |= GENHD_FL_REMOVABLE;
-		gd->events |= DISK_EVENT_MEDIA_CHANGE;
+		gd->events |= DISK_EVENT_MEDIA_CHANGE |
+			DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
 	}
 
 	blk_pm_runtime_init(sdp->request_queue, dev);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 38ddbbf..3571651 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -716,7 +716,8 @@ static int sr_probe(struct device *dev)
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
-	disk->events = DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST;
+	disk->events = DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST
+		| DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
 
 	blk_queue_rq_timeout(sdev->request_queue, SR_TIMEOUT);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5f78edb..a3d5b1c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -148,8 +148,15 @@ struct hd_struct {
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
 	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
+	/* Poll even if events_poll_msecs is unset */
+	DISK_EVENT_FLAG_POLL			= 1 << 16,
+	/* Forward events to udev */
+	DISK_EVENT_FLAG_UEVENT			= 1 << 17,
 };
 
+#define DISK_EVENT_TYPES_MASK \
+	(DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST)
+
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-- 
2.20.1

