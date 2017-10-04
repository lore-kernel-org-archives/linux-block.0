Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [RFC 2/2] blockcg: export latency info for each cgroup
Date: Wed,  4 Oct 2017 10:41:20 -0700
Message-Id: <7f592647e6c30b6eb7cb1cef4892bca060a73d78.1507138530.git.shli@fb.com>
In-Reply-To: <cover.1507138530.git.shli@fb.com>
References: <cover.1507138530.git.shli@fb.com>
In-Reply-To: <cover.1507138530.git.shli@fb.com>
References: <cover.1507138530.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Export the latency info to user. The latency is a good sign to indicate
if IO is congested or not. User can use the info to make decisions like
adjust cgroup settings.

Existing io.stat shows accumulated IO bytes and requests, but
accumulated value for latency doesn't make much sense. This patch
exports the latency info in a 100ms interval.

A micro benchmark running fio test against null_blk in a third level
cgroup shows around 4% regression. If I only do the latency accouting
for leaf cgroup, the regression seems to disappear. So not quite sure if
we should do the accounting for intermediate nodes or if the whole thing
should be enabled optionally.

With this patch, the io.stat will show:
8:0 rbytes=7282688 wbytes=0 rios=83 wios=0 rlat_mean=2720 rlat_min=183 rlat_max=14880 wlat_mean=0 wlat_min=0 wlat_max=0
The new fields will display read/write average/minimum/maximum latency
within 100ms. The latency is us.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-cgroup.c         | 29 +++++++++++++-
 block/blk-stat.c           | 95 +++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h                |  5 +++
 include/linux/blk-cgroup.h |  7 ++++
 4 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d3f56ba..89c5075 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -78,6 +78,7 @@ static void blkg_free(struct blkcg_gq *blkg)
 
 	blkg_rwstat_exit(&blkg->stat_ios);
 	blkg_rwstat_exit(&blkg->stat_bytes);
+	blkg_rq_stat_exit(blkg);
 	kfree(blkg);
 }
 
@@ -104,6 +105,8 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	    blkg_rwstat_init(&blkg->stat_ios, gfp_mask))
 		goto err_free;
 
+	if (blkg_rq_stat_init(blkg, gfp_mask))
+		goto err_free;
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
@@ -952,6 +955,8 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		const char *dname;
 		struct blkg_rwstat rwstat;
 		u64 rbytes, wbytes, rios, wios;
+		u64 rmean = 0, rmin = 0, rmax = 0;
+		u64 wmean = 0, wmin = 0, wmax = 0;
 
 		dname = blkg_dev_name(blkg);
 		if (!dname)
@@ -969,11 +974,30 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		rios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
 
+		if (blkg->rq_stat.stat[0].nr_samples) {
+			rmean = blkg->rq_stat.stat[0].mean;
+			do_div(rmean, 1000);
+			rmin = blkg->rq_stat.stat[0].min;
+			do_div(rmin, 1000);
+			rmax = blkg->rq_stat.stat[0].max;
+			do_div(rmax, 1000);
+		}
+		if (blkg->rq_stat.stat[1].nr_samples) {
+			wmean = blkg->rq_stat.stat[1].mean;
+			do_div(wmean, 1000);
+			wmin = blkg->rq_stat.stat[1].min;
+			do_div(wmin, 1000);
+			wmax = blkg->rq_stat.stat[1].max;
+			do_div(wmax, 1000);
+		}
 		spin_unlock_irq(blkg->q->queue_lock);
 
 		if (rbytes || wbytes || rios || wios)
-			seq_printf(sf, "%s rbytes=%llu wbytes=%llu rios=%llu wios=%llu\n",
-				   dname, rbytes, wbytes, rios, wios);
+			seq_printf(sf, "%s rbytes=%llu wbytes=%llu rios=%llu wios=%llu "
+				   "rlat_mean=%llu rlat_min=%llu rlat_max=%llu "
+				   "wlat_mean=%llu wlat_min=%llu wlat_max=%llu\n",
+				   dname, rbytes, wbytes, rios, wios,
+				   rmean, rmin, rmax, wmean, wmin, wmax);
 	}
 
 	rcu_read_unlock();
@@ -1167,6 +1191,7 @@ int blkcg_init_queue(struct request_queue *q)
 		blkg_destroy_all(q);
 		spin_unlock_irq(q->queue_lock);
 	}
+	blk_stat_enable_accounting(q);
 	return ret;
 }
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index c52356d..f9b6b80 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/rculist.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-cgroup.h>
 
 #include "blk-stat.h"
 #include "blk-mq.h"
@@ -78,6 +79,95 @@ static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
 	stat->nr_batch++;
 }
 
+#ifdef CONFIG_BLK_CGROUP
+#define BLKCG_FLUSH_WINDOW (1000 * 1000 * 100)
+static void blkg_rq_stat_flush_percpu(struct blkcg_gq *blkg, u64 now)
+{
+	int cpu;
+
+	if (now <  blkg->rq_stat.last_flush_time + BLKCG_FLUSH_WINDOW)
+		return;
+	blkg->rq_stat.last_flush_time = now;
+
+	blk_stat_init(&blkg->rq_stat.stat[0]);
+	blk_stat_init(&blkg->rq_stat.stat[1]);
+
+	for_each_online_cpu(cpu) {
+		struct blk_rq_stat *cpu_stat;
+
+		cpu_stat = per_cpu_ptr(blkg->rq_stat.cpu_stat, cpu);
+		blk_stat_sum(&blkg->rq_stat.stat[0], &cpu_stat[0]);
+		blk_stat_init(&cpu_stat[0]);
+		blk_stat_sum(&blkg->rq_stat.stat[1], &cpu_stat[1]);
+		blk_stat_init(&cpu_stat[1]);
+	}
+}
+
+static void blkg_rq_stat_add(struct request *rq, u64 now, s64 value)
+{
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	struct request_queue *q = rq->q;
+	struct blk_rq_stat *stat;
+	int dir = rq_data_dir(rq);
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (!rq->css)
+		return;
+	blkcg = css_to_blkcg(rq->css);
+	blkg = blkg_lookup(blkcg, q);
+	if (!blkg)
+		return;
+
+	while (true) {
+		if (!blkg->rq_stat.cpu_stat)
+			return;
+		stat = get_cpu_ptr(blkg->rq_stat.cpu_stat);
+		__blk_stat_add(&stat[dir], value);
+		put_cpu_ptr(blkg->rq_stat.cpu_stat);
+
+		blkg_rq_stat_flush_percpu(blkg, now);
+
+		if (!blkg->parent)
+			return;
+		blkg = blkg->parent;
+	}
+}
+
+int blkg_rq_stat_init(struct blkcg_gq *blkg, gfp_t gfp)
+{
+	int cpu;
+
+	memset(&blkg->rq_stat, 0, sizeof(blkg->rq_stat));
+
+	blkg->rq_stat.cpu_stat =
+		__alloc_percpu_gfp(2 * sizeof(struct blk_rq_stat),
+		__alignof__(struct blk_rq_stat), gfp);
+	if (!blkg->rq_stat.cpu_stat)
+		return -ENOMEM;
+	blk_stat_init(&blkg->rq_stat.stat[0]);
+	blk_stat_init(&blkg->rq_stat.stat[1]);
+	for_each_online_cpu(cpu) {
+		struct blk_rq_stat *cpu_stat;
+
+		cpu_stat = per_cpu_ptr(blkg->rq_stat.cpu_stat, cpu);
+		blk_stat_init(&cpu_stat[0]);
+		blk_stat_init(&cpu_stat[1]);
+	}
+	return 0;
+}
+
+void blkg_rq_stat_exit(struct blkcg_gq *blkg)
+{
+	free_percpu(blkg->rq_stat.cpu_stat);
+}
+#else
+static void blkg_rq_stat_add(struct request *rq, s64 value)
+{
+}
+#endif
+
 void blk_stat_add(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -85,8 +175,10 @@ void blk_stat_add(struct request *rq)
 	struct blk_rq_stat *stat;
 	int bucket;
 	s64 now, value;
+	u64 time;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	time = ktime_get_ns();
+	now = __blk_stat_time(time);
 	if (now < blk_stat_time(&rq->issue_stat))
 		return;
 
@@ -95,6 +187,7 @@ void blk_stat_add(struct request *rq)
 	blk_throtl_stat_add(rq, value);
 
 	rcu_read_lock();
+	blkg_rq_stat_add(rq, time, value);
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
 		if (!blk_stat_is_active(cb))
 			continue;
diff --git a/block/blk.h b/block/blk.h
index fda5a46..4d76a971 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -309,6 +309,11 @@ static inline void blk_throtl_bio_endio(struct bio *bio) { }
 static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif
 
+#ifdef CONFIG_BLK_CGROUP
+extern int blkg_rq_stat_init(struct blkcg_gq *blkg, gfp_t gfp);
+extern void blkg_rq_stat_exit(struct blkcg_gq *blkg);
+#endif
+
 #ifdef CONFIG_BOUNCE
 extern int init_emergency_isa_pool(void);
 extern void blk_queue_bounce(struct request_queue *q, struct bio **bio);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f57e54d..5d4b68e 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -102,6 +102,12 @@ struct blkcg_policy_data {
 	int				plid;
 };
 
+struct blkcg_gq_rq_stat {
+	u64 last_flush_time;
+	struct blk_rq_stat stat[2];
+	struct blk_rq_stat __percpu *cpu_stat;
+};
+
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
 	/* Pointer to the associated request_queue */
@@ -130,6 +136,7 @@ struct blkcg_gq {
 
 	struct blkg_rwstat		stat_bytes;
 	struct blkg_rwstat		stat_ios;
+	struct blkcg_gq_rq_stat		rq_stat;
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
-- 
2.9.5
