Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:4292 "EHLO
        dggrg01-dlp.huawei.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S933425AbdCKDsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2017 22:48:38 -0500
From: Zhou Chengming <zhouchengming1@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>, <zhouchengming1@huawei.com>
Subject: [PATCH v3] don't forget to call pd_online_fn when activate policy
Date: Sat, 11 Mar 2017 11:46:20 +0800
Message-ID: <1489203980-46134-1-git-send-email-zhouchengming1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When we activate policy on the request_queue, we will create policy_date
for all the existing blkgs of the request_queue, so we should call
pd_init_fn() and pd_online_fn() on these newly created policy_data.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
---
 block/blk-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8ba0af7..1eba1d2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1254,6 +1254,12 @@ int blkcg_activate_policy(struct request_queue *q,
 		pd->plid = pol->plid;
 		if (pol->pd_init_fn)
 			pol->pd_init_fn(pd);
+
+		if (pol->pd_online_fn) {
+			spin_lock(&blkg->blkcg->lock);
+			pol->pd_online_fn(pd);
+			spin_unlock(&blkg->blkcg->lock);
+		}
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
-- 
1.8.3.1
