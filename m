Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37B0C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1902075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfC0NwA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:52:00 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:38596 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0Nv7 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 27 Mar 2019 09:51:59 -0400
Received: from apollon.suse.de.de (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 27 Mar 2019 07:51:46 -0600
From:   Martin Wilck <mwilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH v3 1/5] block: genhd: remove async_events field
Date:   Wed, 27 Mar 2019 14:51:01 +0100
Message-Id: <20190327135105.30893-2-mwilck@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327135105.30893-1-mwilck@suse.com>
References: <20190327135105.30893-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The async_events field, intended to be used for drivers that support
asynchronous notifications about disk events (aka media change events),
isn't currently used by any driver, and apparently that has been that
way for a long time (if not forever). Remove it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c           | 10 ++++------
 drivers/block/pktcdvd.c |  1 -
 include/linux/genhd.h   |  1 -
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7032678..ee76de0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1628,12 +1628,11 @@ static unsigned long disk_events_poll_jiffies(struct gendisk *disk)
 
 	/*
 	 * If device-specific poll interval is set, always use it.  If
-	 * the default is being used, poll iff there are events which
-	 * can't be monitored asynchronously.
+	 * the default is being used, poll if the POLL flag is set.
 	 */
 	if (ev->poll_msecs >= 0)
 		intv_msecs = ev->poll_msecs;
-	else if (disk->events & ~disk->async_events)
+	else if (disk->events)
 		intv_msecs = disk_events_dfl_poll_msecs;
 
 	return msecs_to_jiffies(intv_msecs);
@@ -1860,6 +1859,7 @@ static void disk_check_events(struct disk_events *ev,
  *
  * events		: list of all supported events
  * events_async		: list of events which can be detected w/o polling
+ *			  (always empty, only for backwards compatibility)
  * events_poll_msecs	: polling interval, 0: disable, -1: system default
  */
 static ssize_t __disk_events_show(unsigned int events, char *buf)
@@ -1890,9 +1890,7 @@ static ssize_t disk_events_show(struct device *dev,
 static ssize_t disk_events_async_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct gendisk *disk = dev_to_disk(dev);
-
-	return __disk_events_show(disk->async_events, buf);
+	return 0;
 }
 
 static ssize_t disk_events_poll_msecs_show(struct device *dev,
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f5a7102..0240601 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2761,7 +2761,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
-	disk->async_events = pd->bdev->bd_disk->async_events;
 
 	add_disk(disk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 06c0fd59..5f78edb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -185,7 +185,6 @@ struct gendisk {
 	char *(*devnode)(struct gendisk *gd, umode_t *mode);
 
 	unsigned int events;		/* supported events */
-	unsigned int async_events;	/* async events, subset of all */
 
 	/* Array of pointers to partitions indexed by partno.
 	 * Protected with matching bdev lock but stat and other
-- 
2.21.0

