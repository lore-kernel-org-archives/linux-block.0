Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51FC48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710FD21670
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GogvsPHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfFZNtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uWkMZCpz9fgebIVf4XB5xaCNZsjX2gMh66q0oGJG2IE=; b=GogvsPHY+8Bxfsgw2kfkRKiqZU
        B+E7EZno/nspXZYfm7LJFaQ8sWAtP7MDQMbhpyMalNlwQe8ms22G3+O+z0ayogdlsyiumCNUkYJR4
        2HvLlhjkzWNg/1sjwsAw2nvRvFcVVdJu2kLhuSVQLJMegQz3/TAD3lMO64RSrxj2HCDvgdaL6Je5p
        5gUq/9M94NjvwZJ9v5JydnHTpNioRdtPcadkWLKEFn/uKS60XCV7+1uiY6oykplgk8tnSq/LLs+FM
        CY2iRGl2OIG36yCEha7eZvY4eHvMP/N3DRieTFl4RTQq1YSn7LWqIw9G8PigEFohvgiQUucttW04t
        Vzm03oQA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8J5-0003El-9C; Wed, 26 Jun 2019 13:49:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 9/9] block: never take page references for ITER_BVEC
Date:   Wed, 26 Jun 2019 15:49:28 +0200
Message-Id: <20190626134928.7988-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we pass pages through an iov_iter we always already have a reference
in the caller.  Thus remove the ITER_BVEC_FLAG_NO_REF and don't take
reference to pages by default for bvec backed iov_iters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bio.c          | 14 +-------------
 drivers/block/loop.c | 16 ++++------------
 fs/io_uring.c        |  3 ---
 include/linux/uio.h  | 10 +---------
 4 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a96d33d2de44..3c9225caff8d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -836,15 +836,6 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
-static void bio_get_pages(struct bio *bio)
-{
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
-
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		get_page(bvec->bv_page);
-}
-
 void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
@@ -960,11 +951,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
 
-	if (iov_iter_bvec_no_ref(iter))
+	if (is_bvec)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
-	else if (is_bvec)
-		bio_get_pages(bio);
-
 	return bio->bi_vcnt ? 0 : ret;
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f11b7dc16e9d..44c9985f352a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -264,20 +264,12 @@ lo_do_transfer(struct loop_device *lo, int cmd,
 	return ret;
 }
 
-static inline void loop_iov_iter_bvec(struct iov_iter *i,
-		unsigned int direction, const struct bio_vec *bvec,
-		unsigned long nr_segs, size_t count)
-{
-	iov_iter_bvec(i, direction, bvec, nr_segs, count);
-	i->type |= ITER_BVEC_FLAG_NO_REF;
-}
-
 static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 {
 	struct iov_iter i;
 	ssize_t bw;
 
-	loop_iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -355,7 +347,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		loop_iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -396,7 +388,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_offset = 0;
 		b.bv_len = bvec.bv_len;
 
-		loop_iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
+		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0) {
 			ret = len;
@@ -563,7 +555,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	loop_iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 86a2bd721900..eb6ab1507913 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -997,9 +997,6 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
 	if (offset)
 		iov_iter_advance(iter, offset);
-
-	/* don't drop a reference to these pages */
-	iter->type |= ITER_BVEC_FLAG_NO_REF;
 	return 0;
 }
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2c90a0842ee8..cea1761c5672 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -19,9 +19,6 @@ struct kvec {
 };
 
 enum iter_type {
-	/* set if ITER_BVEC doesn't hold a bv_page ref */
-	ITER_BVEC_FLAG_NO_REF = 2,
-
 	/* iter types */
 	ITER_IOVEC = 4,
 	ITER_KVEC = 8,
@@ -56,7 +53,7 @@ struct iov_iter {
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE | ITER_BVEC_FLAG_NO_REF);
+	return i->type & ~(READ | WRITE);
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
@@ -89,11 +86,6 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
-static inline bool iov_iter_bvec_no_ref(const struct iov_iter *i)
-{
-	return (i->type & ITER_BVEC_FLAG_NO_REF) != 0;
-}
-
 /*
  * Total number of bytes covered by an iovec.
  *
-- 
2.20.1

