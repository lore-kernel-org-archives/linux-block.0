Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:55854 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbcIJLPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Sep 2016 07:15:40 -0400
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] block-throttle: fix throtl_log for throttled-bios dispatch
Date: Sat, 10 Sep 2016 19:11:49 +0800
Message-ID: <1473505909-17603-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

on throtl_pending_timer_fn(), the number of queued rw bios of sq
and dispatched bios are logged, but the numbers are meaningless,
because the dispatched bios are NOT queued on sq->queued[] instead
theses bios are queued on the sq of tg queued on sq->pending_tree,
so move these two throtl_log() to throtl_select_dispatch.

before patch:
1. throttle on /
throtl / [R] bio. bdisp=18432 sz=262144 bps=512000 ... queued=1/0
throtl dispatch nr_queued=0 read=0 write=0
......
throtl bios disp=1

2. throttle on / and /1
throtl /1 [R] bio. bdisp=40960 sz=262144 bps=1024000 ... queued=1/0
throtl dispatch nr_queued=0 read=0 write=0
......
throtl bios disp=1

after patch:
1. throttle on /
throtl / [R] bio. bdisp=26624 sz=262144 bps=512000 ... queued=1/0
throtl / dispatch queued=2/0
......
throtl / dispatch disp=1

2. throttle on / and /1
throtl /1 [R] bio. bdisp=81920 sz=262144 bps=1024000 ... queued=1/0
throtl /1 dispatch queued=2/0
......
throtl /1 dispatch disp=1

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-throttle.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47a3e54..c724c97 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -974,11 +974,12 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 
 static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 {
-	unsigned int nr_disp = 0;
+	unsigned int sum_disp = 0;
 
 	while (1) {
 		struct throtl_grp *tg = throtl_rb_first(parent_sq);
 		struct throtl_service_queue *sq = &tg->service_queue;
+		unsigned int nr_disp;
 
 		if (!tg)
 			break;
@@ -988,16 +989,23 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 		throtl_dequeue_tg(tg);
 
-		nr_disp += throtl_dispatch_tg(tg);
+		throtl_log(sq, "dispatch queued=%u/%u",
+				   sq->nr_queued[READ], sq->nr_queued[WRITE]);
+
+		nr_disp = throtl_dispatch_tg(tg);
+
+		throtl_log(sq, "dispatch disp=%u", nr_disp);
+
+		sum_disp += nr_disp;
 
 		if (sq->nr_queued[0] || sq->nr_queued[1])
 			tg_update_disptime(tg);
 
-		if (nr_disp >= throtl_quantum)
+		if (sum_disp >= throtl_quantum)
 			break;
 	}
 
-	return nr_disp;
+	return sum_disp;
 }
 
 /**
@@ -1031,13 +1039,8 @@ again:
 	dispatched = false;
 
 	while (true) {
-		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
-			   sq->nr_queued[READ] + sq->nr_queued[WRITE],
-			   sq->nr_queued[READ], sq->nr_queued[WRITE]);
-
 		ret = throtl_select_dispatch(sq);
 		if (ret) {
-			throtl_log(sq, "bios disp=%u", ret);
 			dispatched = true;
 		}
 
-- 
2.5.5

