Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209BC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA1A20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA1A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLAJdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8168C30833A4;
        Fri, 30 Nov 2018 22:22:38 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FDB060C67;
        Fri, 30 Nov 2018 22:22:38 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
Date:   Fri, 30 Nov 2018 17:22:24 -0500
Message-Id: <20181130222226.77216-5-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 30 Nov 2018 22:22:38 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

Now when part_round_stats is gone, we can switch to per-cpu in-flight
counters.

We use the local-atomic type local_t, so that if part_inc_in_flight or
part_dec_in_flight is reentrantly called from an interrupt, the value will
be correct.

The other counters could be corrupted due to reentrant interrupt, but the
corruption only results in slight counter skew - the in_flight counter
must be exact, so it needs local_t.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/bio.c           |  4 ++--
 block/blk-core.c      |  4 ++--
 block/blk-merge.c     |  2 +-
 block/genhd.c         | 47 +++++++++++++++++++++++++++++++++++------------
 include/linux/genhd.h |  7 ++++---
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d5ef043a97aa..b25b4fef9900 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1688,7 +1688,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
 	update_io_ticks(cpu, part, jiffies);
 	part_stat_inc(cpu, part, ios[sgrp]);
 	part_stat_add(cpu, part, sectors[sgrp], sectors);
-	part_inc_in_flight(q, part, op_is_write(op));
+	part_inc_in_flight(q, cpu, part, op_is_write(op));
 
 	part_stat_unlock();
 }
@@ -1705,7 +1705,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 	update_io_ticks(cpu, part, now);
 	part_stat_add(cpu, part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_add(cpu, part, time_in_queue, duration);
-	part_dec_in_flight(q, part, op_is_write(req_op));
+	part_dec_in_flight(q, cpu, part, op_is_write(req_op));
 
 	part_stat_unlock();
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index 6bd4669f05fd..87f06672d9a7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1355,7 +1355,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_inc(cpu, part, ios[sgrp]);
 		part_stat_add(cpu, part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_add(cpu, part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
-		part_dec_in_flight(req->q, part, rq_data_dir(req));
+		part_dec_in_flight(req->q, cpu, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
@@ -1390,7 +1390,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			part = &rq->rq_disk->part0;
 			hd_struct_get(part);
 		}
-		part_inc_in_flight(rq->q, part, rw);
+		part_inc_in_flight(rq->q, cpu, part, rw);
 		rq->part = part;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c278b6d18a24..c02386cdf0ca 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -690,7 +690,7 @@ static void blk_account_io_merge(struct request *req)
 		cpu = part_stat_lock();
 		part = req->part;
 
-		part_dec_in_flight(req->q, part, rq_data_dir(req));
+		part_dec_in_flight(req->q, cpu, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index cdf174d7d329..d4c9dd65def6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -45,53 +45,76 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
-void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
+void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
 		return;
 
-	atomic_inc(&part->in_flight[rw]);
+	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
+		local_inc(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
-void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
+void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
 		return;
 
-	atomic_dec(&part->in_flight[rw]);
+	local_dec(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
+		local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
+	int cpu;
+
 	if (queue_is_mq(q)) {
 		blk_mq_in_flight(q, part, inflight);
 		return;
 	}
 
-	inflight[0] = atomic_read(&part->in_flight[0]) +
-			atomic_read(&part->in_flight[1]);
+	inflight[0] = 0;
+	for_each_possible_cpu(cpu) {
+		inflight[0] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+				local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+	}
+	if ((int)inflight[0] < 0)
+		inflight[0] = 0;
+
 	if (part->partno) {
 		part = &part_to_disk(part)->part0;
-		inflight[1] = atomic_read(&part->in_flight[0]) +
-				atomic_read(&part->in_flight[1]);
+		inflight[1] = 0;
+		for_each_possible_cpu(cpu) {
+			inflight[1] +=	local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) +
+					local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+		}
+		if ((int)inflight[1] < 0)
+			inflight[1] = 0;
 	}
 }
 
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
+	int cpu;
+
 	if (queue_is_mq(q)) {
 		blk_mq_in_flight_rw(q, part, inflight);
 		return;
 	}
 
-	inflight[0] = atomic_read(&part->in_flight[0]);
-	inflight[1] = atomic_read(&part->in_flight[1]);
+	inflight[0] = 0;
+	inflight[1] = 0;
+	for_each_possible_cpu(cpu) {
+		inflight[0] += local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]);
+		inflight[1] += local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
+	}
+	if ((int)inflight[0] < 0)
+		inflight[0] = 0;
+	if ((int)inflight[1] < 0)
+		inflight[1] = 0;
 }
 
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f2a0a52c874f..a03aa6502a83 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -17,6 +17,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/uuid.h>
 #include <linux/blk_types.h>
+#include <asm/local.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -89,6 +90,7 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
+	local_t in_flight[2];
 };
 
 #define PARTITION_META_INFO_VOLNAMELTH	64
@@ -122,7 +124,6 @@ struct hd_struct {
 	int make_it_fail;
 #endif
 	unsigned long stamp;
-	atomic_t in_flight[2];
 #ifdef	CONFIG_SMP
 	struct disk_stats __percpu *dkstats;
 #else
@@ -380,9 +381,9 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2]);
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2]);
-void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
+void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part,
 			int rw);
-void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
+void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part,
 			int rw);
 
 static inline struct partition_meta_info *alloc_part_info(struct gendisk *disk)
-- 
2.15.0

