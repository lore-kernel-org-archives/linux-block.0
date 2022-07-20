Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F29C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGTOZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiGTOZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F1BE
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sG3yIvnV48IN3GPasv8v++NX4zFXM2b7RGbH2fVzvx0=; b=xuh5ToipECZHIRr2q75z+uwN/L
        0xoL9racUAZc+/LId+KGPSelsmq4Pv+Ri23jCugrPYdUSsNsARHerkCjNzoOtIyeeb8DYUK31NeuN
        WTCS4YmQEdxjKM1e1RjGRwvttNwlZ6LTEsS6e96tEK0P6JDvxs+DhyIq2J3OCtFCbN8DmejLzJbyT
        Y18Jq+wctya86ZS1sNLL2/8b1y0pXjcmk6LLnG4G8lJtxGU84Bu2bT2Uonswnz3qNrhSpIVKAL4oZ
        RIeVua/x6TW03W1Rf6RDMCdwvOiperl7e97FbM4OC6Rxhgp6vfctKqCWKScuq9WE7iO4e80QtPFMp
        ClmmvEuQ==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdO-006niK-WC; Wed, 20 Jul 2022 14:25:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: move the call to get_max_io_size out of blk_bio_segment_split
Date:   Wed, 20 Jul 2022 16:24:54 +0200
Message-Id: <20220720142456.1414262-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720142456.1414262-1-hch@lst.de>
References: <20220720142456.1414262-1-hch@lst.de>
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
---
 block/blk-merge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e657f1dc824cb..1676a835b16e7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -252,11 +252,12 @@ static bool bvec_split_segs(const struct request_queue *q,
  * @bio:  [in] bio to be split
  * @bs:	  [in] bio set to allocate the clone from
  * @segs: [out] number of segments in the bio with the first half of the sectors
+ * @max_bytes: [in] maximum number of bytes per bio
  *
  * Clone @bio, update the bi_iter of the clone to represent the first sectors
  * of @bio and update @bio->bi_iter to represent the remaining sectors. The
  * following is guaranteed for the cloned bio:
- * - That it has at most get_max_io_size(@q, @bio) sectors.
+ * - That it has at most @max_bytes worth of data
  * - That it has at most queue_max_segments(@q) segments.
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
@@ -266,14 +267,12 @@ static bool bvec_split_segs(const struct request_queue *q,
  * split bio has finished.
  */
 static struct bio *blk_bio_segment_split(struct request_queue *q,
-					 struct bio *bio,
-					 struct bio_set *bs,
-					 unsigned *segs)
+		struct bio *bio, struct bio_set *bs, unsigned *segs,
+		unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
 	unsigned nsegs = 0, bytes = 0;
-	const unsigned max_bytes = get_max_io_size(q, bio) << 9;
 	const unsigned max_segs = queue_max_segments(q);
 
 	bio_for_each_bvec(bv, bio, iter) {
@@ -347,7 +346,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_write_zeroes_split(q, *bio, bs, nr_segs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, bs, nr_segs);
+		split = blk_bio_segment_split(q, *bio, bs, nr_segs,
+				get_max_io_size(q, *bio) << SECTOR_SHIFT);
 		break;
 	}
 
-- 
2.30.2

