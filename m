Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:23938 "EHLO
        BJEXCAS003.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752440AbdHJCeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Aug 2017 22:34:31 -0400
Date: Thu, 10 Aug 2017 10:34:19 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-sysfs: add io queue depth show
Message-ID: <20170810023413.GA33798@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

show max io queue depth, it may doesn't reflect the real hardware's
max queue depth which was reduced by some software designs.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-sysfs.c      | 11 +++++++++++
 include/linux/blkdev.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 27aceab..66cba2b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -256,6 +256,11 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 	return queue_var_show(max_hw_sectors_kb, (page));
 }
 
+static ssize_t queue_io_queue_depth_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(queue_io_queue_depth(q), (page));
+}
+
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
 queue_show_##name(struct request_queue *q, char *page)			\
@@ -678,6 +683,11 @@ static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.store = queue_wb_lat_store,
 };
 
+static struct queue_sysfs_entry queue_io_queue_depth_entry = {
+	.attr = {.name = "io_queue_depth", .mode = S_IRUGO },
+	.show = queue_io_queue_depth_show,
+};
+
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static struct queue_sysfs_entry throtl_sample_time_entry = {
 	.attr = {.name = "throttle_sample_time", .mode = S_IRUGO | S_IWUSR },
@@ -719,6 +729,7 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
+	&queue_io_queue_depth_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25f6a0c..bcd0af4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1405,6 +1405,11 @@ static inline unsigned int queue_max_hw_sectors(struct request_queue *q)
 	return q->limits.max_hw_sectors;
 }
 
+static inline unsigned int queue_io_queue_depth(struct request_queue *q)
+{
+	return q->queue_depth;
+}
+
 static inline unsigned short queue_max_segments(struct request_queue *q)
 {
 	return q->limits.max_segments;
-- 
2.9.4
