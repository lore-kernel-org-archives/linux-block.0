Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 5 Apr 2018 18:10:15 +0800
From: Weiping Zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <cohuck@redhat.com>, <mst@redhat.com>,
	<jasowang@redhat.com>
CC: <linux-block@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [RFC PATCH 1/2] blk-setting: add new helper
 blk_queue_max_hw_sectors_no_limit
Message-ID: <d3e3f9e5554498d6f529bea1c3f2de5b91789d30.1522922101.git.zhangweiping@didichuxing.com>
References: <cover.1522922101.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1522922101.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

There is a default upper limitation BLK_DEF_MAX_SECTORS, but for
some virtual block device driver there is no such limitation. So
add a new help to set max request size.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 block/blk-settings.c   | 20 ++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 48ebe6b..685c30c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -253,6 +253,26 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
+/* same as blk_queue_max_hw_sectors but without default upper limitation */
+void blk_queue_max_hw_sectors_no_limit(struct request_queue *q,
+		unsigned int max_hw_sectors)
+{
+	struct queue_limits *limits = &q->limits;
+	unsigned int max_sectors;
+
+	if ((max_hw_sectors << 9) < PAGE_SIZE) {
+		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
+		printk(KERN_INFO "%s: set to minimum %d\n",
+		       __func__, max_hw_sectors);
+	}
+
+	limits->max_hw_sectors = max_hw_sectors;
+	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
+	limits->max_sectors = max_sectors;
+	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+}
+EXPORT_SYMBOL(blk_queue_max_hw_sectors_no_limit);
+
 /**
  * blk_queue_chunk_sectors - set size of the chunk for this queue
  * @q:  the request queue for the device
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed63f3b..2250709 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1243,6 +1243,8 @@ extern void blk_cleanup_queue(struct request_queue *);
 extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
+extern void blk_queue_max_hw_sectors_no_limit(struct request_queue *,
+						unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
-- 
2.9.4
