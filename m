Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/14] blk-stat: export helpers for modifying blk_rq_stat
Date: Tue,  3 Jul 2018 11:14:57 -0400
Message-Id: <20180703151503.2549-9-josef@toxicpanda.com>
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We need to use blk_rq_stat in the blkcg qos stuff, so export some of
these helpers so they can be used by other things.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-stat.c | 16 ++++++++--------
 block/blk-stat.h |  4 ++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 175c143ac5b9..7587b1c3caaf 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -17,7 +17,7 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-static void blk_stat_init(struct blk_rq_stat *stat)
+void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
@@ -25,7 +25,7 @@ static void blk_stat_init(struct blk_rq_stat *stat)
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
-static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
 	if (!src->nr_samples)
 		return;
@@ -39,7 +39,7 @@ static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
@@ -69,7 +69,7 @@ void blk_stat_add(struct request *rq, u64 now)
 			continue;
 
 		stat = &get_cpu_ptr(cb->cpu_stat)[bucket];
-		__blk_stat_add(stat, value);
+		blk_rq_stat_add(stat, value);
 		put_cpu_ptr(cb->cpu_stat);
 	}
 	rcu_read_unlock();
@@ -82,15 +82,15 @@ static void blk_stat_timer_fn(struct timer_list *t)
 	int cpu;
 
 	for (bucket = 0; bucket < cb->buckets; bucket++)
-		blk_stat_init(&cb->stat[bucket]);
+		blk_rq_stat_init(&cb->stat[bucket]);
 
 	for_each_online_cpu(cpu) {
 		struct blk_rq_stat *cpu_stat;
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++) {
-			blk_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
-			blk_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
+			blk_rq_stat_init(&cpu_stat[bucket]);
 		}
 	}
 
@@ -143,7 +143,7 @@ void blk_stat_add_callback(struct request_queue *q,
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++)
-			blk_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_init(&cpu_stat[bucket]);
 	}
 
 	spin_lock(&q->stats->lock);
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 78399cdde9c9..f4a1568e81a4 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -159,4 +159,8 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
+void blk_rq_stat_add(struct blk_rq_stat *, u64);
+void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
+void blk_rq_stat_init(struct blk_rq_stat *);
+
 #endif
-- 
2.14.3
