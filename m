Return-Path: <SRS0=uvfw=BG=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 3/3] blockcg: export latency info for each cgroup
Date: Fri,  6 Oct 2017 17:56:01 -0700
Message-Id: <c8b704eb77e0b8d1792cde7ca1fefcca09b7684f.1507337347.git.shli@fb.com>
In-Reply-To: <cover.1507337347.git.shli@fb.com>
References: <cover.1507337347.git.shli@fb.com>
In-Reply-To: <cover.1507337347.git.shli@fb.com>
References: <cover.1507337347.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Export the latency info to user. The latency is a good sign to indicate
if IO is congested or not. User can use the info to make decisions like
adjust cgroup settings.

Existing io.stat shows accumulated IO bytes and requests, but
accumulated value for latency doesn't make much sense. This patch
exports the latency info in a 100ms interval.

To reduce overhead, latency info of children is propagated to parents
every 10ms. This means the parents's latency could lost 10ms info of its
children in 100ms. This should be ok, as we don't need precise latency
info.

A micro benchmark running fio test against null_blk in a sixth level
cgroup doesn't show obvious regression. perf shows a little bit overhead
in blk_stat_add (~1%) and blkg_lookup (~1%), which is unavoidable right
now.

With this patch, the io.stat will show:
8:0 rbytes=7282688 wbytes=0 rios=83 wios=0 rlat_mean=2720 rlat_min=183 rlat_max=14880 wlat_mean=0 wlat_min=0 wlat_max=0
The new fields will display read/write average/minimum/maximum latency
within 100ms. The latency is us.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-cgroup.c         |  29 +++++++++-
 block/blk-stat.c           | 135 ++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h                |   5 ++
 include/linux/blk-cgroup.h |   9 +++
 4 files changed, 175 insertions(+), 3 deletions(-)

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
index 3a2f3c9..12fd356 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/rculist.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-cgroup.h>
 
 #include "blk-stat.h"
 #include "blk-mq.h"
@@ -47,6 +48,135 @@ static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
 	stat->nr_samples++;
 }
 
+#ifdef CONFIG_BLK_CGROUP
+#define BLKCG_FLUSH_WINDOW (1000 * 1000 * 100)
+#define BLKCG_PROPAGATE_WINDOW (1000 * 1000 * 10)
+static void blkg_rq_stat_flush_percpu(struct blkcg_gq *blkg, u64 now)
+{
+	int cpu;
+
+	if (now < blkg->rq_stat.last_flush_time + BLKCG_FLUSH_WINDOW)
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
+static void blkg_rq_stat_propagate(struct blkcg_gq *blkg, int dir, u64 value,
+	u64 now)
+{
+	struct blkcg_gq *parent;
+	struct blk_rq_stat *prop_stat;
+	u64 *prop_time;
+
+	prop_stat = &this_cpu_ptr(blkg->rq_stat.cpu_propagate_stat)[dir];
+	prop_time = this_cpu_ptr(blkg->rq_stat.cpu_propagate_time);
+
+	__blk_stat_add(prop_stat, value);
+
+	if (now < *prop_time + BLKCG_PROPAGATE_WINDOW)
+		return;
+
+	prop_stat = this_cpu_ptr(blkg->rq_stat.cpu_propagate_stat);
+	parent = blkg->parent;
+	while (parent) {
+		struct blk_rq_stat *pstat;
+
+		pstat = this_cpu_ptr(parent->rq_stat.cpu_stat);
+		pstat[0].min = min(prop_stat[0].min, pstat[0].min);
+		pstat[1].min = min(prop_stat[1].min, pstat[1].min);
+		pstat[0].max = max(prop_stat[0].max, pstat[0].max);
+		pstat[1].max = max(prop_stat[1].max, pstat[1].max);
+		pstat[0].batch += prop_stat[0].batch;
+		pstat[1].batch += prop_stat[1].batch;
+		pstat[0].nr_samples += prop_stat[0].nr_samples;
+		pstat[1].nr_samples += prop_stat[1].nr_samples;
+
+		blkg_rq_stat_flush_percpu(parent, now);
+
+		parent = parent->parent;
+	}
+
+	*prop_time = now;
+	blk_stat_init(&prop_stat[0]);
+	blk_stat_init(&prop_stat[1]);
+}
+
+static void blkg_rq_stat_add(struct request *rq, u64 now, u64 value)
+{
+	struct blkcg_gq *blkg;
+	struct blk_rq_stat *stat;
+	int dir = rq_data_dir(rq);
+
+	if (!blk_rq_rl(rq))
+		return;
+	blkg = blk_rq_rl(rq)->blkg;
+
+	stat = get_cpu_ptr(blkg->rq_stat.cpu_stat);
+	__blk_stat_add(&stat[dir], value);
+	blkg_rq_stat_propagate(blkg, dir, value, now);
+	put_cpu_ptr(blkg->rq_stat.cpu_stat);
+
+	blkg_rq_stat_flush_percpu(blkg, now);
+}
+
+void blkg_rq_stat_exit(struct blkcg_gq *blkg)
+{
+	free_percpu(blkg->rq_stat.cpu_stat);
+	free_percpu(blkg->rq_stat.cpu_propagate_stat);
+	free_percpu(blkg->rq_stat.cpu_propagate_time);
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
+	blkg->rq_stat.cpu_propagate_stat =
+		__alloc_percpu_gfp(2 * sizeof(struct blk_rq_stat),
+		__alignof__(struct blk_rq_stat), gfp);
+	blkg->rq_stat.cpu_propagate_time = alloc_percpu_gfp(u64, gfp);
+	if (!blkg->rq_stat.cpu_stat || !blkg->rq_stat.cpu_propagate_stat ||
+	    !blkg->rq_stat.cpu_propagate_time) {
+		blkg_rq_stat_exit(blkg);
+		return -ENOMEM;
+	}
+	blk_stat_init(&blkg->rq_stat.stat[0]);
+	blk_stat_init(&blkg->rq_stat.stat[1]);
+	for_each_online_cpu(cpu) {
+		struct blk_rq_stat *cpu_stat;
+
+		cpu_stat = per_cpu_ptr(blkg->rq_stat.cpu_stat, cpu);
+		blk_stat_init(&cpu_stat[0]);
+		blk_stat_init(&cpu_stat[1]);
+		cpu_stat = per_cpu_ptr(blkg->rq_stat.cpu_propagate_stat, cpu);
+		blk_stat_init(&cpu_stat[0]);
+		blk_stat_init(&cpu_stat[1]);
+	}
+	return 0;
+}
+
+#else
+static void blkg_rq_stat_add(struct request *rq, u64 now, u64 value)
+{
+}
+#endif
+
 void blk_stat_add(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -54,8 +184,10 @@ void blk_stat_add(struct request *rq)
 	struct blk_rq_stat *stat;
 	int bucket;
 	u64 now, value;
+	u64 time;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	time = ktime_get_ns();
+	now = __blk_stat_time(time);
 	if (now < blk_stat_time(&rq->issue_stat))
 		return;
 
@@ -64,6 +196,7 @@ void blk_stat_add(struct request *rq)
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
index f57e54d..58f3d25 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -102,6 +102,14 @@ struct blkcg_policy_data {
 	int				plid;
 };
 
+struct blkcg_gq_rq_stat {
+	u64 last_flush_time;
+	struct blk_rq_stat stat[2];
+	struct blk_rq_stat __percpu *cpu_stat;
+	struct blk_rq_stat __percpu *cpu_propagate_stat;
+	u64 __percpu *cpu_propagate_time;
+};
+
 /* association between a blk cgroup and a request queue */
 struct blkcg_gq {
 	/* Pointer to the associated request_queue */
@@ -130,6 +138,7 @@ struct blkcg_gq {
 
 	struct blkg_rwstat		stat_bytes;
 	struct blkg_rwstat		stat_ios;
+	struct blkcg_gq_rq_stat		rq_stat;
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
-- 
2.9.5
