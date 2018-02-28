Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40391 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeB1A4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 19:56:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id m5so318606pff.7
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 16:56:50 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] block: clear ctx pending bit under ctx lock
Date: Tue, 27 Feb 2018 16:56:42 -0800
Message-Id: <d035a59a30e8a39176b4e4a9a92ece3c76d21399.1519779182.git.osandov@fb.com>
In-Reply-To: <cover.1519779182.git.osandov@fb.com>
References: <cover.1519779182.git.osandov@fb.com>
In-Reply-To: <cover.1519779182.git.osandov@fb.com>
References: <cover.1519779182.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When we insert a request, we set the software queue pending bit while
holding the software queue lock. However, we clear it outside of the
lock, so it's possible that a concurrent insert could reset the bit
after we clear it but before we empty the request list. Afterwards, the
bit would still be set but the software queue wouldn't have any requests
in it, leading us to do a spurious run in the future. This is mostly a
benign/theoretical issue, but it makes the following change easier to
justify.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 357492712b0e..09a57d97ca7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -984,9 +984,9 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
 
-	sbitmap_clear_bit(sb, bitnr);
 	spin_lock(&ctx->lock);
 	list_splice_tail_init(&ctx->rq_list, flush_data->list);
+	sbitmap_clear_bit(sb, bitnr);
 	spin_unlock(&ctx->lock);
 	return true;
 }
-- 
2.16.2
