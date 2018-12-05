Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B8BC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4FA2133F
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR7Wg5z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4FA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeLEUYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:44 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34496 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:43 -0500
Received: by mail-qt1-f176.google.com with SMTP id r14so23898156qtp.1
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xGJsbW2rgZ9JSRuIPaddEeemuWEVWwJK5ZTanjIVHww=;
        b=XR7Wg5z5SUyhvYr50wl9qtusSh0KIoHuhmJlMpluKuMj0Cxb/3jWrbufSShQQe7O4g
         ZSIrA8NzNqWM/ukRt0FDc95jsYA5wS6gBWs49PFp6rM7EkckidSPbZE16dqTZ4jvAO9x
         T5+lyEpgh6j/LIkXGlrPmqrHOffZwrbqxdCkv4wE9mWPz0brw94uqH4exyeddL5vXLu/
         uNpiXodXvUsyepsBOWXMYJUev6hzhp5uOXSFbewasCOMxZ4EMsAhUppGlvYrFjqMLmB5
         BLXt+CRpUhDzNOqGmDKvCMUxSoyyL4wElW8PAR85oN66bWH3pZeM8gvlSTFb5PQjFQIf
         Whng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xGJsbW2rgZ9JSRuIPaddEeemuWEVWwJK5ZTanjIVHww=;
        b=FsB0Lb/zBYqbT88Wedh37J4GJd8Z7B6UZI9ss1bmnA67PlIU6hUvj4L2y2LApWPy2H
         MEWGfGmsW8rbqY73M3CYcAUfxWWTE9JfLWb/ODJEJc0ZMsZPmcCsxPTRFw+b4Dyq87IU
         s5wJrqEv8e36JKNinIyXbwA3tMrhFPO3+OJdnpg0y3vIU/d1YxxxWQ167Gn/Q+bZyXmd
         uNHLW752YxQ1e4vxCPu88giRI+pX2s+qd7eDLhqGku8lU+CyuqWlY38dHx0tC9o2MG6o
         EyVYL17afkMIY7K/37Cefds7WEYYWrMXQMMgLEjy6U7uriZ/umvXuO6D1m1U0/eQEj9w
         UWQA==
X-Gm-Message-State: AA+aEWZf0CtDrxmKHrTylvvTpUR3wvXTKZKiaMN/NyqZiZV706Um50oY
        7K7Ii7kF4HyBea4qcPtX4uM=
X-Google-Smtp-Source: AFSGD/XflAFca5sugGRkfpY5BHVLQAU4ySrI+nkfkOhRqbzA0od+9K6YO9cJocUVzKxTGDRS1oryHw==
X-Received: by 2002:ac8:31ed:: with SMTP id i42mr24238783qte.323.1544041482823;
        Wed, 05 Dec 2018 12:24:42 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id 190sm10720651qkh.25.2018.12.05.12.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:41 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 4/7] block: delete part_round_stats and switch to less precise counting
Date:   Wed,  5 Dec 2018 15:24:30 -0500
Message-Id: <20181205202433.95823-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
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
 block/bio.c               | 24 +++++++++++++--
 block/blk-core.c          | 62 +++------------------------------------
 block/blk-merge.c         |  1 -
 block/genhd.c             |  3 --
 block/partition-generic.c |  3 --
 include/linux/genhd.h     |  3 +-
 6 files changed, 26 insertions(+), 70 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 91e398ba57f1..0c2208a5446d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1663,6 +1663,22 @@ void bio_check_pages_dirty(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
+void update_io_ticks(struct hd_struct *part, unsigned long now)
+{
+	unsigned long stamp;
+again:
+	stamp = READ_ONCE(part->stamp);
+	if (unlikely(stamp != now)) {
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
+			__part_stat_add(part, io_ticks, 1);
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
@@ -1670,7 +1686,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
 
 	part_stat_lock();
 
-	part_round_stats(q, part);
+	update_io_ticks(part, jiffies);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_inc_in_flight(q, part, op_is_write(op));
@@ -1682,13 +1698,15 @@ EXPORT_SYMBOL(generic_start_io_acct);
 void generic_end_io_acct(struct request_queue *q, int req_op,
 			 struct hd_struct *part, unsigned long start_time)
 {
-	unsigned long duration = jiffies - start_time;
+	unsigned long now = jiffies;
+	unsigned long duration = now - start_time;
 	const int sgrp = op_stat_group(req_op);
 
 	part_stat_lock();
 
+	update_io_ticks(part, now);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_round_stats(q, part);
+	part_stat_add(part, time_in_queue, duration);
 	part_dec_in_flight(q, part, op_is_write(req_op));
 
 	part_stat_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index 734b768c9d9d..268d2b8e9843 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -584,62 +584,6 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_get_request);
 
-static void part_round_stats_single(struct request_queue *q,
-				    struct hd_struct *part, unsigned long now,
-				    unsigned int inflight)
-{
-	if (inflight) {
-		__part_stat_add(part, time_in_queue,
-				inflight * (now - part->stamp));
-		__part_stat_add(part, io_ticks, (now - part->stamp));
-	}
-	part->stamp = now;
-}
-
-/**
- * part_round_stats() - Round off the performance stats on a struct disk_stats.
- * @q: target block queue
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
-void part_round_stats(struct request_queue *q, struct hd_struct *part)
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
-		part_round_stats_single(q, part2, now, inflight[1]);
-	if (stats & 1)
-		part_round_stats_single(q, part, now, inflight[0]);
-}
-EXPORT_SYMBOL_GPL(part_round_stats);
-
 void blk_put_request(struct request *req)
 {
 	blk_mq_free_request(req);
@@ -1383,9 +1327,10 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
+		update_io_ticks(part, jiffies);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
-		part_round_stats(req->q, part);
+		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
@@ -1420,11 +1365,12 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			part = &rq->rq_disk->part0;
 			hd_struct_get(part);
 		}
-		part_round_stats(rq->q, part);
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
 
+	update_io_ticks(part, jiffies);
+
 	part_stat_unlock();
 }
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a120d59b9705..9da5629d0887 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -689,7 +689,6 @@ static void blk_account_io_merge(struct request *req)
 		part_stat_lock();
 		part = req->part;
 
-		part_round_stats(req->q, part);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
diff --git a/block/genhd.c b/block/genhd.c
index 2fe00cf32b93..cdf174d7d329 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1337,9 +1337,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		part_stat_lock();
-		part_round_stats(gp->queue, hd);
-		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 7e663cfb1487..42d6138ac876 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -122,9 +122,6 @@ ssize_t part_stat_show(struct device *dev,
 	struct request_queue *q = part_to_disk(p)->queue;
 	unsigned int inflight[2];
 
-	part_stat_lock();
-	part_round_stats(q, p);
-	part_stat_unlock();
 	part_in_flight(q, p, inflight);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1677cd2a4c4e..838c2a7a40c5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -398,8 +398,7 @@ static inline void free_part_info(struct hd_struct *part)
 	kfree(part->info);
 }
 
-/* block/blk-core.c */
-extern void part_round_stats(struct request_queue *q, struct hd_struct *part);
+void update_io_ticks(struct hd_struct *part, unsigned long now);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,
-- 
2.18.0

