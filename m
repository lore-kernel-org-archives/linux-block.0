Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH v2 2/2] blk-throttle: fix wrong initialization in case of dm
 device
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
 linux-block <linux-block@vger.kernel.org>
Cc: qijiang.qj@alibaba-inc.com
Message-ID: <241a6fbe-f2d2-3d11-ba45-afc5b02de9c2@gmail.com>
Date: Mon, 20 Nov 2017 10:00:27 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

dm device set QUEUE_FLAG_NONROT in resume, which is after register
queue. That is to mean, the previous initialization in
blk_throtl_register_queue is wrong in this case.
Fix it by checking and then updating the info during root tg
initialization as we don't have a better choice.

Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-throttle.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bf52035..6d6b220 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -541,6 +541,23 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && blkg->parent)
 		sq->parent_sq = &blkg_to_tg(blkg->parent)->service_queue;
 	tg->td = td;
+
+	/*
+	 * dm device set QUEUE_FLAG_NONROT in resume, which is after resister
+	 * queue, so the previous initialization is wrong in this case. Check
+	 * and update it here.
+	 */
+	if (blk_queue_nonrot(blkg->q) &&
+	    td->filtered_latency != LATENCY_FILTERED_SSD) {
+		int i;
+
+		td->throtl_slice = DFL_THROTL_SLICE_SSD;
+		td->filtered_latency = LATENCY_FILTERED_SSD;
+		for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
+			td->avg_buckets[READ][i].latency = 0;
+			td->avg_buckets[WRITE][i].latency = 0;
+		}
+	}
 }
 
 /*
-- 
1.9.4
