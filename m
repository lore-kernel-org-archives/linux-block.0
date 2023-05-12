Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED66C7EE26
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 13:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjELNjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbjELNjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:39:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BAD12087
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ptNyRjDsDOWi2id8Bfmz/XxKVOPHn5T4DqKTnkNcIdY=; b=xH7+9YipqXh3MrTjs+w8pl6zG1
        kPgdfQGI/Bdwy9BJ/nWo7N8GsqEIDQvBjn9+Ig1PYMaCtYmYYhUZmt27uUQGD2r7vphYJ0W2xPn6W
        Qwxy4j9/hgxeyadhqURMCg/m76yFJhDido1tt4HeRDcBN7igvYh7E4BjIDzUV+YsYpFyR1CHn779J
        xtkkqlTsiPCWcvsFm+Uke2majQrkb/p7ZPmS5sNXWVJNvIYIwvTGuzHeSlLvklaip0UtEMzxrmNQX
        A6WOJmsiv7aJhVwdnWQyquaGIC0lR4g8c+BA51x+rNNrXToqo5vV+zzHZnUmyMAnCa/HyJTJsLdTA
        0jeGY3/w==;
Received: from [204.239.251.3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSzL-00C2iY-26;
        Fri, 12 May 2023 13:39:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: move the bi_size update out of __bio_try_merge_page
Date:   Fri, 12 May 2023 06:39:00 -0700
Message-Id: <20230512133901.1053543-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The update of bi_size is the only thing in __bio_try_merge_page that
needs a bio.  Move it to the callers, and merge __bio_try_merge_page
and page_is_mergeable into a single bvec_try_merge_page that only takes
the current bvec instead of a full bio.  This will allow reusing this
function for supporting multi-page integrity payload bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 57 +++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 89b1475de0c370..106009707ca1c5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -903,9 +903,8 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 	return false;
 }
 
-static inline bool page_is_mergeable(const struct bio_vec *bv,
-		struct page *page, unsigned int len, unsigned int off,
-		bool *same_page)
+static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
+		unsigned int len, unsigned int off, bool *same_page)
 {
 	size_t bv_end = bv->bv_offset + bv->bv_len;
 	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
@@ -919,38 +918,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
-	if (*same_page)
-		return true;
-	else if (IS_ENABLED(CONFIG_KMSAN))
-		return false;
-	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
-}
-
-/**
- * __bio_try_merge_page - try appending data to an existing bvec.
- * @bio: destination bio
- * @page: start page to add
- * @len: length of the data to add
- * @off: offset of the data relative to @page
- * @same_page: return if the segment has been merged inside the same page
- *
- * Try to add the data at @page + @off to the last bvec of @bio.  This is a
- * useful optimisation for file systems with a block size smaller than the
- * page size.
- *
- * Warn if (@len, @off) crosses pages in case that @same_page is true.
- *
- * Return %true on success or %false on failure.
- */
-static bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
-{
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	if (!*same_page) {
+		if (IS_ENABLED(CONFIG_KMSAN))
+			return false;
+		if (bv->bv_page + bv_end / PAGE_SIZE != page + off / PAGE_SIZE)
+			return false;
+	}
 
-	if (!page_is_mergeable(bv, page, len, off, same_page))
-		return false;
 	bv->bv_len += len;
-	bio->bi_iter.bi_size += len;
 	return true;
 }
 
@@ -972,7 +947,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 		return false;
 	if (bv->bv_len + len > queue_max_segment_size(q))
 		return false;
-	return __bio_try_merge_page(bio, page, len, offset, same_page);
+	return bvec_try_merge_page(bv, page, len, offset, same_page);
 }
 
 /**
@@ -1001,8 +976,11 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset,
+				same_page)) {
+			bio->bi_iter.bi_size += len;
 			return len;
+		}
 
 		if (bio->bi_vcnt >=
 		    min(bio->bi_max_vecs, queue_max_segments(q)))
@@ -1123,8 +1101,11 @@ int bio_add_page(struct bio *bio, struct page *page,
 		return 0;
 
 	if (bio->bi_vcnt > 0 &&
-	    __bio_try_merge_page(bio, page, len, offset, &same_page))
+	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
+	    		page, len, offset, &same_page)) {
+		bio->bi_iter.bi_size += len;
 		return len;
+	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
@@ -1199,7 +1180,9 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 		return -EIO;
 
 	if (bio->bi_vcnt > 0 &&
-	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
+	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
+	    		page, len, offset, &same_page)) {
+		bio->bi_iter.bi_size += len;
 		if (same_page)
 			put_page(page);
 		return 0;
-- 
2.39.2

