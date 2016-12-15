Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60575 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756333AbcLOUdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:17 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uBFKW86G003300
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 27c263827s-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:11 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 b13d5290c30511e6b7cf0002c99331b0-ee00b6d0 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 17/17] blk-throttle: add latency target support
Date: Thu, 15 Dec 2016 12:33:08 -0800
Message-ID: <99757f2dd713e63fc74ea8ae004b1c50380ec718.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
 block/blk-throttle.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1dc707a..915ebf5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -162,6 +162,10 @@ struct throtl_grp {
 	u64 checked_last_finish_time;
 	u64 avg_ttime;
 	u64 idle_ttime_threshold;
+
+	unsigned int bio_cnt; /* total bios */
+	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
+	unsigned long bio_cnt_reset_time;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -1688,11 +1692,14 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	 * - single idle is too long, longer than a fixed value (in case user
 	 *   configure a too big threshold) or 4 times of slice
 	 * - average think time is more than threshold
+	 * - IO latency is largely below threshold
 	 */
 	u64 time = (u64)jiffies_to_usecs(4 * tg->td->throtl_slice) * 1000;
 	time = min_t(u64, MAX_IDLE_TIME, time);
 	return ktime_get_ns() - tg->last_finish_time > time ||
-	       tg->avg_ttime > tg->idle_ttime_threshold;
+	       tg->avg_ttime > tg->idle_ttime_threshold ||
+	       (tg->latency_target && tg->bio_cnt &&
+		tg->bad_bio_cnt * 5 < tg->bio_cnt);
 }
 
 static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
@@ -2170,12 +2177,36 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	start_time = blk_stat_time(&bio->bi_issue_stat);
 	finish_time = __blk_stat_time(finish_time);
-	if (start_time && finish_time > start_time &&
-	    tg->td->track_bio_latency == 1 &&
-	    !(bio->bi_issue_stat.stat & SKIP_TRACK)) {
-		lat = finish_time - start_time;
+	if (!start_time || finish_time <= start_time)
+		return;
+
+	lat = finish_time - start_time;
+	if (tg->td->track_bio_latency == 1 &&
+	    !(bio->bi_issue_stat.stat & SKIP_TRACK))
 		throtl_track_latency(tg->td, blk_stat_size(&bio->bi_issue_stat),
 			bio_op(bio), lat);
+
+	if (tg->latency_target) {
+		int bucket;
+		unsigned int threshold;
+
+		bucket = request_bucket_index(
+			blk_stat_size(&bio->bi_issue_stat));
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
 
-- 
2.9.3

