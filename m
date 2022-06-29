Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FAFC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiF2XeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiF2XeA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:34:00 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CDF5B7
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:33 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id v126so12611517pgv.11
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQHPcThElpNBg2eLrSPZ2WR8eOXiuNd0REw6P5hWDk0=;
        b=yHAuJhecLPF4B/vQd7eTcTSrP3Vw8IJrFNkgthCccDfWYNeejWoMIlTkIHvzHUZqMc
         hgonhz4PM8gBPjYaYXpGYUtxsuRqr9h9g7NfVmF+Nh+uk92K+uX7RARPoVsDaAhgouk9
         /3zaSBLo9uSBE56R9nSWp7VNwDBPAS3ADHJnhZhK/cwzTtSR+kkwXpnvfXjq1wi4l0HZ
         QOq4fntPMnGspHGsTpGARUgnZDiMcw6aYyZz7DYiVKYU7wkbOTdAMkK5CM/5hlxegegl
         3IcoogvY+O028KUWWZYuznIYChyIv3lbwzT1yp5l0PB3BJCBOTqqc6usjj3rv9NjC8Vu
         64Dw==
X-Gm-Message-State: AJIora8SnavkeRIQGkOmNqOFdZdobtAZAPj3T8BzvXbLNN9vVTB64ogK
        n6zZX9OKS8aWhooHz6d4OK4=
X-Google-Smtp-Source: AGRyM1tIQo50DxKnWlU2K7dekwY74nf0UV7CKz4KCVPhL5+l+1LAePLovKKrR6HgUxR5dHRTmdh8Hg==
X-Received: by 2002:a63:b34d:0:b0:40c:76b2:b725 with SMTP id x13-20020a63b34d000000b0040c76b2b725mr4954190pgt.440.1656545605958;
        Wed, 29 Jun 2022 16:33:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 61/63] PM: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:43 -0700
Message-Id: <20220629233145.2779494-62-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the first two
hib_submit_io() arguments into a single argument.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/power/swap.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 91fffdd2c7fb..277434b6c0bf 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -269,15 +269,14 @@ static void hib_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
-		struct hib_bio_batch *hb)
+static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
+			 struct hib_bio_batch *hb)
 {
 	struct page *page = virt_to_page(addr);
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
-			GFP_NOIO | __GFP_HIGH);
+	bio = bio_alloc(hib_resume_bdev, 1, opf, GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
@@ -317,8 +316,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
-		      swsusp_header, NULL);
+	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);
 	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
@@ -331,7 +329,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
+		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
 				      swsusp_resume_block, swsusp_header, NULL);
 	} else {
 		pr_err("Swap header not found!\n");
@@ -408,7 +406,7 @@ static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
 	} else {
 		src = buf;
 	}
-	return hib_submit_io(REQ_OP_WRITE, REQ_SYNC, offset, src, hb);
+	return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
 }
 
 static void release_swap_writer(struct swap_map_handle *handle)
@@ -1003,7 +1001,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 			return -ENOMEM;
 		}
 
-		error = hib_submit_io(REQ_OP_READ, 0, offset, tmp->map, NULL);
+		error = hib_submit_io(REQ_OP_READ, offset, tmp->map, NULL);
 		if (error) {
 			release_swap_reader(handle);
 			return error;
@@ -1027,7 +1025,7 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	offset = handle->cur->entries[handle->k];
 	if (!offset)
 		return -EFAULT;
-	error = hib_submit_io(REQ_OP_READ, 0, offset, buf, hb);
+	error = hib_submit_io(REQ_OP_READ, offset, buf, hb);
 	if (error)
 		return error;
 	if (++handle->k >= MAP_PAGE_ENTRIES) {
@@ -1526,8 +1524,7 @@ int swsusp_check(void)
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
-		error = hib_submit_io(REQ_OP_READ, 0,
-					swsusp_resume_block,
+		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
 		if (error)
 			goto put;
@@ -1535,7 +1532,7 @@ int swsusp_check(void)
 		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
-			error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
+			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
 						swsusp_resume_block,
 						swsusp_header, NULL);
 		} else {
@@ -1586,11 +1583,11 @@ int swsusp_unmark(void)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
-		      swsusp_header, NULL);
+	hib_submit_io(REQ_OP_READ, swsusp_resume_block,
+			swsusp_header, NULL);
 	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
+		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
 					swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
