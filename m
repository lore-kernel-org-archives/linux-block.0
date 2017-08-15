Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, qijiang.qj@alibaba-inc.com
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH RESEND] blk-throttle: fix potential NULL pointer dereference
 in throtl_select_dispatch
Message-ID: <43a4a32d-4eb2-4b1b-541f-f0593ad90851@gmail.com>
Date: Tue, 15 Aug 2017 08:54:24 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

Since throtl_rb_first may return NULL, so it should check tg first and
then use it.

Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a7285bf..c1d2c5b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1201,7 +1201,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 	while (1) {
 		struct throtl_grp *tg = throtl_rb_first(parent_sq);
-		struct throtl_service_queue *sq = &tg->service_queue;
+		struct throtl_service_queue *sq;
 
 		if (!tg)
 			break;
@@ -1213,6 +1213,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 		nr_disp += throtl_dispatch_tg(tg);
 
+		sq = &tg->service_queue;
 		if (sq->nr_queued[0] || sq->nr_queued[1])
 			tg_update_disptime(tg);
 
-- 
1.9.4
