Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] bfq-iosched: don't worry about reserved tags in limit_depth
Date: Wed,  9 May 2018 14:49:22 -0600
Message-Id: <1525898967-13425-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
References: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Reserved tags are used for error handling, we don't need to
care about them for regular IO. The core won't call us for these
anyway.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ebc264c87a09..246ae25a5f34 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -542,14 +542,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 	if (op_is_sync(op) && !op_is_write(op))
 		return;
 
-	if (data->flags & BLK_MQ_REQ_RESERVED) {
-		if (unlikely(!tags->nr_reserved_tags)) {
-			WARN_ON_ONCE(1);
-			return;
-		}
-		bt = &tags->breserved_tags;
-	} else
-		bt = &tags->bitmap_tags;
+	bt = &tags->bitmap_tags;
 
 	if (unlikely(bfqd->sb_shift != bt->sb.shift))
 		bfq_update_depths(bfqd, bt);
-- 
2.7.4
