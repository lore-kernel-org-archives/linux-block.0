Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A46EC65BAF
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510E20850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhm0lkFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3510E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLFQlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:35 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38723 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeLFQlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:35 -0500
Received: by mail-qk1-f178.google.com with SMTP id d19so688738qkg.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iw1pxVal0P9iW2FYwEShmYf7++g/Hc6pwU/St/Unn+E=;
        b=Jhm0lkFPku52yv/ydwT9kt6hMkiCNiL4QCNcGxo+kbHwgAw1Q6zp0yrlzNAwnVFoCc
         7PGncfiJ8u2TQB5ggkGbdr/8IH43vu6P3awwhuG2sCeYLc13diqcml2c6sGDEGDctkvo
         h158omwn9wpGQLkgk+ot6rC6mEFA/Cgaqag1POgXu7JuiZsXgSshZajr1uhGYHh6JG90
         8Ur5+VVdUlOJlJMYbVWqAI64iN/EgsRE6H3nlj/OH1iTcIffSnrETaeCgTrr6JtwJl3I
         /gWj//q5aQMO3TMoBKD0eTGwcRhqE1pPpUyXyxP9ftc6JUaKsDXyJPY8amIVj0bI37jk
         pP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Iw1pxVal0P9iW2FYwEShmYf7++g/Hc6pwU/St/Unn+E=;
        b=e0eUpIcxnIpJn0hfT20VzGEzvwGWuLYwi4XK38NtypNHQPtMg7r3c3brjIUj6UpH0G
         nFjS6TGOLJpXCSoH70bGPa+hqjRnlCd9V2GCFIoahNKnJQ3GacfpQTF+zkSpYlM+Ch9y
         BjZEEyT/OqQ7mgkhn4wnCqVui01MubD9cXJ3sQMWlJzuKMPAb/uWHGuQriQlsXChzaQe
         doRBblajpLCmR6HDRfCVlZ+UGZfp/dBMzNwEmmRLm3phyB12tU72yQuL5Th81DO5V06p
         qHmvb7RqWWaZqbVrhz9sfKlfJ7ke8U8NZd6R1oRp4QQaoj8WaqKsOrK5agTUrx4cNIr2
         OD5w==
X-Gm-Message-State: AA+aEWZvtKyjHL7k/9I2xgnyHPg1vkVrMyoPpxw1bK6borZ9dwz1knmT
        tBTHGnmsc6AhS9Y3kfmMuWA=
X-Google-Smtp-Source: AFSGD/WJ6tocTP1JdRSp7eRm9dZcgVxLYECUibvsnMTtzJl4J9OIL6VOOE0kgk2DDk+zBZTe+wyyEA==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr25268156qke.274.1544114494277;
        Thu, 06 Dec 2018 08:41:34 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p42sm509546qte.8.2018.12.06.08.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:33 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 4/7] block: delete part_round_stats and switch to less precise counting
Date:   Thu,  6 Dec 2018 11:41:19 -0500
Message-Id: <20181206164122.2166-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
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
 block/blk-core.c          | 62 +++--------------------------------------------
 block/blk-merge.c         |  1 -
 block/genhd.c             |  3 ---
 block/partition-generic.c |  3 ---
 include/linux/genhd.h     |  3 +--
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
2.15.0

