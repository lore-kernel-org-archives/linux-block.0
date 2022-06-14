Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353204AbiFNJJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiFNJJv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A540E6F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R+654CqqyrFlc/qleabG9TKavNiNkiaEV85B/4QZwTU=; b=RWLPRHk06h7gBPiR/REwy8wyet
        zYF4IWWcvbHP2x64gxrkov+wIKJTyITn/NhUNmm+S9LTwkwzilD42WG0xp5Sx0dF3bGceXFWcQJya
        SHP5dL8yPTbIVksK+meg9QS4ksMMKogrWLWnwVSv2RcWTbzUmhRU+YpOI9X/+sNq9WORGHKGpx3g4
        ZTZXkYSyrjIg10dHi2ktS9B8BtnVF8L7hspjTmTpmLOkz6qN3SQ3rGyJGqeB2nNo2v0DlTASyucvM
        OSY1gW0FMdJyZ2uMc83NsSehlfThtGKsBMdOchBi214N/q67xyU2eTW3jTN+VZdbNs/T2TjbiHkOj
        /mRoRH4g==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12YV-008Zfj-IU; Tue, 14 Jun 2022 09:09:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: open code blk_max_size_offset in blk_rq_get_max_sectors
Date:   Tue, 14 Jun 2022 11:09:31 +0200
Message-Id: <20220614090934.570632-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614090934.570632-1-hch@lst.de>
References: <20220614090934.570632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_rq_get_max_sectors always uses q->limits.chunk_sectors as the
chunk_sectors argument, and already checks for max_sectors through the
call to blk_queue_get_max_sectors.  That means much of
blk_max_size_offset is not needed and open coding it simplifies the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index db2e03c8af7f4..df003ecfbd474 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -566,17 +566,18 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
 	struct request_queue *q = rq->q;
+	unsigned int max_sectors;
 
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
+	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
-
-	return min(blk_max_size_offset(q, offset, 0),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+		return max_sectors;
+	return min(max_sectors,
+		   blk_chunk_sectors_left(offset, q->limits.chunk_sectors));
 }
 
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
-- 
2.30.2

