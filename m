Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:15308 "EHLO
        BJEXCAS002.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752814AbdKWNjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:39:09 -0500
Date: Thu, 23 Nov 2017 21:39:03 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 1/5] blk-wbt: remove duplicated setting in wbt_init
Message-ID: <30a5272ce52ad928da45a3f7981a42e008f70838.1511444141.git.zhangweiping@didichuxing.com>
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rwb->wc and rwb->queue_depth were overwritten by wbt_set_write_cache and
wbt_set_queue_depth, remove the default setting.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-wbt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e59d59c..edb09e93 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -723,8 +723,6 @@ int wbt_init(struct request_queue *q)
 		init_waitqueue_head(&rwb->rq_wait[i].wait);
 	}
 
-	rwb->wc = 1;
-	rwb->queue_depth = RWB_DEF_DEPTH;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->queue = q;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
-- 
2.9.4
