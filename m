Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56335 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbeAVBRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jan 2018 20:17:45 -0500
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH RESEND 2/3] blk-throttle: support only configure leaf nodes
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>
Cc: jiufei.xue@linux.alibaba.com, caspar@linux.alibaba.com,
        linux-block <linux-block@vger.kernel.org>
Message-ID: <b00453d6-e7b5-c079-dd08-385fbea6fd29@linux.alibaba.com>
Date: Mon, 22 Jan 2018 09:17:42 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently if we only configure leaf nodes, downgrade check won't
function properly as parent's last low overflow time is meaningless and
always returns now, thus it will be treated always run above low limit
and doesn't have to do downgrade.
In this case, since parent doesn't have low limit, ignore checking it
and just depend on child's decision.
Note that we do not support only configure intermediate nodes.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/blk-throttle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a0bae2c..9c0b5ff 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1959,6 +1959,15 @@ static bool throtl_tg_can_downgrade(struct throtl_grp *tg)
 	unsigned long now = jiffies;
 
 	/*
+	 * If parent doesn't have low limit, only consider child's
+	 * decision.
+	 */
+	if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children) &&
+	    !tg->bps[READ][LIMIT_LOW] && !tg->bps[WRITE][LIMIT_LOW] &&
+	    !tg->iops[READ][LIMIT_LOW] && !tg->iops[WRITE][LIMIT_LOW])
+		return true;
+
+	/*
 	 * If cgroup is below low limit, consider downgrade and throttle other
 	 * cgroups
 	 */
-- 
1.9.4
