Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED2C7EE2E
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbjELNjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjELNjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81C132B7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cGTFEY4mheIEWuSf3+z+ZLW4wLppeiojvczv9Dlr4r0=; b=PTc+N91sC2jj375fD3HeaOEgWT
        nI6lrDEoVzTP5jndocUWVzNEDidxH16b57fKYXQr8BnkEm78mwbt41K/sofLFBiVHtbRhEzgFn4eH
        epcTX8vWYmAv0+bP/01ILZjiIwtXEMjkOK3MdMdtAUpRLnE3zzSiP/7v464V453qgYtFxy0u6tX3h
        sjtPER/u9bhpmDWrT7DA3KnvBchSlFc7sdYGLXDYXTC4M5lz2z14Vz5Y/47+PByjbQqTULj0iPbtG
        cEXZIkaG+WVHCJ2H1A+2aRS+hr12/tJ5tMPBrjK9MCgDALU4+N7uCMxt0N6k1IQuJeT+gK+lBgiZQ
        sUHHJgfg==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzL-00C2iS-0m;
        Fri, 12 May 2023 13:39:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/8] block: downgrade a bio_full call in bio_add_page
Date:   Fri, 12 May 2023 06:38:59 -0700
Message-Id: <20230512133901.1053543-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_add_page already checks that there is space in bi_size a little
earlier.  So after we failed to add to an existing segment, just check
that there is another one available instead of duplicating the bi_size
check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 93e6bca3c2239f..89b1475de0c370 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1126,7 +1126,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 	    __bio_try_merge_page(bio, page, len, offset, &same_page))
 		return len;
 
-	if (bio_full(bio, len))
+	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
 	__bio_add_page(bio, page, len, offset);
 	return len;
-- 
2.39.2

