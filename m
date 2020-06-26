Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51647C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268C020857
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pj2a3nKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgFZICn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgFZICT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:19 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4256FC08C5C1;
        Fri, 26 Jun 2020 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sFxMoqE2sgnbFCbegAWrrjwEvJ1szu0FusAr7R3A7+U=; b=Pj2a3nKjCPDnhBKe1cprUXuAso
        rogZ01V9oli2s1pfDjkyyLLz4sr1K6k0CLSJ4x0Mc+mRR0YwB7WNTQxfiAItS/waTrwk+2iGVDsq8
        h/v/413uGqkSZlwp7VXdbkYhq8MNU5Sas9fxRYBclVi1F+YIIiyZor9go4vMJL10d3m5jbTAKc90Z
        n9ZmibmqV0c5MKeb6bLb3+w7+srfhGXqweRkd+fNx0EPQLO9ATBzyUupvAzF7beFYWF9yTm5HeRiK
        tURVS4oiN6YsDT89gS/3QsVgT4lZP8kh0GVfBPvsdknuQHh0e0b6egpkogFSqZl5/v5XWBOeE2cO7
        VquVCCaA==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJC-0007UN-PI; Fri, 26 Jun 2020 08:02:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] block: simplify set_init_blocksize
Date:   Fri, 26 Jun 2020 10:01:54 +0200
Message-Id: <20200626080158.1998621-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The loop to increase the initial block size doesn't really make any
sense, as the AND operation won't match for powers of two if it didn't
for the initial block size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0e0d43dc27d331..8b7a9c76d33edf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -106,13 +106,7 @@ EXPORT_SYMBOL(invalidate_bdev);
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
 
-	while (bsize < PAGE_SIZE) {
-		if (size & bsize)
-			break;
-		bsize <<= 1;
-	}
 	bdev->bd_block_size = bsize;
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
-- 
2.26.2

