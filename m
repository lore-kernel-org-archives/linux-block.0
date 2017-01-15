Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33969 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750937AbdAODmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:39 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0F3gPY1005112
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27ygp5hj20-8
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 a7ded174dad411e6ab8e0002c99331b0-dadf6a50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 18/18] blk-throttle: add latency target support
Date: Sat, 14 Jan 2017 19:42:35 -0800
Message-ID: <f1dd4aaf37168c06ffcf164a5d65943699ab98fd.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
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
 block/blk-throttle.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c0eb100..901af99 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -165,6 +165,10 @@ struct throtl_grp {
 	unsigned long checked_last_finish_time; /* ns / 1024 */
 	unsigned long avg_idletime; /* ns / 1024 */
 	unsigned long idletime_threshold; /* us */
+
+	unsigned int bio_cnt; /* total bios */
+	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
+	unsigned long bio_cnt_reset_time;
 };
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -1720,12 +1724,15 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
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
@@ -2185,11 +2192,35 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	start_time = blk_stat_time(&bio->bi_issue_stat) >> 10;
 	finish_time = __blk_stat_time(finish_time_ns) >> 10;
-	if (start_time && finish_time > start_time &&
-	    !(bio->bi_issue_stat.stat & SKIP_LATENCY)) {
-		lat = finish_time - start_time;
+	if (!start_time || finish_time <= start_time)
+		return;
+
+	lat = finish_time - start_time;
+	if (!(bio->bi_issue_stat.stat & SKIP_LATENCY))
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

