Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407AFC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D621670
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iNwsss92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFZNtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rIKWqeUm7Zqkyqmua2TEBVmC/9IUThfRyvMY3+104ic=; b=iNwsss925LAXdKMNAT/fnaCLQP
        6A1STQGqFhRThEhmP8ZjNpZCTRJbmvdIfAu5vRmyp6E8p+D/+qMWi5lYsN1SdLSAXlVvr8z8plkO5
        2Dx/ggXC0yt9jPaNUaAH9CSYMiZNHcc9HKOhJAjYxnJtOT1Mpu+gS2Db4ibB80BZzpo6CxL3d1rOl
        R68cFaGbP/ENYgqi0NILTikSCtVSiF46oJJyGAB57xzPIzb7eD+/ZWNG7saXZICovz1DlOPufH1Pq
        32Efu/Z/Y3KS+28dv8ynqVpXpSSDTlE9Vjdh6ftGJKITOS9hswe+Le+Ejl4RrJIitkmMngEGb5CLJ
        CayW/wWA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Ip-0003B7-VU; Wed, 26 Jun 2019 13:49:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/9] block: optionally mark pages dirty in bio_release_pages
Date:   Wed, 26 Jun 2019 15:49:21 +0200
Message-Id: <20190626134928.7988-3-hch@lst.de>
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

A lot of callers of bio_release_pages also want to mark the released
pages as dirty.  Add a mark_dirty parameter to avoid a second
relatively expensive bio_for_each_segment_all loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 12 +++++++-----
 include/linux/bio.h |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9bc7d28ae997..7f3920b6baca 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -845,7 +845,7 @@ static void bio_get_pages(struct bio *bio)
 		get_page(bvec->bv_page);
 }
 
-void bio_release_pages(struct bio *bio)
+void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
@@ -853,8 +853,11 @@ void bio_release_pages(struct bio *bio)
 	if (bio_flagged(bio, BIO_NO_PAGE_REF))
 		return;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		if (mark_dirty && !PageCompound(bvec->bv_page))
+			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
+	}
 }
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
@@ -1683,8 +1686,7 @@ static void bio_dirty_fn(struct work_struct *work)
 	while ((bio = next) != NULL) {
 		next = bio->bi_private;
 
-		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		bio_release_pages(bio, true);
 		bio_put(bio);
 	}
 }
@@ -1700,7 +1702,7 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	bio_release_pages(bio, false);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 87e6c8637bce..9dca313d948a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -426,7 +426,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-void bio_release_pages(struct bio *bio);
+void bio_release_pages(struct bio *bio, bool mark_dirty);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.20.1

