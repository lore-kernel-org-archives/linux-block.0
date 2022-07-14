Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1757CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiGNSJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiGNSJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:21 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506FDC2E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:18 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id z1so1121328plb.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XRcEoE4iSMNUpUECe2dIYkLT1HuZct2wmLoZ0YJMh0=;
        b=fkG1+dDBZ23Md4GFWmp/qgexcGXGKghzknCVK1PNah4HjYLnCKZIDhvTtBmtfizxiY
         usXhFQKpYdOp1llRC7uyK7JDgAQCPlKQVHPQXM8m/7Is42S3nl3x4Xlmmkdc3dNeYWP0
         2JmqbtEQB3Nf0EHO++IjBUZOSnn1M2lBsDUTt41fUCd8YtU9CnBDmFkShO8cFyD/ZEYc
         0SrrbjXaUQpVTztCMq5vV/Qh0fxmrj9HT0ZBqITH41FjCaK8jTv40zHmaXZbyZL6srVv
         sdwD5rPVKQxoERwhiWwqg//L70I7VNc9E9Zk0X9yb6ETZlVKTnEbEAvWmxt/G5YHEs5u
         BGog==
X-Gm-Message-State: AJIora+PwYkhn1qSrzUwjQxYNMorC8mnneidyOen1XrK+y1L6E2Ttya8
        pAtN9mY4jJYav+XrYMMgO8k=
X-Google-Smtp-Source: AGRyM1sKKH88a6SfMyhZBEIvkPCOBKZstXWZN9ewBiMAa5DGYIa06c+a8759kMd6RsxHwm+5AYypoA==
X-Received: by 2002:a17:90b:1e4d:b0:1f0:462b:b531 with SMTP id pi13-20020a17090b1e4d00b001f0462bb531mr17802491pjb.34.1657822157610;
        Thu, 14 Jul 2022 11:09:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 62/63] fs/xfs: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:28 -0700
Message-Id: <20220714180729.1065367-63-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
 
