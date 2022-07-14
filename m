Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F721C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiGNSJg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96A1F630
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:09 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso3865853pjh.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwZgRIbeTJ8+UmoWbPxfXxKQtrGzbjX7MkK2nUi2Kgk=;
        b=iNn3si5SsWeq7GBzX3VC9FJIOSHh4a7B25VvETUGIW1iV2S0hO4nVLR3WppblWPMgl
         aEz7D6wXFRFrHaRs6H3kQk6vW1vHkI1A5XlR3SYvuAkZuA7QutMYrtsWd1NMN5RfXXET
         izXt9vyFVAcG9Xhfh20THzXq3f/51pODgUf5TlhueTFFNDM4t/NkiS+YgB1SodAuCYNZ
         SLFGv+oXltzWV0Vt0uM6RCLxgVO6ruNg8YcHbzV3FmrDKRkfBqenfoQb7HW4uJSWBAKr
         NDRt6TyZmCoIrWLxorYm9noKljRQ8BgGFnLIIuleCmXaarcXZ+hor0NvT45LnbItYnJK
         FQBg==
X-Gm-Message-State: AJIora8DDlHLAOsvWu99abAvEq6/UQDgUBbHVDjuAkyKdK09akfYbOyr
        zKoZRKju9QP79SAcOLwW4PI=
X-Google-Smtp-Source: AGRyM1uLEPDzbPIvYUhlFYTg6pjnSzyp01wHRLDNJwKxsf6E9Lw8Z2lhWLgC8zTRhT7OaUJFBhIkVQ==
X-Received: by 2002:a17:902:f544:b0:16c:5119:d4c2 with SMTP id h4-20020a170902f54400b0016c5119d4c2mr9368872plf.1.1657822149558;
        Thu, 14 Jul 2022 11:09:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH v3 57/63] fs/nfs: Use enum req_op where appropriate
Date:   Thu, 14 Jul 2022 11:07:23 -0700
Message-Id: <20220714180729.1065367-58-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using enum req_op for request operations.
Rename an 'rw' argument into 'op' since that name is typically used for
request operations. This patch does not change any functionality. Note:
REQ_OP_READ = READ = 0 and REQ_OP_WRITE = WRITE = 1.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/nfs/blocklayout/blocklayout.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 79a8b451791f..943aeea1eb16 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -121,7 +121,7 @@ static bool offset_in_map(u64 offset, struct pnfs_block_dev_map *map)
 }
 
 static struct bio *
-do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
+do_add_page_to_bio(struct bio *bio, int npg, enum req_op op, sector_t isect,
 		struct page *page, struct pnfs_block_dev_map *map,
 		struct pnfs_block_extent *be, bio_end_io_t end_io,
 		struct parallel_io *par, unsigned int offset, int *len)
@@ -131,7 +131,7 @@ do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
 	u64 disk_addr, end;
 
 	dprintk("%s: npg %d rw %d isect %llu offset %u len %d\n", __func__,
-		npg, rw, (unsigned long long)isect, offset, *len);
+		npg, (__force u32)op, (unsigned long long)isect, offset, *len);
 
 	/* translate to device offset */
 	isect += be->be_v_offset;
@@ -154,7 +154,7 @@ do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
 
 retry:
 	if (!bio) {
-		bio = bio_alloc(map->bdev, bio_max_segs(npg), rw, GFP_NOIO);
+		bio = bio_alloc(map->bdev, bio_max_segs(npg), op, GFP_NOIO);
 		bio->bi_iter.bi_sector = disk_addr >> SECTOR_SHIFT;
 		bio->bi_end_io = end_io;
 		bio->bi_private = par;
@@ -291,7 +291,7 @@ bl_read_pagelist(struct nfs_pgio_header *header)
 		} else {
 			bio = do_add_page_to_bio(bio,
 						 header->page_array.npages - i,
-						 READ,
+						 REQ_OP_READ,
 						 isect, pages[i], &map, &be,
 						 bl_end_io_read, par,
 						 pg_offset, &pg_len);
@@ -420,9 +420,8 @@ bl_write_pagelist(struct nfs_pgio_header *header, int sync)
 
 		pg_len = PAGE_SIZE;
 		bio = do_add_page_to_bio(bio, header->page_array.npages - i,
-					 WRITE, isect, pages[i], &map, &be,
-					 bl_end_io_write, par,
-					 0, &pg_len);
+					 REQ_OP_WRITE, isect, pages[i], &map,
+					 &be, bl_end_io_write, par, 0, &pg_len);
 		if (IS_ERR(bio)) {
 			header->pnfs_error = PTR_ERR(bio);
 			bio = NULL;
