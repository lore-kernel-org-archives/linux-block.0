Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E3C43612
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CD621929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jL82wDam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbeLUTXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39543 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391685AbeLUTXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:08 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so8024520itl.4
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aNPll3PFLtBObI+WTAtjse6wMNnAQ/B5/ms0XCANw9s=;
        b=jL82wDamJYkDsvDJ62AMeUKwuJ0r9dFY/9z5Tezg/krE36W2pQ4EBaM7jtGkEg0+MD
         l+dk0Xx1u29MDG3KhJ630t0ymzBBRVt+VvEim626vLt5LpmvFoD6OMoQ0tteSGq0C6te
         18MeuNAuahN0sR3G5lsp9IibAtYnkXeep8k0hvhkwlnteGVMBT7bwNLDWUhXoLvDs6VG
         o/z7HpwnBlUORZFl6XudkcUF174UmFqWr+zYVaPQp5+4LuuPOEMoAKnSJ0Qh9MwQ22xK
         dER++DkdtkitFYlffkhFKXDzLBCOtYK0rRkyu13fMZnuSA+4yIWhFuq+CfAdSapKmYy9
         heqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aNPll3PFLtBObI+WTAtjse6wMNnAQ/B5/ms0XCANw9s=;
        b=OZNUtDwBKSZf5DUW0R1jPrRFMTmtl2Ki0g/r2wX1Dga/h7qEjBDGcGB/sgnyPSnlQQ
         M9FL+4crYHzIzhwnfYBj9NrXP16h2n04pdiowpvLxMGapdxZdLM7Fsy5lVOO9LDtL3Fo
         HMOkvSmrSAIDwOulmgTahKideDHDwL0jXy4rolStSNyjih9+CpUdQJggMDrCEpmDRi8+
         t48XeZr1lJ+1pBmABr86uWP+VoccVW1rFmGPw4NoqVPHqDxJ9dS1ux20OltqDcMsAQ+Z
         HwYMZWtqQRgxgUnzZGpY4AU8hX9xcr8HdRGbqtyv24gTSK3IhiFIxEzrb493fZXgVfBe
         IMyQ==
X-Gm-Message-State: AA+aEWZD0I31Wn20t+OXP5Uv6SLjOcfpnupFNkbEBVFQ9rQKzKI1O6Yj
        2lGj1Yq8fI8QLqaldc5ackURGA==
X-Google-Smtp-Source: AFSGD/UopSsSuUEvV5b/N3vQmudVKNUb7Bq0QKDFfcyopiRTfHfXHFeQ1atK+Q5Mv51o+Qm6EoxEcg==
X-Received: by 2002:a02:8ca8:: with SMTP id f37mr2541758jak.80.1545420187654;
        Fri, 21 Dec 2018 11:23:07 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/22] block: implement bio helper to add iter bvec pages to bio
Date:   Fri, 21 Dec 2018 12:22:31 -0700
Message-Id: <20181221192236.12866-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an ITER_BVEC, we can just iterate the iov and add the pages
to the bio directly. This requires that the caller doesn't releases
the pages on IO completion, we add a BIO_HOLD_PAGES flag for that.

The current two callers of bio_iov_iter_get_pages() are updated to
check if they need to release pages on completion. This makes them
work with bvecs that contain kernel mapped pages already.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
 fs/block_dev.c            |  5 ++--
 fs/iomap.c                |  5 ++--
 include/linux/blk_types.h |  1 +
 4 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8281bfcbc265..cc1ddf173aaf 100644
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
+ * The caller needs to check if the bio is flagged BIO_HOLD_PAGES on IO
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
+		bio_set_flag(bio, BIO_HOLD_PAGES);
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
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
@@ -1650,7 +1688,8 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio);
+	if (!bio_flagged(bio, BIO_HOLD_PAGES))
+		bio_release_pages(bio);
 	bio_put(bio);
 	return;
 defer:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9d96c1e30854..1a3981793309 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -325,8 +325,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 		struct bio_vec *bvec;
 		int i;
 
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
 		bio_put(bio);
 	}
 }
diff --git a/fs/iomap.c b/fs/iomap.c
index 46f4cb687f6f..f5a7fc708004 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1576,8 +1576,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		struct bio_vec *bvec;
 		int i;
 
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
+		if (!bio_flagged(bio, BIO_HOLD_PAGES))
+			bio_for_each_segment_all(bvec, bio, i)
+				put_page(bvec->bv_page);
 		bio_put(bio);
 	}
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fc99474ac968..0a19de825f4f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -215,6 +215,7 @@ struct bio {
 /*
  * bio flags
  */
+#define BIO_HOLD_PAGES	0	/* don't put O_DIRECT pages */
 #define BIO_SEG_VALID	1	/* bi_phys_segments valid */
 #define BIO_CLONED	2	/* doesn't own data */
 #define BIO_BOUNCED	3	/* bio is a bounce bio */
-- 
2.17.1

