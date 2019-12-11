Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60300C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFD72173E
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zn3Mpc2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfLKP35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33747 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbfLKP35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so1562581pls.0
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8zjCrJz5ZRdYBpdQDfhxTslxtlYCGJ1G+7YBvhVfgI=;
        b=zn3Mpc2fwIWc8pDQB7gP4q1pc2X/iEkrHaHLDGQcQNv4SUM1gMOlKSJWO0Qa9fumRn
         V93Ai4CIFs5tfbxv50V+C5LCLzKT/QO6RS+DTBKmRX7+h1Dekabh/e2BZnzXhKE9S96x
         k3oSrULLsUS4G7/WB6wdu3oxW39bMMOsbwkueMFJz+qwizVg9wpSXOfu1930JZNE5Sv/
         6B39S5oZSQAXvfDAIWA77wQxq+5o76S+lrOCmQgsIqfxXsmEqmUGMbl9+nGbnpmaVXcQ
         RmPtQ1ltav6gOMXmPA1F0P/TsJTdPjXwvQFKacyLYt6XtYlH0WwanpyqHoeuJksP1Kjn
         kiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8zjCrJz5ZRdYBpdQDfhxTslxtlYCGJ1G+7YBvhVfgI=;
        b=bm8XAtRV/zeWvBOAAZfx0rX3CLmPPMdKFGvtzQhH240v2ZzQtpruR0ugdT+iB9XxbI
         jWL749AxGUsOxTnHs5I16d1sAbz8HN+3RhiNUNJL8BwKqtQscXLWpu3L24nWliCo+NnH
         gNJ79/D/qahqjz/XXYj5rI7LDO4H38BjMllJ6l4YhrlV8sKznIKQRR1756U8bdIcGrwY
         H3d3bOdNHrxzf9a6jzyhsKXjP7Cikm6Rr31MYGsqDFeRB5Eb41Hkj0qB6TcZ9v/X/Srz
         4tbgn0jSrepcFc+Z10esh/CpfCkx1z5SFMfynnzhoGj6aoE8/NrpvcoKLcilIzQ8G60T
         BHJQ==
X-Gm-Message-State: APjAAAWbAVBF8aoxrG8Fbyk4HZ87GVDsxA7gILXzk9FHdnEOZ1XsprFG
        b5rzaAcCmj7X+0Uc+YyH6kg0lw==
X-Google-Smtp-Source: APXvYqzNcqVyVbZb9ulz0Wi2/V5mzS/cYQorx+P9Kc7sv7G0jLWljuOrg76Dj1hLiJyji1gF1tDCJA==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr4171295pjs.59.1576078195498;
        Wed, 11 Dec 2019 07:29:55 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] iomap: pass in the write_begin/write_end flags to iomap_actor
Date:   Wed, 11 Dec 2019 08:29:42 -0700
Message-Id: <20191211152943.2933-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for passing in a flag to the iomap_actor, which
currently doesn't support that.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/dax.c               |  2 +-
 fs/iomap/apply.c       |  2 +-
 fs/iomap/buffered-io.c | 17 ++++++++++-------
 fs/iomap/direct-io.c   |  3 ++-
 fs/iomap/fiemap.c      |  5 +++--
 fs/iomap/seek.c        |  6 ++++--
 fs/iomap/swapfile.c    |  2 +-
 include/linux/iomap.h  |  5 +++--
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..30a20b994140 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1091,7 +1091,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
 static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..562536da8a13 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -77,7 +77,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * iomap into the actors so that they don't need to have special
 	 * handling for the two cases.
 	 */
-	written = actor(inode, pos, length, data, &iomap,
+	written = actor(inode, pos, length, data, flags, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
 	/*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..9b5b770ca4c7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -249,7 +249,7 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
@@ -397,7 +397,8 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 
 static loff_t
 iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
 	loff_t done, ret;
@@ -417,7 +418,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
+				ctx, 0, iomap, srcmap);
 	}
 
 	return done;
@@ -797,7 +798,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 
 static loff_t
 iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iov_iter *i = data;
 	long status = 0;
@@ -897,7 +898,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 static loff_t
 iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	long status = 0;
 	ssize_t written = 0;
@@ -983,7 +984,8 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	bool *did_zero = data;
 	loff_t written = 0;
@@ -1053,7 +1055,8 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
 static loff_t
 iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct page *page = data;
 	int ret;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..2525997b09aa 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -365,7 +365,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 
 static loff_t
 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct iomap_dio *dio = data;
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index bccf305ea9ce..04de960259d0 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -44,7 +44,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 
 static loff_t
 iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct fiemap_ctx *ctx = data;
 	loff_t ret = length;
@@ -111,7 +111,8 @@ EXPORT_SYMBOL_GPL(iomap_fiemap);
 
 static loff_t
 iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	sector_t *bno = data, addr;
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 89f61d93c0bc..a5cbf04e8cb3 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -119,7 +119,8 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
 
 static loff_t
 iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+		      void *data, unsigned flags, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
 	switch (iomap->type) {
 	case IOMAP_UNWRITTEN:
@@ -165,7 +166,8 @@ EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
 static loff_t
 iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+		      void *data, unsigned flags, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
 	switch (iomap->type) {
 	case IOMAP_HOLE:
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..774bfc3e59e1 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -76,7 +76,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
  * distinction between written and unwritten extents.
  */
 static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
-		loff_t count, void *data, struct iomap *iomap,
+		loff_t count, void *data, unsigned flags, struct iomap *iomap,
 		struct iomap *srcmap)
 {
 	struct iomap_swapfile_info *isi = data;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..61fcaa3904d4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -113,7 +113,7 @@ struct iomap_page_ops {
 };
 
 /*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ * Flags for iomap_begin / iomap_end / factor.  No flag implies a read.
  */
 #define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
 #define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
@@ -146,7 +146,8 @@ struct iomap_ops {
  * Main iomap iterator function.
  */
 typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
-		void *data, struct iomap *iomap, struct iomap *srcmap);
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap);
 
 loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
-- 
2.24.0

