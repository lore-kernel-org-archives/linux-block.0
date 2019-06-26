Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D48C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1123D2085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C/TzrjDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZNte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1EuOnpnMp6omkiOkm2XyfbpwCECUTpsqCchs+EKZlN0=; b=C/TzrjDLfzitqMKwlZy3RitvJL
        N1c6AYxAZHH1ZW/vB7Ub8rF1M2gJ4qctR9MoOlNEc4XgVyFAaiWjny87w437d4c5oG4cgr+ul0G9Q
        zPFtAQatwabHKpu9+UNSqM6w2XJebPrcDasf6ToVKa91Tg2R2gA1ZXjzigPlsEsjvcKzHhfHLlnQJ
        nLsDaCNRoc6pwLNblm2F+fSO1/yZSvfTYWYqaN/Nj9BbnF9u9RY11C+WFa6JZQLNhzr6OU4yeYDt6
        4ooGjKh0aaUtx/xYI6HSYkemY404rUR04gUldkY03xNFAX9iGf8b1wyEjrQxs4Darq19VNuU5QZGx
        EX6Y3Ytw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8In-0003Ak-Og; Wed, 26 Jun 2019 13:49:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/9] block: move the BIO_NO_PAGE_REF check into bio_release_pages
Date:   Wed, 26 Jun 2019 15:49:20 +0200
Message-Id: <20190626134928.7988-2-hch@lst.de>
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

Move the BIO_NO_PAGE_REF check into bio_release_pages instead of
duplicating it in both callers.

Also make the function available outside of bio.c so that we can
reuse it in other direct I/O implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c         | 11 ++++++-----
 include/linux/bio.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ad9c3aa9bf7d..9bc7d28ae997 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -845,11 +845,14 @@ static void bio_get_pages(struct bio *bio)
 		get_page(bvec->bv_page);
 }
 
-static void bio_release_pages(struct bio *bio)
+void bio_release_pages(struct bio *bio)
 {
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
 
+	if (bio_flagged(bio, BIO_NO_PAGE_REF))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		put_page(bvec->bv_page);
 }
@@ -1681,8 +1684,7 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
-			bio_release_pages(bio);
+		bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1698,8 +1700,7 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
-		bio_release_pages(bio);
+	bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ee11c4324751..87e6c8637bce 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -426,6 +426,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+void bio_release_pages(struct bio *bio);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
 				    struct iov_iter *, gfp_t);
-- 
2.20.1

