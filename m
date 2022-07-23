Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC4C43334
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 06:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGWG2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiGWG23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 02:28:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500252FD1
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y5VdWypW1Q+9VyH8LnnlMX58cTEaHvmvhFPwYDFao8w=; b=y9yGx1WbhwUrNYFrq0oKyF/i9K
        JF618h+yDHsBIT8O4ip/7KmWyTj+hCU8JBeLYDnNWq2bQRYMNgEinUKaj/wrcQBvP9z/0DOthRidd
        GEI5zehwS2+iyRv9uQRCi/8iuTpXpUMxyU/Xb2HazvJOzxKPJfmknbyju+yewVT7RG9Ap7/Nw526U
        PMZzg79VBOypbB+uwufX9juKGkgLyBfsqBXZojSf4yPUH+WbAP9ewCZxgBEl0l7Mw/3jT2Qk+v2pe
        nVBZnQOVlf40WgICbbo0e3tyBTn8colzXBEunyOwdBnQD1+ZtaDzeNL6mmr9SR8Kyip7VgzLNBiE9
        DF2kbAVw==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8cm-00GLhI-Fo; Sat, 23 Jul 2022 06:28:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] block: move the call to get_max_io_size out of blk_bio_segment_split
Date:   Sat, 23 Jul 2022 08:28:14 +0200
Message-Id: <20220723062816.2210784-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723062816.2210784-1-hch@lst.de>
References: <20220723062816.2210784-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for reusing blk_bio_segment_split for (file system controlled)
splits of REQ_OP_ZONE_APPEND bios by letting the caller control the
maximum size of the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-merge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 83a9d23f2a333..509ee8b5d3e1d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -250,11 +250,12 @@ static bool bvec_split_segs(const struct request_queue *q,
  * @q:    [in] request queue pointer
  * @segs: [out] number of segments in the bio with the first half of the sectors
  * @bs:	  [in] bio set to allocate the clone from
+ * @max_bytes: [in] maximum number of bytes per bio
  *
  * Clone @bio, update the bi_iter of the clone to represent the first sectors
  * of @bio and update @bio->bi_iter to represent the remaining sectors. The
  * following is guaranteed for the cloned bio:
- * - That it has at most get_max_io_size(@bio, @q) sectors.
+ * - That it has at most @max_bytes worth of data
  * - That it has at most queue_max_segments(@q) segments.
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
@@ -264,12 +265,11 @@ static bool bvec_split_segs(const struct request_queue *q,
  * split bio has finished.
  */
 static struct bio *bio_split_rw(struct bio *bio, struct request_queue *q,
-		unsigned *segs, struct bio_set *bs)
+		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
-	const unsigned max_bytes = get_max_io_size(bio, q) << 9;
 	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
@@ -343,7 +343,8 @@ struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
 		split = bio_split_write_zeroes(bio, q, nr_segs, bs);
 		break;
 	default:
-		split = bio_split_rw(bio, q, nr_segs, bs);
+		split = bio_split_rw(bio, q, nr_segs, bs,
+				get_max_io_size(bio, q) << SECTOR_SHIFT);
 		break;
 	}
 
-- 
2.30.2

