Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D26C10F00
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9CC2075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfC0NwD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:03 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:45637 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0NwA (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 27 Mar 2019 09:52:00 -0400
Received: from apollon.suse.de.de (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 27 Mar 2019 07:51:49 -0600
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH v3 2/5] block: disk_events: introduce event flags
Date:   Wed, 27 Mar 2019 14:51:02 +0100
Message-Id: <20190327135105.30893-3-mwilck@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327135105.30893-1-mwilck@suse.com>
References: <20190327135105.30893-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, an empty disk->events field tells the block layer not to
forward media change events to user space. This was done in commit
7c88a168da80 ("block: don't propagate unlisted DISK_EVENTs to userland")
in order to avoid events from "fringe" drivers to be forwarded to user
space. By doing so, the block layer lost the information which events
were supported by a particular block device, and most importantly,
whether or not a given device supports media change events at all.

Prepare for not interpreting the "events" field this way in the future
any more. This is done by adding an additional field "event_flags" to
struct gendisk, and two flag bits that can be set to have the device
treated like one that had the "events" field set to a non-zero value
before. This applies only to the sd and sr drivers, which are changed to
set the new flags.

The new flags are DISK_EVENT_FLAG_POLL to enforce polling of the device
for synchronous events, and DISK_EVENT_FLAG_UEVENT to tell the
blocklayer to generate udev events from kernel events.

In order to add the event_flags field to struct gendisk, the events
field is converted to an "unsigned short"; it doesn't need to hold
values bigger than 2 anyway.

This patch doesn't change behavior.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c         | 13 +++++++++----
 drivers/scsi/sd.c     |  1 +
 drivers/scsi/sr.c     |  1 +
 include/linux/genhd.h | 10 +++++++++-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ee76de0..5375be3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1632,7 +1632,7 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
 	 */
 	if (ev->poll_msecs >= 0)
 		intv_msecs = ev->poll_msecs;
-	else if (disk->events)
+	else if (disk->event_flags & DISK_EVENT_FLAG_POLL)
 		intv_msecs = disk_events_dfl_poll_msecs;
 
 	return msecs_to_jiffies(intv_msecs);
@@ -1842,11 +1842,13 @@ static void disk_check_events(struct disk_events *ev,
 
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
+		if ((events & disk->events & (1 << i)) &&
+		    (disk->event_flags & DISK_EVENT_FLAG_UEVENT))
 			envp[nr_events++] = disk_uevents[i];
 
 	if (nr_events)
@@ -1884,6 +1886,9 @@ static ssize_t disk_events_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (!(disk->event_flags & DISK_EVENT_FLAG_UEVENT))
+		return 0;
+
 	return __disk_events_show(disk->events, buf);
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 251db30..4742a22 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3327,6 +3327,7 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 	if (sdp->removable) {
 		gd->flags |= GENHD_FL_REMOVABLE;
 		gd->events |= DISK_EVENT_MEDIA_CHANGE;
+		gd->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
 	}
 
 	blk_pm_runtime_init(sdp->request_queue, dev);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 039c27c2..c3f443d 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -716,6 +716,7 @@ static int sr_probe(struct device *dev)
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
 	disk->events = DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST;
+	disk->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
 
 	blk_queue_rq_timeout(sdev->request_queue, SR_TIMEOUT);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5f78edb..081cb77 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -150,6 +150,13 @@ enum {
 	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
 };
 
+enum {
+	/* Poll even if events_poll_msecs is unset */
+	DISK_EVENT_FLAG_POLL			= 1 << 0,
+	/* Forward events to udev */
+	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
+};
+
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
@@ -184,7 +191,8 @@ struct gendisk {
 	char disk_name[DISK_NAME_LEN];	/* name of major driver */
 	char *(*devnode)(struct gendisk *gd, umode_t *mode);
 
-	unsigned int events;		/* supported events */
+	unsigned short events;		/* supported events */
+	unsigned short event_flags;	/* flags related to event processing */
 
 	/* Array of pointers to partitions indexed by partno.
 	 * Protected with matching bdev lock but stat and other
-- 
2.21.0

