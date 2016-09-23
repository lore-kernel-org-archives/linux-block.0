Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:62336
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965714AbcIWQWz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 12:22:55 -0400
To: Jens Axboe <axboe@fb.com>
CC: Tejun Heo <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] blkcg: Annotate blkg_hint correctly
Message-ID: <a22244c9-c8fa-2538-688e-58b7284dc387@sandisk.com>
Date: Fri, 23 Sep 2016 09:07:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that sparse complains about blkg_hint manipulations.

Fixes: a637120e4902 ("blkcg: use radix tree to index blkgs from blkcg")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 10648e3..cbdbf34 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -45,7 +45,7 @@ struct blkcg {
 	spinlock_t			lock;
 
 	struct radix_tree_root		blkg_tree;
-	struct blkcg_gq			*blkg_hint;
+	struct blkcg_gq	__rcu		*blkg_hint;
 	struct hlist_head		blkg_list;
 
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
-- 
2.10.0

