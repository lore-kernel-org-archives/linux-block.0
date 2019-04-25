Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F3C282E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CB1218AD
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nydSkczP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfDYHFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:05:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfDYHFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A38pfHu3fvqUv9Advx7YCNtFlo6QWdNsrSzHGAUggAk=; b=nydSkczPSN4UFUwIs+kw6s2XSK
        jgjTBME2ob2m/X9jBhj03srn16hVOh5Q8Lk8m8SLWeWkCAnNwVbU3LvbOn6QxqJQD/Ho820nhCbWB
        lHLRgaGPptiG2Sb/uomCLBhvubwP5IWupWgRc1q3peGk7O9hqJ+wr/TyqADtLJbt2QO2oY7LhkS4W
        FGmsR/yQ/fkY4NtZNKNtkj7HQdehB5a85WF1eGopk2wqOLPxWVPe2P7irq0v9t+BUWCSHEnlf9t1z
        zNQZclBkNyhNI1/DIozNpI7Sw1RVf4E1oDk5A4MgIwWpKO9f0XaquVVO5o+w2kaNF9yLE+v3hexVY
        eke8opww==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYRP-0006z1-JK; Thu, 25 Apr 2019 07:05:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: remove bogus comments in __bio_add_pc_page
Date:   Thu, 25 Apr 2019 09:04:34 +0200
Message-Id: <20190425070435.3478-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425070435.3478-1-hch@lst.de>
References: <20190425070435.3478-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We are never called with file system pages by defintions for the
passthrough interface, and we also never undo any addition later
these days.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e717b303e1fb..de26dc18bceb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -724,11 +724,6 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
 		return 0;
 
-	/*
-	 * For filesystems with a blocksize smaller than the pagesize
-	 * we will often be called with the same page as last time and
-	 * a consecutive offset.  Optimize this special case.
-	 */
 	if (bio->bi_vcnt > 0) {
 		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
@@ -760,10 +755,6 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_phys_segments >= queue_max_segments(q))
 		return 0;
 
-	/*
-	 * setup the new entry, we might clear it again later if we
-	 * cannot add the page
-	 */
 	bvec = &bio->bi_io_vec[bio->bi_vcnt];
 	bvec->bv_page = page;
 	bvec->bv_len = len;
-- 
2.20.1

