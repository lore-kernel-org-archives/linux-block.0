Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85546108F
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJLQpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhJLQpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:45:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E8C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H0eb5vqBKFV2cPDezYyK4olBJMXczPhCFzXvYnYzoY0=; b=eY1HzMbnIDaeDkDcZY5vrBa65z
        iKru3PNY/Q4IWR3bBrwuR4XZFxRGP6snf6onPLlrLcZs2dAvWz+Ee09VoEA9KDhQMN2TmkwuHw4AV
        5VJxPjWt2/sRvG1aLkmELq1fs8CRtHZoIGgdmtpmdPplpDBQPhZ8tFt8vmd9N3nFoSKpF70fMqp7b
        TeBDSqj/oqitsSK/f9htwzhJXCWR6vn5WIfKyjRCPbqUPb5imrqS0TODZYV/gU0pE3LQk7SJ9csHM
        b6d0tsgpIzkXALfSvopRjUrF/qUMQTlngpzaDyxJftioFZQ9eeS0HF+asKUbwD3nZ9UEEZ0fGqUiF
        TX9xchtQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKpv-006f1p-Pi; Tue, 12 Oct 2021 16:41:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 4/5] block: fold blk_max_size_offset into get_max_io_size
Date:   Tue, 12 Oct 2021 18:36:12 +0200
Message-Id: <20211012163613.994933-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012163613.994933-1-hch@lst.de>
References: <20211012163613.994933-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold blk_max_size_offset into the only remaining user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c      | 14 +++++++++-----
 include/linux/blkdev.h | 19 -------------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b3da43160032f..15b2aef1507e5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -177,14 +177,18 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
-	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
-	unsigned max_sectors = sectors;
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
+	sector_t sector = bio->bi_iter.bi_sector;
+	unsigned start_offset = sector & (pbs - 1);
+	unsigned sectors = q->limits.max_sectors;
+	unsigned max_sectors;
 
-	max_sectors += start_offset;
-	max_sectors &= ~(pbs - 1);
+	if (q->limits.chunk_sectors)
+		sectors = min(chunk_size_left(sector, q->limits.chunk_sectors),
+			      sectors);
+
+	max_sectors = (sectors + start_offset) & ~(pbs - 1);
 	if (max_sectors > start_offset)
 		return max_sectors - start_offset;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0b020bb45a3e7..c2fa4666f25e3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -634,25 +634,6 @@ static inline unsigned int chunk_size_left(sector_t offset,
 	return chunk_sectors - (offset & (chunk_sectors - 1));
 }
 
-/*
- * Return maximum size of a request at given offset. Only valid for
- * file system requests.
- */
-static inline unsigned int blk_max_size_offset(struct request_queue *q,
-					       sector_t offset,
-					       unsigned int chunk_sectors)
-{
-	if (!chunk_sectors) {
-		if (q->limits.chunk_sectors)
-			chunk_sectors = q->limits.chunk_sectors;
-		else
-			return q->limits.max_sectors;
-	}
-
-	return min(q->limits.max_sectors,
-			chunk_size_left(offset, chunk_sectors));
-}
-
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.30.2

