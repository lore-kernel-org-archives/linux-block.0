Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33540 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756046AbdDETC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 15:02:57 -0400
Received: by mail-pg0-f41.google.com with SMTP id x125so12936313pgb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 12:02:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 8/8] blk-mq: use true instead of 1 for blk_mq_queue_data.last
Date: Wed,  5 Apr 2017 12:01:36 -0700
Message-Id: <78a868e8cbebc63525fe9aedc226c971a89d8186.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Trivial cleanup.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index de57e7727c52..c82fcb923ff8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1435,7 +1435,7 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
-		.last = 1
+		.last = true,
 	};
 	struct blk_mq_hw_ctx *hctx;
 	blk_qc_t new_cookie;
-- 
2.12.2
