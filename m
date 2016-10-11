Return-Path: <Adam.Manzanares@hgst.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>, Adam
 Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH v3 1/2] block: Add iocontext priority to request
Date: Tue, 11 Oct 2016 13:40:26 -0700
Message-ID: <1476218427-4021-2-git-send-email-adam.manzanares@hgst.com>
In-Reply-To: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
References: <1476218427-4021-1-git-send-email-adam.manzanares@hgst.com>
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
 Documentation/block/queue-sysfs.txt | 12 ++++++++++++
 block/blk-core.c                    |  5 +++++
 block/blk-sysfs.c                   | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h              |  3 +++
 4 files changed, 52 insertions(+)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2a39040..3ca4e8f 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -144,6 +144,18 @@ For storage configurations that need to maximize distribution of completion
 processing setting this option to '2' forces the completion to run on the
 requesting cpu (bypassing the "group" aggregation logic).
 
+rq_ioc_prio (RW)
+----------------
+If this option is '1', and there is a valid iocontext associated with the
+issuing context, and the bio we are processing does not have a valid
+prio, then we save the prio value from the iocontext with the request.
+
+This feature can be combined with device drivers that are aware of prio
+values in order to handle prio accordingly. An example would be if the ata
+layer recognizes prio and creates ata commands with high priority and sends
+them to the device. If the hardware supports priorities for commands then
+this has the potential to speed up response times for high priority IO.
+
 scheduler (RW)
 --------------
 When read, this file will display the current and available IO schedulers
diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c07..2e740c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -33,6 +33,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1648,6 +1649,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 
 void init_request_from_bio(struct request *req, struct bio *bio)
 {
+	struct io_context *ioc = rq_ioc(bio);
 	req->cmd_type = REQ_TYPE_FS;
 
 	req->cmd_flags |= bio->bi_opf & REQ_COMMON_MASK;
@@ -1657,6 +1659,9 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
+	if (blk_queue_rq_ioc_prio(req->q) && !ioprio_valid(req->ioprio) && ioc)
+		req->ioprio = ioc->ioprio;
+
 	blk_rq_bio_prep(req->q, req, bio);
 }
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9cc8d7c..a9c5105 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -384,6 +384,31 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_rq_ioc_prio_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(blk_queue_rq_ioc_prio(q), page);
+}
+
+static ssize_t queue_rq_ioc_prio_store(struct request_queue *q,
+				       const char *page, size_t count)
+{
+	unsigned long rq_ioc_prio_on;
+	ssize_t ret;
+
+	ret = queue_var_store(&rq_ioc_prio_on, page, count);
+	if (ret < 0)
+		return ret;
+
+	spin_lock_irq(q->queue_lock);
+	if (rq_ioc_prio_on)
+		queue_flag_set(QUEUE_FLAG_RQ_IOC_PRIO, q);
+	else
+		queue_flag_clear(QUEUE_FLAG_RQ_IOC_PRIO, q);
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
 
+static struct queue_sysfs_entry queue_rq_ioc_prio_entry = {
+	.attr = {.name = "rq_ioc_prio", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_rq_ioc_prio_show,
+	.store = queue_rq_ioc_prio_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -553,6 +584,7 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
+	&queue_rq_ioc_prio_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358..63b842a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -505,6 +505,7 @@ struct request_queue {
 #define QUEUE_FLAG_FUA	       24	/* device supports FUA writes */
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
+#define QUEUE_FLAG_RQ_IOC_PRIO 27	/* Use iocontext ioprio */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -595,6 +596,8 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
+#define blk_queue_rq_ioc_prio(q) \
+	test_bit(QUEUE_FLAG_RQ_IOC_PRIO, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.1.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
