Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378CC7EE26
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjELNjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjELNjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0612493
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BBsvpW62gpb+w5FeGpQRtYpWNARSW4/g+jU6cv6P90o=; b=XxHrtm+SEZF0YupkSvSkvA3Hg5
        rV3eSc182vIGE9VZqmqs1KsCQdfLKviggV4CF/Eqd1NEsVOZPr7G3TlCi3X86zUBMMmqRZ+oEx4km
        1iG8lRSscNs319tQsbostUZp1JElhP7QCnrpXuIZu/ru4+cIAIo1ewmAoPbc4tPfmPkZLoO/YHnC0
        ipLDe5jXfViWVaFWW5Pb0SdBHD5DeZhUCEZxGN+Q3WeCxxdskdvS2iGVKDvckaOirdotE2jBY8oZ0
        QgKhp5GDNUvwTvGhA7vGxt6dHFEr2D3AzVItOKlSQXm/aC8K619k3NVQR4HZwci3cJVuUyW7lo0H9
        eGiiPUQw==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzJ-00C2hl-1p;
        Fri, 12 May 2023 13:39:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: use SECTOR_SHIFT bio_add_hw_page
Date:   Fri, 12 May 2023 06:38:55 -0700
Message-Id: <20230512133901.1053543-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the SECTOR_SHIFT magic constant instead of the magic number.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 1528ca0f3df6dc..d020065e613cc8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1007,7 +1007,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
+	if (((bio->bi_iter.bi_size + len) >> SECTOR_SHIFT) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-- 
2.39.2

