Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B28C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiF2XeA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiF2Xdg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:36 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52259255B9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:24 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id d129so16761836pgc.9
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwZgRIbeTJ8+UmoWbPxfXxKQtrGzbjX7MkK2nUi2Kgk=;
        b=iB1O3O7ricWQhynp2pvQ3vle1cFOPF7692UpoLu5MfXvjJskudFBqoHlNHrRdPjkJq
         r/qiYeRzZZbNp1Ec/kpkg1nAUrahyUI5J4T7TrlnUa6DPnWR+yPngKfsZz8qRy4ppXuF
         JITK5Ijn6P7KvkM2X2y0XSqGtsYkCD+DelwvI9TqVXyQE9d7itYcRP+gMOcLyCXhK1zB
         WKwZnsan0mr6ZIR9Z4fqsyqiDaNN/sjBSmuiXhl00nNLaIkhcBqmxSBGGxKmG80dSFnf
         hj1JL554C3KeJtX5H2MYxj4rZNtUX47q1Bs6EpkoxDDhxxU8FFeQS8IiyMDv4JFQcNXy
         EjjA==
X-Gm-Message-State: AJIora/Hjqzmcl6Rpi1SBSM3/Xn+HnrYfoyGs9rj3tS1/z8Awn+FakX1
        PUBZPTgjYbY5ifvuneVFs1A=
X-Google-Smtp-Source: AGRyM1sfW4BtJCPpZ9mLrIW7QgXlnCqwlfy6R/SACDLis9Ptm1+vhz7IP7qyNfmxKtpcbBI7hGw6yw==
X-Received: by 2002:a63:6f43:0:b0:408:d61b:77b0 with SMTP id k64-20020a636f43000000b00408d61b77b0mr4845013pgc.529.1656545599930;
        Wed, 29 Jun 2022 16:33:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH v2 57/63] fs/nfs: Use enum req_op where appropriate
Date:   Wed, 29 Jun 2022 16:31:39 -0700
Message-Id: <20220629233145.2779494-58-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
