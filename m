Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:15313 "EHLO
        BJEXCAS008.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752680AbdKWNkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:40:14 -0500
Date: Thu, 23 Nov 2017 21:40:10 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 5/5] blk-wbt: fix comments typo
Message-ID: <6d3b007ad4f6925a77d287ea1cc6552aa32927b2.1511444141.git.zhangweiping@didichuxing.com>
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-wbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index cd9a20a..9f4ef9c 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -481,7 +481,7 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 
 	/*
 	 * At this point we know it's a buffered write. If this is
-	 * kswapd trying to free memory, or REQ_SYNC is set, set, then
+	 * kswapd trying to free memory, or REQ_SYNC is set, then
 	 * it's WB_SYNC_ALL writeback, and we'll use the max limit for
 	 * that. If the write is marked as a background write, then use
 	 * the idle limit, or go to normal if we haven't had competing
-- 
2.9.4
