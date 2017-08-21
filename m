Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:8641 "EHLO
        BJEXCAS006.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753126AbdHUPNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 11:13:08 -0400
Date: Mon, 21 Aug 2017 23:12:43 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: add a cleanup when active policy fail
Message-ID: <20170821151238.GA28794@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

if alloc memory fail, all cpds which were allocated before should be cleaned up.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0480892..7e21c4b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1336,6 +1336,17 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	spin_unlock_irq(q->queue_lock);
 out_bypass_end:
+	if (ret) {
+		spin_lock_irq(q->queue_lock);
+		list_for_each_entry(blkg, &q->blkg_list, q_node) {
+			if (blkg->pd[pol->plid]) {
+				if (pol->pd_free_fn)
+					pol->pd_free_fn(blkg->pd[pol->plid]);
+				blkg->pd[pol->plid] = NULL;
+			}
+		}
+		spin_unlock_irq(q->queue_lock);
+	}
 	if (q->mq_ops)
 		blk_mq_unfreeze_queue(q);
 	else
-- 
2.9.4
