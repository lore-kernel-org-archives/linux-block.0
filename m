Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:3932 "EHLO
        dggrg03-dlp.huawei.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756770AbdCHEOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Mar 2017 23:14:14 -0500
From: Zhou Chengming <zhouchengming1@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>, <zhouchengming1@huawei.com>
Subject: [PATCH] don't forget to call pd_online_fn when activate policy
Date: Wed, 8 Mar 2017 12:09:47 +0800
Message-ID: <1488946187-42760-1-git-send-email-zhouchengming1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: z00354408 <z00354408@notesmail.huawei.com>

Signed-off-by: z00354408 <z00354408@notesmail.huawei.com>
---
 block/blk-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8ba0af7..0dd9e76 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1254,6 +1254,12 @@ int blkcg_activate_policy(struct request_queue *q,
 		pd->plid = pol->plid;
 		if (pol->pd_init_fn)
 			pol->pd_init_fn(pd);
+
+		if (pol->pd_online_fn) {
+			spin_lock(blkg->blkcg->lock);
+			pol->pd_online_fn(pd);
+			spin_unlock(blkg->blkcg->lock);
+		}
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
-- 
1.8.3.1
