Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH] block: correct documentation for blkdev_issue_discard() flags
Date: Mon, 23 Jan 2017 11:41:39 -0800
Message-Id: <20170123194139.51469-1-ebiggers3@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

BLKDEV_IFL_* flags no longer exist; blkdev_issue_discard() now actually
takes BLKDEV_DISCARD_* flags.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ed89c8f4b2a0..463b76dd566f 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
  * @sector:	start sector
  * @nr_sects:	number of sectors to discard
  * @gfp_mask:	memory allocation flags (for bio_alloc)
- * @flags:	BLKDEV_IFL_* flags to control behaviour
+ * @flags:	BLKDEV_DISCARD_* flags to control behaviour
  *
  * Description:
  *    Issue a discard request for the sectors in question.
-- 
2.11.0.483.g087da7b7c-goog
