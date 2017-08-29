Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:32961 "EHLO
        BJEXCAS007.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751867AbdH2QI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2017 12:08:27 -0400
Date: Wed, 30 Aug 2017 00:08:17 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: check pol->cpd_free_fn before free cpd
Message-ID: <20170829160811.GA1324@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

check pol->cpd_free_fn() instead of pol->cpd_alloc_fn() when free cpd.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0480892..adcbc3e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1044,7 +1044,7 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 	list_del(&blkcg->all_blkcgs_node);
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
-		if (blkcg->cpd[i])
+		if (blkcg->cpd[i] && blkcg_policy[i]->cpd_free_fn)
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
 
 	mutex_unlock(&blkcg_pol_mutex);
@@ -1109,7 +1109,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 
 free_pd_blkcg:
 	for (i--; i >= 0; i--)
-		if (blkcg->cpd[i])
+		if (blkcg->cpd[i] && blkcg_policy[i]->cpd_free_fn)
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
 free_blkcg:
 	kfree(blkcg);
@@ -1450,7 +1450,7 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	return 0;
 
 err_free_cpds:
-	if (pol->cpd_alloc_fn) {
+	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
 				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
@@ -1490,7 +1490,7 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	/* remove cpds and unregister */
 	mutex_lock(&blkcg_pol_mutex);
 
-	if (pol->cpd_alloc_fn) {
+	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
 				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
-- 
2.9.4
