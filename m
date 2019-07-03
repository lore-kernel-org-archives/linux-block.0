Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37AC0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C186218A4
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pB0H7uI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCNAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:00:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lv3d4n66kjW1UoxQrY+WZ6kJmTM9S3HPEFhaF13q4M8=; b=pB0H7uI30DEkin7R5FgWOv0peb
        Z9O3jRMJBZzCandrGWR5qeOSpDcvFdi5DQGfjsclgSZiL82PP5pajVO/i4tXLa2m3cDE/+xK0UrmY
        K40SCW3PCuskm0s+0FEMua5n1nYS2RwVThXDMVfAP2n7/jNK8U8Z+X4iOobN4NuXKdgOTBdoUM0NF
        k8z8G83qEGb3+4EcoEKBNm2M2YOkYzl5sbKnkk+gafbINSwfNybUoMbaruDVTFzMdDRuPiSAvFnlc
        RrYO/uzwPcsMoCg+/NdhSsJYPxSWsv/CRO8dmF1CjbwlBSPu6ouGoGwbsHKNbYnHinqisZmob5WVt
        DzGLx1wQ==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiesN-0006XU-MV; Wed, 03 Jul 2019 13:00:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: improve the gap check in __bio_add_pc_page
Date:   Wed,  3 Jul 2019 06:00:34 -0700
Message-Id: <20190703130036.4105-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703130036.4105-1-hch@lst.de>
References: <20190703130036.4105-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we can add more data into an existing segment we do not create a gap
per definition, so move the check for a gap after the attempt to merge
into the segment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 29cd6cf4da51..6be22b8477ce 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -709,18 +709,18 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 			goto done;
 		}
 
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (bvec_gap_to_prev(q, bvec, offset))
-			return 0;
-
 		if (page_is_mergeable(bvec, page, len, offset, &same_page) &&
 		    can_add_page_to_seg(q, bvec, page, len, offset)) {
 			bvec->bv_len += len;
 			goto done;
 		}
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		if (bvec_gap_to_prev(q, bvec, offset))
+			return 0;
 	}
 
 	if (bio_full(bio, len))
-- 
2.20.1

