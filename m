Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33213 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCQXxB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 19:53:01 -0400
Received: by mail-pf0-f177.google.com with SMTP id e129so4888809pfh.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 16:53:00 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [RFC PATCH 4/4] blk-mq: introduce Kyber multiqueue I/O scheduler
Date: Fri, 17 Mar 2017 15:03:33 -0700
Message-Id: <d076751c9aefa1c1179b4f36ef69e96ec8803035.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
In-Reply-To: <cover.1489787289.git.osandov@fb.com>
References: <cover.1489787289.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The Kyber I/O scheduler is an I/O scheduler for fast devices designed to
scale to multiple queues. Users configure a single knob, the target read
latency, and the scheduler tunes itself to achieve that latency goal.

The implementation is based on "tokens", built on top of the scalable
bitmap library. Tokens serve as a mechanism for limiting requests. There
are two tiers of tokens: queueing tokens and dispatch tokens.

A queueing token is required to allocate a request. In fact, these
tokens are actually the blk-mq internal scheduler tags, but the
scheduler manages the allocation directly in order to implement its
policy.

Dispatch tokens are device-wide and split up into two scheduling
domains: reads vs. writes. Each hardware queue dispatches batches
round-robin between the scheduling domains as long as tokens are
available for that domain.

These tokens can be used as the mechanism to enable various policies.
The policy Kyber uses is inspired by active queue management techniques
for network routing, similar to blk-wbt. The scheduler monitors read
latencies and scales the number of available write dispatch tokens
accordingly. Queueing tokens are used to prevent starvation of
synchronous requests by asynchronous requests.

Various extensions are possible, including better heuristics and ionice
support.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/Kconfig.iosched |   8 +
 block/Makefile        |   1 +
 block/elevator.c      |   9 +-
 block/kyber-iosched.c | 586 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 600 insertions(+), 4 deletions(-)
 create mode 100644 block/kyber-iosched.c

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 58fc8684788d..ba6c9be67fa4 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -69,6 +69,14 @@ config MQ_IOSCHED_DEADLINE
 	---help---
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_KYBER
+	tristate "Kyber I/O scheduler"
+	default y
+	---help---
+	  The Kyber I/O scheduler is a low-overhead scheduler suitable for
+	  multiqueue and other fast devices. Given a target latency, it will
+	  self-tune queue depths to achieve that goal.
+
 endmenu
 
 endif
diff --git a/block/Makefile b/block/Makefile
index 081bb680789b..6146d2eaaeaa 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
+obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
diff --git a/block/elevator.c b/block/elevator.c
index 01139f549b5b..44a6e42ffc1a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -221,14 +221,15 @@ int elevator_init(struct request_queue *q, char *name)
 
 	if (!e) {
 		/*
-		 * For blk-mq devices, we default to using mq-deadline,
-		 * if available, for single queue devices. If deadline
-		 * isn't available OR we have multiple queues, default
-		 * to "none".
+		 * For blk-mq, we default to using mq-deadline for single-queue
+		 * devices and kyber for multi-queue devices. We fall back to
+		 * "none" if the preferred scheduler isn't available.
 		 */
 		if (q->mq_ops) {
 			if (q->nr_hw_queues == 1)
 				e = elevator_get("mq-deadline", false);
+			else
+				e = elevator_get("kyber", false);
 			if (!e)
 				return 0;
 		} else
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
new file mode 100644
index 000000000000..e29cea785408
--- /dev/null
+++ b/block/kyber-iosched.c
@@ -0,0 +1,586 @@
+/*
+ * The Kyber I/O scheduler. Controls latency by throttling queue depths using
+ * scalable techniques.
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
+#include <linux/sbitmap.h>
+
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-tag.h"
+#include "blk-stat.h"
+
+/* Scheduling domains. */
+enum {
+	KYBER_READ,
+	KYBER_WRITE,
+	KYBER_NUM_DOMAINS,
+};
+
+enum {
+	KYBER_MIN_DEPTH = 256,
+
+	/*
+	 * Initial device-wide depths for each scheduling domain.
+	 *
+	 * Even for fast devices with lots of tags like NVMe, you can saturate
+	 * the device with only a fraction of the maximum possible queue depth.
+	 * So, we cap these to a reasonable value.
+	 */
+	KYBER_READ_DEPTH = 256,
+	KYBER_WRITE_DEPTH = KYBER_READ_DEPTH / 4,
+
+	/*
+	 * Scheduling domain batch sizes. We favor reads over writes.
+	 */
+	KYBER_READ_BATCH = 16,
+	KYBER_WRITE_BATCH = 8,
+
+	/*
+	 * In order to prevent starvation of synchronous requests by a flood of
+	 * asynchronous requests, we reserve 25% of requests for synchronous
+	 * operations.
+	 */
+	KYBER_ASYNC_PERCENT = 75,
+};
+
+struct kyber_queue_data {
+	struct request_queue *q;
+
+	struct blk_stat_callback *cb;
+
+	/*
+	 * The device is divided into multiple scheduling domains based on the
+	 * request type. Each domain has a fixed number of in-flight requests of
+	 * that type device-wide, limited by these tokens.
+	 */
+	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
+
+	/*
+	 * The maximum depth that the domain tokens can be resized to.
+	 */
+	unsigned int max_domain_tokens[KYBER_NUM_DOMAINS];
+
+	/* Batch size for each scheduling domain. */
+	unsigned int domain_batch[KYBER_NUM_DOMAINS];
+
+	/*
+	 * Async request percentage, converted to per-word depth for
+	 * sbitmap_get_shallow().
+	 */
+	unsigned int async_depth;
+
+	/* Target read latency in nanoseconds. */
+	u64 read_lat_nsec;
+};
+
+struct kyber_hctx_data {
+	spinlock_t lock;
+	struct list_head rqs[KYBER_NUM_DOMAINS];
+	int cur_domain;
+	unsigned int batching;
+};
+
+/*
+ * Heuristics for limiting queue depths based on latency. Similar to AQM
+ * techniques for network routing.
+ */
+static void kyber_stats_fn(struct blk_stat_callback *cb,
+			   struct blk_stats *stats)
+{
+	struct kyber_queue_data *kqd = cb->data;
+	unsigned int orig_write_depth, write_depth;
+	u64 latency, target;
+
+	orig_write_depth = write_depth =
+		READ_ONCE(kqd->domain_tokens[KYBER_WRITE].sb.depth);
+
+	if (!stats->read.nr_samples) {
+		write_depth += 1;
+		goto resize;
+	}
+
+	latency = stats->read.mean;
+	target = kqd->read_lat_nsec;
+
+	if (latency >= 4 * target)
+		write_depth /= 2;
+	else if (latency >= 2 * target)
+		write_depth -= max(write_depth / 4, 1U);
+	else if (latency > target)
+		write_depth -= max(write_depth / 8, 1U);
+	else if (latency <= target / 2)
+		write_depth += 2;
+	else if (latency <= 3 * target / 4)
+		write_depth += 1;
+
+resize:
+	write_depth = clamp_t(unsigned int, write_depth, 1, KYBER_WRITE_DEPTH);
+	if (write_depth != orig_write_depth)
+		sbitmap_queue_resize(&kqd->domain_tokens[KYBER_WRITE], write_depth);
+
+	/* Continue monitoring latencies as long as we are throttling. */
+	if (write_depth < KYBER_WRITE_DEPTH && !timer_pending(&kqd->cb->timer))
+		blk_stat_arm_callback(kqd->cb, jiffies + msecs_to_jiffies(100));
+}
+
+/*
+ * Check if this request met our latency goal. If not, quickly gather some
+ * statistics and start throttling.
+ */
+static void kyber_check_latency(struct kyber_queue_data *kqd,
+				struct request *rq)
+{
+	u64 now, latency;
+	unsigned long expires;
+
+	if (req_op(rq) != REQ_OP_READ)
+		return;
+
+	/* If we are already managing the write depth, don't check again. */
+	if (kqd->domain_tokens[KYBER_WRITE].sb.depth < KYBER_WRITE_DEPTH)
+		return;
+
+	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	if (now < blk_stat_time(&rq->issue_stat))
+		return;
+
+	latency = now - blk_stat_time(&rq->issue_stat);
+
+	if (latency <= kqd->read_lat_nsec)
+		return;
+
+	if (!timer_pending(&kqd->cb->timer)) {
+		expires = jiffies + msecs_to_jiffies(10);
+		blk_stat_arm_callback(kqd->cb, expires);
+	}
+}
+
+static unsigned int kyber_sched_tags_shift(struct kyber_queue_data *kqd)
+{
+	/*
+	 * All of the hardware queues have the same depth, so we can just grab
+	 * the shift of the first one.
+	 */
+	return kqd->q->queue_hw_ctx[0]->sched_tags->bitmap_tags.sb.shift;
+}
+
+static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
+{
+	struct kyber_queue_data *kqd;
+	unsigned int max_tokens;
+	unsigned int shift;
+	int ret = -ENOMEM;
+	int i;
+
+	kqd = kmalloc_node(sizeof(*kqd), GFP_KERNEL, q->node);
+	if (!kqd)
+		goto err;
+	kqd->q = q;
+
+	kqd->cb = blk_stat_alloc_callback(kyber_stats_fn, kqd);
+	if (!kqd->cb)
+		goto err_kqd;
+
+	/*
+	 * The maximum number of tokens for any scheduling domain is at least
+	 * the queue depth of a single hardware queue. If the hardware doesn't
+	 * have many tags, still provide a reasonable number.
+	 */
+	max_tokens = max_t(unsigned int, q->tag_set->queue_depth,
+			   KYBER_MIN_DEPTH);
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
+		kqd->max_domain_tokens[i] = max_tokens;
+		ret = sbitmap_queue_init_node(&kqd->domain_tokens[i],
+					      max_tokens, -1, false, GFP_KERNEL,
+					      q->node);
+		if (ret) {
+			while (--i >= 0)
+				sbitmap_queue_free(&kqd->domain_tokens[i]);
+			goto err_cb;
+		}
+	}
+
+	sbitmap_queue_resize(&kqd->domain_tokens[KYBER_READ], KYBER_READ_DEPTH);
+	sbitmap_queue_resize(&kqd->domain_tokens[KYBER_WRITE], KYBER_WRITE_DEPTH);
+
+	kqd->domain_batch[KYBER_READ] = KYBER_READ_BATCH;
+	kqd->domain_batch[KYBER_WRITE] = KYBER_WRITE_BATCH;
+
+	shift = kyber_sched_tags_shift(kqd);
+	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
+
+	kqd->read_lat_nsec = 2000000ULL;
+
+	return kqd;
+
+err_cb:
+	blk_stat_free_callback(kqd->cb);
+err_kqd:
+	kfree(kqd);
+err:
+	return ERR_PTR(ret);
+}
+
+static void kyber_queue_data_free(struct kyber_queue_data *kqd)
+{
+	int i;
+
+	if (!kqd)
+		return;
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
+		sbitmap_queue_free(&kqd->domain_tokens[i]);
+	blk_stat_free_callback(kqd->cb);
+	kfree(kqd);
+}
+
+static int kyber_hctx_data_init(struct blk_mq_hw_ctx *hctx)
+{
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	int i;
+
+	spin_lock_init(&khd->lock);
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
+		INIT_LIST_HEAD(&khd->rqs[i]);
+
+	khd->cur_domain = 0;
+	khd->batching = 0;
+
+	return 0;
+}
+
+static int kyber_init_sched(struct request_queue *q, struct elevator_type *e)
+{
+	struct kyber_queue_data *kqd;
+	struct elevator_queue *eq;
+	int ret;
+
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
+	kqd = kyber_queue_data_alloc(q);
+	if (IS_ERR(kqd)) {
+		ret = PTR_ERR(kqd);
+		goto err_kobj;
+	}
+
+	ret = blk_mq_sched_init_hctx_data(q, sizeof(struct kyber_hctx_data),
+					  kyber_hctx_data_init, NULL);
+	if (ret)
+		goto err_kqd;
+
+	eq->elevator_data = kqd;
+	q->elevator = eq;
+
+	blk_stat_add_callback(q, kqd->cb);
+
+	return 0;
+
+err_kqd:
+	kyber_queue_data_free(kqd);
+err_kobj:
+	kobject_put(&eq->kobj);
+	return ret;
+}
+
+static void kyber_exit_sched(struct elevator_queue *e)
+{
+	struct kyber_queue_data *kqd = e->elevator_data;
+	struct request_queue *q = kqd->q;
+
+	blk_stat_remove_callback(q, kqd->cb);
+	blk_mq_sched_free_hctx_data(q, NULL);
+	kyber_queue_data_free(e->elevator_data);
+}
+
+static int op_to_sched_domain(int op)
+{
+	if (op_is_write(op))
+		return KYBER_WRITE;
+	else
+		return KYBER_READ;
+}
+
+static int kyber_get_domain_token(struct kyber_queue_data *kqd,
+				  int sched_domain)
+{
+	struct sbitmap_queue *domain_tokens;
+
+	domain_tokens = &kqd->domain_tokens[sched_domain];
+	return __sbitmap_queue_get(domain_tokens);
+}
+
+static int rq_get_domain_token(struct request *rq)
+{
+	return (long)rq->elv.priv[0];
+}
+
+static void rq_set_domain_token(struct request *rq, int token)
+{
+	rq->elv.priv[0] = (void *)(long)token;
+}
+
+static void rq_clear_domain_token(struct kyber_queue_data *kqd,
+				  struct request *rq)
+{
+	int sched_domain, nr;
+
+	nr = rq_get_domain_token(rq);
+	if (nr != -1) {
+		sched_domain = op_to_sched_domain(req_op(rq));
+		sbitmap_queue_clear(&kqd->domain_tokens[sched_domain], nr,
+				    rq->mq_ctx->cpu);
+	}
+}
+
+static struct request *kyber_get_request(struct request_queue *q,
+					 unsigned int op,
+					 struct blk_mq_alloc_data *data)
+{
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
+	struct request *rq;
+
+	/*
+	 * We use the scheduler tags as per-hardware queue queueing tokens.
+	 * Async requests can be limited at this stage.
+	 */
+	if (!op_is_sync(op))
+		data->shallow_depth = READ_ONCE(kqd->async_depth);
+
+	rq = __blk_mq_alloc_request(data, op);
+	if (rq)
+		rq_set_domain_token(rq, -1);
+	return rq;
+}
+
+static void kyber_put_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
+
+	kyber_check_latency(kqd, rq);
+	rq_clear_domain_token(kqd, rq);
+	blk_mq_finish_request(rq);
+}
+
+static void kyber_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx,
+				  struct kyber_hctx_data *khd)
+{
+	LIST_HEAD(rq_list);
+	struct request *rq, *next;
+
+	blk_mq_flush_busy_ctxs(hctx, &rq_list);
+	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
+		int sched_domain;
+
+		sched_domain = op_to_sched_domain(req_op(rq));
+		list_move_tail(&rq->queuelist, &khd->rqs[sched_domain]);
+	}
+}
+
+static struct request *
+kyber_dispatch_cur_domain(struct blk_mq_hw_ctx *hctx,
+			  struct kyber_queue_data *kqd,
+			  struct kyber_hctx_data *khd,
+			  bool *flushed, bool *no_tokens)
+{
+	struct list_head *rqs;
+	struct request *rq;
+	int nr;
+
+	rqs = &khd->rqs[khd->cur_domain];
+	rq = list_first_entry_or_null(rqs, struct request, queuelist);
+
+	/*
+	 * If there wasn't already a pending request and we haven't flushed the
+	 * software queues yet, flush the software queues and check again.
+	 */
+	if (!rq && !*flushed) {
+		kyber_flush_busy_ctxs(hctx, khd);
+		*flushed = true;
+		rq = list_first_entry_or_null(rqs, struct request, queuelist);
+	}
+
+	if (rq) {
+		nr = kyber_get_domain_token(kqd, khd->cur_domain);
+		if (nr == -1) {
+			*no_tokens = true;
+		} else {
+			khd->batching++;
+			rq_set_domain_token(rq, nr);
+			list_del_init(&rq->queuelist);
+			return rq;
+		}
+	}
+
+	/* There were either no pending requests or no tokens. */
+	return NULL;
+}
+
+/*
+ * Returns a request on success, NULL if there were no requests to dispatch, and
+ * ERR_PTR(-EBUSY) if there were requests to dispatch but no domain tokens for
+ * them.
+ */
+static struct request *__kyber_dispatch_request(struct kyber_queue_data *kqd,
+						struct kyber_hctx_data *khd,
+						struct blk_mq_hw_ctx *hctx)
+{
+	bool flushed = false, no_tokens = false;
+	struct request *rq;
+	int i;
+
+	/*
+	 * First, if we are still entitled to batch, try to dispatch a request
+	 * from the batch.
+	 */
+	if (khd->batching < READ_ONCE(kqd->domain_batch[khd->cur_domain])) {
+		rq = kyber_dispatch_cur_domain(hctx, kqd, khd, &flushed,
+					       &no_tokens);
+		if (rq)
+			return rq;
+	}
+
+	/*
+	 * Either,
+	 * 1. We were no longer entitled to a batch.
+	 * 2. The domain we were batching didn't have any requests.
+	 * 3. The domain we were batching was out of tokens.
+	 *
+	 * Start another batch. Note that this wraps back around to the original
+	 * domain if no other domains have requests or tokens.
+	 */
+	khd->batching = 0;
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
+		if (++khd->cur_domain >= KYBER_NUM_DOMAINS)
+			khd->cur_domain = 0;
+
+		rq = kyber_dispatch_cur_domain(hctx, kqd, khd, &flushed,
+					       &no_tokens);
+		if (rq)
+			return rq;
+	}
+
+	return no_tokens ? ERR_PTR(-EBUSY) : NULL;
+}
+
+static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	struct request *rq;
+
+	spin_lock(&khd->lock);
+
+	rq = __kyber_dispatch_request(kqd, khd, hctx);
+	if (IS_ERR(rq)) {
+		/*
+		 * We failed to get a domain token. Mark the queue as needing a
+		 * restart and try again in case a token was freed before we set
+		 * the restart bit.
+		 */
+		blk_mq_sched_mark_restart_queue(hctx);
+		rq = __kyber_dispatch_request(kqd, khd, hctx);
+		if (IS_ERR(rq))
+			rq = NULL;
+	}
+
+	spin_unlock(&khd->lock);
+
+	return rq;
+}
+
+static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct kyber_hctx_data *khd = hctx->sched_data;
+	int i;
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
+		if (!list_empty_careful(&khd->rqs[i]))
+			return true;
+	}
+	return false;
+}
+
+static ssize_t kyber_read_lat_show(struct elevator_queue *e, char *page)
+{
+	struct kyber_queue_data *kqd = e->elevator_data;
+
+	return sprintf(page, "%llu\n", kqd->read_lat_nsec);
+}
+
+static ssize_t kyber_read_lat_store(struct elevator_queue *e, const char *page,
+				    size_t count)
+{
+	struct kyber_queue_data *kqd = e->elevator_data;
+	unsigned long long nsec;
+	int ret;
+
+	ret = kstrtoull(page, 10, &nsec);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(kqd->read_lat_nsec, nsec);
+
+	return count;
+}
+
+static struct elv_fs_entry kyber_sched_attrs[] = {
+	__ATTR(read_lat_nsec, 0644, kyber_read_lat_show, kyber_read_lat_store),
+	__ATTR_NULL
+};
+
+static struct elevator_type kyber_sched = {
+	.ops.mq = {
+		.init_sched = kyber_init_sched,
+		.exit_sched = kyber_exit_sched,
+		.get_request = kyber_get_request,
+		.put_request = kyber_put_request,
+		.dispatch_request = kyber_dispatch_request,
+		.has_work = kyber_has_work,
+	},
+	.uses_mq = true,
+	.elevator_attrs = kyber_sched_attrs,
+	.elevator_name = "kyber",
+	.elevator_owner = THIS_MODULE,
+};
+
+static int __init kyber_init(void)
+{
+	return elv_register(&kyber_sched);
+}
+
+static void __exit kyber_exit(void)
+{
+	elv_unregister(&kyber_sched);
+}
+
+module_init(kyber_init);
+module_exit(kyber_exit);
+
+MODULE_AUTHOR("Omar Sandoval");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kyber I/O scheduler");
-- 
2.12.0
