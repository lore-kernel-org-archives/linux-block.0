Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 8/8] block: hook up writeback throttling
Date: Tue, 1 Nov 2016 15:08:51 -0600
Message-ID: <1478034531-28559-9-git-send-email-axboe@fb.com>
In-Reply-To: <1478034531-28559-1-git-send-email-axboe@fb.com>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Enable throttling of buffered writeback to make it a lot
more smooth, and has way less impact on other system activity.
Background writeback should be, by definition, background
activity. The fact that we flush huge bundles of it at the time
means that it potentially has heavy impacts on foreground workloads,
which isn't ideal. We can't easily limit the sizes of writes that
we do, since that would impact file system layout in the presence
of delayed allocation. So just throttle back buffered writeback,
unless someone is waiting for it.

The algorithm for when to throttle takes its inspiration in the
CoDel networking scheduling algorithm. Like CoDel, blk-wb monitors
the minimum latencies of requests over a window of time. In that
window of time, if the minimum latency of any request exceeds a
given target, then a scale count is incremented and the queue depth
is shrunk. The next monitoring window is shrunk accordingly. Unlike
CoDel, if we hit a window that exhibits good behavior, then we
simply increment the scale count and re-calculate the limits for that
scale value. This prevents us from oscillating between a
close-to-ideal value and max all the time, instead remaining in the
windows where we get good behavior.

Unlike CoDel, blk-wb allows the scale count to to negative. This
happens if we primarily have writes going on. Unlike positive
scale counts, this doesn't change the size of the monitoring window.
When the heavy writers finish, blk-bw quickly snaps back to it's
stable state of a zero scale count.

The patch registers two sysfs entries. The first one, 'wb_window_usec',
defines the window of monitoring. The second one, 'wb_lat_usec',
sets the latency target for the window. It defaults to 2 msec for
non-rotational storage, and 75 msec for rotational storage. Setting
this value to '0' disables blk-wb. Generally, a user would not have
to touch these settings.

We don't enable WBT on devices that are managed with CFQ, and have
a non-root block cgroup attached. If we have a proportional share setup
on this particular disk, then the wbt throttling will interfere with
that. We don't have a strong need for wbt for that case, since we will
rely on CFQ doing that for us.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 Documentation/block/queue-sysfs.txt |  13 ++++
 block/Kconfig                       |  24 +++++++
 block/blk-core.c                    |  18 ++++-
 block/blk-mq.c                      |  27 +++++++-
 block/blk-settings.c                |   4 ++
 block/blk-sysfs.c                   | 134 ++++++++++++++++++++++++++++++++++++
 block/cfq-iosched.c                 |  14 ++++
 include/linux/blkdev.h              |   3 +
 8 files changed, 233 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2a3904030dea..2847219ebd8c 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -169,5 +169,18 @@ This is the number of bytes the device can write in a single write-same
 command.  A value of '0' means write-same is not supported by this
 device.
 
+wb_lat_usec (RW)
+----------------
+If the device is registered for writeback throttling, then this file shows
+the target minimum read latency. If this latency is exceeded in a given
+window of time (see wb_window_usec), then the writeback throttling will start
+scaling back writes.
+
+wb_window_usec (RW)
+-------------------
+If the device is registered for writeback throttling, then this file shows
+the value of the monitoring window in which we'll look at the target
+latency. See wb_lat_usec.
+
 
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/Kconfig b/block/Kconfig
index 6b0ad08f0677..9f5d4dd7d751 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -120,6 +120,30 @@ config BLK_CMDLINE_PARSER
 
 	See Documentation/block/cmdline-partition.txt for more information.
 
+config BLK_WBT
+	bool "Enable support for block device writeback throttling"
+	default n
+	---help---
+	Enabling this option enables the block layer to throttle buffered
+	writeback from the VM, making it more smooth and having less
+	impact on foreground operations.
+
+config BLK_WBT_SQ
+	bool "Single queue writeback throttling"
+	default n
+	depends on BLK_WBT
+	---help---
+	Enable writeback throttling by default on legacy single queue devices
+
+config BLK_WBT_MQ
+	bool "Multiqueue writeback throttling"
+	default y
+	depends on BLK_WBT
+	---help---
+	Enable writeback throttling by default on multiqueue devices.
+	Multiqueue currently doesn't have support for IO scheduling,
+	enabling this option is recommended.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/blk-core.c b/block/blk-core.c
index ca77c725b4e5..c68e92acf21a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -39,6 +39,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-wbt.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
@@ -882,6 +883,8 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
 
 fail:
 	blk_free_flush_queue(q->fq);
+	wbt_exit(q->rq_wb);
+	q->rq_wb = NULL;
 	return NULL;
 }
 EXPORT_SYMBOL(blk_init_allocated_queue);
@@ -1344,6 +1347,7 @@ void blk_requeue_request(struct request_queue *q, struct request *rq)
 	blk_delete_timer(rq);
 	blk_clear_rq_complete(rq);
 	trace_block_rq_requeue(q, rq);
+	wbt_requeue(q->rq_wb, &rq->issue_stat);
 
 	if (rq->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(q, rq);
@@ -1436,6 +1440,8 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	/* this is a bio leak */
 	WARN_ON(req->bio != NULL);
 
+	wbt_done(q->rq_wb, &req->issue_stat);
+
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
@@ -1663,6 +1669,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	int el_ret, where = ELEVATOR_INSERT_SORT;
 	struct request *req;
 	unsigned int request_count = 0;
+	unsigned int wb_acct;
 
 	/*
 	 * low level driver can indicate that it wants pages above a
@@ -1715,17 +1722,22 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	}
 
 get_rq:
+	wb_acct = wbt_wait(q->rq_wb, bio, q->queue_lock);
+
 	/*
 	 * Grab a free request. This is might sleep but can not fail.
 	 * Returns with the queue unlocked.
 	 */
 	req = get_request(q, bio->bi_opf, bio, GFP_NOIO);
 	if (IS_ERR(req)) {
+		__wbt_done(q->rq_wb, wb_acct);
 		bio->bi_error = PTR_ERR(req);
 		bio_endio(bio);
 		goto out_unlock;
 	}
 
+	wbt_track(&req->issue_stat, wb_acct);
+
 	/*
 	 * After dropping the lock and possibly sleeping here, our request
 	 * may now be mergeable after it had proven unmergeable (above).
@@ -2463,6 +2475,7 @@ void blk_start_request(struct request *req)
 	blk_dequeue_request(req);
 
 	blk_stat_set_issue_time(&req->issue_stat);
+	wbt_issue(req->q->rq_wb, &req->issue_stat);
 
 	/*
 	 * We are now handing the request to the hardware, initialize
@@ -2700,9 +2713,10 @@ void blk_finish_request(struct request *req, int error)
 
 	blk_account_io_done(req);
 
-	if (req->end_io)
+	if (req->end_io) {
+		wbt_done(req->q->rq_wb, &req->issue_stat);
 		req->end_io(req, error);
-	else {
+	} else {
 		if (blk_bidi_rq(req))
 			__blk_put_request(req->next_rq->q, req->next_rq);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4555a76d22a7..11e461c026dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -31,6 +31,7 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
+#include "blk-wbt.h"
 
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
@@ -299,6 +300,8 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
+
+	wbt_done(q->rq_wb, &rq->issue_stat);
 	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
@@ -327,6 +330,7 @@ inline void __blk_mq_end_request(struct request *rq, int error)
 	blk_account_io_done(rq);
 
 	if (rq->end_io) {
+		wbt_done(rq->q->rq_wb, &rq->issue_stat);
 		rq->end_io(rq, error);
 	} else {
 		if (unlikely(blk_bidi_rq(rq)))
@@ -434,6 +438,7 @@ void blk_mq_start_request(struct request *rq)
 		rq->next_rq->resid_len = blk_rq_bytes(rq->next_rq);
 
 	blk_stat_set_issue_time(&rq->issue_stat);
+	wbt_issue(q->rq_wb, &rq->issue_stat);
 
 	blk_add_timer(rq);
 
@@ -470,6 +475,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 	struct request_queue *q = rq->q;
 
 	trace_block_rq_requeue(q, rq);
+	wbt_requeue(q->rq_wb, &rq->issue_stat);
 
 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		if (q->dma_drain_size && blk_rq_bytes(rq))
@@ -1270,6 +1276,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
+	unsigned int wb_acct;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1284,9 +1291,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
 
+	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
+
 	rq = blk_mq_map_request(q, bio, &data);
-	if (unlikely(!rq))
+	if (unlikely(!rq)) {
+		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
+	}
+
+	wbt_track(&rq->issue_stat, wb_acct);
 
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
@@ -1363,6 +1376,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	struct blk_mq_alloc_data data;
 	struct request *rq;
 	blk_qc_t cookie;
+	unsigned int wb_acct;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1379,9 +1393,15 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	} else
 		request_count = blk_plug_queued_count(q);
 
+	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
+
 	rq = blk_mq_map_request(q, bio, &data);
-	if (unlikely(!rq))
+	if (unlikely(!rq)) {
+		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
+	}
+
+	wbt_track(&rq->issue_stat, wb_acct);
 
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
@@ -2052,6 +2072,9 @@ void blk_mq_free_queue(struct request_queue *q)
 	list_del_init(&q->all_q_node);
 	mutex_unlock(&all_q_mutex);
 
+	wbt_exit(q->rq_wb);
+	q->rq_wb = NULL;
+
 	blk_mq_del_queue_tag_set(q);
 
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9cf053759363..c7ccabc0ec3e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 
 #include "blk.h"
+#include "blk-wbt.h"
 
 unsigned long blk_max_low_pfn;
 EXPORT_SYMBOL(blk_max_low_pfn);
@@ -845,6 +846,7 @@ EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
 void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
 {
 	q->queue_depth = depth;
+	wbt_set_queue_depth(q->rq_wb, depth);
 }
 EXPORT_SYMBOL(blk_set_queue_depth);
 
@@ -868,6 +870,8 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 	else
 		queue_flag_clear(QUEUE_FLAG_FUA, q);
 	spin_unlock_irq(q->queue_lock);
+
+	wbt_set_write_cache(q->rq_wb, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5bb4648f434a..70644bf87582 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -13,6 +13,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-wbt.h"
 
 struct queue_sysfs_entry {
 	struct attribute attr;
@@ -41,6 +42,19 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 	return count;
 }
 
+static ssize_t queue_var_store64(u64 *var, const char *page)
+{
+	int err;
+	u64 v;
+
+	err = kstrtou64(page, 10, &v);
+	if (err < 0)
+		return err;
+
+	*var = v;
+	return 0;
+}
+
 static ssize_t queue_requests_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->nr_requests, (page));
@@ -364,6 +378,58 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	return ret;
 }
 
+static ssize_t queue_wb_win_show(struct request_queue *q, char *page)
+{
+	if (!q->rq_wb)
+		return -EINVAL;
+
+	return sprintf(page, "%llu\n", div_u64(q->rq_wb->win_nsec, 1000));
+}
+
+static ssize_t queue_wb_win_store(struct request_queue *q, const char *page,
+				  size_t count)
+{
+	ssize_t ret;
+	u64 val;
+
+	if (!q->rq_wb)
+		return -EINVAL;
+
+	ret = queue_var_store64(&val, page);
+	if (ret < 0)
+		return ret;
+
+	q->rq_wb->win_nsec = val * 1000ULL;
+	wbt_update_limits(q->rq_wb);
+	return count;
+}
+
+static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
+{
+	if (!q->rq_wb)
+		return -EINVAL;
+
+	return sprintf(page, "%llu\n", div_u64(q->rq_wb->min_lat_nsec, 1000));
+}
+
+static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
+				  size_t count)
+{
+	ssize_t ret;
+	u64 val;
+
+	if (!q->rq_wb)
+		return -EINVAL;
+
+	ret = queue_var_store64(&val, page);
+	if (ret < 0)
+		return ret;
+
+	q->rq_wb->min_lat_nsec = val * 1000ULL;
+	wbt_update_limits(q->rq_wb);
+	return count;
+}
+
 static ssize_t queue_wc_show(struct request_queue *q, char *page)
 {
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
@@ -578,6 +644,18 @@ static struct queue_sysfs_entry queue_stats_entry = {
 	.show = queue_stats_show,
 };
 
+static struct queue_sysfs_entry queue_wb_lat_entry = {
+	.attr = {.name = "wbt_lat_usec", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_wb_lat_show,
+	.store = queue_wb_lat_store,
+};
+
+static struct queue_sysfs_entry queue_wb_win_entry = {
+	.attr = {.name = "wbt_window_usec", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_wb_win_show,
+	.store = queue_wb_win_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -608,6 +686,8 @@ static struct attribute *default_attrs[] = {
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
 	&queue_stats_entry.attr,
+	&queue_wb_lat_entry.attr,
+	&queue_wb_win_entry.attr,
 	NULL,
 };
 
@@ -722,6 +802,58 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
+static void blk_wb_stat_get(void *data, struct blk_rq_stat *stat)
+{
+	blk_queue_stat_get(data, stat);
+}
+
+static void blk_wb_stat_clear(void *data)
+{
+	blk_stat_clear(data);
+}
+
+static bool blk_wb_stat_is_current(struct blk_rq_stat *stat)
+{
+	return blk_stat_is_current(stat);
+}
+
+static struct wb_stat_ops wb_stat_ops = {
+	.get		= blk_wb_stat_get,
+	.is_current	= blk_wb_stat_is_current,
+	.clear		= blk_wb_stat_clear,
+};
+
+static void blk_wb_init(struct request_queue *q)
+{
+	struct rq_wb *rwb;
+
+#ifndef CONFIG_BLK_WBT_MQ
+	if (q->mq_ops)
+		return;
+#endif
+#ifndef CONFIG_BLK_WBT_SQ
+	if (q->request_fn)
+		return;
+#endif
+
+	rwb = wbt_init(&q->backing_dev_info, &wb_stat_ops, q);
+
+	/*
+	 * If this fails, we don't get throttling
+	 */
+	if (IS_ERR_OR_NULL(rwb))
+		return;
+
+	if (blk_queue_nonrot(q))
+		rwb->min_lat_nsec = 2000000ULL;
+	else
+		rwb->min_lat_nsec = 75000000ULL;
+
+	wbt_set_queue_depth(rwb, blk_queue_depth(q));
+	wbt_set_write_cache(rwb, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+	q->rq_wb = rwb;
+}
+
 int blk_register_queue(struct gendisk *disk)
 {
 	int ret;
@@ -761,6 +893,8 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->mq_ops)
 		blk_mq_register_dev(dev, q);
 
+	blk_wb_init(q);
+
 	if (!q->request_fn)
 		return 0;
 
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index dcbed8c9c82c..0ef5ef5b5ed2 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -16,6 +16,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-cgroup.h>
 #include "blk.h"
+#include "blk-wbt.h"
 
 /*
  * tunables
@@ -3762,9 +3763,11 @@ static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 	struct cfq_data *cfqd = cic_to_cfqd(cic);
 	struct cfq_queue *cfqq;
 	uint64_t serial_nr;
+	bool nonroot_cg;
 
 	rcu_read_lock();
 	serial_nr = bio_blkcg(bio)->css.serial_nr;
+	nonroot_cg = bio_blkcg(bio) != &blkcg_root;
 	rcu_read_unlock();
 
 	/*
@@ -3775,6 +3778,17 @@ static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 		return;
 
 	/*
+	 * If we have a non-root cgroup, we can depend on that to
+	 * do proper throttling of writes. Turn off wbt for that
+	 * case.
+	 */
+	if (nonroot_cg) {
+		struct request_queue *q = cfqd->queue;
+
+		wbt_disable(q->rq_wb);
+	}
+
+	/*
 	 * Drop reference to queues.  New queues will be assigned in new
 	 * group upon arrival of fresh requests.
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6bd5eb56894e..294ee64e7f06 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -38,6 +38,7 @@ struct bsg_job;
 struct blkcg_gq;
 struct blk_flush_queue;
 struct pr_ops;
+struct rq_wb;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -381,6 +382,8 @@ struct request_queue {
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
+	struct rq_wb		*rq_wb;
+
 	/*
 	 * If blkcg is not used, @q->root_rl serves all requests.  If blkcg
 	 * is used, root blkg allocates from @q->root_rl and all other
-- 
2.7.4
