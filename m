Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DCC433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060032177B
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dVKnUSNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH0Phy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Phx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:37:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F6C061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E1e0zf4VnjY94nL9MOcvfNN7fKjR4vD8MYOYhfZ9Xe0=; b=dVKnUSNk9PFpYaT6V+cWLFiCP5
        zsM396SrsyWsq4ZFe7tZEUSbMMF3k7eeQfTC7UZq6WMvMRwMZl6LjhdD4Q2SUHtnK2yacIAR0BjrF
        Lz8tF7dIOYNHVhuFU7DgRNmqRz6Y81SzAjawzh5IWD0+q0FQjkkA7qM/dV5z+xqANxMir0x4ZTrxP
        70KHftmzxH/OjLQcLPPh1q/JvhDa/DRXaoBOCXWeH0yVCUkCqehqgqZYIwQ0yQvDWl/X0wyp+5926
        vRvwD5MxbiJVqNzaNA61mYR/JfhhPn3l18Z/vpKPpYg2o+PFr+VkMpom7+tIba8Hl2Cp3JEddWvAS
        t0r/NCnQ==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJyJ-0006xd-WA; Thu, 27 Aug 2020 15:37:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: remove __blk_rq_unmap_user
Date:   Thu, 27 Aug 2020 17:37:46 +0200
Message-Id: <20200827153748.378424-3-hch@lst.de>
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

Open code __blk_rq_unmap_user in the two callers.  Both never pass a NULL
bio, and one of them can use an existing local variable instead of the bio
flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 51e6195f878d3c..10de4809edf9a7 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -558,20 +558,6 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-static int __blk_rq_unmap_user(struct bio *bio)
-{
-	int ret = 0;
-
-	if (bio) {
-		if (bio_flagged(bio, BIO_USER_MAPPED))
-			bio_unmap_user(bio);
-		else
-			ret = bio_uncopy_user(bio);
-	}
-
-	return ret;
-}
-
 static int __blk_rq_map_user_iov(struct request *rq,
 		struct rq_map_data *map_data, struct iov_iter *iter,
 		gfp_t gfp_mask, bool copy)
@@ -599,7 +585,10 @@ static int __blk_rq_map_user_iov(struct request *rq,
 	 */
 	ret = blk_rq_append_bio(rq, &bio);
 	if (ret) {
-		__blk_rq_unmap_user(orig_bio);
+		if (copy)
+			bio_uncopy_user(orig_bio);
+		else
+			bio_unmap_user(orig_bio);
 		return ret;
 	}
 	bio_get(bio);
@@ -701,9 +690,13 @@ int blk_rq_unmap_user(struct bio *bio)
 		if (unlikely(bio_flagged(bio, BIO_BOUNCED)))
 			mapped_bio = bio->bi_private;
 
-		ret2 = __blk_rq_unmap_user(mapped_bio);
-		if (ret2 && !ret)
-			ret = ret2;
+		if (bio_flagged(mapped_bio, BIO_USER_MAPPED)) {
+			bio_unmap_user(mapped_bio);
+		} else {
+			ret2 = bio_uncopy_user(mapped_bio);
+			if (ret2 && !ret)
+				ret = ret2;
+		}
 
 		mapped_bio = bio;
 		bio = bio->bi_next;
-- 
2.28.0

