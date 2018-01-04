Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH 2/3] blk-throttle: support only configure leaf nodes
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>
Cc: jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com,
 linux-block <linux-block@vger.kernel.org>
Message-ID: <eae0b6c4-05e4-8b2c-5090-9e42466808fb@gmail.com>
Date: Thu, 4 Jan 2018 19:06:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

Currently if we only configure leaf nodes, downgrade check won't
function properly as parent's last low overflow time is meaningless and
always returns now, thus it will be treated always run above low limit
and doesn't have to do downgrade.
In this case, since parent doesn't have low limit, ignore checking it
and just depend on child's decision.
Note that we do not support only configure intermediate nodes.

Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
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
