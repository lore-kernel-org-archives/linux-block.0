Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFAC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7725613C0
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhDFGSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhDFGSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:18:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23FC06174A
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fuBpmp7Kk9McTN23dUnzLCtpP7zUrz1Zo1bUVEJswkY=; b=KlLkTBQkEi66FV6TqIlQjyZOFD
        mGewBNIzxSm5MrgdWrxmBcTcDJwgalVhAiPqrCl5TLEI1bN4O2cRhLS+7ck9Psefu9tgE8+5gRm4S
        K3+BYLCS8glv5BmzyZfRhrUYC9dzwQQakjS9s4AaSoXhFSs1ZhUDGbooti097g7c7t9NXKPS2zuTt
        y0xAnqlloleet9WNouyyVlF4NjJ6OpbyplSYXAN9moZXCGGFDFwKctdOSaZDRR2LNeXRBEbgiO4vH
        fnWCvCVBIAAVHm4TOxddHdMMAJeB+B7F01Yvpr7wGZcBQ/FKRasmCbVbc1iEnJ+GSYAoRMtotA4WN
        /gfAozYA==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf2D-007o18-Bd; Tue, 06 Apr 2021 06:17:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     efremov@linux.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] floppy: always use the track buffer
Date:   Tue,  6 Apr 2021 08:17:55 +0200
Message-Id: <20210406061755.811522-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Always use the track buffer that is already used for addresses outside
the 16MB address capability of the floppy controller.  This allows to
remove a lot of code that relies on kernel virtual addresses.  With
this gone there is just a single place left that looks at the bio,
which can be converted to memcpy_{from,to}_page, thus removing the need
for the extra block-layer bounce buffering for highmem pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/floppy.c | 136 ++++++++---------------------------------
 1 file changed, 25 insertions(+), 111 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 4aa9683ee0c1aa..bdce4fdfb181a0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2399,11 +2399,10 @@ static void rw_interrupt(void)
 		probing = 0;
 	}
 
-	if (CT(raw_cmd->cmd[COMMAND]) != FD_READ ||
-	    raw_cmd->kernel_data == bio_data(current_req->bio)) {
+	if (CT(raw_cmd->cmd[COMMAND]) != FD_READ) {
 		/* transfer directly from buffer */
 		cont->done(1);
-	} else if (CT(raw_cmd->cmd[COMMAND]) == FD_READ) {
+	} else {
 		buffer_track = raw_cmd->track;
 		buffer_drive = current_drive;
 		INFBOUND(buffer_max, nr_sectors + fsector_t);
@@ -2411,27 +2410,6 @@ static void rw_interrupt(void)
 	cont->redo();
 }
 
-/* Compute maximal contiguous buffer size. */
-static int buffer_chain_size(void)
-{
-	struct bio_vec bv;
-	int size;
-	struct req_iterator iter;
-	char *base;
-
-	base = bio_data(current_req->bio);
-	size = 0;
-
-	rq_for_each_segment(bv, current_req, iter) {
-		if (page_address(bv.bv_page) + bv.bv_offset != base + size)
-			break;
-
-		size += bv.bv_len;
-	}
-
-	return size >> 9;
-}
-
 /* Compute the maximal transfer size */
 static int transfer_size(int ssize, int max_sector, int max_size)
 {
@@ -2453,7 +2431,6 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 {
 	int remaining;		/* number of transferred 512-byte sectors */
 	struct bio_vec bv;
-	char *buffer;
 	char *dma_buffer;
 	int size;
 	struct req_iterator iter;
@@ -2492,8 +2469,6 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 
 		size = bv.bv_len;
 		SUPBOUND(size, remaining);
-
-		buffer = page_address(bv.bv_page) + bv.bv_offset;
 		if (dma_buffer + size >
 		    floppy_track_buffer + (max_buffer_sectors << 10) ||
 		    dma_buffer < floppy_track_buffer) {
@@ -2509,13 +2484,13 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 				pr_info("write\n");
 			break;
 		}
-		if (((unsigned long)buffer) % 512)
-			DPRINT("%p buffer not aligned\n", buffer);
 
 		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
-			memcpy(buffer, dma_buffer, size);
+			memcpy_to_page(bv.bv_page, bv.bv_offset, dma_buffer,
+				       size);
 		else
-			memcpy(dma_buffer, buffer, size);
+			memcpy_from_page(dma_buffer, bv.bv_page, bv.bv_offset,
+					 size);
 
 		remaining -= size;
 		dma_buffer += size;
@@ -2690,54 +2665,6 @@ static int make_raw_rw_request(void)
 		raw_cmd->flags &= ~FD_RAW_WRITE;
 		raw_cmd->flags |= FD_RAW_READ;
 		raw_cmd->cmd[COMMAND] = FM_MODE(_floppy, FD_READ);
-	} else if ((unsigned long)bio_data(current_req->bio) < MAX_DMA_ADDRESS) {
-		unsigned long dma_limit;
-		int direct, indirect;
-
-		indirect =
-		    transfer_size(ssize, max_sector,
-				  max_buffer_sectors * 2) - fsector_t;
-
-		/*
-		 * Do NOT use minimum() here---MAX_DMA_ADDRESS is 64 bits wide
-		 * on a 64 bit machine!
-		 */
-		max_size = buffer_chain_size();
-		dma_limit = (MAX_DMA_ADDRESS -
-			     ((unsigned long)bio_data(current_req->bio))) >> 9;
-		if ((unsigned long)max_size > dma_limit)
-			max_size = dma_limit;
-		/* 64 kb boundaries */
-		if (CROSS_64KB(bio_data(current_req->bio), max_size << 9))
-			max_size = (K_64 -
-				    ((unsigned long)bio_data(current_req->bio)) %
-				    K_64) >> 9;
-		direct = transfer_size(ssize, max_sector, max_size) - fsector_t;
-		/*
-		 * We try to read tracks, but if we get too many errors, we
-		 * go back to reading just one sector at a time.
-		 *
-		 * This means we should be able to read a sector even if there
-		 * are other bad sectors on this track.
-		 */
-		if (!direct ||
-		    (indirect * 2 > direct * 3 &&
-		     *errors < drive_params[current_drive].max_errors.read_track &&
-		     ((!probing ||
-		       (drive_params[current_drive].read_track & (1 << drive_state[current_drive].probed_format)))))) {
-			max_size = blk_rq_sectors(current_req);
-		} else {
-			raw_cmd->kernel_data = bio_data(current_req->bio);
-			raw_cmd->length = current_count_sectors << 9;
-			if (raw_cmd->length == 0) {
-				DPRINT("%s: zero dma transfer attempted\n", __func__);
-				DPRINT("indirect=%d direct=%d fsector_t=%d\n",
-				       indirect, direct, fsector_t);
-				return 0;
-			}
-			virtualdmabug_workaround();
-			return 2;
-		}
 	}
 
 	if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
@@ -2781,19 +2708,17 @@ static int make_raw_rw_request(void)
 	raw_cmd->length = ((raw_cmd->length - 1) | (ssize - 1)) + 1;
 	raw_cmd->length <<= 9;
 	if ((raw_cmd->length < current_count_sectors << 9) ||
-	    (raw_cmd->kernel_data != bio_data(current_req->bio) &&
-	     CT(raw_cmd->cmd[COMMAND]) == FD_WRITE &&
+	    (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE &&
 	     (aligned_sector_t + (raw_cmd->length >> 9) > buffer_max ||
 	      aligned_sector_t < buffer_min)) ||
 	    raw_cmd->length % (128 << raw_cmd->cmd[SIZECODE]) ||
 	    raw_cmd->length <= 0 || current_count_sectors <= 0) {
 		DPRINT("fractionary current count b=%lx s=%lx\n",
 		       raw_cmd->length, current_count_sectors);
-		if (raw_cmd->kernel_data != bio_data(current_req->bio))
-			pr_info("addr=%d, length=%ld\n",
-				(int)((raw_cmd->kernel_data -
-				       floppy_track_buffer) >> 9),
-				current_count_sectors);
+		pr_info("addr=%d, length=%ld\n",
+			(int)((raw_cmd->kernel_data -
+			       floppy_track_buffer) >> 9),
+			current_count_sectors);
 		pr_info("st=%d ast=%d mse=%d msi=%d\n",
 			fsector_t, aligned_sector_t, max_sector, max_size);
 		pr_info("ssize=%x SIZECODE=%d\n", ssize, raw_cmd->cmd[SIZECODE]);
@@ -2807,31 +2732,21 @@ static int make_raw_rw_request(void)
 		return 0;
 	}
 
-	if (raw_cmd->kernel_data != bio_data(current_req->bio)) {
-		if (raw_cmd->kernel_data < floppy_track_buffer ||
-		    current_count_sectors < 0 ||
-		    raw_cmd->length < 0 ||
-		    raw_cmd->kernel_data + raw_cmd->length >
-		    floppy_track_buffer + (max_buffer_sectors << 10)) {
-			DPRINT("buffer overrun in schedule dma\n");
-			pr_info("fsector_t=%d buffer_min=%d current_count=%ld\n",
-				fsector_t, buffer_min, raw_cmd->length >> 9);
-			pr_info("current_count_sectors=%ld\n",
-				current_count_sectors);
-			if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
-				pr_info("read\n");
-			if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE)
-				pr_info("write\n");
-			return 0;
-		}
-	} else if (raw_cmd->length > blk_rq_bytes(current_req) ||
-		   current_count_sectors > blk_rq_sectors(current_req)) {
-		DPRINT("buffer overrun in direct transfer\n");
+	if (raw_cmd->kernel_data < floppy_track_buffer ||
+	    current_count_sectors < 0 ||
+	    raw_cmd->length < 0 ||
+	    raw_cmd->kernel_data + raw_cmd->length >
+	    floppy_track_buffer + (max_buffer_sectors << 10)) {
+		DPRINT("buffer overrun in schedule dma\n");
+		pr_info("fsector_t=%d buffer_min=%d current_count=%ld\n",
+			fsector_t, buffer_min, raw_cmd->length >> 9);
+		pr_info("current_count_sectors=%ld\n",
+			current_count_sectors);
+		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
+			pr_info("read\n");
+		if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE)
+			pr_info("write\n");
 		return 0;
-	} else if (raw_cmd->length < current_count_sectors << 9) {
-		DPRINT("more sectors than bytes\n");
-		pr_info("bytes=%ld\n", raw_cmd->length >> 9);
-		pr_info("sectors=%ld\n", current_count_sectors);
 	}
 	if (raw_cmd->length == 0) {
 		DPRINT("zero dma transfer attempted from make_raw_request\n");
@@ -4597,7 +4512,6 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 		return err;
 	}
 
-	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(disk->queue, 64);
 	disk->major = FLOPPY_MAJOR;
 	disk->first_minor = TOMINOR(drive) | (type << 2);
-- 
2.30.1

