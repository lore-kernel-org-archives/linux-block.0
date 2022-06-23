Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A11C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiFWTB7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiFWTBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:45 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E960F38
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:54 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id m14so18832357plg.5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfTDvfTK6+TcFj85MvGtQ2BzwTY2bgwPALXrVpGLWiA=;
        b=o/9MNRbMfnoAa5nMDMt5n1AYA4JhEZufLp+xha4mvIS4mm5gFxS/00/7OxKqR4gLt8
         UIGdclpgR3BD87wgm/lPrRmbBXUc3A1SvRfz4lyqSRLRCja+SWet3iIBEl0T0d1jQJzs
         hUuyQFBmA8hJJXBeJBuE8NQJAELLXyZ9aXii+hAewYxL6VTtnzPQNrtLdJEe4K9jiT2n
         7Ey7m0ghpVpdK4HUPB5KOZLBvHST6+x9PAGQhj4L1viMpXV2TPkehr/zHXN+xom/0VRK
         RjUAMC8xs4dgK47XcfaNE80vMFQ2f/ECwB0U4rxXyhtCjwmkDFJhFnx3QsC/cGXPH/oe
         b4dQ==
X-Gm-Message-State: AJIora/+9MM8mZsEc77tN5t2wUr/4lxPxKK4D4t3ubKrjnS8f8g5rRpv
        M6Iri2VnZk7/yiCxWwTHaec=
X-Google-Smtp-Source: AGRyM1vauuknEQ8DfHYM7PMUum1pq3RjS6jjxfIETc16jhaEPBfDhYAaRbXLRw78X7zmzzi8TrmN9g==
X-Received: by 2002:a17:90b:4b41:b0:1ec:cb06:2fa3 with SMTP id mi1-20020a17090b4b4100b001eccb062fa3mr5171497pjb.55.1656007613856;
        Thu, 23 Jun 2022 11:06:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 50/51] fs/xfs: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:27 -0700
Message-Id: <20220623180528.3595304-51-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for the
combination of a request operation with request flags.

Cc: Darrick J. Wong <djwong@kernel.org>
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
 
