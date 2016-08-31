Return-Path: <prvs=80513f069d=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>
Subject: [PATCH 7/8] wbt: add general throttling mechanism
Date: Wed, 31 Aug 2016 11:05:50 -0600
Message-ID: <1472663151-18560-8-git-send-email-axboe@fb.com>
In-Reply-To: <1472663151-18560-1-git-send-email-axboe@fb.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We can hook this up to the block layer, to help throttle buffered
writes. Or NFS can tap into it, to accomplish the same.

wbt registers a few trace points that can be used to track what is
happening in the system:

wbt_lat: 259:0: latency 2446318
wbt_stat: 259:0: rmean=2446318, rmin=2446318, rmax=2446318, rsamples=1,
               wmean=518866, wmin=15522, wmax=5330353, wsamples=57
wbt_step: 259:0: step down: step=1, window=72727272, background=8, normal=16, max=32

This shows a sync issue event (wbt_lat) that exceeded it's time. wbt_stat
dumps the current read/write stats for that window, and wbt_step shows a
step down event where we now scale back writes. Each trace includes the
device, 259:0 in this case.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/wbt.h        | 118 +++++++++
 include/trace/events/wbt.h | 122 ++++++++++
 lib/Kconfig                |   4 +
 lib/Makefile               |   1 +
 lib/wbt.c                  | 587 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 832 insertions(+)
 create mode 100644 include/linux/wbt.h
 create mode 100644 include/trace/events/wbt.h
 create mode 100644 lib/wbt.c

diff --git a/include/linux/wbt.h b/include/linux/wbt.h
new file mode 100644
index 000000000000..14473d550a18
--- /dev/null
+++ b/include/linux/wbt.h
@@ -0,0 +1,118 @@
+#ifndef WB_THROTTLE_H
+#define WB_THROTTLE_H
+
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ktime.h>
+
+enum {
+	ISSUE_STAT_TRACKED	= 1ULL << 63,
+	ISSUE_STAT_READ		= 1ULL << 62,
+	ISSUE_STAT_MASK 	= ISSUE_STAT_TRACKED | ISSUE_STAT_READ,
+	ISSUE_STAT_TIME_MASK	= ~ISSUE_STAT_MASK,
+
+	WBT_TRACKED		= 1,
+	WBT_READ		= 2,
+};
+
+struct wb_issue_stat {
+	u64 time;
+};
+
+static inline void wbt_issue_stat_set_time(struct wb_issue_stat *stat)
+{
+	stat->time = (stat->time & ISSUE_STAT_MASK) |
+			(ktime_to_ns(ktime_get()) & ISSUE_STAT_TIME_MASK);
+}
+
+static inline u64 wbt_issue_stat_get_time(struct wb_issue_stat *stat)
+{
+	return stat->time & ISSUE_STAT_TIME_MASK;
+}
+
+static inline void wbt_mark_tracked(struct wb_issue_stat *stat)
+{
+	stat->time |= ISSUE_STAT_TRACKED;
+}
+
+static inline void wbt_clear_state(struct wb_issue_stat *stat)
+{
+	stat->time &= ~(ISSUE_STAT_TRACKED | ISSUE_STAT_READ);
+}
+
+static inline bool wbt_tracked(struct wb_issue_stat *stat)
+{
+	return (stat->time & ISSUE_STAT_TRACKED) != 0;
+}
+
+static inline void wbt_mark_read(struct wb_issue_stat *stat)
+{
+	stat->time |= ISSUE_STAT_READ;
+}
+
+static inline bool wbt_is_read(struct wb_issue_stat *stat)
+{
+	return (stat->time & ISSUE_STAT_READ) != 0;
+}
+
+struct wb_stat_ops {
+	void (*get)(void *, struct blk_rq_stat *);
+	void (*clear)(void *);
+};
+
+struct rq_wb {
+	/*
+	 * Settings that govern how we throttle
+	 */
+	unsigned int wb_background;		/* background writeback */
+	unsigned int wb_normal;			/* normal writeback */
+	unsigned int wb_max;			/* max throughput writeback */
+	unsigned int scale_step;
+
+	u64 win_nsec;				/* default window size */
+	u64 cur_win_nsec;			/* current window size */
+
+	/*
+	 * Number of consecutive periods where we don't have enough
+	 * information to make a firm scale up/down decision.
+	 */
+	unsigned int unknown_cnt;
+
+	struct timer_list window_timer;
+
+	s64 sync_issue;
+	void *sync_cookie;
+
+	unsigned int wc;
+	unsigned int queue_depth;
+
+	unsigned long last_issue;		/* last non-throttled issue */
+	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long min_lat_nsec;
+	struct backing_dev_info *bdi;
+	struct request_queue *q;
+	wait_queue_head_t wait;
+	atomic_t inflight;
+
+	struct wb_stat_ops *stat_ops;
+	void *ops_data;
+};
+
+struct backing_dev_info;
+
+void __wbt_done(struct rq_wb *);
+void wbt_done(struct rq_wb *, struct wb_issue_stat *);
+unsigned int wbt_wait(struct rq_wb *, unsigned int, spinlock_t *);
+struct rq_wb *wbt_init(struct backing_dev_info *, struct wb_stat_ops *, void *);
+void wbt_exit(struct rq_wb *);
+void wbt_update_limits(struct rq_wb *);
+void wbt_requeue(struct rq_wb *, struct wb_issue_stat *);
+void wbt_issue(struct rq_wb *, struct wb_issue_stat *);
+void wbt_disable(struct rq_wb *);
+void wbt_track(struct wb_issue_stat *, unsigned int);
+
+void wbt_set_queue_depth(struct rq_wb *, unsigned int);
+void wbt_set_write_cache(struct rq_wb *, bool);
+
+#endif
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
new file mode 100644
index 000000000000..a4b8b2e57bb1
--- /dev/null
+++ b/include/trace/events/wbt.h
@@ -0,0 +1,122 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM wbt
+
+#if !defined(_TRACE_WBT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_WBT_H
+
+#include <linux/tracepoint.h>
+#include <linux/wbt.h>
+
+/**
+ * wbt_stat - trace stats for blk_wb
+ * @stat: array of read/write stats
+ */
+TRACE_EVENT(wbt_stat,
+
+	TP_PROTO(struct backing_dev_info *bdi, struct blk_rq_stat *stat),
+
+	TP_ARGS(bdi, stat),
+
+	TP_STRUCT__entry(
+		__array(char, name, 32)
+		__field(s64, rmean)
+		__field(u64, rmin)
+		__field(u64, rmax)
+		__field(s64, rnr_samples)
+		__field(s64, rtime)
+		__field(s64, wmean)
+		__field(u64, wmin)
+		__field(u64, wmax)
+		__field(s64, wnr_samples)
+		__field(s64, wtime)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		__entry->rmean		= stat[0].mean;
+		__entry->rmin		= stat[0].min;
+		__entry->rmax		= stat[0].max;
+		__entry->rnr_samples	= stat[0].nr_samples;
+		__entry->wmean		= stat[1].mean;
+		__entry->wmin		= stat[1].min;
+		__entry->wmax		= stat[1].max;
+		__entry->wnr_samples	= stat[1].nr_samples;
+	),
+
+	TP_printk("%s: rmean=%llu, rmin=%llu, rmax=%llu, rsamples=%llu, "
+		  "wmean=%llu, wmin=%llu, wmax=%llu, wsamples=%llu\n",
+		  __entry->name, __entry->rmean, __entry->rmin, __entry->rmax,
+		  __entry->rnr_samples, __entry->wmean, __entry->wmin,
+		  __entry->wmax, __entry->wnr_samples)
+);
+
+/**
+ * wbt_lat - trace latency event
+ * @lat: latency trigger
+ */
+TRACE_EVENT(wbt_lat,
+
+	TP_PROTO(struct backing_dev_info *bdi, unsigned long lat),
+
+	TP_ARGS(bdi, lat),
+
+	TP_STRUCT__entry(
+		__array(char, name, 32)
+		__field(unsigned long, lat)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		__entry->lat = lat;
+	),
+
+	TP_printk("%s: latency %llu\n", __entry->name,
+			(unsigned long long) __entry->lat)
+);
+
+/**
+ * wbt_step - trace wb event step
+ * @msg: context message
+ * @step: the current scale step count
+ * @window: the current monitoring window
+ * @bg: the current background queue limit
+ * @normal: the current normal writeback limit
+ * @max: the current max throughput writeback limit
+ */
+TRACE_EVENT(wbt_step,
+
+	TP_PROTO(struct backing_dev_info *bdi, const char *msg,
+		 unsigned int step, unsigned long window, unsigned int bg,
+		 unsigned int normal, unsigned int max),
+
+	TP_ARGS(bdi, msg, step, window, bg, normal, max),
+
+	TP_STRUCT__entry(
+		__array(char, name, 32)
+		__field(const char *, msg)
+		__field(unsigned int, step)
+		__field(unsigned long, window)
+		__field(unsigned int, bg)
+		__field(unsigned int, normal)
+		__field(unsigned int, max)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		__entry->msg	= msg;
+		__entry->step	= step;
+		__entry->window	= window;
+		__entry->bg	= bg;
+		__entry->normal	= normal;
+		__entry->max	= max;
+	),
+
+	TP_printk("%s: %s: step=%u, window=%lu, background=%u, normal=%u, max=%u\n",
+		  __entry->name, __entry->msg, __entry->step, __entry->window,
+		  __entry->bg, __entry->normal, __entry->max)
+);
+
+#endif /* _TRACE_WBT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index d79909dc01ec..5a65a1f91889 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -550,4 +550,8 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config WBT
+	bool
+	select SCALE_BITMAP
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index cfa68eb269e4..c42f0eccd700 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -178,6 +178,7 @@ obj-$(CONFIG_SG_SPLIT) += sg_split.o
 obj-$(CONFIG_SG_POOL) += sg_pool.o
 obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 obj-$(CONFIG_IRQ_POLL) += irq_poll.o
+obj-$(CONFIG_WBT) += wbt.o
 
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
diff --git a/lib/wbt.c b/lib/wbt.c
new file mode 100644
index 000000000000..7da087700eb1
--- /dev/null
+++ b/lib/wbt.c
@@ -0,0 +1,587 @@
+/*
+ * buffered writeback throttling. losely based on CoDel. We can't drop
+ * packets for IO scheduling, so the logic is something like this:
+ *
+ * - Monitor latencies in a defined window of time.
+ * - If the minimum latency in the above window exceeds some target, increment
+ *   scaling step and scale down queue depth by a factor of 2x. The monitoring
+ *   window is then shrunk to 100 / sqrt(scaling step + 1).
+ * - For any window where we don't have solid data on what the latencies
+ *   look like, retain status quo.
+ * - If latencies look good, decrement scaling step.
+ *
+ * Copyright (C) 2016 Jens Axboe
+ *
+ * Things that (may) need changing:
+ *
+ *	- Different scaling of background/normal/high priority writeback.
+ *	  We may have to violate guarantees for max.
+ *	- We can have mismatches between the stat window and our window.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/blk_types.h>
+#include <linux/slab.h>
+#include <linux/backing-dev.h>
+#include <linux/wbt.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/wbt.h>
+
+enum {
+	/*
+	 * Might need to be higher
+	 */
+	RWB_MAX_DEPTH	= 64,
+
+	/*
+	 * 100msec window
+	 */
+	RWB_WINDOW_NSEC		= 100 * 1000 * 1000ULL,
+
+	/*
+	 * Disregard stats, if we don't meet these minimums
+	 */
+	RWB_MIN_WRITE_SAMPLES	= 3,
+	RWB_MIN_READ_SAMPLES	= 1,
+
+	/*
+	 * If we have this number of consecutive windows with not enough
+	 * information to scale up or down, scale up.
+	 */
+	RWB_UNKNOWN_BUMP	= 5,
+};
+
+static inline bool rwb_enabled(struct rq_wb *rwb)
+{
+	return rwb && rwb->wb_normal != 0;
+}
+
+/*
+ * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
+ * false if 'v' + 1 would be bigger than 'below'.
+ */
+static bool atomic_inc_below(atomic_t *v, int below)
+{
+	int cur = atomic_read(v);
+
+	for (;;) {
+		int old;
+
+		if (cur >= below)
+			return false;
+		old = atomic_cmpxchg(v, cur, cur + 1);
+		if (old == cur)
+			break;
+		cur = old;
+	}
+
+	return true;
+}
+
+static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
+{
+	if (rwb_enabled(rwb)) {
+		const unsigned long cur = jiffies;
+
+		if (cur != *var)
+			*var = cur;
+	}
+}
+
+void __wbt_done(struct rq_wb *rwb)
+{
+	int inflight, limit;
+
+	inflight = atomic_dec_return(&rwb->inflight);
+
+	/*
+	 * wbt got disabled with IO in flight. Wake up any potential
+	 * waiters, we don't have to do more than that.
+	 */
+	if (unlikely(!rwb_enabled(rwb))) {
+		wake_up_all(&rwb->wait);
+		return;
+	}
+
+	/*
+	 * If the device does write back caching, drop further down
+	 * before we wake people up.
+	 */
+	if (rwb->wc && !atomic_read(&rwb->bdi->wb.dirty_sleeping))
+		limit = 0;
+	else
+		limit = rwb->wb_normal;
+
+	/*
+	 * Don't wake anyone up if we are above the normal limit.
+	 */
+	if (inflight && inflight >= limit)
+		return;
+
+	if (waitqueue_active(&rwb->wait)) {
+		int diff = limit - inflight;
+
+		if (!inflight || diff >= rwb->wb_background / 2)
+			wake_up_nr(&rwb->wait, 1);
+	}
+}
+
+/*
+ * Called on completion of a request. Note that it's also called when
+ * a request is merged, when the request gets freed.
+ */
+void wbt_done(struct rq_wb *rwb, struct wb_issue_stat *stat)
+{
+	if (!rwb)
+		return;
+
+	if (!wbt_tracked(stat)) {
+		if (rwb->sync_cookie == stat) {
+			rwb->sync_issue = 0;
+			rwb->sync_cookie = NULL;
+		}
+
+		if (wbt_is_read(stat))
+			wb_timestamp(rwb, &rwb->last_comp);
+		wbt_clear_state(stat);
+	} else {
+		WARN_ON_ONCE(stat == rwb->sync_cookie);
+		__wbt_done(rwb);
+		wbt_clear_state(stat);
+	}
+}
+
+static void calc_wb_limits(struct rq_wb *rwb)
+{
+	unsigned int depth;
+
+	if (!rwb->min_lat_nsec) {
+		rwb->wb_max = rwb->wb_normal = rwb->wb_background = 0;
+		return;
+	}
+
+	/*
+	 * For QD=1 devices, this is a special case. It's important for those
+	 * to have one request ready when one completes, so force a depth of
+	 * 2 for those devices. On the backend, it'll be a depth of 1 anyway,
+	 * since the device can't have more than that in flight. If we're
+	 * scaling down, then keep a setting of 1/1/1.
+	 */
+	if (rwb->queue_depth == 1) {
+		if (rwb->scale_step)
+			rwb->wb_max = rwb->wb_normal = 1;
+		else
+			rwb->wb_max = rwb->wb_normal = 2;
+		rwb->wb_background = 1;
+	} else {
+		depth = min_t(unsigned int, RWB_MAX_DEPTH, rwb->queue_depth);
+
+		/*
+		 * Set our max/normal/bg queue depths based on how far
+		 * we have scaled down (->scale_step).
+		 */
+		rwb->wb_max = 1 + ((depth - 1) >> min(31U, rwb->scale_step));
+		rwb->wb_normal = (rwb->wb_max + 1) / 2;
+		rwb->wb_background = (rwb->wb_max + 3) / 4;
+	}
+}
+
+static bool inline stat_sample_valid(struct blk_rq_stat *stat)
+{
+	/*
+	 * We need at least one read sample, and a minimum of
+	 * RWB_MIN_WRITE_SAMPLES. We require some write samples to know
+	 * that it's writes impacting us, and not just some sole read on
+	 * a device that is in a lower power state.
+	 */
+	return stat[0].nr_samples >= 1 &&
+		stat[1].nr_samples >= RWB_MIN_WRITE_SAMPLES;
+}
+
+static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
+{
+	u64 now, issue = ACCESS_ONCE(rwb->sync_issue);
+
+	if (!issue || !rwb->sync_cookie)
+		return 0;
+
+	now = ktime_to_ns(ktime_get());
+	return now - issue;
+}
+
+enum {
+	LAT_OK,
+	LAT_UNKNOWN,
+	LAT_EXCEEDED,
+};
+
+static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
+{
+	u64 thislat;
+
+	/*
+	 * If our stored sync issue exceeds the window size, or it
+	 * exceeds our min target AND we haven't logged any entries,
+	 * flag the latency as exceeded. wbt works off completion latencies,
+	 * but for a flooded device, a single sync IO can take a long time
+	 * to complete after being issued. If this time exceeds our
+	 * monitoring window AND we didn't see any other completions in that
+	 * window, then count that sync IO as a violation of the latency.
+	 */
+	thislat = rwb_sync_issue_lat(rwb);
+	if (thislat > rwb->cur_win_nsec ||
+	    (thislat > rwb->min_lat_nsec && !stat[0].nr_samples)) {
+		trace_wbt_lat(rwb->bdi, thislat);
+		return LAT_EXCEEDED;
+	}
+
+	if (!stat_sample_valid(stat))
+		return LAT_UNKNOWN;
+
+	/*
+	 * If the 'min' latency exceeds our target, step down.
+	 */
+	if (stat[0].min > rwb->min_lat_nsec) {
+		trace_wbt_lat(rwb->bdi, stat[0].min);
+		trace_wbt_stat(rwb->bdi, stat);
+		return LAT_EXCEEDED;
+	}
+
+	if (rwb->scale_step)
+		trace_wbt_stat(rwb->bdi, stat);
+
+	return LAT_OK;
+}
+
+static int latency_exceeded(struct rq_wb *rwb)
+{
+	struct blk_rq_stat stat[2];
+
+	rwb->stat_ops->get(rwb->ops_data, stat);
+	return __latency_exceeded(rwb, stat);
+}
+
+static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
+{
+	trace_wbt_step(rwb->bdi, msg, rwb->scale_step, rwb->cur_win_nsec,
+			rwb->wb_background, rwb->wb_normal, rwb->wb_max);
+}
+
+static void scale_up(struct rq_wb *rwb)
+{
+	/*
+	 * If we're at 0, we can't go lower.
+	 */
+	if (!rwb->scale_step)
+		return;
+
+	rwb->scale_step--;
+	rwb->unknown_cnt = 0;
+	rwb->stat_ops->clear(rwb->ops_data);
+	calc_wb_limits(rwb);
+
+	if (waitqueue_active(&rwb->wait))
+		wake_up_all(&rwb->wait);
+
+	rwb_trace_step(rwb, "step up");
+}
+
+static void scale_down(struct rq_wb *rwb)
+{
+	/*
+	 * Stop scaling down when we've hit the limit. This also prevents
+	 * ->scale_step from going to crazy values, if the device can't
+	 * keep up.
+	 */
+	if (rwb->wb_max == 1)
+		return;
+
+	rwb->scale_step++;
+	rwb->unknown_cnt = 0;
+	rwb->stat_ops->clear(rwb->ops_data);
+	calc_wb_limits(rwb);
+	rwb_trace_step(rwb, "step down");
+}
+
+static void rwb_arm_timer(struct rq_wb *rwb)
+{
+	unsigned long expires;
+
+	/*
+	 * We should speed this up, using some variant of a fast integer
+	 * inverse square root calculation. Since we only do this for
+	 * every window expiration, it's not a huge deal, though.
+	 */
+	rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
+					int_sqrt((rwb->scale_step + 1) << 8));
+	expires = jiffies + nsecs_to_jiffies(rwb->cur_win_nsec);
+	mod_timer(&rwb->window_timer, expires);
+}
+
+static void wb_timer_fn(unsigned long data)
+{
+	struct rq_wb *rwb = (struct rq_wb *) data;
+	int status;
+
+	/*
+	 * If we exceeded the latency target, step down. If we did not,
+	 * step one level up. If we don't know enough to say either exceeded
+	 * or ok, then don't do anything.
+	 */
+	status = latency_exceeded(rwb);
+	switch (status) {
+	case LAT_EXCEEDED:
+		scale_down(rwb);
+		break;
+	case LAT_OK:
+		scale_up(rwb);
+		break;
+	case LAT_UNKNOWN:
+		/*
+		 * We had no read samples, start bumping up the write
+		 * depth slowly
+		 */
+		if (++rwb->unknown_cnt >= RWB_UNKNOWN_BUMP)
+			scale_up(rwb);
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Re-arm timer, if we have IO in flight
+	 */
+	if (rwb->scale_step || atomic_read(&rwb->inflight))
+		rwb_arm_timer(rwb);
+}
+
+void wbt_update_limits(struct rq_wb *rwb)
+{
+	rwb->scale_step = 0;
+	calc_wb_limits(rwb);
+
+	if (waitqueue_active(&rwb->wait))
+		wake_up_all(&rwb->wait);
+}
+
+static bool close_io(struct rq_wb *rwb)
+{
+	const unsigned long now = jiffies;
+
+	return time_before(now, rwb->last_issue + HZ / 10) ||
+		time_before(now, rwb->last_comp + HZ / 10);
+}
+
+#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
+
+static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
+{
+	unsigned int limit;
+
+	/*
+	 * At this point we know it's a buffered write. If REQ_SYNC is
+	 * set, then it's WB_SYNC_ALL writeback, and we'll use the max
+	 * limit for that. If the write is marked as a background write,
+	 * then use the idle limit, or go to normal if we haven't had
+	 * competing IO for a bit.
+	 */
+	if ((rw & REQ_HIPRIO) || atomic_read(&rwb->bdi->wb.dirty_sleeping))
+		limit = rwb->wb_max;
+	else if ((rw & REQ_BG) || close_io(rwb)) {
+		/*
+		 * If less than 100ms since we completed unrelated IO,
+		 * limit us to half the depth for background writeback.
+		 */
+		limit = rwb->wb_background;
+	} else
+		limit = rwb->wb_normal;
+
+	return limit;
+}
+
+static inline bool may_queue(struct rq_wb *rwb, unsigned long rw)
+{
+	/*
+	 * inc it here even if disabled, since we'll dec it at completion.
+	 * this only happens if the task was sleeping in __wbt_wait(),
+	 * and someone turned it off at the same time.
+	 */
+	if (!rwb_enabled(rwb)) {
+		atomic_inc(&rwb->inflight);
+		return true;
+	}
+
+	return atomic_inc_below(&rwb->inflight, get_limit(rwb, rw));
+}
+
+/*
+ * Block if we will exceed our limit, or if we are currently waiting for
+ * the timer to kick off queuing again.
+ */
+static void __wbt_wait(struct rq_wb *rwb, unsigned long rw, spinlock_t *lock)
+{
+	DEFINE_WAIT(wait);
+
+	if (may_queue(rwb, rw))
+		return;
+
+	do {
+		prepare_to_wait_exclusive(&rwb->wait, &wait,
+						TASK_UNINTERRUPTIBLE);
+
+		if (may_queue(rwb, rw))
+			break;
+
+		if (lock)
+			spin_unlock_irq(lock);
+
+		io_schedule();
+
+		if (lock)
+			spin_lock_irq(lock);
+	} while (1);
+
+	finish_wait(&rwb->wait, &wait);
+}
+
+static inline bool wbt_should_throttle(struct rq_wb *rwb, unsigned int rw)
+{
+	const int op = rw >> BIO_OP_SHIFT;
+
+	/*
+	 * If not a WRITE (or a discard), do nothing
+	 */
+	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD))
+		return false;
+
+	/*
+	 * Don't throttle WRITE_ODIRECT
+	 */
+	if ((rw & (REQ_SYNC | REQ_NOIDLE)) == REQ_SYNC)
+		return false;
+
+	return true;
+}
+
+/*
+ * Returns true if the IO request should be accounted, false if not.
+ * May sleep, if we have exceeded the writeback limits. Caller can pass
+ * in an irq held spinlock, if it holds one when calling this function.
+ * If we do sleep, we'll release and re-grab it.
+ */
+unsigned int wbt_wait(struct rq_wb *rwb, unsigned int rw, spinlock_t *lock)
+{
+	unsigned int ret;
+
+	if (!rwb_enabled(rwb))
+		return 0;
+
+	if ((rw >> BIO_OP_SHIFT) == REQ_OP_READ)
+		ret = WBT_READ;
+
+	if (!wbt_should_throttle(rwb, rw)) {
+		if (ret & WBT_READ)
+			wb_timestamp(rwb, &rwb->last_issue);
+		return ret;
+	}
+
+	__wbt_wait(rwb, rw, lock);
+
+	if (!timer_pending(&rwb->window_timer))
+		rwb_arm_timer(rwb);
+
+	return ret | WBT_TRACKED;
+}
+
+void wbt_issue(struct rq_wb *rwb, struct wb_issue_stat *stat)
+{
+	if (!rwb_enabled(rwb))
+		return;
+
+	wbt_issue_stat_set_time(stat);
+
+	/*
+	 * Track sync issue, in case it takes a long time to complete. Allows
+	 * us to react quicker, if a sync IO takes a long time to complete.
+	 * Note that this is just a hint. 'stat' can go away when the
+	 * request completes, so it's important we never dereference it. We
+	 * only use the address to compare with, which is why we store the
+	 * sync_issue time locally.
+	 */
+	if (wbt_is_read(stat) && !rwb->sync_issue) {
+		rwb->sync_cookie = stat;
+		rwb->sync_issue = wbt_issue_stat_get_time(stat);
+	}
+}
+
+void wbt_track(struct wb_issue_stat *stat, unsigned int wb_acct)
+{
+	if (wb_acct & WBT_TRACKED)
+		wbt_mark_tracked(stat);
+	else if (wb_acct & WBT_READ)
+		wbt_mark_read(stat);
+}
+
+void wbt_requeue(struct rq_wb *rwb, struct wb_issue_stat *stat)
+{
+	if (!rwb_enabled(rwb))
+		return;
+	if (stat == rwb->sync_cookie) {
+		rwb->sync_issue = 0;
+		rwb->sync_cookie = NULL;
+	}
+}
+
+void wbt_set_queue_depth(struct rq_wb *rwb, unsigned int depth)
+{
+	if (rwb) {
+		rwb->queue_depth = depth;
+		wbt_update_limits(rwb);
+	}
+}
+
+void wbt_set_write_cache(struct rq_wb *rwb, bool write_cache_on)
+{
+	if (rwb)
+		rwb->wc = write_cache_on;
+}
+
+void wbt_disable(struct rq_wb *rwb)
+{
+	del_timer_sync(&rwb->window_timer);
+	rwb->win_nsec = rwb->min_lat_nsec = 0;
+	wbt_update_limits(rwb);
+}
+EXPORT_SYMBOL_GPL(wbt_disable);
+
+struct rq_wb *wbt_init(struct backing_dev_info *bdi, struct wb_stat_ops *ops,
+		       void *ops_data)
+{
+	struct rq_wb *rwb;
+
+	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
+	if (!rwb)
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&rwb->inflight, 0);
+	init_waitqueue_head(&rwb->wait);
+	setup_timer(&rwb->window_timer, wb_timer_fn, (unsigned long) rwb);
+	rwb->wc = 1;
+	rwb->queue_depth = RWB_MAX_DEPTH;
+	rwb->last_comp = rwb->last_issue = jiffies;
+	rwb->bdi = bdi;
+	rwb->win_nsec = RWB_WINDOW_NSEC;
+	rwb->stat_ops = ops,
+	rwb->ops_data = ops_data;
+	wbt_update_limits(rwb);
+	return rwb;
+}
+
+void wbt_exit(struct rq_wb *rwb)
+{
+	if (rwb) {
+		del_timer_sync(&rwb->window_timer);
+		kfree(rwb);
+	}
+}
-- 
2.7.4
