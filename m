Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49555 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbcJTNMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:22 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: remove bio_is_rw
Date: Thu, 20 Oct 2016 15:12:09 +0200
Message-Id: <1476969135-32732-2-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

With the addition of the zoned operations the tests in this function
became incorrect.  But I think it's much better to just open code the
allow operations in the only caller anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c |  2 +-
 include/linux/bio.h   | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 63f72f0..5384713 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -172,7 +172,7 @@ bool bio_integrity_enabled(struct bio *bio)
 {
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 
-	if (!bio_is_rw(bio))
+	if (bio_op(bio) != REQ_OP_READ && bio_op(bio) != REQ_OP_WRITE)
 		return false;
 
 	/* Already protected? */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97cb48f..87ce64d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -83,17 +83,6 @@ static inline bool bio_no_advance_iter(struct bio *bio)
 	       bio_op(bio) == REQ_OP_WRITE_SAME;
 }
 
-static inline bool bio_is_rw(struct bio *bio)
-{
-	if (!bio_has_data(bio))
-		return false;
-
-	if (bio_no_advance_iter(bio))
-		return false;
-
-	return true;
-}
-
 static inline bool bio_mergeable(struct bio *bio)
 {
 	if (bio->bi_opf & REQ_NOMERGE_FLAGS)
-- 
2.1.4

