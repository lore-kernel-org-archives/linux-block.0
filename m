Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:53992 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZHWJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Apr 2018 03:22:09 -0400
Received: by mail-it0-f67.google.com with SMTP id m134-v6so23210350itb.3
        for <linux-block@vger.kernel.org>; Thu, 26 Apr 2018 00:22:09 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 2/2] blk-mq: fix sysfs inflight counter
Date: Thu, 26 Apr 2018 00:21:59 -0700
Message-Id: <d1d971cfdf1f834ec604b1d40604a74d3080b5b8.1524727168.git.osandov@fb.com>
In-Reply-To: <cover.1524727168.git.osandov@fb.com>
References: <cover.1524727168.git.osandov@fb.com>
In-Reply-To: <cover.1524727168.git.osandov@fb.com>
References: <cover.1524727168.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When the blk-mq inflight implementation was added, /proc/diskstats was
converted to use it, but /sys/block/$dev/inflight was not. Fix it by
adding another helper to count in-flight requests by data direction.

Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c            | 19 +++++++++++++++++++
 block/blk-mq.h            |  4 +++-
 block/genhd.c             | 12 ++++++++++++
 block/partition-generic.c | 10 ++++++----
 include/linux/genhd.h     |  4 +++-
 5 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5450cbc61f8d..9ce9cac16c3f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -115,6 +115,25 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
+static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
+				     struct request *rq, void *priv,
+				     bool reserved)
+{
+	struct mq_inflight *mi = priv;
+
+	if (rq->part == mi->part)
+		mi->inflight[rq_data_dir(rq)]++;
+}
+
+void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+			 unsigned int inflight[2])
+{
+	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+
+	inflight[0] = inflight[1] = 0;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+}
+
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	int freeze_depth;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89b5cd3a6c70..e1bb420dc5d6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -188,7 +188,9 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-			unsigned int inflight[2]);
+		      unsigned int inflight[2]);
+void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+			 unsigned int inflight[2]);
 
 static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/genhd.c b/block/genhd.c
index dc7e089373b9..c4513fe1adda 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -82,6 +82,18 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 	}
 }
 
+void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+		       unsigned int inflight[2])
+{
+	if (q->mq_ops) {
+		blk_mq_in_flight_rw(q, part, inflight);
+		return;
+	}
+
+	inflight[0] = atomic_read(&part->in_flight[0]);
+	inflight[1] = atomic_read(&part->in_flight[1]);
+}
+
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
 {
 	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 08dabcd8b6ae..db57cced9b98 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -145,13 +145,15 @@ ssize_t part_stat_show(struct device *dev,
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
 }
 
-ssize_t part_inflight_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
+	struct request_queue *q = part_to_disk(p)->queue;
+	unsigned int inflight[2];
 
-	return sprintf(buf, "%8u %8u\n", atomic_read(&p->in_flight[0]),
-		atomic_read(&p->in_flight[1]));
+	part_in_flight_rw(q, p, inflight);
+	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c826b0b5232a..6cb8a5789668 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -368,7 +368,9 @@ static inline void free_part_stats(struct hd_struct *part)
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
-			unsigned int inflight[2]);
+		    unsigned int inflight[2]);
+void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
 			int rw);
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
-- 
2.17.0
