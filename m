Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB00C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857A2206DF
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="imB4M4jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBXeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vO78OC+PyADmQtbMP1VNN9uFqYFTMjrx97GcMUSfUA8=; b=imB4M4jjcumcdjMJUO5Xqi3+kl
        pbSM3873hExz7J3rWz347vrqM12EYw+9tlcieUxr2usbZZ6z+1r8k/wiksU7EodNW7hNImvROcN9v
        WQunK6gHmYC7yMpKgSKpdKnj72XL57EtXIKoUQneOlmBNHPtl53rjZSJjXOq8M9uVv47dhG3ogQw/
        eV4c8+ulc/wMP1ghzwc5KB9za1VYm9n+s59Dy7JtcS3/KIPWySogQTjkI9xOoWJow17OuQU9Tx1tX
        xow0i1EaT7hGJVC23psD5TUL2dDmtx2eoYpA88lYcsnms2BdQdhk+ojCoamQ53pQqYdTeufk+INMe
        hfnKjd5Q==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDS-0002lT-5T; Thu, 02 May 2019 23:34:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/8] iomap: use bio_release_pages in iomap_dio_bio_end_io
Date:   Thu,  2 May 2019 19:33:28 -0400
Message-Id: <20190502233332.28720-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
References: <20190502233332.28720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 12a656271076..a7bff5b2e1e8 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1588,13 +1588,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
+		bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
-- 
2.20.1

