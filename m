Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 18/18] blk-throttle: add latency target support
Date: Mon, 27 Mar 2017 10:51:46 -0700
Message-ID: <0d512d4589e1d188a27fea1afd60e5611f1533c9.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

One hard problem adding .low limit is to detect idle cgroup. If one
cgroup doesn't dispatch enough IO against its low limit, we must have a
mechanism to determine if other cgroups dispatch more IO. We added the
think time detection mechanism before, but it doesn't work for all
workloads. Here we add a latency based approach.

We already have mechanism to calculate latency threshold for each IO
size. For every IO dispatched from a cgorup, we compare its latency
against its threshold and record the info. If most IO latency is below
threshold (in the code I use 75%), the cgroup could be treated idle and
other cgroups can dispatch more IO.

Currently this latency target check is only for SSD as we can't
calcualte the latency target for hard disk. And this is only for cgroup
leaf node so far.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4b9c6a1..e506d94 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -170,6 +170,10 @@ struct throtl_grp {
 	unsigned long checked_last_finish_time; /* ns / 1024 */
 	unsigned long avg_idletime; /* ns / 1024 */
 	unsigned long idletime_threshold; /* us */
+
+	unsigned int bio_cnt; /* total bios */
+	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
+	unsigned long bio_cnt_reset_time;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -1725,12 +1729,15 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	 * - single idle is too long, longer than a fixed value (in case user
 	 *   configure a too big threshold) or 4 times of slice
 	 * - average think time is more than threshold
+	 * - IO latency is largely below threshold
 	 */
 	unsigned long time = jiffies_to_usecs(4 * tg->td->throtl_slice);
 
 	time = min_t(unsigned long, MAX_IDLE_TIME, time);
 	return (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
-	       tg->avg_idletime > tg->idletime_threshold;
+	       tg->avg_idletime > tg->idletime_threshold ||
+	       (tg->latency_target && tg->bio_cnt &&
+		tg->bad_bio_cnt * 5 < tg->bio_cnt);
 }
 
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
@@ -2211,12 +2218,36 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	start_time = THROTL_STAT_TIME(bio->bi_throtl_stat) >> 10;
 	finish_time = THROTL_STAT_TIME(finish_time_ns) >> 10;
-	if (start_time && finish_time > start_time &&
-	    !(bio->bi_throtl_stat & THROTL_SKIP_LAT)) {
-		lat = finish_time - start_time;
+	if (!start_time || finish_time <= start_time)
+		return;
+
+	lat = finish_time - start_time;
+	if (!(bio->bi_throtl_stat & THROTL_SKIP_LAT))
 		throtl_track_latency(tg->td,
 			THROTL_STAT_SIZE(bio->bi_throtl_stat),
 			bio_op(bio), lat);
+
+	if (tg->latency_target) {
+		int bucket;
+		unsigned int threshold;
+
+		bucket = request_bucket_index(
+			THROTL_STAT_SIZE(bio->bi_throtl_stat));
+		threshold = tg->td->avg_buckets[bucket].latency +
+			tg->latency_target;
+		if (lat > threshold)
+			tg->bad_bio_cnt++;
+		/*
+		 * Not race free, could get wrong count, which means cgroups
+		 * will be throttled
+		 */
+		tg->bio_cnt++;
+	}
+
+	if (time_after(jiffies, tg->bio_cnt_reset_time) || tg->bio_cnt > 1024) {
+		tg->bio_cnt_reset_time = tg->td->throtl_slice + jiffies;
+		tg->bio_cnt /= 2;
+		tg->bad_bio_cnt /= 2;
 	}
 }
 #endif
-- 
2.9.3
