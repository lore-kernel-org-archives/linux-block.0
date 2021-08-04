Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF016C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D449060F58
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhHDJvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhHDJvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:51:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41CC0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zMBTODObkrw2so7Mc3i2DABpnsop8s0P4ulp/MKDvuE=; b=BM+rMZJ2bh8LQgGlWT0UuIgo+D
        HumCZu2cWTcsXwi98Cnyin5m+ZilpGN1Y308rAyKdd2yKT87f485O6zE8rcw4QvGVncStsHPi5wGC
        yxnOVBbaujiY4UpNDrISLr+RhWY4gDAWioapX9Pg/Dt6FvWQhv1SeLaGy2qutp5YNOOSUJkBbvMvx
        ZQH4QSPDbKciQ8UbkO69j0owmJrMaETpPH1JBI08E4+DvxoLAVvYTF0shGsp7xErDghGzbvuTRtOo
        iiVROq7BaFsg5TGfgKWGCcCQqzKDrCh9Ke4RTzR9RmVEIdaF27v1jvqf+M/R9vzdfBsQnYPddFIWZ
        tNx8IFaw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDXD-005eSO-79; Wed, 04 Aug 2021 09:50:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     cand@gmx.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] n64cart: fix the dma address in n64cart_do_bvec
Date:   Wed,  4 Aug 2021 11:49:58 +0200
Message-Id: <20210804094958.460298-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dma_map_bvec already takes bv_offset into account.

Fixes: 9b2a2bbbb4d0 ("block: Add n64 cart driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/n64cart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 7b4dd10af9ec..c84be0028f63 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -74,7 +74,7 @@ static bool n64cart_do_bvec(struct device *dev, struct bio_vec *bv, u32 pos)
 
 	n64cart_wait_dma();
 
-	n64cart_write_reg(PI_DRAM_REG, dma_addr + bv->bv_offset);
+	n64cart_write_reg(PI_DRAM_REG, dma_addr);
 	n64cart_write_reg(PI_CART_REG, (bstart | CART_DOMAIN) & CART_MAX);
 	n64cart_write_reg(PI_WRITE_REG, bv->bv_len - 1);
 
-- 
2.30.2

