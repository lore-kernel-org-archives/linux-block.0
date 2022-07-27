Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C5FC19F2B
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiG0QYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiG0QYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F54D16C
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=viut8uvu1QJ71RFs5TxtOBKR4g93U6FLq4nGpzCxvDk=; b=5CzO4zhFqfn7vTIPVigVJ5MCU6
        VfxbbLTaPoDBn/NwdPN9auQndZazfbsDq72xUL919TEPvKl4kLiznquLm3ahW4ftt+EI6GJyyi5+p
        lKo6xz3RRLjBCZ3NXpaxESk9hNvt2V79CX32eDf95k1WqJawp+uJ/foWfkq0zWOE4l70PCfe+eoyP
        A1/Xd9H5qIDSWpMFTRKiZ/BDRkdQ5oPfz+41caGy6E7LD3KcgW8Yp05PadRvrPgQqFWPlFd7Wm5z6
        jWYGgDO+1a705N450OotG9VCYXmjCPO70txbOjSyogQLTGn2ff377lFHnTRvl3VnCqfncL/GMhyiu
        PzWoND2w==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjoY-00FUj4-6c; Wed, 27 Jul 2022 16:23:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] block: move the call to get_max_io_size out of blk_bio_segment_split
Date:   Wed, 27 Jul 2022 12:22:58 -0400
Message-Id: <20220727162300.3089193-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727162300.3089193-1-hch@lst.de>
References: <20220727162300.3089193-1-hch@lst.de>
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
index 30872a3537648..ce73b3b6c2a71 100644
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

