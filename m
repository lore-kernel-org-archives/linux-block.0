Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH] blk-throttle: fix wrong initialization in case of dm device
To: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>
Cc: wenqing.lz@taobao.com, boyu.mt@taobao.com, qijiang.qj@alibaba-inc.com
Message-ID: <da3a4940-9c03-53e0-8e73-3ea941a374c5@gmail.com>
Date: Mon, 6 Nov 2017 08:38:59 +0800
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
 block/blk-throttle.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 17816a0..6aeb79e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -539,6 +539,21 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	sq->parent_sq = &td->service_queue;
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && blkg->parent)
 		sq->parent_sq = &blkg_to_tg(blkg->parent)->service_queue;
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
+		for (i = 0; i < LATENCY_BUCKET_SIZE; i++)
+			td->avg_buckets[i].latency = 0;
+	}
 	tg->td = td;
 }
 
-- 
1.9.4
