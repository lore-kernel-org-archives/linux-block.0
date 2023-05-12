Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B2FC77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbjELNjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjELNjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495112EA6
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DuU6R+NkB6GkIUUeDxZk9rv59QqmGVvtU8pZ7WSTfAo=; b=hIdYJMB9zkv4pc/fvWJMHs4ph3
        HtFlfDO5o1aXuxnw23X2Lv48dxiPlhM1qI1NdDYRTTuteKLh7/+GKYEDtRD3B15xiBjQxSGG+HJb1
        /2OBbUojWEJ7FL84nuvBtuL7fRLx+HnwHYaip5oKlChdWEO3IpGyJu1uuNb7RaqratqLmh60h46Ig
        5/IUgnCEjrICbgCMK0uQopXAyATlTdeseCtQ7P/M8mQM0E6159fdw+Sv6o6eJ2eKWQUYOa4l0DBBF
        Vr4AS/6N1n83AGI6R1NwHB6kTDyyqwLMB+4mFD4vIfKrIvO13jh38yLlaJS5EBO4cq8p9eXgtloYx
        szv6M/dg==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzK-00C2iD-1N;
        Fri, 12 May 2023 13:39:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: move the bi_vcnt check out of __bio_try_merge_page
Date:   Fri, 12 May 2023 06:38:57 -0700
Message-Id: <20230512133901.1053543-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the bi_vcnt out of __bio_try_merge_page and into the two callers
that don't already have it in preparation for additional changes to
__bio_try_merge_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c7bf20a779ebed..5d2c95e05b1a52 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -945,20 +945,17 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page)
 {
-	if (bio->bi_vcnt > 0) {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
-				*same_page = false;
-				return false;
-			}
-			bv->bv_len += len;
-			bio->bi_iter.bi_size += len;
-			return true;
-		}
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+	if (!page_is_mergeable(bv, page, len, off, same_page))
+		return false;
+	if (bio->bi_iter.bi_size > UINT_MAX - len) {
+		*same_page = false;
+		return false;
 	}
-	return false;
+	bv->bv_len += len;
+	bio->bi_iter.bi_size += len;
+	return true;
 }
 
 /*
@@ -1127,11 +1124,13 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-		if (bio_full(bio, len))
-			return 0;
-		__bio_add_page(bio, page, len, offset);
-	}
+	if (bio->bi_vcnt > 0 &&
+	    __bio_try_merge_page(bio, page, len, offset, &same_page))
+		return len;
+
+	if (bio_full(bio, len))
+		return 0;
+	__bio_add_page(bio, page, len, offset);
 	return len;
 }
 EXPORT_SYMBOL(bio_add_page);
@@ -1198,13 +1197,14 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
-	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
-		__bio_add_page(bio, page, len, offset);
+	if (bio->bi_vcnt > 0 &&
+	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (same_page)
+			put_page(page);
 		return 0;
 	}
 
-	if (same_page)
-		put_page(page);
+	__bio_add_page(bio, page, len, offset);
 	return 0;
 }
 
-- 
2.39.2

