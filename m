Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD4C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 06:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiEPGhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 02:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEPGhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 02:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CECE3D
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9U+9UVqj4sUUJ+rN3Kos0cDX9lvKJL2K6jRuq0SrhVs=; b=LVaIuy7eJawthXIcJch4M5jqO+
        AISXyaAN6mFgDIHKrRYBZsOca74Bdbhip+pdIvl98eqvyAw+qcg2DNH5pdD5VG7enrUJY5KQEE8VW
        kA5i9/AwNpesPCyC1VbngcL860etxOAe/Sd3hOFz7bdpP50UZ0hMyDfB3Sk5gNhUZRHpaZc26l/7E
        8r0zm7lbxRpWC7O/cM5fgVWS1gNaOIplzLzJWdH8fTPlbbavHRymjTXGBwF3F82QVGpresP23mbFS
        Ejqzc4UjNPSLh1VTiHJF0Ilp5DDcswcS6IDJU13Pr2vkdjD07+ZaAEldal3IduSbIPD3dt7oecnFO
        iFd0Kahg==;
Received: from 213-225-11-122.nat.highway.a1.net ([213.225.11.122] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqULi-006DeF-DR; Mon, 16 May 2022 06:36:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: cleanup the VM accounting in submit_bio
Date:   Mon, 16 May 2022 08:36:54 +0200
Message-Id: <20220516063654.2782792-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio uses some extremely convoluted checks and confusing comments
to only account REQ_OP_READ/REQ_OP_WRITE comments.  Just switch to the
plain obvious checks instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ee18b6a699bdf..48a58c24d452e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -893,19 +893,11 @@ void submit_bio(struct bio *bio)
 	if (blkcg_punt_bio_submit(bio))
 		return;
 
-	/*
-	 * If it's a regular read/write or a barrier with data attached,
-	 * go through the normal accounting stuff before submission.
-	 */
-	if (bio_has_data(bio)) {
-		unsigned int count = bio_sectors(bio);
-
-		if (op_is_write(bio_op(bio))) {
-			count_vm_events(PGPGOUT, count);
-		} else {
-			task_io_account_read(bio->bi_iter.bi_size);
-			count_vm_events(PGPGIN, count);
-		}
+	if (bio_op(bio) == REQ_OP_READ) {
+		task_io_account_read(bio->bi_iter.bi_size);
+		count_vm_events(PGPGIN, bio_sectors(bio));
+	} else if (bio_op(bio) == WRITE) {
+		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
 	/*
-- 
2.30.2

