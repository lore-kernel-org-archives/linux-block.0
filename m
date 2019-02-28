Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8825C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78671218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EW/2bSFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfB1Vgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:36:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40013 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfB1Vgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:36:50 -0500
Received: by mail-io1-f65.google.com with SMTP id p17so17862750iol.7
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gN840LcjsGueYPKzT8V5G3GCmhFsVue5RDrc94TYwF8=;
        b=EW/2bSFBEJnJMzckHYpibMwmN00iW6WFdT61U7JN3JjNFRcZ3KQqOeNKueLmj4VOfM
         7suPlt6D3GDSbT9nVaNt7w7aVUv6EfVXlPzD7faP0VLnIacg5ewbGaJI090awhHswUBE
         mJ2k4bUBagfv7+tCQS1siUl2njOVoEPjyZh1kLnj3xiSFbm+hETLl4oz/W13bI4b05GQ
         BBtcLMctwi945Ek0pxvRscj7Ih++4S+oeQokMEdW+V0cwETP7c2RHV3JqXxgVJnu+UxN
         E/Hj4K0nEtwZ0zIZZtLt82TRujuxeweRgTVpkbDmaHSrlW8kutfQxp3dlcdXQbjBV2FN
         nhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gN840LcjsGueYPKzT8V5G3GCmhFsVue5RDrc94TYwF8=;
        b=RKU48hdyF+L3tTfoNpYf45TXMnMQS0dwyGDdSF1RuVZMzxEepPkJxOwmol3lqtO0by
         ynfWFf4JamVdeulrh94y0Bqt+ldIscZFHxJV5GB4VkoLUND8Dy+hPSa1rF2IDh88kMF7
         UBPbZBCh1n4vWRrLqfJzYpJVRPzeOe7afXlvXA31albF14q/puYQVYUj1YDpku2QiQev
         cBSGrdUyLs3aKxrDcwg9hIKa2L+EXhp5iohXqPkTTaHhxmAdEL3xR9nkpXSqGvOAqnAm
         KHX9b/fj90Fehqz0VzBmv4L9ReUc9V7nqbDrv76zif4zurhXwa1SkYJUoNdiB+Kx55l8
         LA6A==
X-Gm-Message-State: APjAAAUa+vL+TPQ2BEpMdASWy3VVw0jFufb8p9YHwqUBAOs4IRPnzRux
        +x86pPMyuKPS20xyhaZZZaWhzFw2JysRIw==
X-Google-Smtp-Source: APXvYqz6GsXVEflLhiAWOi7n1NHPWeBZN+EQAAGXtnCBdN0Du/Y73GywbCLGqCY34Ucw+/TbzbdB7Q==
X-Received: by 2002:a5e:840c:: with SMTP id h12mr918368ioj.284.1551389809027;
        Thu, 28 Feb 2019 13:36:49 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m79sm1376311itm.25.2019.02.28.13.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:36:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: add BIO_NO_PAGE_REF flag
Date:   Thu, 28 Feb 2019 14:36:42 -0700
Message-Id: <20190228213642.306-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228213642.306-1-axboe@kernel.dk>
References: <20190228213642.306-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If bio_iov_iter_get_pages() is called on an iov_iter that is flagged
with NO_REF, then we don't need to add a page reference for the pages
that we add.

Add BIO_NO_PAGE_REF to track this in the bio, so IO completion knows
not to drop a reference to these pages.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 43 ++++++++++++++++++++++-----------------
 fs/block_dev.c            | 12 ++++++-----
 fs/iomap.c                | 12 ++++++-----
 include/linux/blk_types.h |  1 +
 4 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 71a78d9fb8b7..b64cedc7f87c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -849,20 +849,14 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 	size = bio_add_page(bio, bv->bv_page, len,
 				bv->bv_offset + iter->iov_offset);
 	if (size == len) {
-		struct page *page;
-		int i;
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
+			struct page *page;
+			int i;
+
+			mp_bvec_for_each_page(page, bv, i)
+				get_page(page);
+		}
 
-		/*
-		 * For the normal O_DIRECT case, we could skip grabbing this
-		 * reference and then not have to put them again when IO
-		 * completes. But this breaks some in-kernel users, like
-		 * splicing to/from a loop device, where we release the pipe
-		 * pages unconditionally. If we can fix that case, we can
-		 * get rid of the get here and the need to call
-		 * bio_release_pages() at IO completion time.
-		 */
-		mp_bvec_for_each_page(page, bv, i)
-			get_page(page);
 		iov_iter_advance(iter, size);
 		return 0;
 	}
@@ -925,10 +919,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  * This takes either an iterator pointing to user memory, or one pointing to
  * kernel pages (BVEC iterator). If we're adding user pages, we pin them and
  * map them into the kernel. On IO completion, the caller should put those
- * pages. For now, when adding kernel pages, we still grab a reference to the
- * page. This isn't strictly needed for the common case, but some call paths
- * end up releasing pages from eg a pipe and we can't easily control these.
- * See comment in __bio_iov_bvec_add_pages().
+ * pages. If we're adding kernel pages, and the caller told us it's safe to
+ * do so, we just have to add the pages to the bio directly. We don't grab an
+ * extra reference to those pages (the user should already have that), and we
+ * don't put the page on IO completion. The caller needs to check if the bio is
+ * flagged BIO_NO_PAGE_REF on IO completion. If it isn't, then pages should be
+ * released.
  *
  * The function tries, but does not guarantee, to pin as many pages as
  * fit into the bio, or are requested in *iter, whatever is smaller. If
@@ -940,6 +936,13 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	const bool is_bvec = iov_iter_is_bvec(iter);
 	unsigned short orig_vcnt = bio->bi_vcnt;
 
+	/*
+	 * If this is a BVEC iter, then the pages are kernel pages. Don't
+	 * release them on IO completion, if the caller asked us to.
+	 */
+	if (is_bvec && iov_iter_bvec_no_ref(iter))
+		bio_set_flag(bio, BIO_NO_PAGE_REF);
+
 	do {
 		int ret;
 
@@ -1696,7 +1699,8 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1713,7 +1717,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e9faa52bb489..78d3257435c0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -336,12 +336,14 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		struct bio_vec *bvec;
-		int i;
-		struct bvec_iter_all iter_all;
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
+			struct bvec_iter_all iter_all;
+			struct bio_vec *bvec;
+			int i;
 
-		bio_for_each_segment_all(bvec, bio, i, iter_all)
-			put_page(bvec->bv_page);
+			bio_for_each_segment_all(bvec, bio, i, iter_all)
+				put_page(bvec->bv_page);
+		}
 		bio_put(bio);
 	}
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index 97cb9d486a7d..abdd18e404f8 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1589,12 +1589,14 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		struct bio_vec *bvec;
-		int i;
-		struct bvec_iter_all iter_all;
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
+			struct bvec_iter_all iter_all;
+			struct bio_vec *bvec;
+			int i;
 
-		bio_for_each_segment_all(bvec, bio, i, iter_all)
-			put_page(bvec->bv_page);
+			bio_for_each_segment_all(bvec, bio, i, iter_all)
+				put_page(bvec->bv_page);
+		}
 		bio_put(bio);
 	}
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d66bf5f32610..791fee35df88 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -215,6 +215,7 @@ struct bio {
 /*
  * bio flags
  */
+#define BIO_NO_PAGE_REF	0	/* don't put release vec pages */
 #define BIO_SEG_VALID	1	/* bi_phys_segments valid */
 #define BIO_CLONED	2	/* doesn't own data */
 #define BIO_BOUNCED	3	/* bio is a bounce bio */
-- 
2.17.1

