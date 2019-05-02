Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBFC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D6206DF
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFQd9+aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEBXeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wiGjSoeNl1/KJPhx03RifnO1ykQMrSZKjJzcDKRdTC4=; b=CFQd9+aMYcslxr/75hoOBKlSN5
        nV2dWKunrRs1Hk9N74YzrSbt2blnJ5mKS/5OAGiM/sGv1La2h6PZGnRzTp7tYPx6esP86QdaW6qX+
        /ThM9dkcmke7yUyKve7Ne7G+3wG+hD4xFlXJk20h6ykdFyM2G1uhP1cZaOFOdR6Kfz1u8rb9R3pkP
        tG1CeIbCL7m3pYd9QkDs/NwlerWH1fI9UoOOf2lAmwuay8J/0lh4evpa5bFLkfG3b/oJG9789BlYU
        g6WP5ujCIC4e3imU01A9boF0hyyBNZiIdVXSkkGptBacR3qxKOuh6wZpVV3s2zUR/3+gxHsinULGY
        pr5Fvd6Q==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDR-0002lJ-3j; Thu, 02 May 2019 23:34:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: use bio_release_pages in bio_map_user_iov
Date:   Thu,  2 May 2019 19:33:27 -0400
Message-Id: <20190502233332.28720-4-hch@lst.de>
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

Use bio_release_pages instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a6862b954350..3938e179a530 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1370,8 +1370,6 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	int j;
 	struct bio *bio;
 	int ret;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
 
 	if (!iov_iter_count(iter))
 		return ERR_PTR(-EINVAL);
@@ -1438,9 +1436,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	return bio;
 
  out_unmap:
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		put_page(bvec->bv_page);
-	}
+	bio_release_pages(bio);
 	bio_put(bio);
 	return ERR_PTR(ret);
 }
-- 
2.20.1

