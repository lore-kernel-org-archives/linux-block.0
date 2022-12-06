Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C92C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiLFOoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiLFOoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 09:44:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E832250B
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tYTcAvjp8K/2QucZBC/sDDfw+PZjP3P4ZHHJ4H5NtJs=; b=fyKnv/8oQ5+e+4Mi7S9fG3PV4h
        6XMe8/9lToUoFEK+pC+VGjO96caphor50XuPG9e2SpEpjGiA8r7fgagmE6rpeniopXDJy/gcrdYYp
        nO/TXM97C4hahPX0qX3t8Q0wq2qxjfPK3N7OOPYv7VyEwanhLQl6tNDqWHI1F7As2gvc9YfgjbJoA
        ZxNQl1T+yzIhTI+3Rx5m3Fe4EbO1SzyngLGX+xznclHyR+YQb3pgvPTlRM9fo5fbXfEOxbSwsTR2s
        ZrtmK95NzLt2DeXdVLWdVqM3iToCND3gjVQnfk2DdFtI9ss5yX6EYawnNQrPtJMxOPnrtd+/BWrai
        jzhV/x1Q==;
Received: from [2001:4bb8:19a:6deb:96e2:518:dd92:8fb1] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2ZB3-00BV05-CI; Tue, 06 Dec 2022 14:44:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: bio_copy_data_iter
Date:   Tue,  6 Dec 2022 15:44:07 +0100
Message-Id: <20221206144407.722049-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the pktcdvdv removal, bio_copy_data_iter is unused now.  Fold the
logic into bio_copy_data and remove the separate lower level function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 37 +++++++++++++++----------------------
 include/linux/bio.h |  2 --
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ab59a491a883e3..5f96fcae3f7549 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1401,27 +1401,6 @@ void __bio_advance(struct bio *bio, unsigned bytes)
 }
 EXPORT_SYMBOL(__bio_advance);
 
-void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-			struct bio *src, struct bvec_iter *src_iter)
-{
-	while (src_iter->bi_size && dst_iter->bi_size) {
-		struct bio_vec src_bv = bio_iter_iovec(src, *src_iter);
-		struct bio_vec dst_bv = bio_iter_iovec(dst, *dst_iter);
-		unsigned int bytes = min(src_bv.bv_len, dst_bv.bv_len);
-		void *src_buf = bvec_kmap_local(&src_bv);
-		void *dst_buf = bvec_kmap_local(&dst_bv);
-
-		memcpy(dst_buf, src_buf, bytes);
-
-		kunmap_local(dst_buf);
-		kunmap_local(src_buf);
-
-		bio_advance_iter_single(src, src_iter, bytes);
-		bio_advance_iter_single(dst, dst_iter, bytes);
-	}
-}
-EXPORT_SYMBOL(bio_copy_data_iter);
-
 /**
  * bio_copy_data - copy contents of data buffers from one bio to another
  * @src: source bio
@@ -1435,7 +1414,21 @@ void bio_copy_data(struct bio *dst, struct bio *src)
 	struct bvec_iter src_iter = src->bi_iter;
 	struct bvec_iter dst_iter = dst->bi_iter;
 
-	bio_copy_data_iter(dst, &dst_iter, src, &src_iter);
+	while (src_iter.bi_size && dst_iter.bi_size) {
+		struct bio_vec src_bv = bio_iter_iovec(src, src_iter);
+		struct bio_vec dst_bv = bio_iter_iovec(dst, dst_iter);
+		unsigned int bytes = min(src_bv.bv_len, dst_bv.bv_len);
+		void *src_buf = bvec_kmap_local(&src_bv);
+		void *dst_buf = bvec_kmap_local(&dst_bv);
+
+		memcpy(dst_buf, src_buf, bytes);
+
+		kunmap_local(dst_buf);
+		kunmap_local(src_buf);
+
+		bio_advance_iter_single(src, &src_iter, bytes);
+		bio_advance_iter_single(dst, &dst_iter, bytes);
+	}
 }
 EXPORT_SYMBOL(bio_copy_data);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2c5806997bbf71..b231a665682a3f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -475,8 +475,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
-- 
2.35.1

