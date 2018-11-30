Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8ADC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1E20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA1E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLAJdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C985309BFE2;
        Fri, 30 Nov 2018 22:22:37 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F8EA7C809;
        Fri, 30 Nov 2018 22:22:36 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 3/6] block: delete part_round_stats and switch to less precise counting
Date:   Fri, 30 Nov 2018 17:22:23 -0500
Message-Id: <20181130222226.77216-4-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Nov 2018 22:22:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

We want to convert to per-cpu in_flight counters.

The function part_round_stats needs the in_flight counter every jiffy, it
would be too costly to sum all the percpu variables every jiffy, so it
must be deleted. part_round_stats is used to calculate two counters -
time_in_queue and io_ticks.

time_in_queue can be calculated without part_round_stats, by adding the
duration of the I/O when the I/O ends (the value is almost as exact as the
previously calculated value, except that time for in-progress I/Os is not
counted).

io_ticks can be approximated by increasing the value when I/O is started
or ended and the jiffies value has changed. If the I/Os take less than a
jiffy, the value is as exact as the previously calculated value. If the
I/Os take more than a jiffy, io_ticks can drift behind the previously
calculated value.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/bio.c               | 24 +++++++++++++++---
 block/blk-core.c          | 63 +++--------------------------------------------
 block/blk-merge.c         |  1 -
 block/genhd.c             |  4 ---
 block/partition-generic.c |  4 ---
 include/linux/genhd.h     |  3 +--
 6 files changed, 26 insertions(+), 73 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 03895cc0d74a..d5ef043a97aa 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1663,13 +1663,29 @@ void bio_check_pages_dirty(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
+void update_io_ticks(int cpu, struct hd_struct *part, unsigned long now)
+{
+	unsigned long stamp;
+again:
+	stamp = READ_ONCE(part->stamp);
+	if (unlikely(stamp != now)) {
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
+			__part_stat_add(cpu, part, io_ticks, 1);
+		}
+	}
+	if (part->partno) {
+		part = &part_to_disk(part)->part0;
+		goto again;
+	}
+}
+
 void generic_start_io_acct(struct request_queue *q, int op,
 			   unsigned long sectors, struct hd_struct *part)
 {
 	const int sgrp = op_stat_group(op);
 	int cpu = part_stat_lock();
 
-	part_round_stats(q, cpu, part);
+	update_io_ticks(cpu, part, jiffies);
 	part_stat_inc(cpu, part, ios[sgrp]);
 	part_stat_add(cpu, part, sectors[sgrp], sectors);
 	part_inc_in_flight(q, part, op_is_write(op));
@@ -1681,12 +1697,14 @@ EXPORT_SYMBOL(generic_start_io_acct);
 void generic_end_io_acct(struct request_queue *q, int req_op,
 			 struct hd_struct *part, unsigned long start_time)
 {
-	unsigned long duration = jiffies - start_time;
+	unsigned long now = jiffies;
+	unsigned long duration = now - start_time;
 	const int sgrp = op_stat_group(req_op);
 	int cpu = part_stat_lock();
 
+	update_io_ticks(cpu, part, now);
 	part_stat_add(cpu, part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_round_stats(q, cpu, part);
+	part_stat_add(cpu, part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index 3f6f5e6c2fe4..6bd4669f05fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -583,63 +583,6 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_get_request);
 
-static void part_round_stats_single(struct request_queue *q, int cpu,
-				    struct hd_struct *part, unsigned long now,
-				    unsigned int inflight)
-{
-	if (inflight) {
-		__part_stat_add(cpu, part, time_in_queue,
-				inflight * (now - part->stamp));
-		__part_stat_add(cpu, part, io_ticks, (now - part->stamp));
-	}
-	part->stamp = now;
-}
-
-/**
- * part_round_stats() - Round off the performance stats on a struct disk_stats.
- * @q: target block queue
- * @cpu: cpu number for stats access
- * @part: target partition
- *
- * The average IO queue length and utilisation statistics are maintained
- * by observing the current state of the queue length and the amount of
- * time it has been in this state for.
- *
- * Normally, that accounting is done on IO completion, but that can result
- * in more than a second's worth of IO being accounted for within any one
- * second, leading to >100% utilisation.  To deal with that, we call this
- * function to do a round-off before returning the results when reading
- * /proc/diskstats.  This accounts immediately for all queue usage up to
- * the current jiffies and restarts the counters again.
- */
-void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
-{
-	struct hd_struct *part2 = NULL;
-	unsigned long now = jiffies;
-	unsigned int inflight[2];
-	int stats = 0;
-
-	if (part->stamp != now)
-		stats |= 1;
-
-	if (part->partno) {
-		part2 = &part_to_disk(part)->part0;
-		if (part2->stamp != now)
-			stats |= 2;
-	}
-
-	if (!stats)
-		return;
-
-	part_in_flight(q, part, inflight);
-
-	if (stats & 2)
-		part_round_stats_single(q, cpu, part2, now, inflight[1]);
-	if (stats & 1)
-		part_round_stats_single(q, cpu, part, now, inflight[0]);
-}
-EXPORT_SYMBOL_GPL(part_round_stats);
-
 void blk_put_request(struct request *req)
 {
 	blk_mq_free_request(req);
@@ -1408,9 +1351,10 @@ void blk_account_io_done(struct request *req, u64 now)
 		cpu = part_stat_lock();
 		part = req->part;
 
+		update_io_ticks(cpu, part, jiffies);
 		part_stat_inc(cpu, part, ios[sgrp]);
 		part_stat_add(cpu, part, nsecs[sgrp], now - req->start_time_ns);
-		part_round_stats(req->q, cpu, part);
+		part_stat_add(cpu, part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
@@ -1446,11 +1390,12 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			part = &rq->rq_disk->part0;
 			hd_struct_get(part);
 		}
-		part_round_stats(rq->q, cpu, part);
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
 
+	update_io_ticks(cpu, part, jiffies);
+
 	part_stat_unlock();
 }
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 6be04ef8da5b..c278b6d18a24 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -690,7 +690,6 @@ static void blk_account_io_merge(struct request *req)
 		cpu = part_stat_lock();
 		part = req->part;
 
-		part_round_stats(req->q, cpu, part);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
diff --git a/block/genhd.c b/block/genhd.c
index 0145bcb0cc76..cdf174d7d329 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1326,7 +1326,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight[2];
-	int cpu;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1338,9 +1337,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		cpu = part_stat_lock();
-		part_round_stats(gp->queue, cpu, hd);
-		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5f8db5c5140f..42d6138ac876 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -121,11 +121,7 @@ ssize_t part_stat_show(struct device *dev,
 	struct hd_struct *p = dev_to_part(dev);
 	struct request_queue *q = part_to_disk(p)->queue;
 	unsigned int inflight[2];
-	int cpu;
 
-	cpu = part_stat_lock();
-	part_round_stats(q, cpu, p);
-	part_stat_unlock();
 	part_in_flight(q, p, inflight);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0c5ee17b4d88..f2a0a52c874f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -398,8 +398,7 @@ static inline void free_part_info(struct hd_struct *part)
 	kfree(part->info);
 }
 
-/* block/blk-core.c */
-extern void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part);
+void update_io_ticks(int cpu, struct hd_struct *part, unsigned long now);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,
-- 
2.15.0

