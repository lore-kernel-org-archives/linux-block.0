Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35451 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdDDQvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 12:51:12 -0400
Received: by mail-pg0-f45.google.com with SMTP id 81so157981939pgh.2
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2017 09:51:11 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 5/5] blk-mq: introduce Kyber multiqueue I/O scheduler
Date: Tue,  4 Apr 2017 09:49:58 -0700
Message-Id: <9ee02812ecbe89ffc5221145ed0368ab589f938e.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The Kyber I/O scheduler is an I/O scheduler for fast devices designed to
scale to multiple queues. Users configure only two knobs, the target
read and synchronous write latencies, and the scheduler tunes itself to
achieve that latency goal.

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
for network routing, similar to blk-wbt. The scheduler monitors
latencies and scales the number of dispatch tokens accordingly. Queueing
tokens are used to prevent starvation of synchronous requests by
asynchronous requests.

Various extensions are possible, including better heuristics and ionice
support. The new scheduler isn't set as the default yet.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/block/kyber-iosched.txt |  14 +
 block/Kconfig.iosched                 |   9 +
 block/Makefile                        |   1 +
 block/kyber-iosched.c                 | 706 ++++++++++++++++++++++++++++++++++
 4 files changed, 730 insertions(+)
 create mode 100644 Documentation/block/kyber-iosched.txt
 create mode 100644 block/kyber-iosched.c

diff --git a/Documentation/block/kyber-iosched.txt b/Documentation/block/kyber-iosched.txt
new file mode 100644
index 000000000000..e94feacd7edc
--- /dev/null
+++ b/Documentation/block/kyber-iosched.txt
@@ -0,0 +1,14 @@
+Kyber I/O scheduler tunables
+===========================
+
+The only two tunables for the Kyber scheduler are the target latencies for
+reads and synchronous writes. Kyber will throttle requests in order to meet
+these target latencies.
+
+read_lat_nsec
+-------------
+Target latency for reads (in nanoseconds).
+
+write_lat_nsec
+--------------
+Target latency for synchronous writes (in nanoseconds).
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 58fc8684788d..916e69c68fa4 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -69,6 +69,15 @@ config MQ_IOSCHED_DEADLINE
 	---help---
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_KYBER
+	tristate "Kyber I/O scheduler"
+	default y
+	---help---
+	  The Kyber I/O scheduler is a low-overhead scheduler suitable for
+	  multiqueue and other fast devices. Given target latencies for reads and
+	  synchronous writes, it will self-tune queue depths to achieve that
+	  goal.
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
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
new file mode 100644
index 000000000000..30253d0758aa
--- /dev/null
+++ b/block/kyber-iosched.c
@@ -0,0 +1,706 @@
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
+	KYBER_SYNC_WRITE,
+	KYBER_OTHER, /* Async writes, discard, etc. */
+	KYBER_NUM_DOMAINS,
+};
+
+enum {
+	KYBER_MIN_DEPTH = 256,
+
+	/*
+	 * In order to prevent starvation of synchronous requests by a flood of
+	 * asynchronous requests, we reserve 25% of requests for synchronous
+	 * operations.
+	 */
+	KYBER_ASYNC_PERCENT = 75,
+};
+
+/*
+ * Initial device-wide depths for each scheduling domain.
+ *
+ * Even for fast devices with lots of tags like NVMe, you can saturate
+ * the device with only a fraction of the maximum possible queue depth.
+ * So, we cap these to a reasonable value.
+ */
+static const unsigned int kyber_depth[] = {
+	[KYBER_READ] = 256,
+	[KYBER_SYNC_WRITE] = 128,
+	[KYBER_OTHER] = 64,
+};
+
+/*
+ * Scheduling domain batch sizes. We favor reads.
+ */
+static const unsigned int kyber_batch_size[] = {
+	[KYBER_READ] = 16,
+	[KYBER_SYNC_WRITE] = 8,
+	[KYBER_OTHER] = 8,
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
+	 * Async request percentage, converted to per-word depth for
+	 * sbitmap_get_shallow().
+	 */
+	unsigned int async_depth;
+
+	/* Target latencies in nanoseconds. */
+	u64 read_lat_nsec, write_lat_nsec;
+};
+
+struct kyber_hctx_data {
+	spinlock_t lock;
+	struct list_head rqs[KYBER_NUM_DOMAINS];
+	int cur_domain;
+	unsigned int batching;
+};
+
+static unsigned int rq_sched_domain(const struct request *rq)
+{
+	unsigned int op = rq->cmd_flags;
+
+	if ((op & REQ_OP_MASK) == REQ_OP_READ)
+		return KYBER_READ;
+	else if ((op & REQ_OP_MASK) == REQ_OP_WRITE && op_is_sync(op))
+		return KYBER_SYNC_WRITE;
+	else
+		return KYBER_OTHER;
+}
+
+enum {
+	NONE = 0,
+	GOOD = 1,
+	GREAT = 2,
+	BAD = -1,
+	AWFUL = -2,
+};
+
+#define IS_GOOD(status) ((status) > 0)
+#define IS_BAD(status) ((status) < 0)
+
+static int kyber_lat_status(struct blk_stat_callback *cb,
+			    unsigned int sched_domain, u64 target)
+{
+	u64 latency;
+
+	if (!cb->stat[sched_domain].nr_samples)
+		return NONE;
+
+	latency = cb->stat[sched_domain].mean;
+	if (latency >= 2 * target)
+		return AWFUL;
+	else if (latency > target)
+		return BAD;
+	else if (latency <= target / 2)
+		return GREAT;
+	else /* (latency <= target) */
+		return GOOD;
+}
+
+/*
+ * Adjust the read or synchronous write depth given the status of reads and
+ * writes. The goal is that the latencies of the two domains are fair (i.e., if
+ * one is good, then the other is good).
+ */
+static void kyber_adjust_rw_depth(struct kyber_queue_data *kqd,
+				  unsigned int sched_domain, int this_status,
+				  int other_status)
+{
+	unsigned int orig_depth, depth;
+
+	/*
+	 * If this domain had no samples, or reads and writes are both good or
+	 * both bad, don't adjust the depth.
+	 */
+	if (this_status == NONE ||
+	    (IS_GOOD(this_status) && IS_GOOD(other_status)) ||
+	    (IS_BAD(this_status) && IS_BAD(other_status)))
+		return;
+
+	orig_depth = depth = kqd->domain_tokens[sched_domain].sb.depth;
+
+	if (other_status == NONE) {
+		depth++;
+	} else {
+		switch (this_status) {
+		case GOOD:
+			if (other_status == AWFUL)
+				depth -= max(depth / 4, 1U);
+			else
+				depth -= max(depth / 8, 1U);
+			break;
+		case GREAT:
+			if (other_status == AWFUL)
+				depth /= 2;
+			else
+				depth -= max(depth / 4, 1U);
+			break;
+		case BAD:
+			depth++;
+			break;
+		case AWFUL:
+			if (other_status == GREAT)
+				depth += 2;
+			else
+				depth++;
+			break;
+		}
+	}
+
+	depth = clamp(depth, 1U, kyber_depth[sched_domain]);
+	if (depth != orig_depth)
+		sbitmap_queue_resize(&kqd->domain_tokens[sched_domain], depth);
+}
+
+/*
+ * Adjust the depth of other requests given the status of reads and synchronous
+ * writes. As long as either domain is doing fine, we don't throttle, but if
+ * both domains are doing badly, we throttle heavily.
+ */
+static void kyber_adjust_other_depth(struct kyber_queue_data *kqd,
+				     int read_status, int write_status,
+				     bool have_samples)
+{
+	unsigned int orig_depth, depth;
+	int status;
+
+	orig_depth = depth = kqd->domain_tokens[KYBER_OTHER].sb.depth;
+
+	if (read_status == NONE && write_status == NONE) {
+		depth += 2;
+	} else if (have_samples) {
+		if (read_status == NONE)
+			status = write_status;
+		else if (write_status == NONE)
+			status = read_status;
+		else
+			status = max(read_status, write_status);
+		switch (status) {
+		case GREAT:
+			depth += 2;
+			break;
+		case GOOD:
+			depth++;
+			break;
+		case BAD:
+			depth -= max(depth / 4, 1U);
+			break;
+		case AWFUL:
+			depth /= 2;
+			break;
+		}
+	}
+
+	depth = clamp(depth, 1U, kyber_depth[KYBER_OTHER]);
+	if (depth != orig_depth)
+		sbitmap_queue_resize(&kqd->domain_tokens[KYBER_OTHER], depth);
+}
+
+/*
+ * Apply heuristics for limiting queue depths based on gathered latency
+ * statistics.
+ */
+static void kyber_stat_timer_fn(struct blk_stat_callback *cb)
+{
+	struct kyber_queue_data *kqd = cb->data;
+	int read_status, write_status;
+
+	read_status = kyber_lat_status(cb, KYBER_READ, kqd->read_lat_nsec);
+	write_status = kyber_lat_status(cb, KYBER_SYNC_WRITE, kqd->write_lat_nsec);
+
+	kyber_adjust_rw_depth(kqd, KYBER_READ, read_status, write_status);
+	kyber_adjust_rw_depth(kqd, KYBER_SYNC_WRITE, write_status, read_status);
+	kyber_adjust_other_depth(kqd, read_status, write_status,
+				 cb->stat[KYBER_OTHER].nr_samples != 0);
+
+	/*
+	 * Continue monitoring latencies if we aren't hitting the targets or
+	 * we're still throttling other requests.
+	 */
+	if (!blk_stat_is_active(kqd->cb) &&
+	    ((IS_BAD(read_status) || IS_BAD(write_status) ||
+	      kqd->domain_tokens[KYBER_OTHER].sb.depth < kyber_depth[KYBER_OTHER])))
+		blk_stat_activate_msecs(kqd->cb, 100);
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
+	kqd->cb = blk_stat_alloc_callback(kyber_stat_timer_fn, rq_sched_domain,
+					  KYBER_NUM_DOMAINS, kqd);
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
+		WARN_ON(!kyber_depth[i]);
+		WARN_ON(!kyber_batch_size[i]);
+		ret = sbitmap_queue_init_node(&kqd->domain_tokens[i],
+					      max_tokens, -1, false, GFP_KERNEL,
+					      q->node);
+		if (ret) {
+			while (--i >= 0)
+				sbitmap_queue_free(&kqd->domain_tokens[i]);
+			goto err_cb;
+		}
+		sbitmap_queue_resize(&kqd->domain_tokens[i], kyber_depth[i]);
+	}
+
+	shift = kyber_sched_tags_shift(kqd);
+	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
+
+	kqd->read_lat_nsec = 2000000ULL;
+	kqd->write_lat_nsec = 10000000ULL;
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
+static int kyber_init_sched(struct request_queue *q, struct elevator_type *e)
+{
+	struct kyber_queue_data *kqd;
+	struct elevator_queue *eq;
+
+	eq = elevator_alloc(q, e);
+	if (!eq)
+		return -ENOMEM;
+
+	kqd = kyber_queue_data_alloc(q);
+	if (IS_ERR(kqd)) {
+		kobject_put(&eq->kobj);
+		return PTR_ERR(kqd);
+	}
+
+	eq->elevator_data = kqd;
+	q->elevator = eq;
+
+	blk_stat_add_callback(q, kqd->cb);
+
+	return 0;
+}
+
+static void kyber_exit_sched(struct elevator_queue *e)
+{
+	struct kyber_queue_data *kqd = e->elevator_data;
+	struct request_queue *q = kqd->q;
+	int i;
+
+	blk_stat_remove_callback(q, kqd->cb);
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
+		sbitmap_queue_free(&kqd->domain_tokens[i]);
+	blk_stat_free_callback(kqd->cb);
+	kfree(kqd);
+}
+
+static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct kyber_hctx_data *khd;
+	int i;
+
+	khd = kmalloc_node(sizeof(*khd), GFP_KERNEL, hctx->numa_node);
+	if (!khd)
+		return -ENOMEM;
+
+	spin_lock_init(&khd->lock);
+
+	for (i = 0; i < KYBER_NUM_DOMAINS; i++)
+		INIT_LIST_HEAD(&khd->rqs[i]);
+
+	khd->cur_domain = 0;
+	khd->batching = 0;
+
+	hctx->sched_data = khd;
+
+	return 0;
+}
+
+static void kyber_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	kfree(hctx->sched_data);
+}
+
+static int kyber_get_domain_token(struct kyber_queue_data *kqd,
+				  unsigned int sched_domain)
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
+	unsigned int sched_domain;
+	int nr;
+
+	nr = rq_get_domain_token(rq);
+	if (nr != -1) {
+		sched_domain = rq_sched_domain(rq);
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
+		data->shallow_depth = kqd->async_depth;
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
+	rq_clear_domain_token(kqd, rq);
+	blk_mq_finish_request(rq);
+}
+
+static void kyber_completed_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
+	unsigned int sched_domain;
+	u64 now, latency, target;
+
+	/*
+	 * Check if this request met our latency goal. If not, quickly gather
+	 * some statistics and start throttling.
+	 */
+	sched_domain = rq_sched_domain(rq);
+	switch (sched_domain) {
+	case KYBER_READ:
+		target = kqd->read_lat_nsec;
+		break;
+	case KYBER_SYNC_WRITE:
+		target = kqd->write_lat_nsec;
+		break;
+	default:
+		return;
+	}
+
+	/* If we are already monitoring latencies, don't check again. */
+	if (blk_stat_is_active(kqd->cb))
+		return;
+
+	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	if (now < blk_stat_time(&rq->issue_stat))
+		return;
+
+	latency = now - blk_stat_time(&rq->issue_stat);
+
+	if (latency > target)
+		blk_stat_activate_msecs(kqd->cb, 10);
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
+		unsigned int sched_domain;
+
+		sched_domain = rq_sched_domain(rq);
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
+	if (khd->batching < kyber_batch_size[khd->cur_domain]) {
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
+#define KYBER_LAT_SHOW_STORE(op)					\
+static ssize_t kyber_##op##_lat_show(struct elevator_queue *e,		\
+				     char *page)			\
+{									\
+	struct kyber_queue_data *kqd = e->elevator_data;		\
+									\
+	return sprintf(page, "%llu\n", kqd->op##_lat_nsec);		\
+}									\
+									\
+static ssize_t kyber_##op##_lat_store(struct elevator_queue *e,		\
+				      const char *page, size_t count)	\
+{									\
+	struct kyber_queue_data *kqd = e->elevator_data;		\
+	unsigned long long nsec;					\
+	int ret;							\
+									\
+	ret = kstrtoull(page, 10, &nsec);				\
+	if (ret)							\
+		return ret;						\
+									\
+	kqd->op##_lat_nsec = nsec;					\
+									\
+	return count;							\
+}
+KYBER_LAT_SHOW_STORE(read);
+KYBER_LAT_SHOW_STORE(write);
+#undef KYBER_LAT_SHOW_STORE
+
+#define KYBER_LAT_ATTR(op) __ATTR(op##_lat_nsec, 0644, kyber_##op##_lat_show, kyber_##op##_lat_store)
+static struct elv_fs_entry kyber_sched_attrs[] = {
+	KYBER_LAT_ATTR(read),
+	KYBER_LAT_ATTR(write),
+	__ATTR_NULL
+};
+#undef KYBER_LAT_ATTR
+
+static struct elevator_type kyber_sched = {
+	.ops.mq = {
+		.init_sched = kyber_init_sched,
+		.exit_sched = kyber_exit_sched,
+		.init_hctx = kyber_init_hctx,
+		.exit_hctx = kyber_exit_hctx,
+		.get_request = kyber_get_request,
+		.put_request = kyber_put_request,
+		.completed_request = kyber_completed_request,
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
2.12.2
