Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B1C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 06:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiGWG2e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiGWG2d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 02:28:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311852450
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8nT38rWcxfg9JZ37CIxitgXUgiE+uQrvUjalBYNqNNw=; b=KoYszBgQxh9B3YUujKPYVGNjhX
        wKr1VrGYMgAxQ1lnNYFsm5+8qPxezgbfII0A7qrk5fWIZPQtufRN2SFIUOkCKOcXM0Q+hQAdWBG0U
        8LU8N0+oaC0TXKLRjZl/hQlRJ3okhkfFwqpaO1K/MneiK0kerwrhAImC1wEjZFy6YaDJVajejydlo
        Jc3V7WnEt09mEAl5sWrI/O4nIa+Q0yYPBeF7l8ZrRvs/+sUTTsFlNObVbrUqE2ZBk2WenE1RpXbHg
        2uD5otfuykoduvUIhQfM9/tIVqJ2w/jCxjAoZgPXfguZTwR16c8rbmvVR9zAUBJTifqEiHzSqtb8x
        mS0FbaJw==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8co-00GLhv-Uu; Sat, 23 Jul 2022 06:28:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/6] block: move bio_allowed_max_sectors to blk-merge.c
Date:   Sat, 23 Jul 2022 08:28:15 +0200
Message-Id: <20220723062816.2210784-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723062816.2210784-1-hch@lst.de>
References: <20220723062816.2210784-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move this helper into the only file where it is used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-merge.c | 10 ++++++++++
 block/blk.h       | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 509ee8b5d3e1d..30652c51706d2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -95,6 +95,16 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 	return bio_will_gap(req->q, NULL, bio, req->bio);
 }
 
+/*
+ * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * is defined as 'unsigned int', meantime it has to be aligned to with the
+ * logical block size, which is the minimum accepted unit by hardware.
+ */
+static unsigned int bio_allowed_max_sectors(struct request_queue *q)
+{
+	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+}
+
 static struct bio *bio_split_discard(struct bio *bio, struct request_queue *q,
 		unsigned *nsegs, struct bio_set *bs)
 {
diff --git a/block/blk.h b/block/blk.h
index f50c8fcded99e..b3eda6c3917c1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,16 +344,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 		q->last_merge = NULL;
 }
 
-/*
- * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
- * is defined as 'unsigned int', meantime it has to aligned to with logical
- * block size which is the minimum accepted unit by hardware.
- */
-static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
-{
-	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
-}
-
 /*
  * Internal io_context interface
  */
-- 
2.30.2

