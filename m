Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:32867 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751002AbeAVBRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jan 2018 20:17:23 -0500
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH RESEND 1/3] blk-throttle: fix NULL pointer dereference risk in
 throtl_select_dispatch
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        jiufei.xue@linux.alibaba.com, caspar@linux.alibaba.com
Message-ID: <5d2c2323-058d-7008-85b5-4a353418a341@linux.alibaba.com>
Date: Mon, 22 Jan 2018 09:17:21 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

tg in throtl_select_dispatch is used first and then do check. Since tg
may be NULL, it has potential NULL pointer dereference risk. So fix it.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
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
