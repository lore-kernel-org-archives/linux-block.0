Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35426 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdDAT4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2017 15:56:37 -0400
Received: by mail-pg0-f41.google.com with SMTP id 81so92586496pgh.2
        for <linux-block@vger.kernel.org>; Sat, 01 Apr 2017 12:56:37 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq: add random early detection I/O scheduler
Date: Sat,  1 Apr 2017 12:55:35 -0700
Message-Id: <e9c15e2066177c3efdfe6d134cf9c80b5e8f8d1b.1491076459.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This patch introduces a new I/O scheduler based on the classic random
early detection active queue management algorithm [1]. Random early
detection is one of the simplest and most studied AQM algorithms for
networking, but until now, it hasn't been applied to disk I/O
scheduling.

When applied to network routers, RED probabilistically either marks
packets with ECN or drops them, depending on the configuration. When
dealing with disk I/O, POSIX does not have any mechanism with which to
notify the caller that the disk is congested, so we instead only provide
the latter strategy. Included in this patch is a minor change to the
blk-mq to support this.

Performance results are extremely promising. This scheduling technique
does not require any cross-hardware queue data sharing, as limits are
applied on a per-hardware queue basis, making RED highly scalable.
Additionally, with RED, I/O latencies on a heavily loaded device can be
better than even a completely idle device, as is demonstrated by this
fio job:

----
[global]
filename=/dev/sda
direct=1
runtime=10s
time_based
group_reporting

[idle_reader]
rate_iops=1000
ioengine=sync
rw=randread

[contended_reader]
stonewall
numjobs=4
ioengine=libaio
iodepth=1024
rw=randread
----

1: http://www.icir.org/floyd/papers/red/red.html

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/Kconfig.iosched |   6 ++
 block/Makefile        |   1 +
 block/blk-mq.c        |   2 +
 block/red-iosched.c   | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 block/red-iosched.c

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 58fc8684788d..e8bdd144ec9f 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -69,6 +69,12 @@ config MQ_IOSCHED_DEADLINE
 	---help---
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_RED
+	tristate "Random early detection I/O scheduler"
+	default y
+	---help---
+	  Block I/O adaptation of the RED active queue management algorithm.
+
 endmenu
 
 endif
diff --git a/block/Makefile b/block/Makefile
index 081bb680789b..607ee6e27901 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
+obj-$(CONFIG_MQ_IOSCHED_RED)	+= red-iosched.o
 
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061fc2cc88d3..d7792ca0432c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1542,6 +1542,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
+		bio_advance(bio, bio->bi_iter.bi_size);
+		bio_endio(bio);
 		return BLK_QC_T_NONE;
 	}
 
diff --git a/block/red-iosched.c b/block/red-iosched.c
new file mode 100644
index 000000000000..862158a02e95
--- /dev/null
+++ b/block/red-iosched.c
@@ -0,0 +1,191 @@
+/*
+ * Random early detection I/O scheduler.
+ *
+ * Copyright (C) 2017 Facebook
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/elevator.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/sbitmap.h>
+
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-tag.h"
+
+enum {
+	RED_DEFAULT_MIN_THRESH = 16,
+	RED_DEFAULT_MAX_THRESH = 256,
+	RED_MAX_MAX_THRESH = 256,
+};
+
+struct red_queue_data {
+	struct request_queue *q;
+	unsigned int min_thresh, max_thresh;
+};
+
+static int red_init_sched(struct request_queue *q, struct elevator_type *e)
+{
+	struct red_queue_data *rqd;
+	struct elevator_queue *eq;
+
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
+	rqd = kmalloc_node(sizeof(*rqd), GFP_KERNEL, q->node);
+	if (!rqd) {
+		kobject_put(&eq->kobj);
+		return -ENOMEM;
+	}
+	rqd->min_thresh = RED_DEFAULT_MIN_THRESH;
+	rqd->max_thresh = RED_DEFAULT_MAX_THRESH;
+
+	eq->elevator_data = rqd;
+	q->elevator = eq;
+
+	return 0;
+}
+
+static void red_exit_sched(struct elevator_queue *e)
+{
+	struct red_queue_data *rqd = e->elevator_data;
+
+	kfree(rqd);
+}
+
+static struct request *red_get_request(struct request_queue *q,
+				       unsigned int op,
+				       struct blk_mq_alloc_data *data)
+{
+	struct red_queue_data *rqd = q->elevator->elevator_data;
+	unsigned int queue_length;
+	u32 drop_prob;
+
+	queue_length = sbitmap_weight(&data->hctx->sched_tags->bitmap_tags.sb);
+	if (queue_length <= rqd->min_thresh)
+		goto enqueue;
+	else if (queue_length >= rqd->max_thresh)
+		goto drop;
+
+	drop_prob = (U32_MAX / (rqd->max_thresh - rqd->min_thresh) *
+		     (queue_length - rqd->min_thresh));
+
+	if (prandom_u32() <= drop_prob)
+		goto drop;
+
+enqueue:
+	return __blk_mq_alloc_request(data, op);
+
+drop:
+	/*
+	 * Non-blocking callers will return EWOULDBLOCK; blocking callers should
+	 * check the return code and retry.
+	 */
+	return NULL;
+}
+
+static ssize_t red_min_thresh_show(struct elevator_queue *e, char *page)
+{
+	struct red_queue_data *rqd = e->elevator_data;
+
+	return sprintf(page, "%u\n", rqd->min_thresh);
+}
+
+static ssize_t red_min_thresh_store(struct elevator_queue *e, const char *page,
+				    size_t count)
+{
+	struct red_queue_data *rqd = e->elevator_data;
+	unsigned int thresh;
+	int ret;
+
+	ret = kstrtouint(page, 10, &thresh);
+	if (ret)
+		return ret;
+
+	if (thresh >= rqd->max_thresh)
+		return -EINVAL;
+
+	rqd->min_thresh = thresh;
+
+	return count;
+}
+
+static ssize_t red_max_thresh_show(struct elevator_queue *e, char *page)
+{
+	struct red_queue_data *rqd = e->elevator_data;
+
+	return sprintf(page, "%u\n", rqd->max_thresh);
+}
+
+static ssize_t red_max_thresh_store(struct elevator_queue *e, const char *page,
+				    size_t count)
+{
+	struct red_queue_data *rqd = e->elevator_data;
+	unsigned int thresh;
+	int ret;
+
+	ret = kstrtouint(page, 10, &thresh);
+	if (ret)
+		return ret;
+
+	if (thresh <= rqd->min_thresh || thresh > RED_MAX_MAX_THRESH)
+		return -EINVAL;
+
+	rqd->max_thresh = thresh;
+
+	return count;
+}
+
+#define RED_THRESH_ATTR(which) __ATTR(which##_thresh, 0644, red_##which##_thresh_show, red_##which##_thresh_store)
+static struct elv_fs_entry red_sched_attrs[] = {
+	RED_THRESH_ATTR(min),
+	RED_THRESH_ATTR(max),
+	__ATTR_NULL
+};
+#undef RED_THRESH_ATTR
+
+static struct elevator_type red_sched = {
+	.ops.mq = {
+		.init_sched = red_init_sched,
+		.exit_sched = red_exit_sched,
+		.get_request = red_get_request,
+	},
+	.uses_mq = true,
+	.elevator_attrs = red_sched_attrs,
+	.elevator_name = "red",
+	.elevator_owner = THIS_MODULE,
+};
+
+static int __init red_init(void)
+{
+	return elv_register(&red_sched);
+}
+
+static void __exit red_exit(void)
+{
+	elv_unregister(&red_sched);
+}
+
+module_init(red_init);
+module_exit(red_exit);
+
+MODULE_AUTHOR("Omar Sandoval");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Random early detection I/O scheduler");
-- 
2.12.1
