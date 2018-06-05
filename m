Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: michaelcallahan@fb.com,
	newella@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] blkcg: Track DISCARD statistics and output them in cgroup io.stat
Date: Tue,  5 Jun 2018 11:01:20 -0700
Message-Id: <20180605180120.2726113-7-tj@kernel.org>
In-Reply-To: <20180605180120.2726113-1-tj@kernel.org>
References: <20180605180120.2726113-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Add tracking of REQ_OP_DISCARD ios to the per-cgroup io.stat.  Two
fields, dbytes and dios, to respectively count the total bytes and
number of discards are added.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
Cc: Michael Callahan <michaelcallahan@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 block/blk-cgroup.c                      | 14 ++++++++++----
 include/linux/blk-cgroup.h              |  5 ++++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 74cdeae..7f7a161 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1263,17 +1263,19 @@ IO Interface Files
 	Lines are keyed by $MAJ:$MIN device numbers and not ordered.
 	The following nested keys are defined.
 
-	  ======	===================
+	  ======	=====================
 	  rbytes	Bytes read
 	  wbytes	Bytes written
 	  rios		Number of read IOs
 	  wios		Number of write IOs
-	  ======	===================
+	  dbytes	Bytes discarded
+	  dios		Number of discard IOs
+	  ======	=====================
 
 	An example read output follows:
 
-	  8:16 rbytes=1459200 wbytes=314773504 rios=192 wios=353
-	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252
+	  8:16 rbytes=1459200 wbytes=314773504 rios=192 wios=353 dbytes=0 dios=0
+	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252 dbytes=50331648 dios=3021
 
   io.weight
 	A read-write flat-keyed file which exists on non-root cgroups.
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb8..513d1ea 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -564,6 +564,7 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		[BLKG_RWSTAT_WRITE]	= "Write",
 		[BLKG_RWSTAT_SYNC]	= "Sync",
 		[BLKG_RWSTAT_ASYNC]	= "Async",
+		[BLKG_RWSTAT_DISCARD]	= "Discard",
 	};
 	const char *dname = blkg_dev_name(pd->blkg);
 	u64 v;
@@ -577,7 +578,8 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			   (unsigned long long)atomic64_read(&rwstat->aux_cnt[i]));
 
 	v = atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_WRITE]);
+		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_WRITE]) +
+		atomic64_read(&rwstat->aux_cnt[BLKG_RWSTAT_DISCARD]);
 	seq_printf(sf, "%s Total %llu\n", dname, (unsigned long long)v);
 	return v;
 }
@@ -955,7 +957,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		const char *dname;
 		struct blkg_rwstat rwstat;
-		u64 rbytes, wbytes, rios, wios;
+		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 
 		dname = blkg_dev_name(blkg);
 		if (!dname)
@@ -967,17 +969,21 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 					offsetof(struct blkcg_gq, stat_bytes));
 		rbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
+		dbytes = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
 		rwstat = blkg_rwstat_recursive_sum(blkg, NULL,
 					offsetof(struct blkcg_gq, stat_ios));
 		rios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_READ]);
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
+		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
 		spin_unlock_irq(blkg->q->queue_lock);
 
 		if (rbytes || wbytes || rios || wios)
-			seq_printf(sf, "%s rbytes=%llu wbytes=%llu rios=%llu wios=%llu\n",
-				   dname, rbytes, wbytes, rios, wios);
+			seq_printf(sf, "%s rbytes=%llu wbytes=%llu "
+				   "rios=%llu wios=%llu dbytes=%llu dios=%llu\n",
+				   dname, rbytes, wbytes, rios, wios,
+				   dbytes, dios);
 	}
 
 	rcu_read_unlock();
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd..bdb5c58d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -35,6 +35,7 @@ enum blkg_rwstat_type {
 	BLKG_RWSTAT_WRITE,
 	BLKG_RWSTAT_SYNC,
 	BLKG_RWSTAT_ASYNC,
+	BLKG_RWSTAT_DISCARD,
 
 	BLKG_RWSTAT_NR,
 	BLKG_RWSTAT_TOTAL = BLKG_RWSTAT_NR,
@@ -589,7 +590,9 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
 {
 	struct percpu_counter *cnt;
 
-	if (op_is_write(op))
+	if (op_is_discard(op))
+		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_DISCARD];
+	else if (op_is_write(op))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_WRITE];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_READ];
-- 
2.9.5
