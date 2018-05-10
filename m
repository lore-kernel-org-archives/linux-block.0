Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] blk-mq: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:33 -0700
Message-Id: <55ec0aec733169ae8cd8eec0a9581c693725de04.1525964385.git.joe@perches.com>
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
List-ID: <linux-block@vger.kernel.org>

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ce9cac16c3f..37e6206e745c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2782,13 +2782,13 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	} while (set->queue_depth);
 
 	if (!set->queue_depth || err) {
-		pr_err("blk-mq: failed to allocate request map\n");
+		pr_err("failed to allocate request map\n");
 		return -ENOMEM;
 	}
 
 	if (depth != set->queue_depth)
-		pr_info("blk-mq: reduced tag depth (%u -> %u)\n",
-						depth, set->queue_depth);
+		pr_info("reduced tag depth (%u -> %u)\n",
+			depth, set->queue_depth);
 
 	return 0;
 }
@@ -2845,8 +2845,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		return -EINVAL;
 
 	if (set->queue_depth > BLK_MQ_MAX_DEPTH) {
-		pr_info("blk-mq: reduced tag depth to %u\n",
-			BLK_MQ_MAX_DEPTH);
+		pr_info("reduced tag depth to %u\n", BLK_MQ_MAX_DEPTH);
 		set->queue_depth = BLK_MQ_MAX_DEPTH;
 	}
 
-- 
2.15.0
