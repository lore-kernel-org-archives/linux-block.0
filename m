Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19926C2D0C4
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3355207FF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 16:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eQQkP4Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfLJQZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:25:05 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41748 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfLJQZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 11:25:04 -0500
Received: by mail-il1-f194.google.com with SMTP id z90so16640818ilc.8
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2019 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6xGL0+Pvg+YsVb4S081GX/xoxEhKO3Eq64Kq716fjY=;
        b=eQQkP4QniithxoS/TSUmlbKRATm/UWwPjKu5OwiUIOCJnp7KCYci+TRhGXB2cQgZHU
         vHFvXlmoWh1qn7u+pFpAtwDxLp41TidswikH0e6NbtPVWF29qmIQ3bdsEWqXZPZmIR9Z
         6gY4C4Rasj5MSB0KWqLtkVkQSIkuBLs++jKv9q0NmceTz08mPxux8e8dfYP3hE7jkQdD
         q6U/WDMVmItC5Vvi0A3vdrBcdTdTCtY0d8UoKfyKioyzQdB3d68aBCRrzFpgwT5qs3k6
         kgD/FAXk3Ij9DJsVFyjkMVDgc80SniX11+vaw8WiF+SqbnwSBW41klh453qhmAf+Q5r1
         CQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6xGL0+Pvg+YsVb4S081GX/xoxEhKO3Eq64Kq716fjY=;
        b=si96c7GilBKYXrfWsuou9mTGRTRRgonf95Q88Sy4XceIDQErRrgquWUw7oR4YnAlrm
         7Peuql9TR+hvP6LdnKxHvh6B54AfrSYLheajyEZggA96druYMQxuMWiY0SH2y/4Q1LzU
         jFdEzvNogD/q6d5gZ41zTXql9nd7p+JiJMEkomQq8fPoBfKyIwkyWeVYXnrg70eF6nrw
         ApB4fxGPKER5+lCKDXSD9/dQ7V+K8vsq5f06uwyGzuNEUCHeKKnr7TSS68vuBU2ZwXmE
         m2WQz2LNVR5CaU9dekUnoA9DB9+9ZhZy77M2q83OcmFay685lSMHIb4WaZrCpRyv2dm+
         Pxkw==
X-Gm-Message-State: APjAAAWKsSoUME2enl/s2rzDAo2Yxo3cSpu6GP+RFTb6XLDxboI9hJ2K
        BZuj2GUAOgE8Lbu8KIsP5sLG/n0BMfsnSg==
X-Google-Smtp-Source: APXvYqwqBizrk9IOVrpYwJOag6Se2wpP/F4l2DgMAcpgdzdYcJmV/WSCppXecARpMQ2a9wTOWWefmA==
X-Received: by 2002:a92:3d49:: with SMTP id k70mr33109866ila.246.1575995103774;
        Tue, 10 Dec 2019 08:25:03 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y11sm791174iol.23.2019.12.10.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:25:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Date:   Tue, 10 Dec 2019 09:24:54 -0700
Message-Id: <20191210162454.8608-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210162454.8608-1-axboe@kernel.dk>
References: <20191210162454.8608-1-axboe@kernel.dk>
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
 fs/iomap/buffered-io.c | 58 ++++++++++++++++++++++++++++++++++--------
 include/linux/iomap.h  |  1 +
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9b5b770ca4c7..c8d36b280ff2 100644
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
@@ -796,19 +806,25 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 	return ret;
 }
 
+#define GPW_PAGE_BATCH		16
+
 static loff_t
 iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
+	struct address_space *mapping = inode->i_mapping;
+	struct page *drop_pages[GPW_PAGE_BATCH];
 	struct iov_iter *i = data;
 	long status = 0;
 	ssize_t written = 0;
+	unsigned drop_nr = 0;
 
 	do {
 		struct page *page;
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
+		bool drop_page = false;	/* drop page after IO */
 
 		offset = offset_in_page(pos);
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
@@ -832,10 +848,17 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
+				drop_page = true;
+				flags &= ~IOMAP_UNCACHED;
+				goto retry;
+			}
 			break;
+		}
 
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
@@ -866,13 +889,24 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 						iov_iter_single_seg_count(i));
 			goto again;
 		}
+
+		if (drop_page &&
+		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
+			drop_pages[drop_nr] = page;
+			if (++drop_nr == GPW_PAGE_BATCH)
+				write_drop_cached_pages(drop_pages, mapping,
+								&drop_nr);
+		} else
+			balance_dirty_pages_ratelimited(inode->i_mapping);
+
 		pos += copied;
 		written += copied;
 		length -= copied;
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
 	} while (iov_iter_count(i) && length);
 
+	if (drop_nr)
+		write_drop_cached_pages(drop_pages, mapping, &drop_nr);
+
 	return written ? written : status;
 }
 
@@ -882,10 +916,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
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
index 61fcaa3904d4..833dd43507ac 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -121,6 +121,7 @@ struct iomap_page_ops {
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_UNCACHED		(1 << 6)
 
 struct iomap_ops {
 	/*
-- 
2.24.0

