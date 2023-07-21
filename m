Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6BEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 13:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGUNwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGUNwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 09:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E84206
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689947439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cCBusrI2LRu7ze2Ol7FPMTfGYIgbj51wqVSrdkfXcqA=;
        b=LknPupNkQvIqnOGMwlgKER75TEkBtBje7VmVqZvVhl9R2fQBLlCh1+gtuvPUqKQfw5Kic5
        Rp9/cKYupEWebzGT3Zfq1lgn5gN/Ua81AQcpZDSW6PQiHYbulSmzU1++TyDGUi2QlMO8lv
        /6AUZzvLUtqJ5DzUNiM5VLfkA9hb1FQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-kvK9oESDPx26mErX2iaSKw-1; Fri, 21 Jul 2023 09:50:36 -0400
X-MC-Unique: kvK9oESDPx26mErX2iaSKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACD948564EF;
        Fri, 21 Jul 2023 13:50:35 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A158F492B02;
        Fri, 21 Jul 2023 13:50:35 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id D2BD730C0458; Fri, 21 Jul 2023 13:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id D1D5C3FB76;
        Fri, 21 Jul 2023 15:50:29 +0200 (CEST)
Date:   Fri, 21 Jul 2023 15:50:29 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 3/3] brd: implement write zeroes
Message-ID: <3bcf643-5eef-9537-6def-17de279f1e4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements REQ_OP_WRITE_ZEROES on brd. Write zeroes will free
the pages just like discard, but the difference is that it writes zeroes
to the preceding and following page if the range is not aligned on page
boundary.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   78 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -301,7 +301,8 @@ out:
 void brd_do_discard(struct brd_device *brd, struct bio *bio)
 {
 	struct free_page_batch *batch = NULL;
-	sector_t sector, len, front_pad;
+	bool zero_padding = bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	sector_t sector, len, front_pad, end_pad;
 
 	if (unlikely(!discard)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
@@ -311,11 +312,22 @@ void brd_do_discard(struct brd_device *b
 	sector = bio->bi_iter.bi_sector;
 	len = bio_sectors(bio);
 	front_pad = -sector & (PAGE_SECTORS - 1);
+
+	if (zero_padding && unlikely(front_pad != 0))
+		copy_to_brd(brd, page_address(ZERO_PAGE(0)),
+			    sector, min(len, front_pad) << SECTOR_SHIFT);
+
 	sector += front_pad;
 	if (unlikely(len <= front_pad))
 		return;
 	len -= front_pad;
-	len = round_down(len, PAGE_SECTORS);
+
+	end_pad = len & (PAGE_SECTORS - 1);
+	if (zero_padding && unlikely(end_pad != 0))
+		copy_to_brd(brd, page_address(ZERO_PAGE(0)),
+			    sector + len - end_pad, end_pad << SECTOR_SHIFT);
+	len -= end_pad;
+
 	while (len) {
 		brd_free_page(brd, sector, &batch);
 		sector += PAGE_SECTORS;
@@ -333,34 +345,42 @@ static void brd_submit_bio(struct bio *b
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
-		brd_do_discard(brd, bio);
-		goto endio;
-	}
-
-	sector = bio->bi_iter.bi_sector;
-	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
-		int err;
-
-		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
-
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
-		if (err) {
-			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
-				bio_wouldblock_error(bio);
-				return;
+	switch (bio_op(bio)) {
+		case REQ_OP_DISCARD:
+		case REQ_OP_WRITE_ZEROES:
+			brd_do_discard(brd, bio);
+			break;
+
+		case REQ_OP_READ:
+		case REQ_OP_WRITE:
+			sector = bio->bi_iter.bi_sector;
+			bio_for_each_segment(bvec, bio, iter) {
+				unsigned int len = bvec.bv_len;
+				int err;
+
+				/* Don't support un-aligned buffer */
+				WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
+						(len & (SECTOR_SIZE - 1)));
+
+				err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
+						  bio->bi_opf, sector);
+				if (err) {
+					if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
+						bio_wouldblock_error(bio);
+						return;
+					}
+					bio_io_error(bio);
+					return;
+				}
+				sector += len >> SECTOR_SHIFT;
 			}
-			bio_io_error(bio);
-			return;
-		}
-		sector += len >> SECTOR_SHIFT;
+			break;
+
+		default:
+			bio->bi_status = BLK_STS_NOTSUPP;
+			break;
 	}
 
-endio:
 	bio_endio(bio);
 }
 
@@ -378,9 +398,11 @@ static void brd_set_discard_limits(struc
 	if (discard) {
 		queue->limits.discard_granularity = PAGE_SIZE;
 		blk_queue_max_discard_sectors(queue, round_down(UINT_MAX, PAGE_SECTORS));
+		blk_queue_max_write_zeroes_sectors(queue, round_down(UINT_MAX, PAGE_SECTORS));
 	} else {
 		queue->limits.discard_granularity = 0;
 		blk_queue_max_discard_sectors(queue, 0);
+		blk_queue_max_write_zeroes_sectors(queue, 0);
 	}
 }
 
@@ -420,7 +442,7 @@ MODULE_PARM_DESC(max_part, "Num Minors t
 
 static bool discard = false;
 module_param_cb(discard, &discard_ops, &discard, 0644);
-MODULE_PARM_DESC(discard, "Support discard");
+MODULE_PARM_DESC(discard, "Support discard and write zeroes");
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);

