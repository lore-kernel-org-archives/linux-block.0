Return-Path: <huijin.park@samsung.com>
From: Huijin Park <huijin.park@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Huijin Park
	<huijin.park@samsung.com>, js07.lee@samsung.com, bbanghj.park@gmail.com
Subject: [PATCH] genhd: incrase size of disk stat counters
Date: Mon, 30 Jul 2018 07:43:10 -0400
Message-id: <1532950990-1657-1-git-send-email-huijin.park@samsung.com>
References: <CGME20180730114602eucas1p14b7cd9e90df341d88fa5d97ec74f005a@eucas1p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>

From: "huijin.park" <huijin.park@samsung.com>

The kernel's representation of the disk statistics uses different size
on 32b and 64b platforms. But the data size of io is not different
between 32b and 64b platforms. So in the 32b platform, it might happen
overflow earlier than 64b platform. Therefore, it seems like a better
approach would be to extend the length of the disk_stats structure on
32b architectures to 64b.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 block/genhd.c             |   28 +++++++++++++++++++---------
 block/partition-generic.c |   31 +++++++++++++++++++------------
 include/linux/genhd.h     |   12 ++++++------
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a3..3e6d0c2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1334,27 +1334,37 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
-			   "%u %u %u "
-			   "%lu %lu %lu %u\n",
+			   "%llu %llu %llu %llu "
+			   "%llu %llu %llu %llu "
+			   "%u %llu %llu "
+			   "%llu %llu %llu %llu\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
 			   part_stat_read(hd, merges[STAT_READ]),
 			   part_stat_read(hd, sectors[STAT_READ]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_READ])),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_READ])),
+				   NSEC_PER_MSEC),
 			   part_stat_read(hd, ios[STAT_WRITE]),
 			   part_stat_read(hd, merges[STAT_WRITE]),
 			   part_stat_read(hd, sectors[STAT_WRITE]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_WRITE])),
+				   NSEC_PER_MSEC),
 			   inflight[0],
-			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
-			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							io_ticks)),
+				   NSEC_PER_MSEC),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							time_in_queue)),
+				   NSEC_PER_MSEC),
 			   part_stat_read(hd, ios[STAT_DISCARD]),
 			   part_stat_read(hd, merges[STAT_DISCARD]),
 			   part_stat_read(hd, sectors[STAT_DISCARD]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_DISCARD]))
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_DISCARD])),
+				   NSEC_PER_MSEC)
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5a8975a..108b473 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -128,26 +128,33 @@ ssize_t part_stat_show(struct device *dev,
 	part_stat_unlock();
 	part_in_flight(q, p, inflight);
 	return sprintf(buf,
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u"
+		"%8llu %8llu %8llu %8llu "
+		"%8llu %8llu %8llu %8llu "
+		"%8u %8llu %8llu "
+		"%8llu %8llu %8llu %8llu"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_READ])),
+		part_stat_read(p, sectors[STAT_READ]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, ticks[STAT_READ])),
+			NSEC_PER_MSEC),
 		part_stat_read(p, ios[STAT_WRITE]),
 		part_stat_read(p, merges[STAT_WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
+		part_stat_read(p, sectors[STAT_WRITE]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p,
+							  ticks[STAT_WRITE])),
+			NSEC_PER_MSEC),
 		inflight[0],
-		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, io_ticks)),
+			NSEC_PER_MSEC),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, time_in_queue)),
+			NSEC_PER_MSEC),
 		part_stat_read(p, ios[STAT_DISCARD]),
 		part_stat_read(p, merges[STAT_DISCARD]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_DISCARD])));
+		part_stat_read(p, sectors[STAT_DISCARD]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p,
+							  ticks[STAT_DISCARD])),
+			NSEC_PER_MSEC));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5786442..d4cb798 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -83,12 +83,12 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[NR_STAT_GROUPS];
-	unsigned long ios[NR_STAT_GROUPS];
-	unsigned long merges[NR_STAT_GROUPS];
-	unsigned long ticks[NR_STAT_GROUPS];
-	unsigned long io_ticks;
-	unsigned long time_in_queue;
+	unsigned long long sectors[NR_STAT_GROUPS];
+	unsigned long long ios[NR_STAT_GROUPS];
+	unsigned long long merges[NR_STAT_GROUPS];
+	unsigned long long ticks[NR_STAT_GROUPS];
+	unsigned long long io_ticks;
+	unsigned long long time_in_queue;
 };
 
 #define PARTITION_META_INFO_VOLNAMELTH	64
-- 
1.7.9.5
