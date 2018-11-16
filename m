Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF4C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0819221019
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0819221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeKPKrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:47:17 -0500
Received: from 109-183-129-149.customers.tmcz.cz ([109.183.129.149]:46232 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:47:17 -0500
Received: from debian.vm ([192.168.192.2])
        by leontynka.twibright.com with smtp (Exim 4.89)
        (envelope-from <mpatocka@redhat.com>)
        id 1gNRdF-0001CY-Jl; Fri, 16 Nov 2018 01:05:10 +0100
Received: by debian.vm (sSMTP sendmail emulation); Fri, 16 Nov 2018 01:05:09 +0100
Message-Id: <20181116000508.980108938@debian.vm>
User-Agent: quilt/0.65
Date:   Fri, 16 Nov 2018 01:04:19 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <msnitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 3/3] block: use a driver-specific handler for the "inflight" value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=dm-inflight.patch
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Device mapper was converted to percpu inflight counters. In order to
display the correct values in the "inflight" sysfs file and in
/proc/diskstats, we need a custom callback that sums the percpu counters.

The function part_round_stats calculates the number of in-flight I/Os
every jiffy and uses this to calculate the counters time_in_queue and
io_ticks. In order to avoid excessive memory traffic on systems with high
number of CPUs, this functionality is disabled when percpu inflight values
are used and the values time_in_queue and io_ticks are calculated
differently - the result is less precise.

We add the duration of an I/O to time_in_queue when the I/O finishes (the
value is almost the same as previously, except for the time of in-flight
I/Os).

If an I/O starts or finishes and the "jiffies" value has changed, we add
one to io_ticks. If the I/Os take less than a jiffy, the value is as exact
as the previous value. If the I/Os take more than a jiffy, the value may
lag behind the previous value.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/blk-core.c       |    7 ++++++-
 block/blk-settings.c   |    6 ++++++
 block/genhd.c          |   12 ++++++++++++
 drivers/md/dm.c        |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/blkdev.h |    3 +++
 5 files changed, 62 insertions(+), 3 deletions(-)

Index: linux-dm/block/genhd.c
===================================================================
--- linux-dm.orig/block/genhd.c	2018-11-15 22:11:51.000000000 +0100
+++ linux-dm/block/genhd.c	2018-11-15 22:11:51.000000000 +0100
@@ -68,6 +68,13 @@ void part_dec_in_flight(struct request_q
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
+	if (q->get_inflight_fn) {
+		q->get_inflight_fn(q, inflight);
+		inflight[0] += inflight[1];
+		inflight[1] = 0;
+		return;
+	}
+
 	if (q->mq_ops) {
 		blk_mq_in_flight(q, part, inflight);
 		return;
@@ -85,6 +92,11 @@ void part_in_flight(struct request_queue
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
+	if (q->get_inflight_fn) {
+		q->get_inflight_fn(q, inflight);
+		return;
+	}
+
 	if (q->mq_ops) {
 		blk_mq_in_flight_rw(q, part, inflight);
 		return;
Index: linux-dm/include/linux/blkdev.h
===================================================================
--- linux-dm.orig/include/linux/blkdev.h	2018-11-15 22:11:51.000000000 +0100
+++ linux-dm/include/linux/blkdev.h	2018-11-15 22:11:51.000000000 +0100
@@ -286,6 +286,7 @@ struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
 typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
+typedef void (get_inflight_fn)(struct request_queue *, unsigned int [2]);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
@@ -405,6 +406,7 @@ struct request_queue {
 	make_request_fn		*make_request_fn;
 	poll_q_fn		*poll_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
+	get_inflight_fn		*get_inflight_fn;
 
 	const struct blk_mq_ops	*mq_ops;
 
@@ -1099,6 +1101,7 @@ extern void blk_queue_update_dma_alignme
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern void blk_queue_get_inflight(struct request_queue *, get_inflight_fn *);
 
 /*
  * Number of physical segments as sent to the device.
Index: linux-dm/block/blk-settings.c
===================================================================
--- linux-dm.orig/block/blk-settings.c	2018-11-15 22:11:51.000000000 +0100
+++ linux-dm/block/blk-settings.c	2018-11-15 22:11:51.000000000 +0100
@@ -849,6 +849,12 @@ void blk_queue_write_cache(struct reques
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
+void blk_queue_get_inflight(struct request_queue *q, get_inflight_fn *fn)
+{
+	q->get_inflight_fn = fn;
+}
+EXPORT_SYMBOL_GPL(blk_queue_get_inflight);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
Index: linux-dm/drivers/md/dm.c
===================================================================
--- linux-dm.orig/drivers/md/dm.c	2018-11-15 22:11:51.000000000 +0100
+++ linux-dm/drivers/md/dm.c	2018-11-15 22:18:44.000000000 +0100
@@ -657,18 +657,30 @@ int md_in_flight(struct mapped_device *m
 	return (int)sum;
 }
 
+static void test_io_ticks(int cpu, struct hd_struct *part, unsigned long now)
+{
+	unsigned long stamp = READ_ONCE(part->stamp);
+	if (unlikely(stamp != now)) {
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
+			__part_stat_add(cpu, part, io_ticks, 1);
+		}
+	}
+}
+
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
+	unsigned long now = jiffies;
 	struct hd_struct *part;
 	int sgrp, cpu;
 
-	io->start_time = jiffies;
+	io->start_time = now;
 
 	part = &dm_disk(md)->part0;
 	sgrp = op_stat_group(bio_op(bio));
 	cpu = part_stat_lock();
+	test_io_ticks(cpu, part, now);
 	__part_stat_add(cpu, part, ios[sgrp], 1);
 	__part_stat_add(cpu, part, sectors[sgrp], bio_sectors(bio));
 	part_stat_unlock();
@@ -685,7 +697,8 @@ static void end_io_acct(struct dm_io *io
 {
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
-	unsigned long duration = jiffies - io->start_time;
+	unsigned long now = jiffies;
+	unsigned long duration = now - io->start_time;
 	struct hd_struct *part;
 	int sgrp, cpu;
 
@@ -697,7 +710,9 @@ static void end_io_acct(struct dm_io *io
 	part = &dm_disk(md)->part0;
 	sgrp = op_stat_group(bio_op(bio));
 	cpu = part_stat_lock();
+	test_io_ticks(cpu, part, now);
 	__part_stat_add(cpu, part, nsecs[sgrp], jiffies_to_nsecs(duration));
+	__part_stat_add(cpu, part, time_in_queue, duration);
 	part_stat_unlock();
 
 	smp_wmb();
@@ -711,6 +726,23 @@ static void end_io_acct(struct dm_io *io
 	}
 }
 
+static void dm_get_inflight(struct request_queue *q, unsigned int inflight[2])
+{
+	struct mapped_device *md = q->queuedata;
+	int cpu;
+
+	inflight[READ] = inflight[WRITE] = 0;
+	for_each_possible_cpu(cpu) {
+		struct dm_percpu *p = per_cpu_ptr(md->counters, cpu);
+		inflight[READ] += p->inflight[READ];
+		inflight[WRITE] += p->inflight[WRITE];
+	}
+	if ((int)inflight[READ] < 0)
+		inflight[READ] = 0;
+	if ((int)inflight[WRITE] < 0)
+		inflight[WRITE] = 0;
+}
+
 /*
  * Add the bio to the list of deferred io.
  */
@@ -2224,6 +2256,7 @@ int dm_setup_md_queue(struct mapped_devi
 	case DM_TYPE_NVME_BIO_BASED:
 		dm_init_normal_md_queue(md);
 		blk_queue_make_request(md->queue, dm_make_request);
+		blk_queue_get_inflight(md->queue, dm_get_inflight);
 		break;
 	case DM_TYPE_NONE:
 		WARN_ON_ONCE(true);
Index: linux-dm/block/blk-core.c
===================================================================
--- linux-dm.orig/block/blk-core.c	2018-11-15 22:11:51.000000000 +0100
+++ linux-dm/block/blk-core.c	2018-11-15 22:11:51.000000000 +0100
@@ -695,10 +695,15 @@ static void part_round_stats_single(stru
 void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
 {
 	struct hd_struct *part2 = NULL;
-	unsigned long now = jiffies;
+	unsigned long now;
 	unsigned int inflight[2];
 	int stats = 0;
 
+	if (q->get_inflight_fn)
+		return;
+
+	now = jiffies;
+
 	if (part->stamp != now)
 		stats |= 1;
 

