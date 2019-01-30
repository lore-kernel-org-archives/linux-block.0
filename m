Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26060C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FC720882
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RS1ICGx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfA3X0C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:26:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41863 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3X0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:26:02 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so1061158ioc.8
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BK66d+c011HKx58tvLlznS+PEC6KSjdwHKShIT6KD+A=;
        b=RS1ICGx9eCd+DVjixkhcbXZI22u6/fF01cB9L7GaiFtH8FT4g8XRzYeU96GUwP25xV
         H8Hn++L0YQ//tDaSaCryo+g4iryG+iOQ4ne6RrC5yo1Q7k/7qx/5vW9BTGfdcXlw+KMw
         4sc6wH2xzQPQVE+Vs7a+zIFKC+vrZWDJdQ7epbA3jdb/Dxqr3h7yNBd8Ubgk5BQdw0KX
         GJRysyfVU+C8tWCv4SSFfCMbYff8n9KkRkUrs32g4DmN51CL4CeTvKBz4oqjiG4E5YdX
         rrWfdLNykcpk7mBWy3iMpt0jWpYaRTt9nxFNRC94YeJiimWRGrO6XT/cGuwsrCfPR4V0
         HTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BK66d+c011HKx58tvLlznS+PEC6KSjdwHKShIT6KD+A=;
        b=dhGSz7F+O1qd5yXUvjDDucZfEqoPlWiO8cUHkdja+Pk9tTPBpzTpg5rQ3SN+FRVYl8
         +6dfleadPO4TJksp8+rPypSwkbN5BGu6GpcHHoiskRLSzTbRrj+v1+rwAef/R7ZS8zoH
         pjphMA2MppyGMnEw1mnMJpFBYHAeLpG8rHWiT/UCaXJBS9Ffz148sWxRAlkEClMpIvDU
         5pBSV3FXgV1Zw2QgR9YB+7EfFwUt7esfP0k3nbgZf/ZBLRSYhloaRB9nYLPCXQV0ryAJ
         3EAk2YjrBEr/K+eHobynMogQDcE2eagwTePnsY4oNoWeFB4CwldZOr4ehGf+H9gBCMrU
         VK/A==
X-Gm-Message-State: AHQUAubW//pysx/G+6k26VTpq5C9MxNaf3q9iMZVwFvDlJuHEmU7QDKG
        X8HyPUGmir04Ftdt055nUf/LYXZaf1M=
X-Google-Smtp-Source: ALg8bN7hufXf4vXAcwJdfG/hHVJfxGju0rHqadMcKEIMBQ3YA4mFfQZFqFsAp/YnR0xCkvTCurDxxQ==
X-Received: by 2002:a6b:92d7:: with SMTP id u206mr19879481iod.174.1548885364102;
        Wed, 30 Jan 2019 13:56:04 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:56:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/18] block: implement bio helper to add iter bvec pages to bio
Date:   Wed, 30 Jan 2019 14:55:33 -0700
Message-Id: <20190130215540.20871-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an ITER_BVEC, we can just iterate the iov and add the pages
to the bio directly. This requires that the caller doesn't releases
the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.

The current two callers of bio_iov_iter_get_pages() are updated to
check if they need to release pages on completion. This makes them
work with bvecs that contain kernel mapped pages already.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
 fs/block_dev.c            |  5 ++--
 fs/iomap.c                |  5 ++--
 include/linux/blk_types.h |  1 +
 4 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..330df572cfb8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
+{
+	const struct bio_vec *bv = iter->bvec;
+	unsigned int len;
+	size_t size;
+
+	len = min_t(size_t, bv->bv_len, iter->count);
+	size = bio_add_page(bio, bv->bv_page, len,
+				bv->bv_offset + iter->iov_offset);
+	if (size == len) {
+		iov_iter_advance(iter, size);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
 /**
@@ -876,23 +893,43 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 }
 
 /**
- * bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
+ * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
- * @iter: iov iterator describing the region to be mapped
+ * @iter: iov iterator describing the region to be added
+ *
+ * This takes either an iterator pointing to user memory, or one pointing to
+ * kernel pages (BVEC iterator). If we're adding user pages, we pin them and
+ * map them into the kernel. On IO completion, the caller should put those
+ * pages. If we're adding kernel pages, we just have to add the pages to the
+ * bio directly. We don't grab an extra reference to those pages (the user
+ * should already have that), and we don't put the page on IO completion.
+ * The caller needs to check if the bio is flagged BIO_NO_PAGE_REF on IO
+ * completion. If it isn't, then pages should be released.
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
  * The function tries, but does not guarantee, to pin as many pages as
- * fit into the bio, or are requested in *iter, whatever is smaller.
- * If MM encounters an error pinning the requested pages, it stops.
- * Error is returned only if 0 pages could be pinned.
+ * fit into the bio, or are requested in *iter, whatever is smaller. If
+ * MM encounters an error pinning the requested pages, it stops. Error
+ * is returned only if 0 pages could be pinned.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
+	const bool is_bvec = iov_iter_is_bvec(iter);
 	unsigned short orig_vcnt = bio->bi_vcnt;
 
+	/*
+	 * If this is a BVEC iter, then the pages are kernel pages. Don't
+	 * release them on IO completion.
+	 */
+	if (is_bvec)
+		bio_set_flag(bio, BIO_NO_PAGE_REF);
+
 	do {
-		int ret = __bio_iov_iter_get_pages(bio, iter);
+		int ret;
+
+		if (is_bvec)
+			ret = __bio_iov_bvec_add_pages(bio, iter);
+		else
+			ret = __bio_iov_iter_get_pages(bio, iter);
 
 		if (unlikely(ret))
 			return bio->bi_vcnt > orig_vcnt ? 0 : ret;
@@ -1634,7 +1671,8 @@ static void bio_dirty_fn(struct work_struct *work)
 		next = bio->bi_private;
 
 		bio_set_pages_dirty(bio);
-		bio_release_pages(bio);
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1650,7 +1688,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 392e2bfb636f..051ab41d1c61 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -338,8 +338,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 		struct bio_vec *bvec;
 		int i;
 
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
 		bio_put(bio);
 	}
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index 4ee50b76b4a1..e5c48a0b20e0 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1582,8 +1582,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		struct bio_vec *bvec;
 		int i;
 
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
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

