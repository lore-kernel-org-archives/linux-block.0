Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:23910 "EHLO
        BJEXCAS005.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933662AbdHYPto (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 11:49:44 -0400
Date: Fri, 25 Aug 2017 23:49:32 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: avoid free blkcg_root when failed to alloc blkcg
 policy
Message-ID: <20170825154926.GA25023@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

this patch fix two errors, firstly avoid kfree blk_root, secondly not
free(blkcg) ,if blkcg alloc fail(blkcg == NULL), just unlock that mutex;

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0480892..d3f56ba 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1067,7 +1067,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg = kzalloc(sizeof(*blkcg), GFP_KERNEL);
 		if (!blkcg) {
 			ret = ERR_PTR(-ENOMEM);
-			goto free_blkcg;
+			goto unlock;
 		}
 	}
 
@@ -1111,8 +1111,10 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	for (i--; i >= 0; i--)
 		if (blkcg->cpd[i])
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
-free_blkcg:
-	kfree(blkcg);
+
+	if (blkcg != &blkcg_root)
+		kfree(blkcg);
+unlock:
 	mutex_unlock(&blkcg_pol_mutex);
 	return ret;
 }
-- 
2.9.4
