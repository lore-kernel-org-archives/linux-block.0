Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA04C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiF2Xd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiF2XdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:19 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B955FB2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:08 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id l6so15466400plg.11
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnTD4IEfeOUWAo4hNSQIGoF7Hp+KXwVppG9SUedb4Dg=;
        b=bjviI+TSIclEJ3shI5787RDVusIXhEgY1CTimjsprHQXwm4g+dItk7MOafElUohsoa
         KieZXUkPzDT3Cri1z1wsdpcNgEOTms+iquZkXeiyhqMWliPCxfu3PzfSXPIZJt5t90os
         FxPg3c/ugUQiMPrpkpfUvOsdXW+e2/TYsjk24ATks4IiqmyhWu6YHEUSU4cyLlASq5fN
         BxkavnZFpxTjGWzPaxwUX93DkO/zjFjR9T1RqvK+enyKZfBY/iYMhuvhh6uIgRR8Ykrw
         TAA45ezL6NT2wLlDASYfI07l1T2CgU4FeZyJ3Yyx6ryB7akgEXonK9UiSjY2Bym7BImx
         KpZQ==
X-Gm-Message-State: AJIora/vJEI5knvjAEzvuZji0Z0MymIMNMMq8wBdcJ5lQ6UeR904+WgX
        qL1pIBuAIrbzgqdmISSGWx3tkGjHT2S7Ug==
X-Google-Smtp-Source: AGRyM1tY4pEUlhIv+ESFyOSDQvGwzljV4KX+ZxAaw+F6alZMfA3oCllOCya7zYwb7p093SvYxc15aA==
X-Received: by 2002:a17:902:da87:b0:16a:54e1:3426 with SMTP id j7-20020a170902da8700b0016a54e13426mr11305897plx.157.1656545586964;
        Wed, 29 Jun 2022 16:33:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 48/63] fs/direct-io: Reduce the size of struct dio
Date:   Wed, 29 Jun 2022 16:31:30 -0700
Message-Id: <20220629233145.2779494-49-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reduce the size of struct dio by combining the 'op' and 'op_flags' into
the new 'opf' member. Use the new blk_opf_t type to improve static type
checking. This patch does not change any functionality.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/direct-io.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 840752006f60..b72706d163f5 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -117,8 +117,7 @@ struct dio_submit {
 /* dio_state communicated between submission path and end_io */
 struct dio {
 	int flags;			/* doesn't change */
-	int op;
-	int op_flags;
+	blk_opf_t opf;			/* request operation type and flags */
 	struct gendisk *bio_disk;
 	struct inode *inode;
 	loff_t i_size;			/* i_size when submitted */
@@ -154,6 +153,11 @@ struct dio {
 
 static struct kmem_cache *dio_cache __read_mostly;
 
+static inline bool op_is_read(blk_opf_t opf)
+{
+	return !op_is_write(opf);
+}
+
 /*
  * How many pages are in the queue?
  */
@@ -172,7 +176,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
 				&sdio->from);
 
-	if (ret < 0 && sdio->blocks_available && (dio->op == REQ_OP_WRITE)) {
+	if (ret < 0 && sdio->blocks_available && op_is_write(dio->opf)) {
 		struct page *page = ZERO_PAGE(0);
 		/*
 		 * A memory fault, but the filesystem has some outstanding
@@ -251,7 +255,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 		transferred = dio->result;
 
 		/* Check for short read case */
-		if ((dio->op == REQ_OP_READ) &&
+		if (op_is_read(dio->opf) &&
 		    ((offset + transferred) > dio->i_size))
 			transferred = dio->i_size - offset;
 		/* ignore EFAULT if some IO has been done */
@@ -286,7 +290,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 	 * zeros from unwritten extents.
 	 */
 	if (flags & DIO_COMPLETE_INVALIDATE &&
-	    ret > 0 && dio->op == REQ_OP_WRITE &&
+	    ret > 0 && op_is_write(dio->opf) &&
 	    dio->inode->i_mapping->nrpages) {
 		err = invalidate_inode_pages2_range(dio->inode->i_mapping,
 					offset >> PAGE_SHIFT,
@@ -305,7 +309,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 		 */
 		dio->iocb->ki_pos += transferred;
 
-		if (ret > 0 && dio->op == REQ_OP_WRITE)
+		if (ret > 0 && op_is_write(dio->opf))
 			ret = generic_write_sync(dio->iocb, ret);
 		dio->iocb->ki_complete(dio->iocb, ret);
 	}
@@ -353,7 +357,7 @@ static void dio_bio_end_aio(struct bio *bio)
 		 */
 		if (dio->result)
 			defer_completion = dio->defer_completion ||
-					   (dio->op == REQ_OP_WRITE &&
+					   (op_is_write(dio->opf) &&
 					    dio->inode->i_mapping->nrpages);
 		if (defer_completion) {
 			INIT_WORK(&dio->complete_work, dio_aio_complete_work);
@@ -396,7 +400,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
 	 * we request a valid number of vectors.
 	 */
-	bio = bio_alloc(bdev, nr_vecs, dio->op | dio->op_flags, GFP_KERNEL);
+	bio = bio_alloc(bdev, nr_vecs, dio->opf, GFP_KERNEL);
 	bio->bi_iter.bi_sector = first_sector;
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
@@ -426,7 +430,7 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	dio->refcount++;
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 
-	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty)
+	if (dio->is_async && op_is_read(dio->opf) && dio->should_dirty)
 		bio_set_pages_dirty(bio);
 
 	dio->bio_disk = bio->bi_bdev->bd_disk;
@@ -492,7 +496,7 @@ static struct bio *dio_await_one(struct dio *dio)
 static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 {
 	blk_status_t err = bio->bi_status;
-	bool should_dirty = dio->op == REQ_OP_READ && dio->should_dirty;
+	bool should_dirty = op_is_read(dio->opf) && dio->should_dirty;
 
 	if (err) {
 		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
@@ -653,7 +657,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 		 * which may decide to handle it or also return an unmapped
 		 * buffer head.
 		 */
-		create = dio->op == REQ_OP_WRITE;
+		create = op_is_write(dio->opf);
 		if (dio->flags & DIO_SKIP_HOLES) {
 			i_size = i_size_read(dio->inode);
 			if (i_size && fs_startblk <= (i_size - 1) >> i_blkbits)
@@ -804,7 +808,7 @@ submit_page_section(struct dio *dio, struct dio_submit *sdio, struct page *page,
 	int ret = 0;
 	int boundary = sdio->boundary;	/* dio_send_cur_page may clear it */
 
-	if (dio->op == REQ_OP_WRITE) {
+	if (op_is_write(dio->opf)) {
 		/*
 		 * Read accounting is performed in submit_bio()
 		 */
@@ -992,7 +996,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 				loff_t i_size_aligned;
 
 				/* AKPM: eargh, -ENOTBLK is a hack */
-				if (dio->op == REQ_OP_WRITE) {
+				if (op_is_write(dio->opf)) {
 					put_page(page);
 					return -ENOTBLK;
 				}
@@ -1196,12 +1200,11 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	dio->inode = inode;
 	if (iov_iter_rw(iter) == WRITE) {
-		dio->op = REQ_OP_WRITE;
-		dio->op_flags = REQ_SYNC | REQ_IDLE;
+		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (iocb->ki_flags & IOCB_NOWAIT)
-			dio->op_flags |= REQ_NOWAIT;
+			dio->opf |= REQ_NOWAIT;
 	} else {
-		dio->op = REQ_OP_READ;
+		dio->opf = REQ_OP_READ;
 	}
 
 	/*
