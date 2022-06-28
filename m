Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3420CCA479
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 14:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346751AbiF1Ogn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbiF1Ogn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 10:36:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC362A429
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:36:42 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXRsL0js4zTgHb;
        Tue, 28 Jun 2022 22:33:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 22:36:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 2/2] blk-cgroup: factor out blkcg_free_all_cpd()
Date:   Tue, 28 Jun 2022 22:49:21 +0800
Message-ID: <20220628144921.2190275-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220628144921.2190275-1-yanaijie@huawei.com>
References: <20220628144921.2190275-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To reduce some duplicated code, factor out blkcg_free_all_cpd(). No
functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 block/blk-cgroup.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 60d205ec213e..22268af435bd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1532,6 +1532,18 @@ void blkcg_deactivate_policy(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
 
+static void blkcg_free_all_cpd(struct blkcg_policy *pol)
+{
+	struct blkcg *blkcg;
+
+	list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
+		if (blkcg->cpd[pol->plid]) {
+			pol->cpd_free_fn(blkcg->cpd[pol->plid]);
+			blkcg->cpd[pol->plid] = NULL;
+		}
+	}
+}
+
 /**
  * blkcg_policy_register - register a blkcg policy
  * @pol: blkcg policy to register
@@ -1596,14 +1608,9 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	return 0;
 
 err_free_cpds:
-	if (pol->cpd_free_fn) {
-		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
-			if (blkcg->cpd[pol->plid]) {
-				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
-				blkcg->cpd[pol->plid] = NULL;
-			}
-		}
-	}
+	if (pol->cpd_free_fn)
+		blkcg_free_all_cpd(pol);
+
 	blkcg_policy[pol->plid] = NULL;
 err_unlock:
 	mutex_unlock(&blkcg_pol_mutex);
@@ -1620,8 +1627,6 @@ EXPORT_SYMBOL_GPL(blkcg_policy_register);
  */
 void blkcg_policy_unregister(struct blkcg_policy *pol)
 {
-	struct blkcg *blkcg;
-
 	mutex_lock(&blkcg_pol_register_mutex);
 
 	if (WARN_ON(blkcg_policy[pol->plid] != pol))
@@ -1636,14 +1641,9 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	/* remove cpds and unregister */
 	mutex_lock(&blkcg_pol_mutex);
 
-	if (pol->cpd_free_fn) {
-		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
-			if (blkcg->cpd[pol->plid]) {
-				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
-				blkcg->cpd[pol->plid] = NULL;
-			}
-		}
-	}
+	if (pol->cpd_free_fn)
+		blkcg_free_all_cpd(pol);
+
 	blkcg_policy[pol->plid] = NULL;
 
 	mutex_unlock(&blkcg_pol_mutex);
-- 
2.31.1

