Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 10/18] blk-throttle: choose a small throtl_slice for SSD
Date: Mon, 27 Mar 2017 10:51:38 -0700
Message-ID: <0d0d41ceac055019992db08ac152f41c3726a585.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The throtl_slice is 100ms by default. This is a long time for SSD, a lot
of IO can run. To make cgroups have smoother throughput, we choose a
small value (20ms) for SSD.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-sysfs.c    |  2 ++
 block/blk-throttle.c | 23 ++++++++++++++++++++---
 block/blk.h          |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b315e62..7f090dd 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -906,6 +906,8 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_wb_init(q);
 
+	blk_throtl_register_queue(q);
+
 	if (q->request_fn || (q->mq_ops && q->elevator)) {
 		ret = elv_register_queue(q);
 		if (ret) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 93841da..d00c1c1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -18,8 +18,9 @@ static int throtl_grp_quantum = 8;
 /* Total max dispatch from all groups in one round */
 static int throtl_quantum = 32;
 
-/* Throttling is performed over 100ms slice and after that slice is renewed */
-#define DFL_THROTL_SLICE (HZ / 10)
+/* Throttling is performed over a slice and after that slice is renewed */
+#define DFL_THROTL_SLICE_HD (HZ / 10)
+#define DFL_THROTL_SLICE_SSD (HZ / 50)
 #define MAX_THROTL_SLICE (HZ)
 
 static struct blkcg_policy blkcg_policy_throtl;
@@ -1961,7 +1962,6 @@ int blk_throtl_init(struct request_queue *q)
 
 	q->td = td;
 	td->queue = q;
-	td->throtl_slice = DFL_THROTL_SLICE;
 
 	td->limit_valid[LIMIT_MAX] = true;
 	td->limit_index = LIMIT_MAX;
@@ -1982,6 +1982,23 @@ void blk_throtl_exit(struct request_queue *q)
 	kfree(q->td);
 }
 
+void blk_throtl_register_queue(struct request_queue *q)
+{
+	struct throtl_data *td;
+
+	td = q->td;
+	BUG_ON(!td);
+
+	if (blk_queue_nonrot(q))
+		td->throtl_slice = DFL_THROTL_SLICE_SSD;
+	else
+		td->throtl_slice = DFL_THROTL_SLICE_HD;
+#ifndef CONFIG_BLK_DEV_THROTTLING_LOW
+	/* if no low limit, use previous default */
+	td->throtl_slice = DFL_THROTL_SLICE_HD;
+#endif
+}
+
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
 {
diff --git a/block/blk.h b/block/blk.h
index bcd3de6..13070c3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -319,10 +319,12 @@ static inline struct io_context *create_io_context(gfp_t gfp_mask, int node)
 extern void blk_throtl_drain(struct request_queue *q);
 extern int blk_throtl_init(struct request_queue *q);
 extern void blk_throtl_exit(struct request_queue *q);
+extern void blk_throtl_register_queue(struct request_queue *q);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline void blk_throtl_register_queue(struct request_queue *q) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
-- 
2.9.3
