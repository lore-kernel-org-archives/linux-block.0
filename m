Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F32C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiGTOZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGTOZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC010DE
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gPo/DRZENC7orQHnijPSTv/tmEFxTv1kTQ5HHSDZ6Jk=; b=Lg64+S/+zR+gkgMnHdUIXYGdKt
        0Du7tO01z2x7oSdgaIyIrsB9Onb3vIcHyvEu23Q0Kjxi5SuPVNRM9aVC2wvrou7+11Cg1fkGJ+rVW
        Y+TzMPZKIs4Dr2ScEkLcQfJjMz0IHuT0YYRXOzw7QRBB/amXZbZkT1L5fSJVeVk6i9TpHMoEFmNZt
        aGEIdMVmv97wo4mjri60yJBl/HhG+H8sy9UTAi+580O1cTf7K/B9+o4ypbm+LgmmS3x/vpARrojUJ
        GtswA+mHfHZvrKmzOINPiKQ7HAA09bBiOQ6jXrpA4vrj0rcYCgr3pLXXof1ShikBX1qu/Rh5bHPmV
        EA6u+VGA==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdR-006nl1-I6; Wed, 20 Jul 2022 14:25:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Date:   Wed, 20 Jul 2022 16:24:55 +0200
Message-Id: <20220720142456.1414262-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720142456.1414262-1-hch@lst.de>
References: <20220720142456.1414262-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move this helper into the only file where it is used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 10 ++++++++++
 block/blk.h       | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1676a835b16e7..9593a8a617292 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -95,6 +95,16 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 	return bio_will_gap(req->q, NULL, bio, req->bio);
 }
 
+/*
+ * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * is defined as 'unsigned int', meantime it has to aligned to with logical
+ * block size which is the minimum accepted unit by hardware.
+ */
+static unsigned int bio_allowed_max_sectors(struct request_queue *q)
+{
+	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+}
+
 static struct bio *blk_bio_discard_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
diff --git a/block/blk.h b/block/blk.h
index c4b084bfe87c9..3026ba81c85f0 100644
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

