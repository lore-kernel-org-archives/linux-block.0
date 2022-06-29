Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB8C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiF2XeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiF2XeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:34:01 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E17BD2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:36 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 9so16775982pgd.7
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XRcEoE4iSMNUpUECe2dIYkLT1HuZct2wmLoZ0YJMh0=;
        b=XogbnE7D3OIeHI5qKOD23TGaW9pS9SjGnmMjNEwd2mxZjA8bjjOaj+UlBfqHdBRW04
         Avx4ZiYzGVZEVxZCbdGRoYfQUAs8qC+M/m6vVvHnMcBqw8qle6om6YPNNVKcyygkbj0r
         LO2v8GbWSvrxK9m0HVWa3ACzAoNIWA967veg/qg5JrX7BJxRjXiL8BhUYTiehFHP1NvF
         Psgo2LK8LCp+HR6PFR+XRBvwmOEQdo+qzHyNjGgLQw6lReZwawFa48m3lTUz3g2PD1rl
         MZVAldFhdZi5tGAeoT5hOtYuIX39EGHyFXh2LAuSWgv1viKsfpbMS+2TpzVS+TDx/wRI
         PgGw==
X-Gm-Message-State: AJIora+ob7bT2ibhDrBIxN31Bq2FKUTJn4LId0lLjVytOpOy84fL6zsQ
        Oea196XQLUgCXiMZlb7jO3Y=
X-Google-Smtp-Source: AGRyM1u6R0vwPIW7ZENk9qOHF+haQX6Jr76ZavKXPywon5dWmrZ5cZ0BBi0+plTVxuqEE0mr2IVxDg==
X-Received: by 2002:a63:9d41:0:b0:40c:67af:1fed with SMTP id i62-20020a639d41000000b0040c67af1fedmr4821536pgd.185.1656545607468;
        Wed, 29 Jun 2022 16:33:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 62/63] fs/xfs: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:44 -0700
Message-Id: <20220629233145.2779494-63-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for the
combination of a request operation with request flags.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/xfs/xfs_bio_io.c      | 2 +-
 fs/xfs/xfs_buf.c         | 4 ++--
 fs/xfs/xfs_linux.h       | 2 +-
 fs/xfs/xfs_log_recover.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index ae4345b37621..fe21c76f75b8 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -15,7 +15,7 @@ xfs_rw_bdev(
 	sector_t		sector,
 	unsigned int		count,
 	char			*data,
-	unsigned int		op)
+	enum req_op		op)
 
 {
 	unsigned int		is_vmalloc = is_vmalloc_addr(data);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index bf4e60871068..5e8f40d8c052 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1416,7 +1416,7 @@ xfs_buf_ioapply_map(
 	int		map,
 	int		*buf_offset,
 	int		*count,
-	int		op)
+	blk_opf_t	op)
 {
 	int		page_index;
 	unsigned int	total_nr_pages = bp->b_page_count;
@@ -1493,7 +1493,7 @@ _xfs_buf_ioapply(
 	struct xfs_buf	*bp)
 {
 	struct blk_plug	plug;
-	int		op;
+	blk_opf_t	op;
 	int		offset;
 	int		size;
 	int		i;
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index cb9105d667db..f9878021e7d0 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -196,7 +196,7 @@ static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 }
 
 int xfs_rw_bdev(struct block_device *bdev, sector_t sector, unsigned int count,
-		char *data, unsigned int op);
+		char *data, enum req_op op);
 
 #define ASSERT_ALWAYS(expr)	\
 	(likely(expr) ? (void)0 : assfail(NULL, #expr, __FILE__, __LINE__))
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 5f7e4e6e33ce..940c8107cbd4 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -122,7 +122,7 @@ xlog_do_io(
 	xfs_daddr_t		blk_no,
 	unsigned int		nbblks,
 	char			*data,
-	unsigned int		op)
+	enum req_op		op)
 {
 	int			error;
 
