Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6FC2D0C7
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C7A22B48
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hIShSVgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfLKP3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbfLKP3u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so10526435pgk.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g934jRFitGK2n249ARajPKYt/UpPdfJOZffggpxpM9A=;
        b=hIShSVguWXwm0y2cL0ju6hNSTjgZP3jIvU5CANQeaBbbgcdD6PfmACfAi4kfMs+Sqx
         nATEMWbANyYz5uspreNDCqQMAz2eCalKMGWZm21O9mpV7mCH/K4jmhnX/pB/lM1aE0vM
         Xm/hmRQamtmiB6Pj9UPRaQ2DAIiLu2Qy0H/4qEegJZeOX1p+Yl2jRURAqxI866AIvP3Y
         3UkbbAU+/7GJlWj/F02kfTmothrYFyD0N89sVtF04WTWIQx7aeucl6rRkCb2zrxepLZQ
         xP8vmSzTeiLhDUm2cExVT4HSFl9BTSNUR3f3NiK51XVhiZASq3GK9ydsAXSn+aeHt6A5
         Ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g934jRFitGK2n249ARajPKYt/UpPdfJOZffggpxpM9A=;
        b=ahsWtSoKbfki9tuDkDp3RsDYmuwU0ECiyenuUwjcbYgYW85yFbdDTEoRu0lhyKXfHe
         d8Tc48tT2YAppO6nN+1IjTnGIj4PRSA7HZxoLuIyr8s4q2ZPnruyx2KDGu1V5JrAkfXL
         aeFo8ASqZQx4+3Ju60pmU3afjEjsNYFoaQ8YP9gMeIJ7UWnJwEFRunLxPb/6Pi+4wCsN
         K+yv+6prZjDLoi/JsKK5wXhnmoGbn9wSrEKeGL3QOPcKEyiGMA5Siq+O8Exu6M5od+HT
         xcGq49YvyzN3+ZWsioMaNu30AIoKGYu5eC5H42biewQfnXjPawqB86rUKjNm/nTj+TjU
         0fHA==
X-Gm-Message-State: APjAAAWCg682fmDwGvWrLYrOps4iApqY9qzN0zeGhAlx/lLiWjprP6JV
        5g7BtVosCuiMpFLl4epet1aImA==
X-Google-Smtp-Source: APXvYqwpF6dGCPhavv63RwYf+8PYYsJTF9C7RX+z8Jolg/cVO5+K6nTPhv4+p5ass14DlFh2i74SoA==
X-Received: by 2002:a63:a707:: with SMTP id d7mr4668981pgf.93.1576078189951;
        Wed, 11 Dec 2019 07:29:49 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] fs: add read support for RWF_UNCACHED
Date:   Wed, 11 Dec 2019 08:29:39 -0700
Message-Id: <20191211152943.2933-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll drop the
cache for buffered reads if we are the ones instantiating it. If the
data is already cached, we leave it cached.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      |  3 +++
 include/uapi/linux/fs.h |  5 ++++-
 mm/filemap.c            | 46 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..092ea2a4319b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_UNCACHED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3418,6 +3419,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		ki->ki_flags |= IOCB_APPEND;
+	if (flags & RWF_UNCACHED)
+		ki->ki_flags |= IOCB_UNCACHED;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..357ebb0e0c5d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -299,8 +299,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* drop cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000040)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_UNCACHED)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..ed23a11b3e34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -933,8 +933,8 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
+static int __add_to_page_cache(struct page *page, struct address_space *mapping,
+			       pgoff_t offset, gfp_t gfp_mask, bool lru)
 {
 	void *shadow = NULL;
 	int ret;
@@ -956,9 +956,17 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		WARN_ON_ONCE(PageActive(page));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
 			workingset_refault(page, shadow);
-		lru_cache_add(page);
+		if (lru)
+			lru_cache_add(page);
 	}
 	return ret;
+
+}
+
+int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
+				pgoff_t offset, gfp_t gfp_mask)
+{
+	return __add_to_page_cache(page, mapping, offset, gfp_mask, true);
 }
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
 
@@ -2032,6 +2040,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	offset = *ppos & ~PAGE_MASK;
 
 	for (;;) {
+		bool drop_page = false;
 		struct page *page;
 		pgoff_t end_index;
 		loff_t isize;
@@ -2048,6 +2057,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;
+			/* UNCACHED implies no read-ahead */
+			if (iocb->ki_flags & IOCB_UNCACHED)
+				goto no_cached_page;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -2147,6 +2159,26 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		offset &= ~PAGE_MASK;
 		prev_offset = offset;
 
+		/*
+		 * If we're dropping this page due to drop-behind, then
+		 * lock it first. Ignore errors here, we can just leave it
+		 * in the page cache. Note that we didn't add this page to
+		 * the LRU when we added it to the page cache. So if we
+		 * fail removing it, or lock it, add to the LRU.
+		 */
+		if (drop_page) {
+			bool addlru = true;
+
+			if (!lock_page_killable(page)) {
+				if (page->mapping == mapping)
+					addlru = !remove_mapping(mapping, page);
+				else
+					addlru = false;
+				unlock_page(page);
+			}
+			if (addlru)
+				lru_cache_add(page);
+		}
 		put_page(page);
 		written += ret;
 		if (!iov_iter_count(iter))
@@ -2234,8 +2266,12 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
-		error = add_to_page_cache_lru(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			drop_page = true;
+
+		error = __add_to_page_cache(page, mapping, index,
+				mapping_gfp_constraint(mapping, GFP_KERNEL),
+				!drop_page);
 		if (error) {
 			put_page(page);
 			if (error == -EEXIST) {
-- 
2.24.0

