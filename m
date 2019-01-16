Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF63AC43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDAB2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sTABqWCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfAPRue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35384 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfAPRud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:33 -0500
Received: by mail-io1-f65.google.com with SMTP id f4so5608419ion.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lz/3jHz1x36txQZ/D99mDx/1sUz8ZTGETsX8P4ZemoU=;
        b=sTABqWCbQD2fHxQcGIMSZ2d2ao1lOM52J+XjQepM40gZWuNCIL8Kpa9JmR5k4I2XWh
         dA5fyWDQLzfdaAKgLOyxIttJ00KiIpMr0vfXA7cAzjHv82WHwu2SJfU9IJ9KZdn37aF/
         ybO7anIq9RCj8pjaIdnBlLgO7ApHuwK0vOFglV71jTNj3QdidqigqoP7zzVKW+EhD8AP
         oMFBtqMldIV60MZsiM+XhczELtWcxVVwvbrrULVZ9qsXf72BTmiIoVO4JLLMaG2Rli4K
         Znuvokh8+oQ95Velj1MUvowNwnCX2DIQ6aYwOwB0ZkCHkMjT/2Ybr77ycw+kNpOR5NFN
         baaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lz/3jHz1x36txQZ/D99mDx/1sUz8ZTGETsX8P4ZemoU=;
        b=sstU3YYKEUTLZkeuiN2IEOv/0Qf2sA3eLH7pTVp7Btug6okEFCReKXFo2+ba1imItF
         bui22zyj4bf7rXH5qJ+311kQmqCKGulMDzN8LVLeANQK7MUma0kmIJkbKGKlQ1NSFjnf
         b1Xm+cvzDifVjOFKdPfn/4f/Gz/ZxmC/a+bQLAudscU6LWag/scEz8+xRZ0INjT//ZCI
         wER1ArMbU5VGZ7/TOrzjrvmuIpCRJD+qPwQGVj5xCUuhZG0wQ98xVKK0IgCfSnxVA4dL
         RCJE7XrcJTg9TE5IiMgmqgLyeQILA5G5QjeTEmjPI9+SUuEvWI3RvaRs3SPPoF+WykMl
         yQcA==
X-Gm-Message-State: AJcUukekHUn1dIklVSxVVWzDsp68BMphAKFgQeo2rychczpgTxWhGB+W
        vxHnM/gqe8qTppNe00L1maumQA==
X-Google-Smtp-Source: ALg8bN5GQ31v2UouS2A0ZxSKoC4Kp8ZyMRJR0xTpkVGZg7dJU4U2PfhlZi4e7r0NGfu5Mcl2uFxWVQ==
X-Received: by 2002:a5e:da49:: with SMTP id o9mr5411384iop.246.1547661032251;
        Wed, 16 Jan 2019 09:50:32 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:31 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/15] block: implement bio helper to add iter bvec pages to bio
Date:   Wed, 16 Jan 2019 10:49:59 -0700
Message-Id: <20190116175003.17880-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
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
index 4db1008309ed..7af4f45d2ed6 100644
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
index 2ebd2a0d7789..b7742014c9de 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -324,8 +324,9 @@ static void blkdev_bio_end_io(struct bio *bio)
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
index 4ee50b76b4a1..0a64c9c51203 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1582,8 +1582,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
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
index 5c7e7f859a24..97e206855cd3 100644
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

