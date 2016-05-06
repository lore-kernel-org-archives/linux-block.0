Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63463 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758812AbcEFWDI (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 6 May 2016 18:03:08 -0400
From: Michael Callahan <michaelcallahan@fb.com>
To: <linux-block@vger.kernel.org>
CC: <coder.callahan@gmail.com>, <axboe@fb.com>
Subject: [PATCH 4/4] block: Track DISCARD statistics and output them in stat and diskstat
Date: Fri, 6 May 2016 18:02:55 -0400
Message-ID: <tc2bn4in8ts.fsf@vmbox.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add tracking of REQ_DISCARD ios to the partition statistics and append
them to the various stat files in /sys as well as /proc/diskstats.
These are tracked with the same four stats as reads and writes:

Number of discard ios completed.
Number of discard ios merged
Number of discard sectors completed
Milliseconds spent on discard requests

This is done via adding a new STAT_DISCARD define to genhd.h and then
using it to index that stat field for discard requests.

Sign-off-by: Michael Callahan <michaelcallahan@fb.com>

 Documentation/ABI/testing/procfs-diskstats | 10 ++++++++++
 Documentation/block/stat.txt               | 28 ++++++++++++++++------------
 Documentation/iostats.txt                  | 15 ++++++++++++++-
 block/genhd.c                              | 14 +++++++++++---
 block/partition-generic.c                  |  9 +++++++--
 include/linux/genhd.h                      | 16 ++++++++++------
 6 files changed, 68 insertions(+), 24 deletions(-)
---
diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index f91a973..0a5c005 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -5,6 +5,7 @@ Description:
 		The /proc/diskstats file displays the I/O statistics
 		of block devices. Each line contains the following 14
 		fields:
+
 		 1 - major number
 		 2 - minor mumber
 		 3 - device name
@@ -19,4 +20,13 @@ Description:
 		12 - I/Os currently in progress
 		13 - time spent doing I/Os (ms)
 		14 - weighted time spent doing I/Os (ms)
+
+		Kernel 4.7 appends four more fields for discard tracking
+		putting the total at 18:
+
+		15 - discards completed successfully
+		16 - discards merged
+		17 - sectors discarded
+		18 - time spent discarding
+
 		For more details refer to Documentation/iostats.txt
diff --git a/Documentation/block/stat.txt b/Documentation/block/stat.txt
index 0dbc946..0aace9c 100644
--- a/Documentation/block/stat.txt
+++ b/Documentation/block/stat.txt
@@ -31,28 +31,32 @@ write ticks     milliseconds  total wait time for write requests
 in_flight       requests      number of I/Os currently in flight
 io_ticks        milliseconds  total time this block device has been active
 time_in_queue   milliseconds  total wait time for all requests
+discard I/Os    requests      number of discard I/Os processed
+discard merges  requests      number of discard I/Os merged with in-queue I/O
+discard sectors sectors       number of sectors discarded
+discard ticks   milliseconds  total wait time for discard requests
 
-read I/Os, write I/Os
-=====================
+read I/Os, write I/Os, discard I/0s
+===================================
 
 These values increment when an I/O request completes.
 
-read merges, write merges
-=========================
+read merges, write merges, discard merges
+=========================================
 
 These values increment when an I/O request is merged with an
 already-queued I/O request.
 
-read sectors, write sectors
-===========================
+read sectors, write sectors, discard_sectors
+============================================
 
-These values count the number of sectors read from or written to this
-block device.  The "sectors" in question are the standard UNIX 512-byte
-sectors, not any device- or filesystem-specific block size.  The
-counters are incremented when the I/O completes.
+These values count the number of sectors read from, written to, or
+discarded from this block device.  The "sectors" in question are the
+standard UNIX 512-byte sectors, not any device- or filesystem-specific
+block size.  The counters are incremented when the I/O completes.
 
-read ticks, write ticks
-=======================
+read ticks, write ticks, discard ticks
+======================================
 
 These values count the number of milliseconds that I/O requests have
 waited on this block device.  If there are multiple I/O requests waiting,
diff --git a/Documentation/iostats.txt b/Documentation/iostats.txt
index 65f694f..7b9609e 100644
--- a/Documentation/iostats.txt
+++ b/Documentation/iostats.txt
@@ -22,7 +22,6 @@ Here are examples of these different formats:
    3     0   39082680 hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
    3     1    9221278 hda1 35486 0 35496 38030 0 0 0 0 0 38030 38030
 
-
 2.6 sysfs:
    446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
    35486    38030    38030    38030
@@ -31,6 +30,9 @@ Here are examples of these different formats:
    3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
    3    1   hda1 35486 38030 38030 38030
 
+4.7 diskstats:
+   3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0
+
 On 2.4 you might execute "grep 'hda ' /proc/partitions". On 2.6, you have
 a choice of "cat /sys/block/hda/stat" or "grep 'hda ' /proc/diskstats".
 The advantage of one over the other is that the sysfs choice works well
@@ -90,6 +92,17 @@ Field 11 -- weighted # of milliseconds spent doing I/Os
     last update of this field.  This can provide an easy measure of both
     I/O completion time and the backlog that may be accumulating.
 
+In 4.7 appends the following four fields for discard tracking:
+
+Field 12 -- # of discards completed
+    This is the total number of discards completed successfully.
+Field 13 -- # of discards merged
+    See the description of field 2
+Field 14 -- # of sectors discarded
+    This is the total number of sectors discarded successfully.
+Field 15 -- # of milliseconds spent discarding
+    This is the total number of milliseconds spent by all discards (as
+    measured from __make_request() to end_that_request_last()).
 
 To avoid introducing performance bottlenecks, no locks are held while
 modifying these counters.  This implies that minor inaccuracies may be
diff --git a/block/genhd.c b/block/genhd.c
index b6f1dee..1b558dc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1195,8 +1195,12 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		cpu = part_stat_lock();
 		part_round_stats(cpu, hd);
 		part_stat_unlock();
-		seq_printf(seqf, "%4d %7d %s %lu %lu %lu "
-			   "%u %lu %lu %lu %u %u %u %u\n",
+		seq_printf(seqf, "%4d %7d %s "
+			   "%lu %lu %lu %u "
+			   "%lu %lu %lu %u "
+			   "%u %u %u "
+			   "%lu %lu %lu %u"
+			   "\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
@@ -1209,7 +1213,11 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
 			   part_in_flight(hd),
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
-			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
+			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
+			   part_stat_read(hd, ios[STAT_DISCARD]),
+			   part_stat_read(hd, merges[STAT_DISCARD]),
+			   part_stat_read(hd, sectors[STAT_DISCARD]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_DISCARD]))
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 15bf298..0f18368 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -121,7 +121,8 @@ ssize_t part_stat_show(struct device *dev,
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u"
+		"%8u %8u %8u "
+		"%8lu %8lu %8llu %8u"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
@@ -133,7 +134,11 @@ ssize_t part_stat_show(struct device *dev,
 		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
 		part_in_flight(p),
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
+		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
+		part_stat_read(p, ios[STAT_DISCARD]),
+		part_stat_read(p, merges[STAT_DISCARD]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_DISCARD])));
 }
 
 ssize_t part_inflight_show(struct device *dev,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ab31525..466c36e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -61,6 +61,7 @@ enum {
 
 #define STAT_READ			0
 #define STAT_WRITE			1
+#define STAT_DISCARD			2
 
 #include <linux/major.h>
 #include <linux/device.h>
@@ -83,10 +84,10 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[2];	/* STAT_READs and STAT_WRITEs */
-	unsigned long ios[2];
-	unsigned long merges[2];
-	unsigned long ticks[2];
+	unsigned long sectors[3];	/* STAT_READ, STAT_WRITE, STAT_DISCARD */
+	unsigned long ios[3];
+	unsigned long merges[3];
+	unsigned long ticks[3];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 };
@@ -386,7 +387,8 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #define part_stat_read_accum(part, field)				\
 	(part_stat_read(part, field[STAT_READ]) +			\
-	 part_stat_read(part, field[STAT_WRITE]))
+	 part_stat_read(part, field[STAT_WRITE]) +			\
+	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
@@ -436,11 +438,13 @@ static inline void free_part_info(struct hd_struct *part)
 
 static inline int rw_stat_group(unsigned int rw_flags)
 {
+	if (rw_flags & REQ_DISCARD)
+		return STAT_DISCARD;
 	return rw_flags & 1;
 }
 
 #define stat_group_to_rw(sgrp)						\
-	(sgrp)
+	(!!(sgrp))
 
 /* block/blk-core.c */
 extern void part_round_stats(int cpu, struct hd_struct *part);
