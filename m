Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:30908 "EHLO
        BJEXMBX012.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752680AbdKWNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:40:01 -0500
Date: Thu, 23 Nov 2017 21:39:55 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 4/5] blk-wbt: move wbt_clear_stat to common place in wbt_done
Message-ID: <7614401233068669e19b4d0d9e257cc5b84cd906.1511444141.git.zhangweiping@didichuxing.com>
References: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1511444141.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

wbt_done call wbt_clear_stat no matter current stat was tracked
or not, move it to common place.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-wbt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0fb65f0..cd9a20a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -178,12 +178,11 @@ void wbt_done(struct rq_wb *rwb, struct blk_issue_stat *stat)
 
 		if (wbt_is_read(stat))
 			wb_timestamp(rwb, &rwb->last_comp);
-		wbt_clear_state(stat);
 	} else {
 		WARN_ON_ONCE(stat == rwb->sync_cookie);
 		__wbt_done(rwb, wbt_stat_to_mask(stat));
-		wbt_clear_state(stat);
 	}
+	wbt_clear_state(stat);
 }
 
 /*
-- 
2.9.4
