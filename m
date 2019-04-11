Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B615C10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49598204EC
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnYvL2Uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDKGYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:24:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKGYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 02:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iYShD2iYjoJ3N/yaubBfhjrzHLqObdxLLALOYXoIRk0=; b=lnYvL2Uhqz1DUuCb/NiH6zxB4/
        nWI9ufhVg7JCSmW/iSfxcDVR8/s1utOEX1DDYTB9emI+EXggVOCHycG46NYDQRgGJY93PvTbcgoP0
        TNOcXxw406Knzeujlgi3g8Net/ZA6sL8pURNkeCv+yLlhmD9Ro+lP6iNeEPrbgqo9Sao+AHDgBjCd
        0hyzmNU2YWvlQh+gK0g44S//vttQbE3AR2nNoyWkNxmfgt+I/Yfijn3RLVHu8WB69thTN+NXRbyoU
        +rKZ8QPDrUnnc2QU06mnveVyNEqyeNnpxH8VqwTwogYCCOm4mRIwxU9LZAqjI/moDTsSVq27Ozyey
        8Hns2mqQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hET82-0005NG-H8; Thu, 11 Apr 2019 06:24:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: change how we get page references in bio_iov_iter_get_pages
Date:   Thu, 11 Apr 2019 08:23:30 +0200
Message-Id: <20190411062331.27800-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411062331.27800-1-hch@lst.de>
References: <20190411062331.27800-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of needing a special macro to iterate over all pages in
a bvec just do a second passs over the whole bio.  This also matches
what we do on the release side.  The release side helper is moved
up to where we need the get helper to clearly express the symmetry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          | 51 ++++++++++++++++++++++----------------------
 include/linux/bvec.h |  5 -----
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c2a389b1509a..d3490aeb1a7e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -861,6 +861,26 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+static void bio_get_pages(struct bio *bio)
+{
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	int i;
+
+	bio_for_each_segment_all(bvec, bio, i, iter_all)
+		get_page(bvec->bv_page);
+}
+
+static void bio_release_pages(struct bio *bio)
+{
+	struct bvec_iter_all iter_all;
+	struct bio_vec *bvec;
+	int i;
+
+	bio_for_each_segment_all(bvec, bio, i, iter_all)
+		put_page(bvec->bv_page);
+}
+
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
 	const struct bio_vec *bv = iter->bvec;
@@ -875,15 +895,6 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 				bv->bv_offset + iter->iov_offset);
 	if (unlikely(size != len))
 		return -EINVAL;
-
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-		struct page *page;
-		int i;
-
-		mp_bvec_for_each_page(page, bv, i)
-			get_page(page);
-	}
-
 	iov_iter_advance(iter, size);
 	return 0;
 }
@@ -963,13 +974,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	if (WARN_ON_ONCE(bio->bi_vcnt))
 		return -EINVAL;
 
-	/*
-	 * If this is a BVEC iter, then the pages are kernel pages. Don't
-	 * release them on IO completion, if the caller asked us to.
-	 */
-	if (is_bvec && iov_iter_bvec_no_ref(iter))
-		bio_set_flag(bio, BIO_NO_PAGE_REF);
-
 	do {
 		if (is_bvec)
 			ret = __bio_iov_bvec_add_pages(bio, iter);
@@ -977,6 +981,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
 
+	if (iov_iter_bvec_no_ref(iter))
+		bio_set_flag(bio, BIO_NO_PAGE_REF);
+	else
+		bio_get_pages(bio);
+
 	return bio->bi_vcnt ? 0 : ret;
 }
 
@@ -1670,16 +1679,6 @@ void bio_set_pages_dirty(struct bio *bio)
 	}
 }
 
-static void bio_release_pages(struct bio *bio)
-{
-	struct bio_vec *bvec;
-	int i;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, i, iter_all)
-		put_page(bvec->bv_page);
-}
-
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
  * If they are, then fine.  If, however, some pages are clean then they must
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f6275c4da13a..307bbda62b7b 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -189,9 +189,4 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
 	}
 }
 
-#define mp_bvec_for_each_page(pg, bv, i)				\
-	for (i = (bv)->bv_offset / PAGE_SIZE;				\
-		(i <= (((bv)->bv_offset + (bv)->bv_len - 1) / PAGE_SIZE)) && \
-		(pg = bvec_nth_page((bv)->bv_page, i)); i += 1)
-
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.20.1

