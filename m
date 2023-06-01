Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4593C7EE3A
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFAH2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjFAH2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 03:28:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8C1A2
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fPoAnXGtXKPEfLQRq94kOkNo24Bb1mEI4j5q8xWtS6A=; b=4PrTI9IMsPL2BHyS1n/KtOcjaj
        d72nB7vNgU09TyvvOEOlVsu3EN2cj0hoSLDTQtCkccJRB0CqPGpPgHEbk5yiTuTCs77mntsYC+/uA
        TjpAG3j/9XbKrDEQwe7BgqtVqUIvMRG6SZ1Ewi6eeaAJVrZXWMmrsmFUFqSGHanVgl371Q75B+tIR
        61P9wY7pfnYWhPPEm/KYJ0MOMYiKeuM0IltleHINkpMrnmwi21KZk4mzerZooVsFN8DeHnvLexS/z
        ce+Rv2FG4YHtXupQXulf5sl1OK/RkIxrllDIWYWzqFdkgwsd5FZhTuv2VHdRZpAL8Cmzvv0fJh1Xz
        4Krf2w2Q==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4cjd-002ML3-2e;
        Thu, 01 Jun 2023 07:28:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: remove a duplicate bdev_read_only declaration
Date:   Thu,  1 Jun 2023 09:28:27 +0200
Message-Id: <20230601072829.1258286-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601072829.1258286-1-hch@lst.de>
References: <20230601072829.1258286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdev_read_only is already declared as in inline in blkdev.h, don't
add another declaration after it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d89c2da1469872..20bbce92a91c11 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1455,7 +1455,6 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
-int bdev_read_only(struct block_device *bdev);
 int set_blocksize(struct block_device *bdev, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
-- 
2.39.2

