Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] blk-mq: fix typo in a function comment
Date: Sat, 30 Jun 2018 22:12:41 +0900
Message-Id: <1530364361-5026-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Fix typo in a function blk_mq_alloc_tag_set() comment.
if if it too large -> if it's too large.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d51..706f35e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2701,7 +2701,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
- * requested depth down, if if it too large. In that case, the set
+ * requested depth down, if it's too large. In that case, the set
  * value will be stored in set->queue_depth.
  */
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
-- 
2.7.4
