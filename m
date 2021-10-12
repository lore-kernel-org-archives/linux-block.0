Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB3F6103D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJLQ2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhJLQ2D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:28:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF35C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nex4qEamS0rqMlOOfmvQk0wnapjqIMJH5FAhT/MwRXo=; b=Yfkb8bb4aF5MYlpUARx295XGBg
        tngAPd7EsGVy0p69i0K5JlGbSlqmsuafZwtPNEMCX2/2LLUoGYIfu/rTtOnsZHx2SBnnZc2AwvP7H
        xk2/zinTbpJ7ZuaW4OsH6mx+ezHib/gyukx/krqk4qanyMWPIPZy4YqSTsbCC14uWoRPwGOl87HEE
        uwpFQmUnEw/8mv/9qBfgZZmPCDi42U7tdY9i9pCgQoDas3ifGHFIRgxvLDy3Y/h2PpCc8tD2TPAE1
        Rtdj/NC5HSNGx7T3yrtNOVXSRM/Rg233HQxKeAD+YsqK4h86Q6gZxIjUc3HulLGgdqiYmPzaDt0hh
        tudM2leQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKaG-006eF1-UV; Tue, 12 Oct 2021 16:25:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/8] block: mark __bio_try_merge_page static
Date:   Tue, 12 Oct 2021 18:18:02 +0200
Message-Id: <20211012161804.991559-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark __bio_try_merge_page static and move it up a bit to avoid the need
for a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 77 ++++++++++++++++++++++-----------------------
 include/linux/bio.h |  2 --
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7e2899071de26..c89e402356a59 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -808,6 +808,44 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
 }
 
+/**
+ * __bio_try_merge_page - try appending data to an existing bvec.
+ * @bio: destination bio
+ * @page: start page to add
+ * @len: length of the data to add
+ * @off: offset of the data relative to @page
+ * @same_page: return if the segment has been merged inside the same page
+ *
+ * Try to add the data at @page + @off to the last bvec of @bio.  This is a
+ * useful optimisation for file systems with a block size smaller than the
+ * page size.
+ *
+ * Warn if (@len, @off) crosses pages in case that @same_page is true.
+ *
+ * Return %true on success or %false on failure.
+ */
+static bool __bio_try_merge_page(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int off, bool *same_page)
+{
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return false;
+
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (page_is_mergeable(bv, page, len, off, same_page)) {
+			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+				*same_page = false;
+				return false;
+			}
+			bv->bv_len += len;
+			bio->bi_iter.bi_size += len;
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Try to merge a page into a segment, while obeying the hardware segment
  * size limit.  This is not for normal read/write bios, but for passthrough
@@ -939,45 +977,6 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 
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
-bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
-{
-	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
-		return false;
-
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
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(__bio_try_merge_page);
-
 /**
  * __bio_add_page - add page(s) to a bio in a new segment
  * @bio: destination bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2ffc7c768091c..faa0a2fabaf08 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -425,8 +425,6 @@ extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
-bool __bio_try_merge_page(struct bio *bio, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-- 
2.30.2

