Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C92C00144
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 18:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiGZSaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiGZSai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:30:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F09FC8
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VhbNXcdNwx7sZpIrbaf0U/VpY9ZMCjG+Icj10evIR4s=; b=b+ld9Ye9EEbxzBBISfcvCkmg1v
        CqTXDSGuSe7sjJ0NC7uEtAiVRRduZgp0a+RlPjqoWf7oo3Am1+RDkC6IjalOLbvTKbY4oZU1OxHFX
        A/4kN/icT/MJUyIXrlw8cfzX8n2/mJQDIkeM152xktS8teh0MemeHGHcVMIFfiLur2uzshrV3fU5N
        kso4jVnbjdBLMlenRSYjF/Wb/TOo3B0sN8Eq0W6w9hWJ5L7f8Ru19i+lS7OvMi1Ir3gQ6Rg0yor4r
        wXmkS71sw4cps77kSNSQtIzgUqChiHFZqTVgxiG6mp8j2NrjwlcnQlhoyOynscy5zxXOz7KO7mm/W
        QgefcK+g==;
Received: from [2001:67c:370:1998:f991:c4cf:cf3d:dfb6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGPKH-0027u9-4s; Tue, 26 Jul 2022 18:30:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] block: move the call to get_max_io_size out of blk_bio_segment_split
Date:   Tue, 26 Jul 2022 14:30:27 -0400
Message-Id: <20220726183029.2950008-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726183029.2950008-1-hch@lst.de>
References: <20220726183029.2950008-1-hch@lst.de>
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
index 9454c0d927d8b..b58e06db5b1b9 100644
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

