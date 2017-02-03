Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28957 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdBCJSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2017 04:18:30 -0500
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>
Subject: [PATCH RESEND] blkcg: fix double free of new_blkg in blkcg_init_queue
Date: Fri, 3 Feb 2017 17:19:07 +0800
Message-ID: <1486113547-43833-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If blkg_create fails, new_blkg passed as an argument will
be freed by blkg_create, so there is no need to free it again.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-cgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8ba0af7..f570f38 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1079,10 +1079,8 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	if (IS_ERR(blkg)) {
-		blkg_free(new_blkg);
+	if (IS_ERR(blkg))
 		return PTR_ERR(blkg);
-	}
 
 	q->root_blkg = blkg;
 	q->root_rl.blkg = blkg;
-- 
2.5.0

