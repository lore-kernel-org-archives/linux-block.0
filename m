Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198566108F
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhJLQrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhJLQrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:47:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545CC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/5uYh4ExOIZhja/8G0h5dj7VL0zcyNA471aQT2/JKso=; b=Mj1H9h83lvDw+KbJx3FLLp0PWi
        9Yd7tiEVrw9YZ69fH3KF48RaV/G8dfaEYcabcwox6KlyC/H+fwzBE3QhLDTBovihKgbnwmGyYlhR9
        q+vtajCQEzuEkIi88OPY9NVOfIcUkMg5nbjUFuBUjhAM5kA9XSgVASFxAMe8XyDiYb7ZwqKtQU2DI
        f2HFLV3dCew1WMq3dGsEhRe2ec4bbrH9r87X/mZr3vmXzMFO+CCE7W2HhU2J1Mksoxe/kDV0Z2IDY
        mt3QATLdb/BY4hyJFS3VOokbN/dytTajqOH0nCCDpuYRe6JjpXvHRkjt2tBghzWMx3SEksI6xNyUJ
        g6OzUufg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKri-006f89-6Y; Tue, 12 Oct 2021 16:43:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 5/5] block: pass the start sector to get_max_io_size
Date:   Tue, 12 Oct 2021 18:36:13 +0200
Message-Id: <20211012163613.994933-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012163613.994933-1-hch@lst.de>
References: <20211012163613.994933-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the start sector instead of the whole bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15b2aef1507e5..b397972b526a0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -174,12 +174,10 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
  * requests that are submitted to a block device if the start of a bio is not
  * aligned to a physical block boundary.
  */
-static inline unsigned get_max_io_size(struct request_queue *q,
-				       struct bio *bio)
+static inline unsigned get_max_io_size(struct request_queue *q, sector_t sector)
 {
 	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
 	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
-	sector_t sector = bio->bi_iter.bi_sector;
 	unsigned start_offset = sector & (pbs - 1);
 	unsigned sectors = q->limits.max_sectors;
 	unsigned max_sectors;
@@ -287,7 +285,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, sectors = 0;
-	const unsigned max_sectors = get_max_io_size(q, bio);
+	const unsigned max_sectors = get_max_io_size(q, bio->bi_iter.bi_sector);
 	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
-- 
2.30.2

