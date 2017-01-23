Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH] block: remove outdated part of blkdev_issue_flush() comment
Date: Mon, 23 Jan 2017 11:43:21 -0800
Message-Id: <20170123194321.51596-1-ebiggers3@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

blkdev_issue_flush() is now always synchronous, and it no longer has a
flags argument.  So remove the part of the comment about the WAIT flag.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-flush.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 20b7c7a02f1c..3c0ab7361e46 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -490,8 +490,7 @@ void blk_insert_flush(struct request *rq)
  * Description:
  *    Issue a flush for the block device in question. Caller can supply
  *    room for storing the error offset in case of a flush error, if they
- *    wish to. If WAIT flag is not passed then caller may check only what
- *    request was pushed in some internal queue for later handling.
+ *    wish to.
  */
 int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 		sector_t *error_sector)
-- 
2.11.0.483.g087da7b7c-goog
