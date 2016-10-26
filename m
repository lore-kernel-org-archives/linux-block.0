Return-Path: <prvs=9107f69a83=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <kernel@kolivas.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 7/8] blk-wbt: add general throttling mechanism
Date: Wed, 26 Oct 2016 14:52:14 -0600
Message-ID: <1477515135-16469-8-git-send-email-axboe@fb.com>
In-Reply-To: <1477515135-16469-1-git-send-email-axboe@fb.com>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We can hook this up to the block layer, to help throttle buffered
writes.

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
 block/Makefile             |   1 +
 block/blk-wbt.c            | 704 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-wbt.h            | 166 +++++++++++
 include/trace/events/wbt.h | 153 ++++++++++
 4 files changed, 1024 insertions(+)
 create mode 100644 block/blk-wbt.c
 create mode 100644 block/blk-wbt.h
 create mode 100644 include/trace/events/wbt.h

diff --git a/block/Makefile b/block/Makefile
index ff6edd5593d1..baeaec67e0e0 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
+obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
new file mode 100644
index 000000000000..82823c723f6d
--- /dev/null
+++ b/block/blk-wbt.c
@@ -0,0 +1,704 @@
+/*
+ * buffered writeback throttling. loosely based on CoDel. We can't drop
+ * packets for IO scheduling, so the logic is something like this:
+ *
+ * - Monitor latencies in a defined window of time.
+ * - If the minimum latency in the above window exceeds some target, increment
+ *   scaling step and scale down queue depth by a factor of 2x. The monitoring
+ *   window is then shrunk to 100 / sqrt(scaling step + 1).
+ * - For any window where we don't have solid data on what the latencies
+ *   look like, retain status quo.
+ * - If latencies look good, decrement scaling step.
+ * - If we're only doing writes, allow the scaling step to go negative. This
+ *   will temporarily boost write performance, snapping back to a stable
+ *   scaling step of 0 if reads show up or the heavy writers finish. Unlike
+ *   positive scaling steps where we shrink the monitoring window, a negative
+ *   scaling step retains the default step==0 window size.
+ *
+ * Copyright (C) 2016 Jens Axboe
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/blk_types.h>
+#include <linux/slab.h>
+#include <linux/backing-dev.h>
+#include <linux/swap.h>
+
+#include "blk-wbt.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/wbt.h>
+
+enum {
+	/*
+	 * Default setting, we'll scale up (to 75% of QD max) or down (min 1)
+	 * from here depending on device stats
+	 */
+	RWB_DEF_DEPTH	= 16,
+
+	/*
+	 * 100msec window
+	 */
+	RWB_WINDOW_NSEC		= 100 * 1000 * 1000ULL,
+
+	/*
+	 * Disregard stats, if we don't meet this minimum
+	 */
+	RWB_MIN_WRITE_SAMPLES	= 3,
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
+/*
+ * If a task was rate throttled in balance_dirty_pages() within the last
+ * second or so, use that to indicate a higher cleaning rate.
+ */
+static bool wb_recent_wait(struct rq_wb *rwb)
+{
+	struct bdi_writeback *wb = &rwb->bdi->wb;
+
+	return time_before(jiffies, wb->dirty_sleep + HZ);
+}
+
+static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb, bool is_kswapd)
+{
+	return &rwb->rq_wait[is_kswapd];
+}
+
+static void rwb_wake_all(struct rq_wb *rwb)
+{
+	int i;
+
+	for (i = 0; i < WBT_NUM_RWQ; i++) {
+		struct rq_wait *rqw = &rwb->rq_wait[i];
+
+		if (waitqueue_active(&rqw->wait))
+			wake_up_all(&rqw->wait);
+	}
+}
+
+void __wbt_done(struct rq_wb *rwb, enum wbt_flags wb_acct)
+{
+	struct rq_wait *rqw;
+	int inflight, limit;
+
+	if (!(wb_acct & WBT_TRACKED))
+		return;
+
+	rqw = get_rq_wait(rwb, wb_acct & WBT_KSWAPD);
+	inflight = atomic_dec_return(&rqw->inflight);
+
+	/*
+	 * wbt got disabled with IO in flight. Wake up any potential
+	 * waiters, we don't have to do more than that.
+	 */
+	if (unlikely(!rwb_enabled(rwb))) {
+		rwb_wake_all(rwb);
+		return;
+	}
+
+	/*
+	 * If the device does write back caching, drop further down
+	 * before we wake people up.
+	 */
+	if (rwb->wc && !wb_recent_wait(rwb))
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
+	if (waitqueue_active(&rqw->wait)) {
+		int diff = limit - inflight;
+
+		if (!inflight || diff >= rwb->wb_background / 2)
+			wake_up(&rqw->wait);
+	}
+}
+
+/*
+ * Called on completion of a request. Note that it's also called when
+ * a request is merged, when the request gets freed.
+ */
+void wbt_done(struct rq_wb *rwb, struct blk_issue_stat *stat)
+{
+	if (!rwb)
+		return;
+
+	if (!wbt_is_tracked(stat)) {
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
+		__wbt_done(rwb, wbt_stat_to_mask(stat));
+		wbt_clear_state(stat);
+	}
+}
+
+/*
+ * Return true, if we can't increase the depth further by scaling
+ */
+static bool calc_wb_limits(struct rq_wb *rwb)
+{
+	unsigned int depth;
+	bool ret = false;
+
+	if (!rwb->min_lat_nsec) {
+		rwb->wb_max = rwb->wb_normal = rwb->wb_background = 0;
+		return false;
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
+		if (rwb->scale_step > 0)
+			rwb->wb_max = rwb->wb_normal = 1;
+		else {
+			rwb->wb_max = rwb->wb_normal = 2;
+			ret = true;
+		}
+		rwb->wb_background = 1;
+	} else {
+		/*
+		 * scale_step == 0 is our default state. If we have suffered
+		 * latency spikes, step will be > 0, and we shrink the
+		 * allowed write depths. If step is < 0, we're only doing
+		 * writes, and we allow a temporarily higher depth to
+		 * increase performance.
+		 */
+		depth = min_t(unsigned int, RWB_DEF_DEPTH, rwb->queue_depth);
+		if (rwb->scale_step > 0)
+			depth = 1 + ((depth - 1) >> min(31, rwb->scale_step));
+		else if (rwb->scale_step < 0) {
+			unsigned int maxd = 3 * rwb->queue_depth / 4;
+
+			depth = 1 + ((depth - 1) << -rwb->scale_step);
+			if (depth > maxd) {
+				depth = maxd;
+				ret = true;
+			}
+		}
+
+		/*
+		 * Set our max/normal/bg queue depths based on how far
+		 * we have scaled down (->scale_step).
+		 */
+		rwb->wb_max = depth;
+		rwb->wb_normal = (rwb->wb_max + 1) / 2;
+		rwb->wb_background = (rwb->wb_max + 3) / 4;
+	}
+
+	return ret;
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
+	LAT_OK = 1,
+	LAT_UNKNOWN,
+	LAT_UNKNOWN_WRITES,
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
+	/*
+	 * No read/write mix, if stat isn't valid
+	 */
+	if (!stat_sample_valid(stat)) {
+		/*
+		 * If we had writes in this stat window and the window is
+		 * current, we're only doing writes. If a task recently
+		 * waited or still has writes in flights, consider us doing
+		 * just writes as well.
+		 */
+		if ((stat[1].nr_samples && rwb->stat_ops->is_current(stat)) ||
+		    wb_recent_wait(rwb) || wbt_inflight(rwb))
+			return LAT_UNKNOWN_WRITES;
+		return LAT_UNKNOWN;
+	}
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
+	 * Hit max in previous round, stop here
+	 */
+	if (rwb->scaled_max)
+		return;
+
+	rwb->scale_step--;
+	rwb->unknown_cnt = 0;
+	rwb->stat_ops->clear(rwb->ops_data);
+
+	rwb->scaled_max = calc_wb_limits(rwb);
+
+	rwb_wake_all(rwb);
+
+	rwb_trace_step(rwb, "step up");
+}
+
+/*
+ * Scale rwb down. If 'hard_throttle' is set, do it quicker, since we
+ * had a latency violation.
+ */
+static void scale_down(struct rq_wb *rwb, bool hard_throttle)
+{
+	/*
+	 * Stop scaling down when we've hit the limit. This also prevents
+	 * ->scale_step from going to crazy values, if the device can't
+	 * keep up.
+	 */
+	if (rwb->wb_max == 1)
+		return;
+
+	if (rwb->scale_step < 0 && hard_throttle)
+		rwb->scale_step = 0;
+	else
+		rwb->scale_step++;
+
+	rwb->scaled_max = false;
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
+	if (rwb->scale_step > 0) {
+		/*
+		 * We should speed this up, using some variant of a fast
+		 * integer inverse square root calculation. Since we only do
+		 * this for every window expiration, it's not a huge deal,
+		 * though.
+		 */
+		rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
+					int_sqrt((rwb->scale_step + 1) << 8));
+	} else {
+		/*
+		 * For step < 0, we don't want to increase/decrease the
+		 * window size.
+		 */
+		rwb->cur_win_nsec = rwb->win_nsec;
+	}
+
+	expires = jiffies + nsecs_to_jiffies(rwb->cur_win_nsec);
+	mod_timer(&rwb->window_timer, expires);
+}
+
+static void wb_timer_fn(unsigned long data)
+{
+	struct rq_wb *rwb = (struct rq_wb *) data;
+	unsigned int inflight = wbt_inflight(rwb);
+	int status;
+
+	status = latency_exceeded(rwb);
+
+	trace_wbt_timer(rwb->bdi, status, rwb->scale_step, inflight);
+
+	/*
+	 * If we exceeded the latency target, step down. If we did not,
+	 * step one level up. If we don't know enough to say either exceeded
+	 * or ok, then don't do anything.
+	 */
+	switch (status) {
+	case LAT_EXCEEDED:
+		scale_down(rwb, true);
+		break;
+	case LAT_OK:
+		scale_up(rwb);
+		break;
+	case LAT_UNKNOWN_WRITES:
+		scale_up(rwb);
+		break;
+	case LAT_UNKNOWN:
+		if (++rwb->unknown_cnt < RWB_UNKNOWN_BUMP)
+			break;
+		/*
+		 * We get here for two reasons:
+		 *
+		 * 1) We previously scaled reduced depth, and we currently
+		 *    don't have a valid read/write sample. For that case,
+		 *    slowly return to center state (step == 0).
+		 * 2) We started a the center step, but don't have a valid
+		 *    read/write sample, but we do have writes going on.
+		 *    Allow step to go negative, to increase write perf.
+		 */
+		if (rwb->scale_step > 0)
+			scale_up(rwb);
+		else if (rwb->scale_step < 0)
+			scale_down(rwb, false);
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Re-arm timer, if we have IO in flight
+	 */
+	if (rwb->scale_step || inflight)
+		rwb_arm_timer(rwb);
+}
+
+void wbt_update_limits(struct rq_wb *rwb)
+{
+	rwb->scale_step = 0;
+	rwb->scaled_max = false;
+	calc_wb_limits(rwb);
+
+	rwb_wake_all(rwb);
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
+	 * At this point we know it's a buffered write. If this is
+	 * kswapd trying to free memory, or REQ_SYNC is set, set, then
+	 * it's WB_SYNC_ALL writeback, and we'll use the max limit for
+	 * that. If the write is marked as a background write, then use
+	 * the idle limit, or go to normal if we haven't had competing
+	 * IO for a bit.
+	 */
+	if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
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
+static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
+			     unsigned long rw)
+{
+	/*
+	 * inc it here even if disabled, since we'll dec it at completion.
+	 * this only happens if the task was sleeping in __wbt_wait(),
+	 * and someone turned it off at the same time.
+	 */
+	if (!rwb_enabled(rwb)) {
+		atomic_inc(&rqw->inflight);
+		return true;
+	}
+
+	return atomic_inc_below(&rqw->inflight, get_limit(rwb, rw));
+}
+
+/*
+ * Block if we will exceed our limit, or if we are currently waiting for
+ * the timer to kick off queuing again.
+ */
+static void __wbt_wait(struct rq_wb *rwb, unsigned long rw, spinlock_t *lock)
+{
+	struct rq_wait *rqw = get_rq_wait(rwb, current_is_kswapd());
+	DEFINE_WAIT(wait);
+
+	if (may_queue(rwb, rqw, rw))
+		return;
+
+	do {
+		prepare_to_wait_exclusive(&rqw->wait, &wait,
+						TASK_UNINTERRUPTIBLE);
+
+		if (may_queue(rwb, rqw, rw))
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
+	finish_wait(&rqw->wait, &wait);
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
+	unsigned int ret = 0;
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
+	if (current_is_kswapd())
+		ret |= WBT_KSWAPD;
+
+	return ret | WBT_TRACKED;
+}
+
+void wbt_issue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+{
+	if (!rwb_enabled(rwb))
+		return;
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
+		rwb->sync_issue = blk_stat_time(stat);
+	}
+}
+
+void wbt_requeue(struct rq_wb *rwb, struct blk_issue_stat *stat)
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
+	if (rwb) {
+		del_timer_sync(&rwb->window_timer);
+		rwb->win_nsec = rwb->min_lat_nsec = 0;
+		wbt_update_limits(rwb);
+	}
+}
+EXPORT_SYMBOL_GPL(wbt_disable);
+
+struct rq_wb *wbt_init(struct backing_dev_info *bdi, struct wb_stat_ops *ops,
+		       void *ops_data)
+{
+	struct rq_wb *rwb;
+	int i;
+
+	BUILD_BUG_ON(WBT_NR_BITS > BLK_STAT_RES_BITS);
+
+	if (!ops->get || !ops->is_current || !ops->clear)
+		return ERR_PTR(-EINVAL);
+
+	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
+	if (!rwb)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < WBT_NUM_RWQ; i++) {
+		atomic_set(&rwb->rq_wait[i].inflight, 0);
+		init_waitqueue_head(&rwb->rq_wait[i].wait);
+	}
+
+	setup_timer(&rwb->window_timer, wb_timer_fn, (unsigned long) rwb);
+	rwb->wc = 1;
+	rwb->queue_depth = RWB_DEF_DEPTH;
+	rwb->last_comp = rwb->last_issue = jiffies;
+	rwb->bdi = bdi;
+	rwb->win_nsec = RWB_WINDOW_NSEC;
+	rwb->stat_ops = ops;
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
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
new file mode 100644
index 000000000000..deba3c815033
--- /dev/null
+++ b/block/blk-wbt.h
@@ -0,0 +1,166 @@
+#ifndef WB_THROTTLE_H
+#define WB_THROTTLE_H
+
+#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ktime.h>
+
+#include "blk-stat.h"
+
+enum wbt_flags {
+	WBT_TRACKED		= 1,	/* write, tracked for throttling */
+	WBT_READ		= 2,	/* read */
+	WBT_KSWAPD		= 4,	/* write, from kswapd */
+
+	WBT_NR_BITS		= 3,	/* number of bits */
+};
+
+enum {
+	WBT_NUM_RWQ		= 2,
+};
+
+static inline void wbt_clear_state(struct blk_issue_stat *stat)
+{
+	stat->time &= BLK_STAT_TIME_MASK;
+}
+
+static inline enum wbt_flags wbt_stat_to_mask(struct blk_issue_stat *stat)
+{
+	return (stat->time & BLK_STAT_MASK) >> BLK_STAT_SHIFT;
+}
+
+static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags wb_acct)
+{
+	stat->time |= ((u64) wb_acct) << BLK_STAT_SHIFT;
+}
+
+static inline bool wbt_is_tracked(struct blk_issue_stat *stat)
+{
+	return (stat->time >> BLK_STAT_SHIFT) & WBT_TRACKED;
+}
+
+static inline bool wbt_is_read(struct blk_issue_stat *stat)
+{
+	return (stat->time >> BLK_STAT_SHIFT) & WBT_READ;
+}
+
+struct wb_stat_ops {
+	void (*get)(void *, struct blk_rq_stat *);
+	bool (*is_current)(struct blk_rq_stat *);
+	void (*clear)(void *);
+};
+
+struct rq_wait {
+	wait_queue_head_t wait;
+	atomic_t inflight;
+};
+
+struct rq_wb {
+	/*
+	 * Settings that govern how we throttle
+	 */
+	unsigned int wb_background;		/* background writeback */
+	unsigned int wb_normal;			/* normal writeback */
+	unsigned int wb_max;			/* max throughput writeback */
+	int scale_step;
+	bool scaled_max;
+
+	/*
+	 * Number of consecutive periods where we don't have enough
+	 * information to make a firm scale up/down decision.
+	 */
+	unsigned int unknown_cnt;
+
+	u64 win_nsec;				/* default window size */
+	u64 cur_win_nsec;			/* current window size */
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
+	struct rq_wait rq_wait[WBT_NUM_RWQ];
+
+	struct wb_stat_ops *stat_ops;
+	void *ops_data;
+};
+
+static inline unsigned int wbt_inflight(struct rq_wb *rwb)
+{
+	unsigned int i, ret = 0;
+
+	for (i = 0; i < WBT_NUM_RWQ; i++)
+		ret += atomic_read(&rwb->rq_wait[i].inflight);
+
+	return ret;
+}
+
+struct backing_dev_info;
+
+#ifdef CONFIG_BLK_WBT
+
+void __wbt_done(struct rq_wb *, enum wbt_flags);
+void wbt_done(struct rq_wb *, struct blk_issue_stat *);
+enum wbt_flags wbt_wait(struct rq_wb *, unsigned int, spinlock_t *);
+struct rq_wb *wbt_init(struct backing_dev_info *, struct wb_stat_ops *, void *);
+void wbt_exit(struct rq_wb *);
+void wbt_update_limits(struct rq_wb *);
+void wbt_requeue(struct rq_wb *, struct blk_issue_stat *);
+void wbt_issue(struct rq_wb *, struct blk_issue_stat *);
+void wbt_disable(struct rq_wb *);
+
+void wbt_set_queue_depth(struct rq_wb *, unsigned int);
+void wbt_set_write_cache(struct rq_wb *, bool);
+
+#else
+
+static inline void __wbt_done(struct rq_wb *rwb, enum wbt_flags flags)
+{
+}
+static inline void wbt_done(struct rq_wb *rwb, struct blk_issue_stat *stat)
+{
+}
+static inline enum wbt_flags wbt_wait(struct rq_wb *rwb,
+				      unsigned int rw, spinlock_t *lock)
+{
+	return 0;
+}
+static inline struct rq_wb *wbt_init(struct backing_dev_info *bdi,
+				     struct wb_stat_ops *ops, void *ops_data)
+{
+	return NULL;
+}
+static inline void wbt_exit(struct rq_wb *rbw)
+{
+}
+static inline void wbt_update_limits(struct rq_wb *rwb)
+{
+}
+static inline void wbt_requeue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+{
+}
+static inline void wbt_issue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+{
+}
+static inline void wbt_disable(struct rq_wb *rwb)
+{
+}
+static inline void wbt_set_queue_depth(struct rq_wb *rwb, unsigned int depth)
+{
+}
+static inline void wbt_set_write_cache(struct rq_wb *rwb, bool wc)
+{
+}
+
+#endif /* CONFIG_BLK_WBT */
+
+#endif
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
new file mode 100644
index 000000000000..3c518e455680
--- /dev/null
+++ b/include/trace/events/wbt.h
@@ -0,0 +1,153 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM wbt
+
+#if !defined(_TRACE_WBT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_WBT_H
+
+#include <linux/tracepoint.h>
+#include "../../../block/blk-wbt.h"
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
+		__entry->lat = div_u64(lat, 1000);
+	),
+
+	TP_printk("%s: latency %lluus\n", __entry->name,
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
+		 int step, unsigned long window, unsigned int bg,
+		 unsigned int normal, unsigned int max),
+
+	TP_ARGS(bdi, msg, step, window, bg, normal, max),
+
+	TP_STRUCT__entry(
+		__array(char, name, 32)
+		__field(const char *, msg)
+		__field(int, step)
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
+		__entry->window	= div_u64(window, 1000);
+		__entry->bg	= bg;
+		__entry->normal	= normal;
+		__entry->max	= max;
+	),
+
+	TP_printk("%s: %s: step=%d, window=%luus, background=%u, normal=%u, max=%u\n",
+		  __entry->name, __entry->msg, __entry->step, __entry->window,
+		  __entry->bg, __entry->normal, __entry->max)
+);
+
+/**
+ * wbt_timer - trace wb timer event
+ * @status: timer state status
+ * @step: the current scale step count
+ * @inflight: tracked writes inflight
+ */
+TRACE_EVENT(wbt_timer,
+
+	TP_PROTO(struct backing_dev_info *bdi, unsigned int status,
+		 int step, unsigned int inflight),
+
+	TP_ARGS(bdi, status, step, inflight),
+
+	TP_STRUCT__entry(
+		__array(char, name, 32)
+		__field(unsigned int, status)
+		__field(int, step)
+		__field(unsigned int, inflight)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		__entry->status		= status;
+		__entry->step		= step;
+		__entry->inflight	= inflight;
+	),
+
+	TP_printk("%s: status=%u, step=%d, inflight=%u\n", __entry->name,
+		  __entry->status, __entry->step, __entry->inflight)
+);
+
+#endif /* _TRACE_WBT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4
