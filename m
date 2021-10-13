Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A82C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FF460F21
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJMRVE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJMRVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:21:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D60C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rYFGT7iDLRKUU8zMOy/5mxxbgfh3nFb9YyOqS7yIMMo=; b=Ql6BGHyXLfNDn8uKgiq7GiJY3r
        4H22EWIodWMIFsNc1RABfX0h5VNY9uGZQLVSn22HpuVt1RnBCISvQBGeFmVAIX2Yb9/+2u31tgUlH
        /zk9eem7j4EL8yflwBMe+agLGBNfpXJeG4VarHGV5IKS7taf1Rh6+3nA2D4D3R4bOe6cu7BCtqXuC
        CYYrowNzcToWoTa7iQp9jFnYUF/WOjNhcNqu6hAuyoRtxc9O/yRuQQ8PIG82WV9QbS3sKwEtFiAeF
        fy8u8o4K8SAgJZcc5XQDJ6UnAgRiBWFJvREt8TBxo+vM3Zq9SebWlDt+YL2VsN4LdRwix5qrQVLRC
        m9Okfkrw==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahsq-007ebV-KS; Wed, 13 Oct 2021 17:17:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 5/6] block: fold blk_max_size_offset into get_max_io_size
Date:   Wed, 13 Oct 2021 19:12:14 +0200
Message-Id: <20211013171215.1177671-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013171215.1177671-1-hch@lst.de>
References: <20211013171215.1177671-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold blk_max_size_offset into the only remaining user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c      | 15 ++++++++++-----
 include/linux/blkdev.h | 19 -------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3e9dde152fdcd..87ea3e7b8ad28 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -177,14 +177,19 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
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
+
+	if (q->limits.chunk_sectors) {
+		sectors = min(sectors, blk_chunk_sectors_left(sector,
+						q->limits.chunk_sectors));
+	}
 
-	max_sectors += start_offset;
-	max_sectors &= ~(pbs - 1);
+	max_sectors = (sectors + start_offset) & ~(pbs - 1);
 	if (max_sectors > start_offset)
 		return max_sectors - start_offset;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c6ecd996c2d46..7e6b68969cec0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -634,25 +634,6 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
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
-			blk_chunk_sectors_left(offset, chunk_sectors));
-}
-
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.30.2

