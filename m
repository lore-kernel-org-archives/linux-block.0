Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BDC04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B2D20879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fd/Qfi17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEMGir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:38:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lBaH1nBiHm7+wFF1enY3xJjL2CLdHGWOBCdP2tQak6M=; b=fd/Qfi17FfkZD/GDbfNGP/U+nN
        nWo18f0lqMjDeoV0KyWg/79UDvBC0dNDLn5+HqVtDFeY0Nv5ILPD2N+nYIioho4lcluy9jMlCA9ig
        hYlfMnjOvGPuK778t3Z0+jZ22Ax5NZWHvW3BSLSOAGt0uLKR6o6ORFWHjkqDSnB2lAvtDrLaXu/XO
        yiUUMCiu9z4Xj9MMlSjJalhRZojEzy+Y5kcrrTQiReHeaBNCmzYbUc4Do358GDD2HxS6f5SwMpKn3
        yrPQDrs9bfY8uz941VP99CeYCyftrjU9C5RTe/TpoBztqAnqxfrQuL6qht099Oayf+Y2FZ7QDePip
        9UjijvZg==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4bk-0007PF-TO; Mon, 13 May 2019 06:38:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/10] block: remove the segment size check in bio_will_gap
Date:   Mon, 13 May 2019 08:37:47 +0200
Message-Id: <20190513063754.1520-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We fundamentally do not have a maximum segement size for devices with a
virt boundary.  So don't bother checking it, especially given that the
existing checks didn't properly work to start with as we never update
bi_seg_back_size after a successful merge, and for front merges would
have had to check bi_seg_front_size anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 80a5a0facb87..eee2c02c50ce 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -12,23 +12,6 @@
 
 #include "blk.h"
 
-/*
- * Check if the two bvecs from two bios can be merged to one segment.  If yes,
- * no need to check gap between the two bios since the 1st bio and the 1st bvec
- * in the 2nd bio can be handled in one segment.
- */
-static inline bool bios_segs_mergeable(struct request_queue *q,
-		struct bio *prev, struct bio_vec *prev_last_bv,
-		struct bio_vec *next_first_bv)
-{
-	if (!biovec_phys_mergeable(q, prev_last_bv, next_first_bv))
-		return false;
-	if (prev->bi_seg_back_size + next_first_bv->bv_len >
-			queue_max_segment_size(q))
-		return false;
-	return true;
-}
-
 static inline bool bio_will_gap(struct request_queue *q,
 		struct request *prev_rq, struct bio *prev, struct bio *next)
 {
@@ -60,7 +43,7 @@ static inline bool bio_will_gap(struct request_queue *q,
 	 */
 	bio_get_last_bvec(prev, &pb);
 	bio_get_first_bvec(next, &nb);
-	if (bios_segs_mergeable(q, prev, &pb, &nb))
+	if (biovec_phys_mergeable(q, &pb, &nb))
 		return false;
 	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
 }
-- 
2.20.1

