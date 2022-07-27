Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC9C19F2B
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiG0QZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiG0QYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBAB4E62F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XZGZy0s7RnfoncuceJb1Wsb4ySM0ED0d66bgJt25KAs=; b=CqCnEwWPa3S38R1C/EqT7BNLYr
        LQeBwFEWCEQ0CNEdRysZlhIWTlwMmjXa7f9gd3tCj4VcHOf1PwTe7RtxuznDiv2VGmlCrxsMOAB7/
        XBqcGSDmcT5FwthyYrVMPmjccQDkZ9h7Qu1BJbPyzRN2l4ERGhN057m77FejQc+D5XSZRgrw/IgW+
        xOndmZLdaaxWw7Ye/yJrpaw9BvsuTW09wDz8tzflKQWa3IMjCIOc2gc2hJ8pyzCnsU+gAGluC6QdN
        NPgRQvS9E/5aUyXRDxcBPWuqhDLnBPoyHUf8XmIabZkJNUhqU87Bk8ZnDV9rvEGfk+f5zPvkS5dyg
        NQsHQ8jA==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjoa-00FUkd-99; Wed, 27 Jul 2022 16:23:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/6] block: move bio_allowed_max_sectors to blk-merge.c
Date:   Wed, 27 Jul 2022 12:22:59 -0400
Message-Id: <20220727162300.3089193-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727162300.3089193-1-hch@lst.de>
References: <20220727162300.3089193-1-hch@lst.de>
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
index ce73b3b6c2a71..c2bf8723f30c6 100644
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
index 1cc813241cd4f..19dd12ade8087 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -349,16 +349,6 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
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

