Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BC0C43217
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05F9604AC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhJYJtb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232758AbhJYJrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+df4F7LF+ki/nFAZUVTO37MAPaj/0UJlB9TLsPdgVI=;
        b=IhWTeCaWgNYwcuhIcAwCfWfl6kD4Na69q7JYVegVnSbpO0k7AKVc3Nj8CBXdqSJRLgb8Sx
        2pXHkUsY2moPhPmadq5Wy1pltCoh+ghi5yF1X2ZdkwTCETPSjmkFHTNo6Kx0sL+xVnzXkV
        nyZB6YurM5KB1SCFd7KM8XPc/hgrT4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-1OUGEHq9O769EzE6wFN9RA-1; Mon, 25 Oct 2021 05:45:07 -0400
X-MC-Unique: 1OUGEHq9O769EzE6wFN9RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D21BCC63B;
        Mon, 25 Oct 2021 09:45:00 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7112F5BAE5;
        Mon, 25 Oct 2021 09:44:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] loop: cover simple read/write via lo_rw_aio()
Date:   Mon, 25 Oct 2021 17:44:33 +0800
Message-Id: <20211025094437.2837701-5-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lo_rw_aio() is capable of doing simple buffered read/write, not
necessary to use lo_simple_read()/lo_simple_write() for that.

Add cmd->use_dio for real loop dio, then cmd->use_aio is only used
in case that lo_rw_aio() is used for submitting IO against backing file.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 83 +++++++++-----------------------------------
 drivers/block/loop.h |  1 +
 2 files changed, 18 insertions(+), 66 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 769cf84c6899..d1784f825b6b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -339,23 +339,6 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	return bw;
 }
 
-static int lo_write_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
-{
-	struct bio_vec bvec;
-	struct req_iterator iter;
-	int ret = 0;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
-		if (ret < 0)
-			break;
-		cond_resched();
-	}
-
-	return ret;
-}
-
 /*
  * This is the slow, transforming version that needs to double buffer the
  * data as it cannot do the transformations in place without having direct
@@ -391,33 +374,6 @@ static int lo_write_transfer(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-static int lo_read_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
-{
-	struct bio_vec bvec;
-	struct req_iterator iter;
-	struct iov_iter i;
-	ssize_t len;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
-		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
-		if (len < 0)
-			return len;
-
-		if (len != bvec.bv_len) {
-			struct bio *bio;
-
-			__rq_for_each_bio(bio, rq)
-				zero_fill_bio(bio);
-			break;
-		}
-		cond_resched();
-	}
-
-	return 0;
-}
-
 static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		loff_t pos)
 {
@@ -520,10 +476,10 @@ static void lo_complete_rq(struct request *rq)
 	blk_status_t ret = BLK_STS_OK;
 
 	/* Kernel wrote to our pages, call flush_dcache_page */
-	if (req_op(rq) == REQ_OP_READ && !cmd->use_aio && cmd->ret >= 0)
+	if (req_op(rq) == REQ_OP_READ && !cmd->use_dio && cmd->ret >= 0)
 		lo_flush_dcache_for_read(rq);
 
-	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
+	if (!cmd->use_dio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
 		if (cmd->ret < 0)
 			ret = errno_to_blk_status(cmd->ret);
@@ -625,17 +581,24 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		offset = bio->bi_iter.bi_bvec_done;
 		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	}
-	atomic_set(&cmd->ref, 2);
-
 	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
-	cmd->iocb.ki_complete = lo_rw_aio_complete;
-	cmd->iocb.ki_flags = IOCB_DIRECT;
+
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	if (!cmd->use_dio) {
+		atomic_set(&cmd->ref, 1);
+		cmd->iocb.ki_flags = 0;
+		cmd->ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
+		lo_rw_aio_do_completion(cmd);
+		return 0;
+	}
 
+	atomic_set(&cmd->ref, 2);
+	cmd->iocb.ki_complete = lo_rw_aio_complete;
+	cmd->iocb.ki_flags = IOCB_DIRECT;
 	ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
 
 	lo_rw_aio_do_completion(cmd);
@@ -650,15 +613,6 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
 
-	/*
-	 * lo_write_simple and lo_read_simple should have been covered
-	 * by io submit style function like lo_rw_aio(), one blocker
-	 * is that lo_read_simple() need to call flush_dcache_page after
-	 * the page is written from kernel, and it isn't easy to handle
-	 * this in io submit style function which submits all segments
-	 * of the req at one time. And direct read IO doesn't need to
-	 * run flush_dcache_page().
-	 */
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
@@ -676,17 +630,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
-		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
-			return lo_write_simple(lo, rq, pos);
+			return lo_rw_aio(lo, cmd, pos, WRITE);
 	case REQ_OP_READ:
 		if (lo->transfer)
 			return lo_read_transfer(lo, rq, pos);
-		else if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, READ);
 		else
-			return lo_read_simple(lo, rq, pos);
+			return lo_rw_aio(lo, cmd, pos, READ);
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
@@ -2171,7 +2121,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->use_aio = false;
 		break;
 	default:
-		cmd->use_aio = lo->use_dio;
+		cmd->use_aio = !lo->transfer;
+		cmd->use_dio = lo->use_dio && cmd->use_aio;
 		break;
 	}
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 04c88dd6eabd..b7d611e4f517 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -74,6 +74,7 @@ struct loop_device {
 struct loop_cmd {
 	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
+	bool use_dio;
 	atomic_t ref; /* only for aio */
 	long ret;
 	struct kiocb iocb;
-- 
2.31.1

