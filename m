Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50205 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424284AbcKANkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:24 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/16] bcache: use op_is_sync to check for synchronous requests
Date: Tue,  1 Nov 2016 07:40:05 -0600
Message-Id: <1478007617-18715-5-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

(and remove one layer of masking for the op_is_write call next to it).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/request.c   | 4 ++--
 drivers/md/bcache/writeback.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 40ffe5e..e8a2b69 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -404,8 +404,8 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 
 	if (!congested &&
 	    mode == CACHE_MODE_WRITEBACK &&
-	    op_is_write(bio_op(bio)) &&
-	    (bio->bi_opf & REQ_SYNC))
+	    op_is_write(bio->bi_opf) &&
+	    op_is_sync(bio->bi_opf))
 		goto rescale;
 
 	spin_lock(&dc->io_lock);
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 301eaf5..629bd1a 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -57,8 +57,7 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 	if (would_skip)
 		return false;
 
-	return bio->bi_opf & REQ_SYNC ||
-		in_use <= CUTOFF_WRITEBACK;
+	return op_is_sync(bio->bi_opf) || in_use <= CUTOFF_WRITEBACK;
 }
 
 static inline void bch_writeback_queue(struct cached_dev *dc)
-- 
2.1.4

