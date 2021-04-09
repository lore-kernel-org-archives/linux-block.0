Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0291C433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4861056
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 15:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhDIPFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhDIPFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 11:05:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F575C061760
        for <linux-block@vger.kernel.org>; Fri,  9 Apr 2021 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=StHH9tCTdOdvamuVMyM8L+Fm06OlpP4ouzo1J/xMTf4=; b=Ra8NIikQf2DFXvlU+bwmVxGs6w
        9tAccqPuBYIOZwffDmY2hFJNT2Az6wJx5EGaVK6jbM/HVyM4X80sil6gdNrn4TeoNoEyEdl/kuxye
        8k5V7Lu9YoGCxlbo3vbIXT1cNsKW7F2/PqQTJaUCWKKr/wC4dMh+ByXPDprFAzuvz+VnCO7V5nOL8
        0vXfxXjUc0Uo8ic2j3raXZTlXlRPdr1TFUcdjB4PxHV/ajFLitQe3+8FSrcwJbcTjiTJ4ltaxcNcb
        a+iidwzaN+gCTIAYv6PS8H5AptnzSgCUxoGlBWOBi/b2uGLG99Kr1UeWRzQIwd73Qr6xj5eGBESuu
        s4I296vA==;
Received: from [2001:4bb8:188:4907:b4ac:cde4:522b:2423] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUsgk-004bjT-UT; Fri, 09 Apr 2021 15:04:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] block: remove an incorrect check from blk_rq_append_bio
Date:   Fri,  9 Apr 2021 17:04:46 +0200
Message-Id: <20210409150447.1977410-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_rq_append_bio is also used for the copy case, not just the map case,
so tis debug check is not correct.

Fixes: 393bb12e0058 ("block: stop calling blk_queue_bounce for passthrough requests")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 block/blk-map.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index dac78376acc899..3743158ddaeb76 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -485,9 +485,6 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 	struct bio_vec bv;
 	unsigned int nr_segs = 0;
 
-	if (WARN_ON_ONCE(rq->q->limits.bounce != BLK_BOUNCE_NONE))
-		return -EINVAL;
-
 	bio_for_each_bvec(bv, bio, iter)
 		nr_segs++;
 
-- 
2.30.1

