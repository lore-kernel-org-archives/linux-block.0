Return-Path: <khlebnikov@yandex-team.ru>
Subject: [PATCH RFC] block,
 bfq: set default slice_idle to zero for non-rotational devices
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, linux-kernel@vger.kernel.org
Date: Thu, 01 Nov 2018 20:43:30 +0300
Message-ID: <154109421062.925711.4117729151502021084.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

With default 8ms idle slice BFQ is up to 10 times slower than CFQ
for massive random read workloads for common SATA SSD.

For now zero idle slice gives better out of box experience.
CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
to IOPS mode on SSDs")

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/block/bfq-iosched.txt |   12 +++++++-----
 block/bfq-iosched.c                 |    8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 8d8d8f06cab2..c4a0f8998ce6 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -307,11 +307,13 @@ slice_idle
 ----------
 
 This parameter specifies how long BFQ should idle for next I/O
-request, when certain sync BFQ queues become empty. By default
-slice_idle is a non-zero value. Idling has a double purpose: boosting
-throughput and making sure that the desired throughput distribution is
-respected (see the description of how BFQ works, and, if needed, the
-papers referred there).
+request, when certain sync BFQ queues become empty.
+
+By default slice_idle is a non-zero value for rotational devices.
+
+Idling has a double purpose: boosting throughput and making sure that
+the desired throughput distribution is respected (see the description
+of how BFQ works, and, if needed, the papers referred there).
 
 As for throughput, idling can be very helpful on highly seeky media
 like single spindle SATA/SAS disks where we can cut down on overall
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6075100f03a5..d19e70a26ff0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -177,8 +177,8 @@ static const int bfq_back_max = 16 * 1024;
 /* Penalty of a backwards seek, in number of sectors. */
 static const int bfq_back_penalty = 2;
 
-/* Idling period duration, in ns. */
-static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
+/* Idling period duration, in ns. Zero for non-rotational devices. */
+static u64 bfq_slice_idle[2] = { NSEC_PER_SEC / 125, 0 };
 
 /* Minimum number of assigned budgets for which stats are safe to compute. */
 static const int bfq_stats_min_budgets = 194;
@@ -3044,7 +3044,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  */
 			*delta_ms = BFQ_MIN_TT / NSEC_PER_MSEC;
 		else /* charge at least one seek */
-			*delta_ms = bfq_slice_idle / NSEC_PER_MSEC;
+			*delta_ms = bfq_slice_idle[0] / NSEC_PER_MSEC;
 
 		return slow;
 	}
@@ -5431,7 +5431,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_fifo_expire[1] = bfq_fifo_expire[1];
 	bfqd->bfq_back_max = bfq_back_max;
 	bfqd->bfq_back_penalty = bfq_back_penalty;
-	bfqd->bfq_slice_idle = bfq_slice_idle;
+	bfqd->bfq_slice_idle = bfq_slice_idle[blk_queue_nonrot(bfqd->queue)];
 	bfqd->bfq_timeout = bfq_timeout;
 
 	bfqd->bfq_requests_within_timer = 120;
