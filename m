Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F4C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiFXFZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXFZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44F4EF4D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lGyEkVh2hHEInvAt4Bv2zsU7SC86bTVfhXEB/jvgEjg=; b=zVEMKFBZwm1+RdDRHMwL04krwa
        XRAreQ5HRYGb7AmRiUrucLz97e+SS3ypfYG5nBYh1nFAOYypk8q4p7ssjgP+h0cImuI4yo+hOY8dy
        vqJBpokzbIlikHT8Im2FmWxEpkQ9L19ja27urHrPocL1JuUX3xYAxYhHbUhZAveHwTbePPmnR8SuD
        +1MQa8Zrkv+ukglmybP1WaKLxlkQBovw22SgokZM2rhA5CoksPSW/Z+r5SNLa1RJZaptDGz1jYm86
        s5KefvWDUs2WZeJpVub/k3whifxdFfXjT86u/3JIFzRnNaoOwgVpQVIvjuuwNPBfOnNzC7R7jocEC
        ro2xIH0g==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4boh-000c9I-8S; Fri, 24 Jun 2022 05:25:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: simplify blktrace sysfs attribute creation
Date:   Fri, 24 Jun 2022 07:25:05 +0200
Message-Id: <20220624052510.3996673-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624052510.3996673-1-hch@lst.de>
References: <20220624052510.3996673-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the trace attributes to the default gendisk attributes, just like
we already do for partitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c            | 11 +----------
 block/blk.h                  |  2 ++
 block/genhd.c                |  3 +++
 block/partitions/core.c      |  1 -
 include/linux/blktrace_api.h | 10 ----------
 kernel/trace/blktrace.c      | 11 -----------
 6 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 84d7f87015673..e4df5ccebf0d0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -803,21 +803,14 @@ int blk_register_queue(struct gendisk *disk)
 	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
 
-	ret = blk_trace_init_sysfs(dev);
-	if (ret)
-		return ret;
-
 	mutex_lock(&q->sysfs_dir_lock);
 
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
-	if (ret < 0) {
-		blk_trace_remove_sysfs(dev);
+	if (ret < 0)
 		goto unlock;
-	}
 
 	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
 	if (ret) {
-		blk_trace_remove_sysfs(dev);
 		kobject_del(&q->kobj);
 		kobject_put(&dev->kobj);
 		goto unlock;
@@ -883,7 +876,6 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
 	kobject_del(&q->kobj);
-	blk_trace_remove_sysfs(dev);
 	kobject_put(&dev->kobj);
 
 	return ret;
@@ -924,7 +916,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 	blk_crypto_sysfs_unregister(q);
-	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
 	elv_unregister_queue(q);
diff --git a/block/blk.h b/block/blk.h
index 0d6668663ab5d..4b2e0bc5b4a80 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -439,6 +439,8 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
+extern struct attribute_group blk_trace_attr_group;
+
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/block/genhd.c b/block/genhd.c
index bf9be06af2c8d..12b0eda8d125b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1134,6 +1134,9 @@ static struct attribute_group disk_attr_group = {
 
 static const struct attribute_group *disk_attr_groups[] = {
 	&disk_attr_group,
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+        &blk_trace_attr_group,
+#endif
 	NULL
 };
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8a0ec929023bc..7dc487f5b03cd 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -9,7 +9,6 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
-#include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 623e22492afa5..f6f9b544365ab 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -77,10 +77,6 @@ extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			   char __user *arg);
 extern int blk_trace_startstop(struct request_queue *q, int start);
 extern int blk_trace_remove(struct request_queue *q);
-extern void blk_trace_remove_sysfs(struct device *dev);
-extern int blk_trace_init_sysfs(struct device *dev);
-
-extern struct attribute_group blk_trace_attr_group;
 
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
 # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
@@ -91,13 +87,7 @@ extern struct attribute_group blk_trace_attr_group;
 # define blk_trace_remove(q)				(-ENOTTY)
 # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
 # define blk_add_cgroup_trace_msg(q, cg, fmt, ...)	do { } while (0)
-# define blk_trace_remove_sysfs(dev)			do { } while (0)
 # define blk_trace_note_message_enabled(q)		(false)
-static inline int blk_trace_init_sysfs(struct device *dev)
-{
-	return 0;
-}
-
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 
 #ifdef CONFIG_COMPAT
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fe04c6f96ca5d..c584effe5fe99 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1867,17 +1867,6 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 out:
 	return ret ? ret : count;
 }
-
-int blk_trace_init_sysfs(struct device *dev)
-{
-	return sysfs_create_group(&dev->kobj, &blk_trace_attr_group);
-}
-
-void blk_trace_remove_sysfs(struct device *dev)
-{
-	sysfs_remove_group(&dev->kobj, &blk_trace_attr_group);
-}
-
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 
 #ifdef CONFIG_EVENT_TRACING
-- 
2.30.2

