Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582CC433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE70C2177B
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DGuHyIX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH0Ph5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Ph4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:37:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8CC061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PzbFGLqqN+piCUhxXTb0JA5yaeZEn4sFZBnpvKYnkxU=; b=DGuHyIX+gb1JKQIAi2R3tK6Q33
        TyoEBFWB39xFCDRKudEVFChhHTApgsdBEL0dMgBT7dH2cIFSrFjRL5ZeQYH9dsgkaJ5FYd7im2sFD
        Tml9GYE2f0Yq2u4wa/NzqemecvrdfyFJFC6VoysURTlqbNO/2zC44tE9MhpDu2wce/Z4EeWA8+vk4
        ejiEK1I2AxPLDiOm8ZsYezHEqRYsmy4Ot0dg6siVqmHxgixdjVTP668DG2GHCYjQiQiutvPWuO2Ii
        lhe9csDaKMqqCtu/Cy0rHBePcl8P+3M6Un7CNLpVtwdVhVBEi7pvzD+gcxeHSV3E1hqtHtR+y1N/1
        YPRuuNcw==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJyM-0006xt-Q4; Thu, 27 Aug 2020 15:37:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: remove the BIO_USER_MAPPED flag
Date:   Thu, 27 Aug 2020 17:37:48 +0200
Message-Id: <20200827153748.378424-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153748.378424-1-hch@lst.de>
References: <20200827153748.378424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just check if there is private data, in which case the bio must have
originated from bio_copy_user_iov.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c           | 10 ++++------
 include/linux/blk_types.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 427962ac2f675f..be118926ccf4e3 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -109,7 +109,7 @@ static int bio_uncopy_user(struct bio *bio)
 	struct bio_map_data *bmd = bio->bi_private;
 	int ret = 0;
 
-	if (!bmd || !bmd->is_null_mapped) {
+	if (!bmd->is_null_mapped) {
 		/*
 		 * if we're in a workqueue, the request is orphaned, so
 		 * don't copy into a random user address space, just free
@@ -307,8 +307,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 			break;
 	}
 
-	bio_set_flag(bio, BIO_USER_MAPPED);
-
 	/*
 	 * Subtle: if we end up needing to bounce a bio, it would normally
 	 * disappear when its bi_end_io is run.  However, we need the original
@@ -654,12 +652,12 @@ int blk_rq_unmap_user(struct bio *bio)
 		if (unlikely(bio_flagged(bio, BIO_BOUNCED)))
 			mapped_bio = bio->bi_private;
 
-		if (bio_flagged(mapped_bio, BIO_USER_MAPPED)) {
-			bio_unmap_user(mapped_bio);
-		} else {
+		if (bio->bi_private) {
 			ret2 = bio_uncopy_user(mapped_bio);
 			if (ret2 && !ret)
 				ret = ret2;
+		} else {
+			bio_unmap_user(mapped_bio);
 		}
 
 		mapped_bio = bio;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1bd8dad69baf..39b1ba6da9ef71 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -255,7 +255,6 @@ enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
-	BIO_USER_MAPPED,	/* contains user pages */
 	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
-- 
2.28.0

