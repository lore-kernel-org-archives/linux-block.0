Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] blk-mq: enable checking two part inflight counts at the same time
Date: Fri,  4 Aug 2017 09:04:21 -0600
Message-Id: <1501859062-11120-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Modify blk_mq_in_flight() to count both a partition and root at
the same time. Then we only have to call it once, instead of
potentially looping the tags twice.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 38 +++++++++++++++++++++++++-------------
 block/blk-mq.c   | 10 ++++++----
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6ad2b8602c1d..d836c84ad3da 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1470,17 +1470,12 @@ static void add_acct_request(struct request_queue *q, struct request *rq,
 }
 
 static void part_round_stats_single(struct request_queue *q, int cpu,
-				    struct hd_struct *part, unsigned long now)
+				    struct hd_struct *part, unsigned long now,
+				    unsigned int inflight)
 {
-	int inflight[2];
-
-	if (now == part->stamp)
-		return;
-
-	part_in_flight(q, part, inflight);
-	if (inflight[0]) {
+	if (inflight) {
 		__part_stat_add(cpu, part, time_in_queue,
-				inflight[0] * (now - part->stamp));
+				inflight * (now - part->stamp));
 		__part_stat_add(cpu, part, io_ticks, (now - part->stamp));
 	}
 	part->stamp = now;
@@ -1505,12 +1500,29 @@ static void part_round_stats_single(struct request_queue *q, int cpu,
  */
 void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
 {
+	struct hd_struct *part2 = NULL;
 	unsigned long now = jiffies;
+	unsigned int inflight[2];
+	int stats = 0;
+
+	if (part->stamp != now)
+		stats |= 1;
+
+	if (part->partno) {
+		part2 = &part_to_disk(part)->part0;
+		if (part2->stamp != now)
+			stats |= 2;
+	}
+
+	if (!stats)
+		return;
+
+	part_in_flight(q, part, inflight);
 
-	if (part->partno)
-		part_round_stats_single(q, cpu, &part_to_disk(part)->part0,
-						now);
-	part_round_stats_single(q, cpu, part, now);
+	if (stats & 2)
+		part_round_stats_single(q, cpu, part2, now, inflight[1]);
+	if (stats & 1)
+		part_round_stats_single(q, cpu, part, now, inflight[0]);
 }
 EXPORT_SYMBOL_GPL(part_round_stats);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fe1aa1f5f069..410ed246bc9b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -98,11 +98,13 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 		return;
 
 	/*
-	 * Count as inflight if it either matches the partition we asked
-	 * for, or if it's the root
+	 * Count as inflight if it matches the partition, count separately
+	 * (but all) if we got asked for the root
 	 */
-	if (rq->part == mi->part || mi->part->partno)
+	if (rq->part == mi->part)
 		mi->inflight[0]++;
+	if (mi->part->partno)
+		mi->inflight[1]++;
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
@@ -110,7 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 {
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
-	inflight[0] = 0;
+	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
-- 
2.7.4
