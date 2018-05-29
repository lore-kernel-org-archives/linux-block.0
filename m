Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57840 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754942AbeE2IaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 May 2018 04:30:01 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH RESEND] blk-throttle: fix potential NULL pointer dereference in throtl_select_dispatch
Date: Tue, 29 May 2018 16:29:12 +0800
Message-Id: <1527582552-4841-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

tg in throtl_select_dispatch is used first and then do check. Since tg
may be NULL, it has potential NULL pointer dereference risk. So fix
it.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dffe982..a168e82 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1294,7 +1294,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 	while (1) {
 		struct throtl_grp *tg = throtl_rb_first(parent_sq);
-		struct throtl_service_queue *sq = &tg->service_queue;
+		struct throtl_service_queue *sq;
 
 		if (!tg)
 			break;
@@ -1306,6 +1306,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 
 		nr_disp += throtl_dispatch_tg(tg);
 
+		sq = &tg->service_queue;
 		if (sq->nr_queued[0] || sq->nr_queued[1])
 			tg_update_disptime(tg);
 
-- 
1.8.3.1
