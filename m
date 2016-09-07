Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35336 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbcIGXqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2016 19:46:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id b2so10889778pat.2
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2016 16:46:23 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/5] scale_bitmap: randomize initial last_cache values
Date: Wed,  7 Sep 2016 16:46:06 -0700
Message-Id: <85250262e068a837772c2264707623e56b067788.1473291703.git.osandov@fb.com>
In-Reply-To: <cover.1473291702.git.osandov@fb.com>
References: <cover.1473291702.git.osandov@fb.com>
In-Reply-To: <cover.1473291702.git.osandov@fb.com>
References: <cover.1473291702.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In order to get good cache behavior from a scale_bitmap, we want each
CPU to stick to its own cacheline(s) as much as possible. This might
happen naturally as the bitmap gets filled up and the last_cache values
spread out, but we really want this behavior from the start. blk-mq
apparently intended to do this, but the code to do this was never wired
up. Get rid of the dead code and make it part of the scale_bitmap
library.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c | 8 --------
 block/blk-mq-tag.h | 1 -
 lib/scale_bitmap.c | 6 ++++++
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 4dff92c..30d4838 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -7,7 +7,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/random.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
@@ -422,13 +421,6 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
 	kfree(tags);
 }
 
-void blk_mq_tag_init_last_tag(struct blk_mq_tags *tags, unsigned int *tag)
-{
-	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags;
-
-	*tag = prandom_u32() % depth;
-}
-
 int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int tdepth)
 {
 	tdepth -= tags->nr_reserved_tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index e6fc179c..f511e0a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -30,7 +30,6 @@ extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 			   unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
-extern void blk_mq_tag_init_last_tag(struct blk_mq_tags *tags, unsigned int *last_tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int depth);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
diff --git a/lib/scale_bitmap.c b/lib/scale_bitmap.c
index 8abe2cd..d88c792 100644
--- a/lib/scale_bitmap.c
+++ b/lib/scale_bitmap.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
 
+#include <linux/random.h>
 #include <linux/scale_bitmap.h>
 
 int scale_bitmap_init_node(struct scale_bitmap *bitmap, unsigned int depth,
@@ -212,6 +213,11 @@ int scale_bitmap_queue_init_node(struct scale_bitmap_queue *sbq,
 		return -ENOMEM;
 	}
 
+	if (depth && !round_robin) {
+		for_each_possible_cpu(i)
+			*per_cpu_ptr(sbq->alloc_hint, i) = prandom_u32() % depth;
+	}
+
 	sbq->wake_batch = SBQ_WAKE_BATCH;
 	if (sbq->wake_batch > depth / SBQ_WAIT_QUEUES)
 		sbq->wake_batch = max(1U, depth / SBQ_WAIT_QUEUES);
-- 
2.9.3

