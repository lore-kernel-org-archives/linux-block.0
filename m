Return-Path: <zhangweiping@didichuxing.com>
Date: Tue, 10 Oct 2017 22:53:46 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: check pol->cpd_free_fn before free cpd
Message-ID: <20171010145342.GA24247@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

check pol->cpd_free_fn() instead of pol->cpd_alloc_fn() when free cpd.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d3f56ba..e7ec676 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1452,7 +1452,7 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	return 0;
 
 err_free_cpds:
-	if (pol->cpd_alloc_fn) {
+	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
 				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
@@ -1492,7 +1492,7 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	/* remove cpds and unregister */
 	mutex_lock(&blkcg_pol_mutex);
 
-	if (pol->cpd_alloc_fn) {
+	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
 				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
-- 
2.9.4
