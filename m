Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F0AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC212146F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfC0NwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:10 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:59107 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0NwK (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 27 Mar 2019 09:52:10 -0400
Received: from apollon.suse.de.de (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 27 Mar 2019 07:51:57 -0600
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v3 5/5] block: check_events: don't bother with events if unsupported
Date:   Wed, 27 Mar 2019 14:51:05 +0100
Message-Id: <20190327135105.30893-6-mwilck@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327135105.30893-1-mwilck@suse.com>
References: <20190327135105.30893-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers now report to the block layer if they support media change
events. If this is not the case, there's no need to allocate the event
structure, and all event handling code can effectively be skipped. This
simplifies code flow in particular for non-removable sd devices.

This effectively reverts commit 75e3f3ee3c64 ("block: always allocate
genhd->ev if check_events is implemented").

The sysfs files for the events are kept in place even if no events are
supported, as user space may rely on them being present. The only
difference is that an error code is now returned if the user tries to
set poll_msecs.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5375be3..1d0d25f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1904,6 +1904,9 @@ static ssize_t disk_events_poll_msecs_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (!disk->ev)
+		return sprintf(buf, "-1\n");
+
 	return sprintf(buf, "%ld\n", disk->ev->poll_msecs);
 }
 
@@ -1920,6 +1923,9 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
 	if (intv < 0 && intv != -1)
 		return -EINVAL;
 
+	if (!disk->ev)
+		return -ENODEV;
+
 	disk_block_events(disk);
 	disk->ev->poll_msecs = intv;
 	__disk_unblock_events(disk, true);
@@ -1984,7 +1990,7 @@ static void disk_alloc_events(struct gendisk *disk)
 {
 	struct disk_events *ev;
 
-	if (!disk->fops->check_events)
+	if (!disk->fops->check_events || !disk->events)
 		return;
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
@@ -2006,14 +2012,14 @@ static void disk_alloc_events(struct gendisk *disk)
 
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
@@ -2027,14 +2033,13 @@ static void disk_add_events(struct gendisk *disk)
 
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
2.21.0

