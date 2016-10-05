Return-Path: <Adam.Manzanares@hgst.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>, Adam
 Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH v2 2/2] block: Add iocontext priority to request
Date: Wed, 5 Oct 2016 12:00:07 -0700
Message-ID: <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
In-Reply-To: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: adam.manzanares@hgst.com
List-ID: <linux-block@vger.kernel.org>

Patch adds an association between iocontext ioprio and the ioprio of
a request. This feature is only enabled if a queue flag is set to
indicate that requests should have ioprio associated with them. The
queue flag is exposed as the req_prio queue sysfs entry.

Signed-off-by: Adam Mananzanares <adam.manzanares@hgst.com>
---
 block/blk-core.c       |  8 +++++++-
 block/blk-sysfs.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 36c7ac3..17c3ce5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -33,6 +33,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1648,6 +1649,7 @@ out:
 
 void init_request_from_bio(struct request *req, struct bio *bio)
 {
+	struct io_context *ioc = rq_ioc(bio);
 	req->cmd_type = REQ_TYPE_FS;
 
 	req->cmd_flags |= bio->bi_opf & REQ_COMMON_MASK;
@@ -1656,7 +1658,11 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
-	req->ioprio = bio_prio(bio);
+	if (blk_queue_req_prio(req->q))
+		req->ioprio = ioprio_best(bio_prio(bio), ioc->ioprio);
+	else
+		req->ioprio = bio_prio(bio);
+
 	blk_rq_bio_prep(req->q, req, bio);
 }
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f87a7e7..268a71a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -384,6 +384,31 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_req_prio_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(blk_queue_req_prio(q), page);
+}
+
+static ssize_t queue_req_prio_store(struct request_queue *q, const char *page,
+				    size_t count)
+{
+	unsigned long req_prio_on;
+	ssize_t ret;
+
+	ret = queue_var_store(&req_prio_on, page, count);
+	if (ret < 0)
+		return ret;
+
+	spin_lock_irq(q->queue_lock);
+	if (req_prio_on)
+		queue_flag_set(QUEUE_FLAG_REQ_PRIO, q);
+	else
+		queue_flag_clear(QUEUE_FLAG_REQ_PRIO, q);
+	spin_unlock_irq(q->queue_lock);
+
+	return ret;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -526,6 +551,12 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
+static struct queue_sysfs_entry queue_req_prio_entry = {
+	.attr = {.name = "req_prio", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_req_prio_show,
+	.store = queue_req_prio_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -553,6 +584,7 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
+	&queue_req_prio_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e79055c..23e1e2d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -505,6 +505,7 @@ struct request_queue {
 #define QUEUE_FLAG_FUA	       24	/* device supports FUA writes */
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
+#define QUEUE_FLAG_REQ_PRIO    27	/* Use iocontext ioprio */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -595,6 +596,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
+#define blk_queue_req_prio(q)	test_bit(QUEUE_FLAG_REQ_PRIO, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.1.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
