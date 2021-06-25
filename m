Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ECEC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3724161423
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYGvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jun 2021 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFYGvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jun 2021 02:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF11BC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+4rNVD/UAVondguki6UkxGDstH9iHRoA1/gS/wfovVA=; b=fDgbBcLsf9iKgK8L39AiVnrl4X
        8jY0tPaDlLZ/iQeZtOinkDBkOQ/naf+zLCmuMiQl4VjYtSHwoAbQhHIxy9dYSsr04mk+M8cuIrgZJ
        lMrBPX6U891lT5g8iUhyfvWBqtlka/aOQ81z9+RbvoGz5d8cAFVCLKfmbJB3oXqpRKaJC4eyyIk8f
        lM1gUOBLhtBWjRI0dfMmBLPvT9W6Y3jGnufZI4Y37lFrE0dDFsjC2v84/X1dNNXg1a0HxPynOHbXg
        LKJwkPq4zf3FCzR2toIvzTS7MuwP4pBpCTWhEaHNMZrZ8WctVQuIR2Gn73cYRbtx69xmrXDwotS8O
        Y0Yp4QrA==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwfda-00HO0M-4P; Fri, 25 Jun 2021 06:48:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: reorder and better document the __REQ_* flags
Date:   Fri, 25 Jun 2021 08:46:15 +0200
Message-Id: <20210625064615.923862-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep the op-specific flag last and make a little more sense of the
comments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db61f7df1823..c80756e9f16e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -381,15 +381,14 @@ enum req_flag_bits {
 	 * work item to avoid such priority inversions.
 	 */
 	__REQ_CGROUP_PUNT,
+	__REQ_HIPRI,		/* High Priority I/O (polled) */
+	__REQ_SWAP,		/* swap I/O */
 
-	/* command specific flags for REQ_OP_WRITE_ZEROES: */
-	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
+	__REQ_DRV,		/* for driver use */
 
-	__REQ_HIPRI,
+	/* command specific flag for REQ_OP_WRITE_ZEROES: */
+	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	/* for driver use */
-	__REQ_DRV,
-	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
-- 
2.30.2

