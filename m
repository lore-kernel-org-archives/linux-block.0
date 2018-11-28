Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAF1C04EBA
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EAF2086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EAF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeK1Lmm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:42:42 -0500
Received: from 109-183-129-149.customers.tmcz.cz ([109.183.129.149]:56968 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Lml (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 06:42:41 -0500
Received: from debian.vm ([192.168.192.2])
        by leontynka.twibright.com with smtp (Exim 4.89)
        (envelope-from <mpatocka@redhat.com>)
        id 1gRnwH-0007s3-Kx; Wed, 28 Nov 2018 01:42:50 +0100
Received: by debian.vm (sSMTP sendmail emulation); Wed, 28 Nov 2018 01:42:49 +0100
Message-Id: <20181128004249.147084927@debian.vm>
User-Agent: quilt/0.65
Date:   Wed, 28 Nov 2018 01:42:12 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 1/3] block: delete part_round_stats and switch to less precise counting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=block-delete-part_round_stats.patch
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

---
 block/bio.c               |   26 ++++++++++++++++--
 block/blk-core.c          |   64 +++-------------------------------------------
 block/blk-merge.c         |    1 
 block/genhd.c             |    4 --
 block/partition-generic.c |    4 --
 include/linux/genhd.h     |    3 --
 6 files changed, 29 insertions(+), 73 deletions(-)

Index: linux-block/block/bio.c
===================================================================
--- linux-block.orig/block/bio.c	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/block/bio.c	2018-11-26 23:44:17.000000000 +0100
@@ -1663,13 +1663,29 @@ defer:
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
@@ -1681,12 +1697,16 @@ EXPORT_SYMBOL(generic_start_io_acct);
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
+	if (part->partno)
+		part_stat_add(cpu, &part_to_disk(part)->part0, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
Index: linux-block/block/blk-core.c
===================================================================
--- linux-block.orig/block/blk-core.c	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/block/blk-core.c	2018-11-26 23:44:17.000000000 +0100
@@ -583,63 +583,6 @@ struct request *blk_get_request(struct r
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
@@ -1408,9 +1351,11 @@ void blk_account_io_done(struct request
 		cpu = part_stat_lock();
 		part = req->part;
 
+		update_io_ticks(cpu, part, jiffies);
 		part_stat_inc(cpu, part, ios[sgrp]);
 		part_stat_add(cpu, part, nsecs[sgrp], now - req->start_time_ns);
-		part_round_stats(req->q, cpu, part);
+		part_stat_add(cpu, part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
+			part_stat_add(cpu, &part_to_disk(part)->part0, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
@@ -1446,11 +1391,12 @@ void blk_account_io_start(struct request
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
 
Index: linux-block/block/blk-merge.c
===================================================================
--- linux-block.orig/block/blk-merge.c	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/block/blk-merge.c	2018-11-26 23:44:17.000000000 +0100
@@ -690,7 +690,6 @@ static void blk_account_io_merge(struct
 		cpu = part_stat_lock();
 		part = req->part;
 
-		part_round_stats(req->q, cpu, part);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
Index: linux-block/block/genhd.c
===================================================================
--- linux-block.orig/block/genhd.c	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/block/genhd.c	2018-11-26 23:44:17.000000000 +0100
@@ -1326,7 +1326,6 @@ static int diskstats_show(struct seq_fil
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight[2];
-	int cpu;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1338,9 +1337,6 @@ static int diskstats_show(struct seq_fil
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		cpu = part_stat_lock();
-		part_round_stats(gp->queue, cpu, hd);
-		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
Index: linux-block/block/partition-generic.c
===================================================================
--- linux-block.orig/block/partition-generic.c	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/block/partition-generic.c	2018-11-26 23:44:17.000000000 +0100
@@ -121,11 +121,7 @@ ssize_t part_stat_show(struct device *de
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
Index: linux-block/include/linux/genhd.h
===================================================================
--- linux-block.orig/include/linux/genhd.h	2018-11-26 23:44:17.000000000 +0100
+++ linux-block/include/linux/genhd.h	2018-11-26 23:44:17.000000000 +0100
@@ -398,8 +398,7 @@ static inline void free_part_info(struct
 	kfree(part->info);
 }
 
-/* block/blk-core.c */
-extern void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part);
+void update_io_ticks(int cpu, struct hd_struct *part, unsigned long now);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,

