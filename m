Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55599 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739AbcEJWJb (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 18:09:31 -0400
From: Michael Callahan <michaelcallahan@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@fb.com>, <coder.callahan@gmail.com>
Subject: [PATCH 1/1] block: Use per-cpu partition in_flight counters.
Date: Tue, 10 May 2016 18:09:19 -0400
Message-ID: <tc260ulmupc.fsf@vmbox.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Move the partition in_flight counters from hd_struct to disk_stats so
that they become tracked on a per-cpu basis.

Sign-off-by: Michael Callahan <michaelcallahan@fb.com>
---

This patch is incomplete as it just comments out use of in_flight in dm.c as
that code tracks io statistics in it's own special way.  Any thoughts on
how to fix dm.c are welcome.

---
diff --git a/block/bio.c b/block/bio.c
index 807d25e..35d185f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1686,7 +1686,7 @@ void generic_start_io_acct(int rw, unsigned long sectors,
 	part_round_stats(cpu, part);
 	part_stat_inc(cpu, part, ios[rw]);
 	part_stat_add(cpu, part, sectors[rw], sectors);
-	part_inc_in_flight(part, rw);
+	part_inc_in_flight(cpu, part, rw);
 
 	part_stat_unlock();
 }
@@ -1700,7 +1700,7 @@ void generic_end_io_acct(int rw, struct hd_struct *part,
 
 	part_stat_add(cpu, part, ticks[rw], duration);
 	part_round_stats(cpu, part);
-	part_dec_in_flight(part, rw);
+	part_dec_in_flight(cpu, part, rw);
 
 	part_stat_unlock();
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index b60537b..b8656a0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2303,7 +2303,7 @@ void blk_account_io_done(struct request *req)
 		part_stat_inc(cpu, part, ios[rw]);
 		part_stat_add(cpu, part, ticks[rw], duration);
 		part_round_stats(cpu, part);
-		part_dec_in_flight(part, rw);
+		part_dec_in_flight(cpu, part, rw);
 
 		hd_struct_put(part);
 		part_stat_unlock();
@@ -2361,7 +2361,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			hd_struct_get(part);
 		}
 		part_round_stats(cpu, part);
-		part_inc_in_flight(part, rw);
+		part_inc_in_flight(cpu, part, rw);
 		rq->part = part;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2613531..f564c5d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -633,7 +633,7 @@ static void blk_account_io_merge(struct request *req)
 		part = req->part;
 
 		part_round_stats(cpu, part);
-		part_dec_in_flight(part, rq_data_dir(req));
+		part_dec_in_flight(cpu, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
diff --git a/block/partition-generic.c b/block/partition-generic.c
index d7eb77e..7054d5d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -141,8 +141,8 @@ ssize_t part_inflight_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%8u %8u\n", atomic_read(&p->in_flight[0]),
-		atomic_read(&p->in_flight[1]));
+	return sprintf(buf, "%8u %8u\n", part_stat_read(p, in_flight[0]),
+		part_stat_read(p, in_flight[1]));
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3d3ac13..620d755 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -719,8 +719,6 @@ static void start_io_acct(struct dm_io *io)
 	cpu = part_stat_lock();
 	part_round_stats(cpu, &dm_disk(md)->part0);
 	part_stat_unlock();
-	atomic_set(&dm_disk(md)->part0.in_flight[rw],
-		atomic_inc_return(&md->pending[rw]));
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio->bi_rw, bio->bi_iter.bi_sector,
@@ -746,7 +744,6 @@ static void end_io_acct(struct dm_io *io)
 	 * a flush.
 	 */
 	pending = atomic_dec_return(&md->pending[rw]);
-	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
 	pending += atomic_read(&md->pending[rw^0x1]);
 
 	/* nudge anyone waiting on suspend queue */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5c70676..73a1e7e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -84,6 +84,7 @@ struct disk_stats {
 	unsigned long ios[2];
 	unsigned long merges[2];
 	unsigned long ticks[2];
+	unsigned long in_flight[2];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 };
@@ -119,7 +120,6 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	unsigned long stamp;
-	atomic_t in_flight[2];
 #ifdef	CONFIG_SMP
 	struct disk_stats __percpu *dkstats;
 #else
@@ -395,23 +395,24 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(cpu, gendiskp, field, subnd)			\
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
-static inline void part_inc_in_flight(struct hd_struct *part, int rw)
+static inline void part_inc_in_flight(int cpu, struct hd_struct *part, int rw)
 {
-	atomic_inc(&part->in_flight[rw]);
+	part_stat_inc(cpu, part, in_flight[rw]);
 	if (part->partno)
-		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
+		part_stat_inc(cpu, &part_to_disk(part)->part0, in_flight[rw]);
 }
 
-static inline void part_dec_in_flight(struct hd_struct *part, int rw)
+static inline void part_dec_in_flight(int cpu, struct hd_struct *part, int rw)
 {
-	atomic_dec(&part->in_flight[rw]);
+	part_stat_dec(cpu, part, in_flight[rw]);
 	if (part->partno)
-		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
+		part_stat_dec(cpu, &part_to_disk(part)->part0, in_flight[rw]);
 }
 
 static inline int part_in_flight(struct hd_struct *part)
 {
-	return atomic_read(&part->in_flight[0]) + atomic_read(&part->in_flight[1]);
+	return part_stat_read(part, in_flight[0]) +
+		part_stat_read(part, in_flight[1]);
 }
 
 static inline struct partition_meta_info *alloc_part_info(struct gendisk *disk)
