Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF34C41513
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGXQyi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjGXQyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77088102
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vsmlaB3gAZ5AWEXt1JWDSCXwf4hG6CBi27SCZNx8+W8=; b=yhLOLGW3H705wbWExbRIjFFArQ
        FXOvNWn4HSqkQAFBt4QXI5uXUHiHQ8gPzzBZcgv87Vc0budcu3njdEEfq4Wp8BjzuVlE/ZX23XEVb
        8q7AP1pZfF54jWoHdE0CngiEdQYxrHaqG5LouXeBAuhhnAXKtRK93qbkSOzsm9J6wIb8ubUngvsO3
        Edw+ym5Qbw+kAjcaXeNBSkludx8lsQpmjhDQA0B8dbbwImbrvXz0Z4ulljNSrnkpFzpq7ctKLq+Uu
        vprVgoqQttqNaVH/4Z5Tkt9SK5sMQqumQ1XkB3LRtGzXHVPG17kl9yntApHy8auUI4gLrq4oVCDov
        +2aNZ4AQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypO-004vuU-1q;
        Mon, 24 Jul 2023 16:54:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/8] block: downgrade a bio_full call in bio_add_page
Date:   Mon, 24 Jul 2023 09:54:31 -0700
Message-Id: <20230724165433.117645-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
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
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 17f57fd2cff2f1..d8e0e8de8cf4f6 100644
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

