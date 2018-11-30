Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CBC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1943620863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1943620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeLAJd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJd2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBF83307CDDB;
        Fri, 30 Nov 2018 22:22:41 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F07017CC9;
        Fri, 30 Nov 2018 22:22:39 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 5/6] block: return just one value from part_in_flight
Date:   Fri, 30 Nov 2018 17:22:25 -0500
Message-Id: <20181130222226.77216-6-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 30 Nov 2018 22:22:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

The previous patches deleted all the code that needed the second value
returned from part_in_flight - now the kernel only uses the first value.

Consequently, part_in_flight (and blk_mq_in_flight) may be changed so that
it only returns one value.

This patch just refactors the code, there's no functional change.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-mq.c            | 12 +++++-------
 block/blk-mq.h            |  3 +--
 block/genhd.c             | 32 +++++++++++---------------------
 block/partition-generic.c |  6 +++---
 include/linux/genhd.h     |  3 +--
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7dcef565dc0f..88ed969cb9df 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -101,25 +101,23 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 	struct mq_inflight *mi = priv;
 
 	/*
-	 * index[0] counts the specific partition that was asked for. index[1]
-	 * counts the ones that are active on the whole device, so increment
-	 * that if mi->part is indeed a partition, and not a whole device.
+	 * index[0] counts the specific partition that was asked for.
 	 */
 	if (rq->part == mi->part)
 		mi->inflight[0]++;
-	if (mi->part->partno)
-		mi->inflight[1]++;
 
 	return true;
 }
 
-void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-		      unsigned int inflight[2])
+unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 {
+	unsigned inflight[2];
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+
+	return inflight[0];
 }
 
 static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 7291e5379358..4022943cb191 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -184,8 +184,7 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-		      unsigned int inflight[2]);
+unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2]);
 
diff --git a/block/genhd.c b/block/genhd.c
index d4c9dd65def6..3397288a2926 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -65,34 +65,24 @@ void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part
 		local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2])
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
 {
 	int cpu;
+	int inflight;
 
 	if (queue_is_mq(q)) {
-		blk_mq_in_flight(q, part, inflight);
-		return;
+		return blk_mq_in_flight(q, part);
 	}
 
-	inflight[0] = 0;
+	inflight = 0;
 	for_each_possible_cpu(cpu) {
-		inflight[0] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+		inflight +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
 				local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
 	}
-	if ((int)inflight[0] < 0)
-		inflight[0] = 0;
+	if (inflight < 0)
+		inflight = 0;
 
-	if (part->partno) {
-		part = &part_to_disk(part)->part0;
-		inflight[1] = 0;
-		for_each_possible_cpu(cpu) {
-			inflight[1] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
-					local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
-		}
-		if ((int)inflight[1] < 0)
-			inflight[1] = 0;
-	}
+	return (unsigned int)inflight;
 }
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
@@ -1348,7 +1338,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	struct disk_part_iter piter;
 	struct hd_struct *hd;
 	char buf[BDEVNAME_SIZE];
-	unsigned int inflight[2];
+	unsigned int inflight;
 
 	/*
 	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
@@ -1360,7 +1350,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
-		part_in_flight(gp->queue, hd, inflight);
+		inflight = part_in_flight(gp->queue, hd);
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
@@ -1376,7 +1366,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   part_stat_read(hd, merges[STAT_WRITE]),
 			   part_stat_read(hd, sectors[STAT_WRITE]),
 			   (unsigned int)part_stat_read_msecs(hd, STAT_WRITE),
-			   inflight[0],
+			   inflight,
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
 			   part_stat_read(hd, ios[STAT_DISCARD]),
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 42d6138ac876..8e596a8dff32 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -120,9 +120,9 @@ ssize_t part_stat_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 	struct request_queue *q = part_to_disk(p)->queue;
-	unsigned int inflight[2];
+	unsigned int inflight;
 
-	part_in_flight(q, p, inflight);
+	inflight = part_in_flight(q, p);
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
@@ -137,7 +137,7 @@ ssize_t part_stat_show(struct device *dev,
 		part_stat_read(p, merges[STAT_WRITE]),
 		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
 		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
-		inflight[0],
+		inflight,
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
 		part_stat_read(p, ios[STAT_DISCARD]),
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a03aa6502a83..13b7ce01727a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -377,8 +377,7 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(cpu, gendiskp, field, subnd)			\
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
-void part_in_flight(struct request_queue *q, struct hd_struct *part,
-		    unsigned int inflight[2]);
+unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part,
-- 
2.15.0

