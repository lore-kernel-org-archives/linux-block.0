Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C93CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiGNSJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiGNSJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:19 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B013F1D
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:16 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id l12so1122112plk.13
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqV8cNZaB9jlk+NaIIKl1ONjy8WOx/shXV6SvyYqNyQ=;
        b=rSaNV+vPZzKV0idhTTs7odrI7RfeJcNB1C17HeGmknUusQMPETVwFrBa3ZtZePPlcr
         OfgHP9zgvKWVFcxhaPJwBtJdybWkMSOrJ/UDXdj7g/zX4hZWIE8imYzxwnuql/ieWw59
         XmQfDOKNhzwEJmmRsPUdhHgWj5Dx5HFw82jUAfVho+8TUOE9k26VrEclM4a26ZMNnP2L
         6a1XiqhMzYl3dk8P68zwcmAVMiiCGO6TNf3o9aEcbLxA9x3XPdcnnvjtN7nQgxTpWu8+
         klJntE3RUJ+18fUtvPW9VAroxFLaW2NekFsqvVj8HXraqgzmcQdaM6CC1x/WEp11Wv7c
         sG3w==
X-Gm-Message-State: AJIora+cL056SKw2ToVjuhNdCzdslgh8ip8zkghdIRJW0s6HhWxuiEh5
        Z6eTFBmdiZPuXr2ZDWkahzw=
X-Google-Smtp-Source: AGRyM1s7xtq/w1mQaucwsr7+7uWNUpqbgSbpdV6NDww0l1VCZ6hzQBOqGHCd0gCFH1iZ+I/hHWbXkA==
X-Received: by 2002:a17:902:f54e:b0:16c:5119:d4a8 with SMTP id h14-20020a170902f54e00b0016c5119d4a8mr9387356plf.22.1657822155988;
        Thu, 14 Jul 2022 11:09:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 61/63] PM: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:27 -0700
Message-Id: <20220714180729.1065367-62-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the first two
hib_submit_io() arguments into a single argument.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
