Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mchristi@redhat.com,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: shrink bio size again
Date: Mon, 13 Jun 2016 16:48:35 +0200
Message-Id: <1465829315-23137-4-git-send-email-hch@lst.de>
In-Reply-To: <1465829315-23137-1-git-send-email-hch@lst.de>
References: <1465829315-23137-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The recent ops split grew the bio by adding the new ioprio field.
Shrink it again by using a 16-bit field for the bi_flags value and
filling the holes near the beginning of the structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4494b6c..f254eb2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -26,11 +26,11 @@ typedef void (bio_destructor_t) (struct bio *);
 struct bio {
 	struct bio		*bi_next;	/* request queue link */
 	struct block_device	*bi_bdev;
-	unsigned int		bi_flags;	/* status, command, etc */
 	int			bi_error;
 	unsigned int		bi_rw;		/* bottom bits req flags,
 						 * top bits REQ_OP
 						 */
+	unsigned short		bi_flags;	/* status, command, etc */
 	unsigned short		bi_ioprio;
 
 	struct bvec_iter	bi_iter;
@@ -116,7 +116,7 @@ struct bio {
  * Flags starting here get preserved by bio_reset() - this includes
  * BVEC_POOL_IDX()
  */
-#define BIO_RESET_BITS	13
+#define BIO_RESET_BITS	10
 
 /*
  * We support 6 different bvec pools, the last one is magic in that it
@@ -131,7 +131,7 @@ struct bio {
  * freed.
  */
 #define BVEC_POOL_BITS		(4)
-#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
+#define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 
 #endif /* CONFIG_BLOCK */
-- 
2.1.4
