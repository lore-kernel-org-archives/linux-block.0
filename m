Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D8461056
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJMRTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJMRTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:19:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E7C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IQJ8GnhbCaRo74p7BMfA0XFVqv7nTesXdElRT9vzcB4=; b=VcvNUQT3TJcjIkmVNJewMGHd2Z
        iPuAQXUc3L8z6OolO0tJS+IeaiZWPogjeX2z8XZIBHAPD7SnbRVC0wrv5c5N10kOAMsZisWwLfahP
        GZ3/091pCweLFrZnFmfH16XzOrRz98cD694aPikTq0L3GWgMnu6netmLVsIizhD17zMbblTs+G7E/
        J3KL/dUiCqRt85WCMSge43LpBnQh3ko0x0BN4kNZzeSNjIN5BahWcgU8+URrrC3xP69IYMD22AIQ8
        7j69yTEMnMWP74j0aCo+uVXgSVLVrX+aKWUnMkOHpAetuK/Juyp2Cf8kZr3PNef29pfRHIftil/Z9
        V1Objgmw==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahqp-007eWq-W1; Wed, 13 Oct 2021 17:15:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 3/6] block: only call blk_queue_get_max_sectors once in blk_rq_get_max_sectors
Date:   Wed, 13 Oct 2021 19:12:12 +0200
Message-Id: <20211013171215.1177671-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013171215.1177671-1-hch@lst.de>
References: <20211013171215.1177671-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consolidate the two calls to blk_rq_get_max_sectors into one using a
local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 14ce19607cd8a..8ed50952e93ad 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -595,17 +595,18 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
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
+		return max_sectors;
 
-	return min(blk_max_size_offset(q, offset, 0),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+	return min(max_sectors, blk_max_size_offset(q, offset, 0));
 }
 
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
-- 
2.30.2

