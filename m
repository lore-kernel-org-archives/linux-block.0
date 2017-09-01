Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:9151 "EHLO
        BJEXCAS007.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751924AbdIAORj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Sep 2017 10:17:39 -0400
Date: Fri, 1 Sep 2017 22:17:29 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2 1/2] blkcg: check pol->cpd_free_fn before free cpd
Message-ID: <acad1f83be4fdb54fc2e89886ad23f8dbb25b22f.1504275001.git.zhangweiping@didichuxing.com>
References: <cover.1504275001.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1504275001.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

check pol->cpd_free_fn() instead of pol->cpd_alloc_fn() when free cpd.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0480892..0c45870 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
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
