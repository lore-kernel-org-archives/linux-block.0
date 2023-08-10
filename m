Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F3C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjHJKJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHJKJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 06:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0F83
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691662122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9AiNKrVX8hfRXAiH8rdKAY0xfsUsj0VMC9UfNMLLnw=;
        b=N/MlXP1ChCSbCRkJbnjLNh5BRU56uCqBNFXAXabWZLYWzqQQn66Ex63PBx9CjSbdl3LQv9
        sI0kURSwSmb7TW7itdIU9sjq4W3HJc4NKNRxf8OBxwYXwru2co2xFKg3TH/hGa9s/oKEUq
        cdp1AoyrgRHnb5EsfoekvU6zBOcxrv8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-0QMvhMtAPzartjXIrlA_MQ-1; Thu, 10 Aug 2023 06:08:41 -0400
X-MC-Unique: 0QMvhMtAPzartjXIrlA_MQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7723C0D848;
        Thu, 10 Aug 2023 10:08:40 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B020940C6F4E;
        Thu, 10 Aug 2023 10:08:40 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id C53AC30B9C07; Thu, 10 Aug 2023 10:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id BABF33F7CF;
        Thu, 10 Aug 2023 12:08:39 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:08:39 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 1/4] brd: use a switch statement in brd_submit_bio
In-Reply-To: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
Message-ID: <ee59ce87-9e5-c725-8040-80c5e0fd48f@redhat.com>
References: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a switch statement in brd_submit_bio, so that the code will look
better when we add support for more bio operations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -243,29 +243,38 @@ out:
 static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
-		int err;
+	switch (bio_op(bio)) {
+		case REQ_OP_READ:
+		case REQ_OP_WRITE:
+			sector = bio->bi_iter.bi_sector;
+			bio_for_each_segment(bvec, bio, iter) {
+				unsigned int len = bvec.bv_len;
+				int err;
 
-		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+				/* Don't support un-aligned buffer */
+				WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
+						(len & (SECTOR_SIZE - 1)));
 
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
-		if (err) {
-			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
-				bio_wouldblock_error(bio);
-				return;
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
+		default:
+			bio->bi_status = BLK_STS_NOTSUPP;
+			break;
 	}
 
 	bio_endio(bio);

