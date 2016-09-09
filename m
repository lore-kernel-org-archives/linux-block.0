Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35989 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754414AbcIISmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 14:42:33 -0400
Received: by mail-pa0-f41.google.com with SMTP id id6so30774734pad.3
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 11:42:33 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v3 5/5] sbitmap: randomize initial last_cache values
Date: Fri,  9 Sep 2016 11:42:11 -0700
Message-Id: <38c544e501d976df00a7e13b3041fcfca2a117ed.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In order to get good cache behavior from a sbitmap, we want each CPU to
stick to its own cacheline(s) as much as possible. This might happen
naturally as the bitmap gets filled up and the last_cache values spread
out, but we really want this behavior from the start. blk-mq apparently
intended to do this, but the code to do this was never wired up. Get rid
of the dead code and make it part of the sbitmap library.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c | 8 --------
 block/blk-mq-tag.h | 1 -
 lib/sbitmap.c      | 6 ++++++
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e1c2bed..cef618f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -7,7 +7,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/random.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
@@ -419,13 +418,6 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
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
index f90b850..09f4cc0 100644
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
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 3a91269..d873bb0a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
 
+#include <linux/random.h>
 #include <linux/sbitmap.h>
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -208,6 +209,11 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
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

