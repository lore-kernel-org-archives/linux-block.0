Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5112C433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904AC208C2
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5QjvBaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfHLPkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:40:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLPkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 11:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MUN6U56JBvocg7k3hVuSzOdFPN8In04LJ5UpziIbO6E=; b=X5QjvBaz0l8b2ZaJ/2j8tbRSWB
        xEBgG5tMcNXqSio40BEs2BQ+eRqoA7i4SG4cMqvRy6lPERxUPwGaz5H5WZiJj2NBmoluhtQiDfWsg
        bBUBohMm7VSUIVhpFbwAdk5o8gEANIRRkmbbQj8IPsmJWH78lPUHhJCs/MXHumIXC5A1qDLVQ9B2K
        tIoexN+kb74nKgw7dQkoSD76N4x0rftdcKQue9Xysvuv6PLQTLgh7Kr1E1bxSvxA7O9N63jMFVZQZ
        +sAtnQbTCugEhDG8+x599XIJIRAqe94Wx8icH4WWDIs0+M8i0SVuMrIuW/X8gzMmuah0HvZuDThE3
        uopsjKKw==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxCQW-0002ST-1Y; Mon, 12 Aug 2019 15:40:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/3] block: improve the gap check in __bio_add_pc_page
Date:   Mon, 12 Aug 2019 17:39:56 +0200
Message-Id: <20190812153958.29560-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812153958.29560-1-hch@lst.de>
References: <20190812153958.29560-1-hch@lst.de>
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
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 24a496f5d2e2..9f80bf4531b3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -710,18 +710,18 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
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

