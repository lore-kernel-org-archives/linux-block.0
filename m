Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A444C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA4D2077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDWHQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWHQH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:16:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A16783082E58;
        Tue, 23 Apr 2019 07:16:07 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAE5010018E0;
        Tue, 23 Apr 2019 07:16:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] block: integrity: simplify bio_integrity_prep
Date:   Tue, 23 Apr 2019 15:15:50 +0800
Message-Id: <20190423071550.20806-3-ming.lei@redhat.com>
In-Reply-To: <20190423071550.20806-1-ming.lei@redhat.com>
References: <20190423071550.20806-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Apr 2019 07:16:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now bio integrity is capable of dealing with multi-page bvec,
also bio_integrity_add_page() can add physically contiguous pages
into bip once, so avoid to loop over page by page.

Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio-integrity.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index ba9d145315ed..61edc79737bd 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -223,9 +223,7 @@ bool bio_integrity_prep(struct bio *bio)
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
 	struct request_queue *q = bio->bi_disk->queue;
 	void *buf;
-	unsigned long start, end;
-	unsigned int len, nr_pages;
-	unsigned int bytes, offset, i;
+	unsigned int len;
 	unsigned int intervals;
 	blk_status_t status;
 
@@ -262,12 +260,8 @@ bool bio_integrity_prep(struct bio *bio)
 		goto err_end_io;
 	}
 
-	end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	start = ((unsigned long) buf) >> PAGE_SHIFT;
-	nr_pages = end - start;
-
 	/* Allocate bio integrity payload and integrity vectors */
-	bip = bio_integrity_alloc(bio, GFP_NOIO, nr_pages);
+	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
@@ -283,30 +277,9 @@ bool bio_integrity_prep(struct bio *bio)
 		bip->bip_flags |= BIP_IP_CHECKSUM;
 
 	/* Map it */
-	offset = offset_in_page(buf);
-	for (i = 0 ; i < nr_pages ; i++) {
-		int ret;
-		bytes = PAGE_SIZE - offset;
-
-		if (len <= 0)
-			break;
-
-		if (bytes > len)
-			bytes = len;
-
-		ret = bio_integrity_add_page(bio, virt_to_page(buf),
-					     bytes, offset);
-
-		if (ret == 0)
-			return false;
-
-		if (ret < bytes)
-			break;
-
-		buf += bytes;
-		len -= bytes;
-		offset = 0;
-	}
+	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
+				   offset_in_page(buf)) != len)
+		return false;
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE) {
-- 
2.9.5

