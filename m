Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B9C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641A620854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BY73Nqku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfCNUox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52168 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfCNUox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:53 -0400
Received: by mail-it1-f194.google.com with SMTP id e24so6946433itl.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gN840LcjsGueYPKzT8V5G3GCmhFsVue5RDrc94TYwF8=;
        b=BY73Nqku9pDd7Tt63H0nWva/+qC+nYYLeIseswb6XjfgcsuxlekYjhlpcwqcubu04C
         89LhMs8JojYWO/bKAS+ygqaWuIx66BKsoP0reJH57vFZuVvZE24Mfh86Mh0hFdmKCRh4
         mEaPRawGIA0MPhYRGjyOvL2EhKQbwrFS+D3woXxK29xEGLhhLgrsP6cRy3K7tEDQZ7+H
         81wpotgaL3p2DPdc8NvUTzWKsCVdUCZUojHVobfcH30LChV3apU217xKELqyMEXhf8UG
         ukKvjw+4fkla21vDFVsH0E6B3VM34X9832lmiv6FZ7lEoFa5eaqU6ETnFKUXYnsYlyeJ
         XR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gN840LcjsGueYPKzT8V5G3GCmhFsVue5RDrc94TYwF8=;
        b=G90lZ473TzYEwp80WodmRdR2i3WHSwPWHARfp7RUL9jMG2Up+Vptd0i0RmnNtUosm9
         NlQ7nkBcjWpVsgDHDzV2dPNZI/PXxDK10NL9Copv0XOQv+bSoC9c9XW929vdLS1oz/gG
         HsYlXg4gkxVRDOfa4aDCFgCQcgnpcjxttv5hRCraDR+lVSZ0rgRXSaaZrINiXp7utSgB
         IeWqXmGDUPB1z+u+YV+ekww+cM+w2Hgj3hvBB/yttWFLh9EdEMI3qnASMQUprfFEZ+e5
         vInnaI2DAwchEJoYIlnsZbhFF/lrTHuLuaE6YhNGlmY1h/b02fcIFm8w8qG7sKCKEgAD
         CiWA==
X-Gm-Message-State: APjAAAUxv7nYgYuBwCOB1KDu9h+Ynwn1xOOsfCIQuil/5v583P3ixoqG
        E6u4mJiQVNuKvYYxivkIomVO2w==
X-Google-Smtp-Source: APXvYqxgiKVBxGm8tkS8ryVboSIYwzaJFzcb+ybnacq8EPE3WSLep5bL0V1suqgL7zogmL3Jm1pySQ==
X-Received: by 2002:a24:f644:: with SMTP id u65mr334070ith.162.1552596291893;
        Thu, 14 Mar 2019 13:44:51 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] block: add BIO_NO_PAGE_REF flag
Date:   Thu, 14 Mar 2019 14:44:34 -0600
Message-Id: <20190314204435.7692-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
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

