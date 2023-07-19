Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4CC0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 20:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjGSUWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSUWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 16:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BC135
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689798121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sRo3gN/LJXiVMx/g1vtWeFh4Eo71p22bbKf6S4YuYe4=;
        b=Bwr2KUfdM5yedKaLXjISXHGH1ShzzOZKW/jRSktr8v5YqJBmrExssKGnkPWRDqI4p88Z8B
        SugoOxxTMcVQ2o6X6mPcvedFpFex2nrw/8Y6m7wkHmDxTPNFPoxmash3PQ1AskGNJmKHKy
        /dwFfZa96XTIt9JAmjcUqQ+9BoTZOTU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-nmesSBlfMDSn_4MPSD-aXw-1; Wed, 19 Jul 2023 16:21:46 -0400
X-MC-Unique: nmesSBlfMDSn_4MPSD-aXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75766856F66;
        Wed, 19 Jul 2023 20:21:14 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F2B40D2839;
        Wed, 19 Jul 2023 20:21:14 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 6129F3096A42; Wed, 19 Jul 2023 20:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 5FF873F7CF;
        Wed, 19 Jul 2023 22:21:14 +0200 (CEST)
Date:   Wed, 19 Jul 2023 22:21:14 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 3/3] brd: implement write zeroes
Message-ID: <73c46137-c06e-348f-3d37-8c305ad4c4f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements REQ_OP_WRITE_ZEROES on brd. Write zeroes will free
the pages just like discard, but the difference is that it writes zeroes
to the preceding and following page if the range is not aligned on page
boundary.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -272,7 +272,8 @@ out:
 
 void brd_do_discard(struct brd_device *brd, struct bio *bio)
 {
-	sector_t sector, len, front_pad;
+	bool zero_padding = bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	sector_t sector, len, front_pad, end_pad;
 
 	if (unlikely(!discard)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
@@ -282,11 +283,22 @@ void brd_do_discard(struct brd_device *b
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
 		brd_free_page(brd, sector);
 		sector += PAGE_SECTORS;
@@ -302,7 +314,8 @@ static void brd_submit_bio(struct bio *b
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
+	if (bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_WRITE_ZEROES) {
 		brd_do_discard(brd, bio);
 		goto endio;
 	}
@@ -355,7 +368,7 @@ MODULE_PARM_DESC(max_part, "Num Minors t
 
 static bool discard = false;
 module_param(discard, bool, 0444);
-MODULE_PARM_DESC(discard, "Support discard");
+MODULE_PARM_DESC(discard, "Support discard and write zeroes");
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
@@ -425,6 +438,7 @@ static int brd_alloc(int i)
 	if (discard) {
 		disk->queue->limits.discard_granularity = PAGE_SIZE;
 		blk_queue_max_discard_sectors(disk->queue, round_down(UINT_MAX, PAGE_SECTORS));
+		blk_queue_max_write_zeroes_sectors(disk->queue, round_down(UINT_MAX, PAGE_SECTORS));
 	}
 
 	/* Tell the block layer that this is not a rotational device */

