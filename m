Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A18C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7365F2085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loH7YDpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFZNtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o4f2NEljcvaaHeQsRYlIKXIK410Z3aMMZJTCWYJ1USE=; b=loH7YDpCsPeLgpDdr9enIpyOWO
        oK3WRijRgMHU/66WINuXLO4L7mIL4KiMU2vGeI6O3W8nN2CgUOx9BpDimOjqf8zAC0EkbhXvHJyMg
        wavaaKY8m83IAhhCdhLDZDeX7bj8L2zJvm8rOakGRIw3++lLQArOOaBtoGJJ/AHRNIwjG0Baruyga
        Q/blmDDKLyzEpAsFYIBEcx0N2tiYYSspF+FoB9yukHm1ojSGixseepNTO4xNN4Yqy5twTMdNKKX/s
        RVo+Bq7WeAqPK/vxVYaZ9C9xY7+Xhyrx9ZuVfrkdDgHYLL6dERcc9lESDKTzXEivPrWvFQRE9C3EP
        AqLk3n9Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Is-0003Bk-5c; Wed, 26 Jun 2019 13:49:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/9] block: use bio_release_pages in bio_unmap_user
Date:   Wed, 26 Jun 2019 15:49:22 +0200
Message-Id: <20190626134928.7988-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7f3920b6baca..20a16347bcbb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1437,24 +1437,6 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	return ERR_PTR(ret);
 }
 
-static void __bio_unmap_user(struct bio *bio)
-{
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	/*
-	 * make sure we dirty pages we wrote to
-	 */
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (bio_data_dir(bio) == READ)
-			set_page_dirty_lock(bvec->bv_page);
-
-		put_page(bvec->bv_page);
-	}
-
-	bio_put(bio);
-}
-
 /**
  *	bio_unmap_user	-	unmap a bio
  *	@bio:		the bio being unmapped
@@ -1466,7 +1448,8 @@ static void __bio_unmap_user(struct bio *bio)
  */
 void bio_unmap_user(struct bio *bio)
 {
-	__bio_unmap_user(bio);
+	bio_release_pages(bio, bio_data_dir(bio) == READ);
+	bio_put(bio);
 	bio_put(bio);
 }
 
-- 
2.20.1

