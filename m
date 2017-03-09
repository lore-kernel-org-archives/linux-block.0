Return-Path: <zhouchengming1@huawei.com>
From: Zhou Chengming <zhouchengming1@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <miaoxie@huawei.com>, <zhouchengming1@huawei.com>
Subject: [PATCH v2] don't forget to call pd_online_fn when activate policy
Date: Thu, 9 Mar 2017 10:20:08 +0800
Message-ID: <1489026008-161611-1-git-send-email-zhouchengming1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

When we activate policy on the request_queue, we will create policy_date
for all the existing blkgs of the request_queue, so we should call
pd_init_fn() and pd_online_fn() on these newly created policy_data.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
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
