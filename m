Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33770 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdC1XNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 19:13:20 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so1240248pgb.0
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 16:13:19 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 1/3] block: warn if sharing request queue across gendisks
Date: Tue, 28 Mar 2017 16:12:15 -0700
Message-Id: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the remaining drivers have been converted to one request queue
per gendisk, let's warn if a request queue gets registered more than
once. This will catch future drivers which might do it inadvertently or
any old drivers that I may have missed.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-sysfs.c      | 7 +++++++
 include/linux/blkdev.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7f090dd15ca6..833fb7f9ce9d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -871,6 +871,11 @@ int blk_register_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return -ENXIO;
 
+	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
+		  "%s is registering an already registered queue\n",
+		  kobject_name(&dev->kobj));
+	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
+
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
 	 * request_queues for non-existent devices.  Shutting down a fully
@@ -931,6 +936,8 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return;
 
+	queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
+
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1a7dc42a8918..a2dc6b390d48 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -617,6 +617,7 @@ struct request_queue {
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
 #define QUEUE_FLAG_RESTART     28	/* queue needs restart at completion */
 #define QUEUE_FLAG_POLL_STATS  29	/* collecting stats for hybrid polling */
+#define QUEUE_FLAG_REGISTERED  30	/* queue has been registered to a disk */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
-- 
2.12.1
