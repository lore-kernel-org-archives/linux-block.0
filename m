Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D83C2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E422173E
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qxq/32r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfLKP37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43740 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfLKP36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so455826pga.10
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vezaSQ9/HzyiknN4dL3ceKw9qbj13XNQmUHG7g1Svg=;
        b=qxq/32r1bbzFPXnnxgC3s691AYktTKm89RQV6YfjmLSwapNX/y30/rnNS/vTpMICw0
         E0CpPjbr9qyfHH8Vl8o7gSlUP4m/CdU6oSaUyiDPAqu2pKxY/tFE4d2/t/5szdhZa6xy
         mgCsrrL7ZmnM+ara0lBgrlaZPAGDiDmSnuNt1hgEMrtv7CBtQsYu+T8Ai5t6KdHnIWQ2
         /YGi/E7OpVhs4dbPi3Q+rxMKQKGcaoBx5nEtHSh3+a7dk2Th2Wsz8umkDYyO3/HKGSH7
         RlMVSN/2SuKzR1au+4VMWCNbYMJFUDUm3ZZEoqnwhewkuwCRTl/E4hYO/l9U/G04102i
         jkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vezaSQ9/HzyiknN4dL3ceKw9qbj13XNQmUHG7g1Svg=;
        b=A1nAq3ivNTd1uJBGwwEAYeXXsVuIGaeWxjPFQKkzL4K8zNEu+HPgG8SqP+CHwKeUj2
         wYMHlHmEByS033xmjpZxOLkniy6JjIDrib8TAmonb7s/b6CwtvITILXKoNEFY7xK2KaO
         55fLlVCKjf6SP4rcPvbetB6iwJhc1JTKJ5rpEYTmadVoTDT0KRUmCQPPsdvaplgooHIS
         9ZmMTQB1w/jH5rtFGcNZB1fL1HzBcir0RLX5KnByBU4gQR4wXTc+43i2T8GOGmpanHeG
         D67QA19CnUzsM9dVThUAiedhZhU8DK8CNJJ1V6r5p0xTNV7zFHrhZDJISLvYV7Q/OVLq
         csKw==
X-Gm-Message-State: APjAAAU735F4CLzfGdnUh4fp4znqQKoM5z9Jav8eppODjXd2x/Ka03xS
        0JuCWq/JJqFez4Rhi2i62bxf9A==
X-Google-Smtp-Source: APXvYqxhzEn4zXSGLljyGdTPmkM/M2dDixk96VcFJMQAKJxxvd643ce1GydOHXqrtciawN+rEIkbEA==
X-Received: by 2002:a63:4e22:: with SMTP id c34mr4738177pgb.214.1576078197199;
        Wed, 11 Dec 2019 07:29:57 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Date:   Wed, 11 Dec 2019 08:29:43 -0700
Message-Id: <20191211152943.2933-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for RWF_UNCACHED for file systems using iomap to
perform buffered writes. We use the generic infrastructure for this,
by tracking pages we created and calling write_drop_cached_pages()
to issue writeback and prune those pages.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++--------
 include/linux/iomap.h  |  5 +++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 562536da8a13..966826ad4bb9 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -90,5 +90,29 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 				     flags, &iomap);
 	}
 
+	if (written && (flags & IOMAP_UNCACHED)) {
+		struct address_space *mapping = inode->i_mapping;
+
+		end = pos + written;
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret)
+			goto out;
+
+		/*
+		 * No pages were created for this range, we're done
+		 */
+		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
+			goto out;
+
+		/*
+		 * Try to invalidate cache pages for the range we just wrote.
+		 * We don't care if invalidation fails as the write has still
+		 * worked and leaving clean uptodate pages in the page cache
+		 * isn't a corruption vector for uncached IO.
+		 */
+		invalidate_inode_pages2_range(mapping,
+				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	}
+out:
 	return written ? written : ret;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9b5b770ca4c7..09440f114506 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -566,6 +566,7 @@ EXPORT_SYMBOL_GPL(iomap_migrate_page);
 
 enum {
 	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
+	IOMAP_WRITE_F_UNCACHED		= (1 << 1),
 };
 
 static void
@@ -643,6 +644,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	unsigned aop_flags;
 	struct page *page;
 	int status = 0;
 
@@ -659,8 +661,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 			return status;
 	}
 
+	aop_flags = AOP_FLAG_NOFS;
+	if (flags & IOMAP_UNCACHED)
+		aop_flags |= AOP_FLAG_UNCACHED;
 	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
-			AOP_FLAG_NOFS);
+						aop_flags);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
@@ -670,9 +675,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		iomap_read_inline_data(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
-	else
-		status = __iomap_write_begin(inode, pos, len, flags, page,
+	else {
+		unsigned wb_flags = 0;
+
+		if (flags & IOMAP_UNCACHED)
+			wb_flags = IOMAP_WRITE_F_UNCACHED;
+		status = __iomap_write_begin(inode, pos, len, wb_flags, page,
 				srcmap);
+	}
 
 	if (unlikely(status))
 		goto out_unlock;
@@ -832,10 +842,17 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
-				srcmap);
-		if (unlikely(status))
+retry:
+		status = iomap_write_begin(inode, pos, bytes, flags, &page,
+						iomap, srcmap);
+		if (unlikely(status)) {
+			if (status == -ENOMEM && (flags & IOMAP_UNCACHED)) {
+				iomap->flags |= IOMAP_F_PAGE_CREATE;
+				flags &= ~IOMAP_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -882,10 +899,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
+	unsigned flags = IOMAP_WRITE;
+
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		flags |= IOMAP_UNCACHED;
 
 	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
+		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags,
+					ops, iter, iomap_write_actor);
 		if (ret <= 0)
 			break;
 		pos += ret;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 61fcaa3904d4..b5b5cf781eea 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -48,12 +48,16 @@ struct vm_fault;
  *
  * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
  * buffer heads for this mapping.
+ *
+ * IOMAP_F_PAGE_CREATE indicates that pages had to be allocated to satisfy
+ * this operation.
  */
 #define IOMAP_F_NEW		0x01
 #define IOMAP_F_DIRTY		0x02
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
+#define IOMAP_F_PAGE_CREATE	0x20
 
 /*
  * Flags set by the core iomap code during operations:
@@ -121,6 +125,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_UNCACHED		(1 << 6)
 
 struct iomap_ops {
 	/*
-- 
2.24.0

