Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932253AbcIRHho (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:44 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 10/14] blk-mq: Uninit hardware context in order reverse to init
Date: Sun, 18 Sep 2016 09:37:20 +0200
Message-Id: <cdf0bb66b4fa3bdcedb3bcd2df57ff38ed9fb02c.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cd32a08..c589096 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2013,12 +2013,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
+			kobject_put(&hctx->kobj);
+
 			if (hctx->tags) {
 				blk_mq_free_rq_map(set, hctx->tags, j);
 				set->tags[j] = NULL;
 			}
 			blk_mq_exit_hctx(q, set, hctx, j);
-			kobject_put(&hctx->kobj);
 			hctxs[j] = NULL;
 		}
 	}
-- 
1.8.3.1

