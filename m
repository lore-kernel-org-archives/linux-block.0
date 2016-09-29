Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:60416
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754542AbcI2PsQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 11:48:16 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH v2] blkcg: Unlock blkcg_pol_mutex once if cpd == NULL
To: Jens Axboe <axboe@fb.com>
CC: Tejun Heo <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <e9746d79-c14d-bf76-5218-3e7cdfbf4b34@sandisk.com>
Date: Thu, 29 Sep 2016 08:33:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Unlocking a mutex twice is wrong. Hence modify blkcg_policy_register()
such that blkcg_pol_mutex is unlocked once if cpd == NULL. This patch
avoids that smatch reports the following error:

block/blk-cgroup.c:1378: blkcg_policy_register() error: double unlock 'mutex:&blkcg_pol_mutex'

Fixes: 06b285bd1125 ("blkcg: fix blkcg_policy_data allocation bug")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
---
 block/blk-cgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dd38e5c..b08ccbb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1340,10 +1340,8 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			struct blkcg_policy_data *cpd;
 
 			cpd = pol->cpd_alloc_fn(GFP_KERNEL);
-			if (!cpd) {
-				mutex_unlock(&blkcg_pol_mutex);
+			if (!cpd)
 				goto err_free_cpds;
-			}
 
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
-- 
2.10.0


