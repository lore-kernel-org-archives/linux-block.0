Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEAFC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7118D613B9
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhFXHsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhFXHsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7DCC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kIhjoiVNzumaABIY3GcAiEUpbdV72ilDW/nXKvhJa8s=; b=UC+J5Od9872o82sYH8PvSD/d/F
        Ppix21W3T4M07Y3sD/hWEZKr5uyUo00oFw5hb05MSYca8WrU2+o+8V2lPZwv0FAvScryL2mN1RC/L
        tVY7K4oBeJQ/4rtVAHrmlhwoRHoPdqeAFWjaY2+a4Jl1nGpyp2uSZTrD2Zm+WVgCF1v7i26wTb443
        +1lKz6CTa97+PmO+T8IOvrvW5/WcQoD+U5FMwQGlaqe8n2vJJwiSc3xQhBu/sJMYCVqD0SV+fXS3N
        6nKBIL9Ws7Ws524LKQqpfyimZNjB9aiwUe1diYU1z4Lym06KKCX8Y9Kyq9dUkrqr7U3eijFYpNXVx
        bbBu4niQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwK3q-00GJzt-KT; Thu, 24 Jun 2021 07:46:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: add the events* attributes to disk_attrs
Date:   Thu, 24 Jun 2021 09:38:43 +0200
Message-Id: <20210624073843.251178-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210624073843.251178-1-hch@lst.de>
References: <20210624073843.251178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the events attributes to the disk_attrs array, which ensures they are
added by the driver core when the device is created rather than adding
them after the device has been added, which is racy versus uevents and
requires more boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h         |  3 +++
 block/disk-events.c | 23 ++++-------------------
 block/genhd.c       |  3 +++
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index f8d726429906..4fcd7a032377 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -364,5 +364,8 @@ void disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
 void disk_del_events(struct gendisk *disk);
 void disk_release_events(struct gendisk *disk);
+extern struct device_attribute dev_attr_events;
+extern struct device_attribute dev_attr_events_async;
+extern struct device_attribute dev_attr_events_poll_msecs;
 
 #endif /* BLK_INTERNAL_H */
diff --git a/block/disk-events.c b/block/disk-events.c
index 1bc5dcb75e4e..a75931ff5da4 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -368,18 +368,10 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
 	return count;
 }
 
-static const DEVICE_ATTR(events, 0444, disk_events_show, NULL);
-static const DEVICE_ATTR(events_async, 0444, disk_events_async_show, NULL);
-static const DEVICE_ATTR(events_poll_msecs, 0644,
-			 disk_events_poll_msecs_show,
-			 disk_events_poll_msecs_store);
-
-static const struct attribute *disk_events_attrs[] = {
-	&dev_attr_events.attr,
-	&dev_attr_events_async.attr,
-	&dev_attr_events_poll_msecs.attr,
-	NULL,
-};
+DEVICE_ATTR(events, 0444, disk_events_show, NULL);
+DEVICE_ATTR(events_async, 0444, disk_events_async_show, NULL);
+DEVICE_ATTR(events_poll_msecs, 0644, disk_events_poll_msecs_show,
+	    disk_events_poll_msecs_store);
 
 /*
  * The default polling interval can be specified by the kernel
@@ -444,11 +436,6 @@ void disk_alloc_events(struct gendisk *disk)
 
 void disk_add_events(struct gendisk *disk)
 {
-	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
-		pr_warn("%s: failed to create sysfs files for events\n",
-			disk->disk_name);
-
 	if (!disk->ev)
 		return;
 
@@ -472,8 +459,6 @@ void disk_del_events(struct gendisk *disk)
 		list_del_init(&disk->ev->node);
 		mutex_unlock(&disk_events_mutex);
 	}
-
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
 }
 
 void disk_release_events(struct gendisk *disk)
diff --git a/block/genhd.c b/block/genhd.c
index 4f879deede9a..79aa40b4c39c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1022,6 +1022,9 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_stat.attr,
 	&dev_attr_inflight.attr,
 	&dev_attr_badblocks.attr,
+	&dev_attr_events.attr,
+	&dev_attr_events_async.attr,
+	&dev_attr_events_poll_msecs.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
-- 
2.30.2

