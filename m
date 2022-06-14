Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C405C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353038AbiFNJKA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351222AbiFNJJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE523F300
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cPXKljoKRMe0CQB/zcaUxOrheWmQqCmqWStWsCIRHuE=; b=aWiI+nEi8Hmmh9n8MW0K98vxeE
        JhNVeKpD5j1I1H1gOnPS5IA53xaOMlEBeUpUNDiDSGDwyf5+r8ssD9gatptABgHrVbeboi4eB6n0B
        qO/64jvoDYr4AjrRY8O1Xx9T99gsHf672g0NYqrPRXVPxWf9HxLIo433PhdJvet5XNmpwcm5D5hc9
        ATkYwCkWaecAkQc4p2cHPJDgUK0Wzs4UOYzH9wyu+LVjqCvBIqAGcmvOJLPW+XJ9Q4Kz33HTIo8n6
        KPE3MnU2ts7jF8um1fVdad/JkinujZe/vSAKdhfSYSr7rsnNv8OZKzO1rPQq0iGPJTd2IkpGMPsVR
        ce0P+P/A==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12Ya-008Ziu-T7; Tue, 14 Jun 2022 09:09:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: fold blk_max_size_offset into get_max_io_size
Date:   Tue, 14 Jun 2022 11:09:33 +0200
Message-Id: <20220614090934.570632-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that blk_max_size_offset has a single caller left, fold it into that
and clean up the naming convention for the local variables there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c      |  9 +++++++--
 include/linux/blkdev.h | 19 -------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4da981efddeed..0f5f42ebd0bb0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -166,9 +166,14 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 {
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	unsigned max_sectors, start, end;
+	unsigned max_sectors = queue_max_sectors(q), start, end;
+
+	if (q->limits.chunk_sectors) {
+		max_sectors = min(max_sectors,
+			blk_chunk_sectors_left(bio->bi_iter.bi_sector,
+					       q->limits.chunk_sectors));
+	}
 
-	max_sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
 	start = bio->bi_iter.bi_sector & (pbs - 1);
 	end = (start + max_sectors) & ~(pbs - 1);
 	if (end > start)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e66ad451274ec..05e60ee269d91 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,25 +944,6 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
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

