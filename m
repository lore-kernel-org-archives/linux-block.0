Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45797 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965464AbeF2B6k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 21:58:40 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] Block: blk-throttle: set low_valid immediately once one cgroup has io.low configured
Date: Fri, 29 Jun 2018 09:56:56 +0800
Message-Id: <1530237416-105735-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Once one cgroup has io.low configured, @low_valid becomes true and other
cgroups won't switch it back whatsoever.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-throttle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8bd54118dc0a..479c6b9dcf10 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -579,8 +579,10 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		if (tg->bps[READ][LIMIT_LOW] || tg->bps[WRITE][LIMIT_LOW] ||
-		    tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW])
+		    tg->iops[READ][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) {
 			low_valid = true;
+			break;
+		}
 	}
 	rcu_read_unlock();
 
-- 
1.8.3.1
