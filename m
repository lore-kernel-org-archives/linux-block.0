Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3081CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C6261076
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhJLQnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJLQnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ECEC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=T3PafNR+rI85MAFZQaPflfTB/dmPSO0JFchpAmxlmkY=; b=uRYHwcTMRdGsL5NQtDOn6GJmFN
        YXRi+m6QDTdmuYA4GJSG6qooxGRaMKnORHnZOc9w83ChTBuUB78DtDpGlpJ7XYCZBTvIkmSbqeI8M
        2jmaAXw0Lftpys/sy25cIWK+SVjyIdmxdMpOlDTkQ57Brr4HQl6DuoAc4gRhCilHuiP24KC9eN5LQ
        v1o8EW+s+cj3TGjSpw/sG3SZWSwCxmiKeyLHKpUb5qc02SLLIiLQrE4zxWJOwMdb9YKSfo1hxo156
        WTlCcsZWd0P6bEGJq4Sudo5PSJx8zHNxKyviabO36muwlXZzE4SVYloj3r0ZDbm2SCC+xF8r4aFvz
        lLPf3Z2w==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKp0-006eym-9j; Tue, 12 Oct 2021 16:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 3/5] block: open code blk_max_size_offset in blk_rq_get_max_sectors
Date:   Tue, 12 Oct 2021 18:36:11 +0200
Message-Id: <20211012163613.994933-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012163613.994933-1-hch@lst.de>
References: <20211012163613.994933-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_rq_get_max_sectors always uses q->limits.chunk_sectors as the
chunk_sectors argument, and already checks for max_sectors through the
call to blk_queue_get_max_sectors.  That means much of
blk_max_size_offset is not needed and open coding it simplifies the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 14ce19607cd8a..b3da43160032f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -595,17 +595,18 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
 	struct request_queue *q = rq->q;
+	unsigned int max_sectors;
 
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	if (!q->limits.chunk_sectors ||
-	    req_op(rq) == REQ_OP_DISCARD ||
-	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
-
-	return min(blk_max_size_offset(q, offset, 0),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	if (q->limits.chunk_sectors &&
+	    req_op(rq) != REQ_OP_DISCARD &&
+	    req_op(rq) != REQ_OP_SECURE_ERASE)
+		max_sectors = min(max_sectors,
+			chunk_size_left(offset, q->limits.chunk_sectors));
+	return max_sectors;
 }
 
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
-- 
2.30.2

