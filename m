Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610AC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550562082E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZX+Q8D7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfDKGX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:23:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKGX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 02:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cHcU+eKZKcD5xFJf2Pkg9y0v4jYXJxrJMR4xwiFCmMI=; b=ZX+Q8D7KrgTICtBAWV3GXyVo9Q
        vhuHn4j592p+AZXIeQlOOhXOryk4J+i510hu8/v2ZVyjps6WWmDonVcs7u/N4zTGzBaVy55PuX3MG
        s6mLOQmKD61t/oCTcIIWsW9mzGZFxc4OiGyLvTnad0NlkNglC9NXrfzISRXyQ/EWXzr37J8zn8prH
        enHRWWsqoR1eZts7LjEDX7QEOnpf/9h0+ZOAbgjnWQjZm09TLceDUxFvZfVbtUxMVBOf8sxEiramX
        /acUinWqmMZgHP1t8WZiUhQIUtC9f6gFBHnDqRGwL6+H6AQLqMuHKH+od5PJ2O3Kyb0T5L8+xRCO+
        79rbLcSA==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hET7t-0005LS-Ak; Thu, 11 Apr 2019 06:23:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page call
Date:   Thu, 11 Apr 2019 08:23:27 +0200
Message-Id: <20190411062331.27800-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411062331.27800-1-hch@lst.de>
References: <20190411062331.27800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The offset in scatterlists is allowed to be larger than the page size,
so don't go to great length to avoid that case and simplify the
arithmetics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-merge.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 895795cdb145..247b17f2a0f6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -469,26 +469,17 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 		struct scatterlist **sg)
 {
 	unsigned nbytes = bvec->bv_len;
-	unsigned nsegs = 0, total = 0, offset = 0;
+	unsigned nsegs = 0, total = 0;
 
 	while (nbytes > 0) {
-		unsigned seg_size;
-		struct page *pg;
-		unsigned idx;
+		unsigned offset = bvec->bv_offset + total;
+		unsigned len = min(get_max_segment_size(q, offset), nbytes);
 
 		*sg = blk_next_sg(sg, sglist);
+		sg_set_page(*sg, bvec->bv_page, len, offset);
 
-		seg_size = get_max_segment_size(q, bvec->bv_offset + total);
-		seg_size = min(nbytes, seg_size);
-
-		offset = (total + bvec->bv_offset) % PAGE_SIZE;
-		idx = (total + bvec->bv_offset) / PAGE_SIZE;
-		pg = bvec_nth_page(bvec->bv_page, idx);
-
-		sg_set_page(*sg, pg, seg_size, offset);
-
-		total += seg_size;
-		nbytes -= seg_size;
+		total += len;
+		nbytes -= len;
 		nsegs++;
 	}
 
-- 
2.20.1

