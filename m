Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: remove blk_mq_alloc_single_hw_queue() prototype
Date: Wed, 14 Sep 2016 14:33:15 +0200
Message-Id: <1473856395-22262-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The blk_mq_alloc_single_hw_queue() is a prototype artifact that
should have been removed with
commit cdef54dd85ad66e77262ea57796a3e81683dd5d6
"blk-mq: remove alloc_hctx and free_hctx methods" where the last
users of it were deleted.

Fixes: cdef54dd85ad ("blk-mq: remove alloc_hctx and free_hctx methods")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/blk-mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e43bbffb5b7a..d3fb9c3c6969 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -221,7 +221,6 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *, const int ctx_index);
-struct blk_mq_hw_ctx *blk_mq_alloc_single_hw_queue(struct blk_mq_tag_set *, unsigned int, int);
 
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
-- 
2.7.4
