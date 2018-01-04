Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH 1/3] blk-throttle: fix NULL pointer dereference risk in
 throtl_select_dispatch
To: Jens Axboe <axboe@kernel.dk>
Cc: jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com,
 linux-block <linux-block@vger.kernel.org>
Message-ID: <63f2dcbe-6524-82b8-adff-66a860443f65@gmail.com>
Date: Thu, 4 Jan 2018 19:06:07 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

tg in throtl_select_dispatch is used first and then do check. Since tg
may be NULL, it has potential NULL pointer dereference risk. So fix it.

Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9052f4e..a0bae2c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1228,7 +1228,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 	while (1) {
 		struct throtl_grp *tg = throtl_rb_first(parent_sq);
-		struct throtl_service_queue *sq = &tg->service_queue;
+		struct throtl_service_queue *sq;
 
 		if (!tg)
 			break;
@@ -1240,6 +1240,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 		nr_disp += throtl_dispatch_tg(tg);
 
+		sq = &tg->service_queue;
 		if (sq->nr_queued[0] || sq->nr_queued[1])
 			tg_update_disptime(tg);
 
-- 
1.9.4
