Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] blk-mq: enable checking two part inflight counts at the same time
Date: Thu,  3 Aug 2017 14:01:56 -0600
Message-Id: <1501790516-6924-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We only need to iterate the queues and tags once, we if just pass
in both partition structs. Add part_in_flight_double() for
returning this value.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c      | 34 +++++++++++++++++++++++-----------
 block/blk-mq.c        | 25 +++++++++++++++++--------
 block/blk-mq.h        |  3 ++-
 block/genhd.c         | 23 +++++++++++++++++++++--
 include/linux/genhd.h |  2 ++
 5 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ba88d71b442f..d111a8f5bdf1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1470,14 +1470,9 @@ static void add_acct_request(struct request_queue *q, struct request *rq,
 }
 
 static void part_round_stats_single(struct request_queue *q, int cpu,
-				    struct hd_struct *part, unsigned long now)
+				    struct hd_struct *part, unsigned long now,
+				    unsigned int inflight)
 {
-	int inflight;
-
-	if (now == part->stamp)
-		return;
-
-	inflight = part_in_flight(q, part);
 	if (inflight) {
 		__part_stat_add(cpu, part, time_in_queue,
 				inflight * (now - part->stamp));
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
+	part_in_flight_double(q, part, part2, inflight);
 
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
index 37035891e120..03d164917160 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -87,8 +87,9 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 }
 
 struct mq_inflight {
-	struct hd_struct *part;
-	unsigned int inflight;
+	struct hd_struct *part1;
+	struct hd_struct *part2;
+	unsigned int *inflight;
 };
 
 static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
@@ -97,17 +98,25 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
-		mi->inflight++;
+	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+		return;
+	if (rq->part == mi->part1) {
+		mi->inflight[0]++;
+		if (mi->part1->partno &&
+		    &part_to_disk(mi->part1)->part0 == mi->part2)
+			mi->inflight[1]++;
+	} else if (rq->part == mi->part2)
+		mi->inflight[1]++;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q,
-			       struct hd_struct *part)
+void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part1,
+		      struct hd_struct *part2, unsigned int *inflight)
 {
-	struct mq_inflight mi = { .part = part, .inflight = 0 };
+	struct mq_inflight mi = { .part1 = part1, .part2 = part2,
+				  .inflight = inflight };
 
+	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
-	return mi.inflight;
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index cade1a512a01..c5264a64fb7c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -138,6 +138,7 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
+void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part1,
+			struct hd_struct *part2, unsigned int *inflight);
 
 #endif
diff --git a/block/genhd.c b/block/genhd.c
index ad5dc567d57f..6faacccd8453 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -67,13 +67,32 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 
 int part_in_flight(struct request_queue *q, struct hd_struct *part)
 {
-	if (q->mq_ops)
-		return blk_mq_in_flight(q, part);
+	if (q->mq_ops) {
+		unsigned int inflight[2];
+
+		blk_mq_in_flight(q, part, NULL, inflight);
+		return inflight[0];
+	}
 
 	return atomic_read(&part->in_flight[0]) +
 			atomic_read(&part->in_flight[1]);
 }
 
+void part_in_flight_double(struct request_queue *q, struct hd_struct *part1,
+			   struct hd_struct *part2, unsigned int *inflight)
+{
+	if (q->mq_ops) {
+		blk_mq_in_flight(q, part1, part2, inflight);
+		return;
+	}
+
+	inflight[0] = atomic_read(&part1->in_flight[0]) +
+			atomic_read(&part1->in_flight[1]);
+	if (part2) {
+		inflight[1] = atomic_read(&part2->in_flight[0]) +
+				atomic_read(&part2->in_flight[1]);
+	}
+}
 /**
  * disk_get_part - get partition
  * @disk: disk to look partition from
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f2c5096b3a7e..408690079143 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -363,6 +363,8 @@ static inline void free_part_stats(struct hd_struct *part)
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
 int part_in_flight(struct request_queue *q, struct hd_struct *part);
+void part_in_flight_double(struct request_queue *q, struct hd_struct *part1,
+			struct hd_struct *part2, unsigned int *inflight);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw);
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw);
 
-- 
2.7.4
