Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33913 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965114AbcKNWW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:28 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uAEMLMad013063
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 26qkgf8wd5-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.236.87) with ESMTP id
 d1ee8596aab811e68f2c0002c9521c9e-612dba50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:25 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 15/15] blk-throttle: add latency target support
Date: Mon, 14 Nov 2016 14:22:22 -0800
Message-ID: <420a0f26dd7a20ad8316258c81cb64043134bc86.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

One hard problem adding .high limit is to detect idle cgroup. If one
cgroup doesn't dispatch enough IO against its high limit, we must have a
mechanism to determine if other cgroups dispatch more IO. We added the
think time detection mechanism before, but it doesn't work for all
workloads. Here we add a latency based approach.

We calculate the average request size and average latency of a cgroup.
Then we can calculate the target latency for the cgroup with the average
request size and the equation. In queue LIMIT_HIGH state, if a cgroup
doesn't dispatch enough IO against high limit but its average latency is
lower than its target latency, we treat the cgroup idle. In this case
other cgroups can dispatch more IO, eg, across their high limit.
Similarly in queue LIMIT_MAX state, if a cgroup doesn't dispatch enough
IO but its average latency is higher than its target latency, we treat
the cgroup busy. In this case, we should throttle other cgroups to make
the first cgroup's latency lower.

If cgroup's average request size is big (currently sets to 128k), we
always treat the cgroup busy (the think time check is still effective
though).

Currently this latency target check is only for SSD as we can't
calcualte the latency target for hard disk. And this is only for cgroup
leaf node so far.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c      | 58 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/blk_types.h |  1 +
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ac4d9ea..d07f332 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -156,6 +156,12 @@ struct throtl_grp {
 	u64 last_finish_time;
 	u64 checked_last_finish_time;
 	u64 avg_ttime;
+
+	unsigned int bio_batch;
+	u64 total_latency;
+	u64 avg_latency;
+	u64 total_size;
+	u64 avg_size;
 };
 
 /* We measure latency for request size from 4k to 4k * ( 1 << 4) */
@@ -1734,12 +1740,30 @@ static unsigned long tg_last_high_overflow_time(struct throtl_grp *tg)
 	return ret;
 }
 
+static u64 throtl_target_latency(struct throtl_data *td,
+	struct throtl_grp *tg)
+{
+	if (td->line_slope == 0 || tg->latency_target == 0)
+		return 0;
+
+	/* latency_target + f(avg_size) - f(4k) */
+	return td->line_slope * ((tg->avg_size >> 10) - 4) +
+		tg->latency_target;
+}
+
 static bool throtl_tg_is_idle(struct throtl_grp *tg)
 {
-	/* cgroup is idle if average think time is more than threshold */
-	return ktime_get_ns() - tg->last_finish_time >
+	/*
+	 * cgroup is idle if:
+	 * 1. average think time is higher than threshold
+	 * 2. average request size is small and average latency is higher
+	 *    than target
+	 */
+	return (ktime_get_ns() - tg->last_finish_time >
 		4 * tg->td->idle_ttime_threshold ||
-	       tg->avg_ttime > tg->td->idle_ttime_threshold;
+		tg->avg_ttime > tg->td->idle_ttime_threshold) ||
+	       (tg->avg_latency && tg->avg_size && tg->avg_size <= 128 * 1024 &&
+		tg->avg_latency < throtl_target_latency(tg->td, tg));
 }
 
 static bool throtl_upgrade_check_one(struct throtl_grp *tg)
@@ -2123,6 +2147,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	bio_associate_current(bio);
 	bio->bi_cg_private = q;
 	bio->bi_cg_size = bio_sectors(bio);
+	bio->bi_cg_enter_time = ktime_get_ns();
 
 	blk_throtl_update_ttime(tg);
 
@@ -2264,6 +2289,33 @@ void blk_throtl_bio_endio(struct bio *bio)
 		}
 	}
 
+	if (bio->bi_cg_enter_time && finish_time > bio->bi_cg_enter_time &&
+	    tg->latency_target) {
+		lat = finish_time - bio->bi_cg_enter_time;
+		tg->total_latency += lat;
+		tg->total_size += bio->bi_cg_size << 9;
+		tg->bio_batch++;
+	}
+
+	if (tg->bio_batch >= 8) {
+		int batch = tg->bio_batch;
+		u64 size = tg->total_size;
+
+		lat = tg->total_latency;
+
+		tg->bio_batch = 0;
+		tg->total_latency = 0;
+		tg->total_size = 0;
+
+		if (batch) {
+			do_div(lat, batch);
+			tg->avg_latency = (tg->avg_latency * 7 +
+				lat) >> 3;
+			do_div(size, batch);
+			tg->avg_size = (tg->avg_size * 7 + size) >> 3;
+		}
+	}
+
 end:
 	rcu_read_unlock();
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 45bb437..fe87a20 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -61,6 +61,7 @@ struct bio {
 	struct cgroup_subsys_state *bi_css;
 	void *bi_cg_private;
 	u64 bi_cg_issue_time;
+	u64 bi_cg_enter_time;
 	sector_t bi_cg_size;
 #endif
 	union {
-- 
2.9.3

