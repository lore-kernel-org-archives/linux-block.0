Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA964C10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5E213F2
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qv+wn4SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDHKrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHKrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 06:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n/GJhC/hxw8BRmeDZBAoq/4qqLPNu1J4dLamEiCJW3E=; b=qv+wn4SOot8rKAMeitVQRFORq+
        nTDhYWj4gmNlIGXHnn442vQqXMjd8ioi+ZdY34nG1YjzQBpSejWe8SE5aI+9XMsbBwWmxxHC7ywCe
        kueTVEKns0vjpN3pogA3lbN9eO6fJFt+pDA8J9P9mYGSrS616ygPLWx1Gnzxx27EeFloR0rsSptPh
        um5iAX60H0QaIX/bRM6SrMUBPQfU42/OnWnkTEjH2H4BrlD3Q9eDNZMotCmcOWcZ3G0Q1HYOXzQFk
        teJesYNSc55Ob06g5iRXplhhJh22B/Y8/aTV2usFBWXbfxHyKOhcspOIwezeXaHnoIo9RwxmehgIO
        7fK+Zidg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRnt-0000FK-B0; Mon, 08 Apr 2019 10:47:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page call
Date:   Mon,  8 Apr 2019 12:46:37 +0200
Message-Id: <20190408104641.4905-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408104641.4905-1-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
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
---
 block/blk-merge.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8f96d683b577..52dbdd089fdf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -467,26 +467,17 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
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

