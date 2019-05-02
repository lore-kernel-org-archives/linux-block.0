Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87342C04AA9
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E2C206DF
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S3bZ2wf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEBXeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QArtGL80DyEe/i2v0z2nn9t4OQ5PBJxNK+aQr4ysy4I=; b=S3bZ2wf7Zp8onIk6fZIvQAPNeo
        mwu9tPMTcWfIEuu97KCvFNVH5CkoIFFT04dHfN8XsCn4Qhwk6vUdlS60MeXdaMWDmiDASJUhRu+gK
        LwnSquCVEhYRpP7pwgz/Ei0YhAVu7mjdzAjQYCvMSFJ85kYXL3yuf37zB8s4UXwT9Xr5lNovlQJf4
        I82kct/KKLpH6KV4GyyXfAAY4l26ySHEfVLjO2st1Bdp3JvWVdGjdx+nl5GFcZvI/AI6L6ZuGPyCO
        mfyukbRCyWBgHSmIfgVaKl/nVet1FR4FAhHu57k/qBc9k8nCCAZCbSLzF8LXGGX1RqcLIqNOy+X9b
        ReYes/yw==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDP-0002lB-VJ; Thu, 02 May 2019 23:34:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: use bio_release_pages in bio_unmap_user
Date:   Thu,  2 May 2019 19:33:26 -0400
Message-Id: <20190502233332.28720-3-hch@lst.de>
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

Use bio_release_pages and bio_set_pages_dirty instead of open coding
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 96ddffa49881..a6862b954350 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1445,24 +1445,6 @@ struct bio *bio_map_user_iov(struct request_queue *q,
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
@@ -1474,7 +1456,9 @@ static void __bio_unmap_user(struct bio *bio)
  */
 void bio_unmap_user(struct bio *bio)
 {
-	__bio_unmap_user(bio);
+	bio_set_pages_dirty(bio);
+	bio_release_pages(bio);
+	bio_put(bio);
 	bio_put(bio);
 }
 
-- 
2.20.1

