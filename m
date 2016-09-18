Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758160AbcIRHhi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:38 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 05/14] blk-mq: Remove a redundant assignment
Date: Sun, 18 Sep 2016 09:37:15 +0200
Message-Id: <d1f923c3217665d106d7a6cb52d267052f0254f6.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_hw_ctx::queue_num is initialized in blk_mq_init_hctx()
function.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c77b68..a38fd2e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2013,7 +2013,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		atomic_set(&hctxs[i]->nr_active, 0);
 		hctxs[i]->numa_node = node;
-		hctxs[i]->queue_num = i;
 
 		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
 			free_cpumask_var(hctxs[i]->cpumask);
-- 
1.8.3.1

