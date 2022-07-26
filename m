Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25174C00140
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiGZSak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiGZSaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:30:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC4B4A6
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VrNW3RggJ+X0vx+EgeS/FGmSx/GWBzf0Cf59PMdr3yU=; b=ZLyEXPQ/nPrCPfd3lk181NiFND
        /fMCHOw3wg0Nhq3aONMWNDIzzuAy4egPIdQpICMAdLNAzJ5Xzovp4kl07YuY9Mq3c+BeaZUQcNyWb
        BDLTd6zGVIIlJhm5H5tD8Qk75YmJDiyCNS+cMCkyEzV0X8bDo0DiHfLS0D5tApGzDXHmbCLphn4W0
        Lro0NdJ4+p/X8ZiWneOxQzpX+/PHGPJm8hUihqbqz3hjJucYPW3FmvknJIkJUKJwNZ+wEXs8Snvl9
        Er8mE0t8yPHg5roonG4kcclBOgJdxxP5RIuxhjetChzhkR1/fLyzpNwp00R3cQSnOlG4vQTrlTZAw
        Oa2Xcv3g==;
Received: from [2001:67c:370:1998:f991:c4cf:cf3d:dfb6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGPKI-0027um-9R; Tue, 26 Jul 2022 18:30:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/6] block: move bio_allowed_max_sectors to blk-merge.c
Date:   Tue, 26 Jul 2022 14:30:28 -0400
Message-Id: <20220726183029.2950008-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726183029.2950008-1-hch@lst.de>
References: <20220726183029.2950008-1-hch@lst.de>
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
index b58e06db5b1b9..659ebb376c461 100644
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

