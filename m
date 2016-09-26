Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:65212
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753240AbcIZWgf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 18:36:35 -0400
To: Jens Axboe <axboe@fb.com>
CC: Tejun Heo <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] blkcg: Unlock blkcg_pol_mutex once if cpd == NULL
Message-ID: <db0c6205-9ca2-d80e-26fc-6cff0d84d73c@sandisk.com>
Date: Mon, 26 Sep 2016 15:36:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Unlocking a mutex twice is wrong. Hence modify blkcg_policy_register()
such that blkcg_pol_mutex is unlocked once if cpd == NULL. This patch
avoids that smatch reports the following error:

block/blk-cgroup.c:1378: blkcg_policy_register() error: double unlock 'mutex:&blkcg_pol_mutex'

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
---
 block/blk-cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dd38e5c..cdbca1c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1327,8 +1327,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (!blkcg_policy[i])
 			break;
-	if (i >= BLKCG_MAX_POLS)
+	if (i >= BLKCG_MAX_POLS) {
+		mutex_unlock(&blkcg_pol_mutex);
 		goto err_unlock;
+	}
 
 	/* register @pol */
 	pol->plid = i;
@@ -1374,8 +1376,8 @@ err_free_cpds:
 		}
 	}
 	blkcg_policy[pol->plid] = NULL;
+
 err_unlock:
-	mutex_unlock(&blkcg_pol_mutex);
 	mutex_unlock(&blkcg_pol_register_mutex);
 	return ret;
 }
-- 
2.10.0

