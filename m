Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D225F991
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204187; cv=none; b=taFBA4kYYm5F3+x2LFVhlJDro4HwzZSB+DMNFAr+mPPPOZ0mgt04mYk10D3SgRZRfHJO7y2vcSks0jVzie/AHQMLS8JzEJYigd6Tcem/FSZw78Jqb6yXOZOnAiTDshxWXiWn6jKAkOBLnFVf31FFM2BpDQQqi44hSSMJzL+pR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204187; c=relaxed/simple;
	bh=OWZUUf6RmdhJj0xw63vvxYlk3DIOBGH3jVGYjBMx3/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIYqKu2POjM66F6Q5pWoRqlzcrXrROsdPRTPgCAw3LVnYGzHWduwspDTDYrPc6KigTSc7MTlUcrR+HEruxn7EA9M662CA/0Ypm27Z9yPob3MKjxVq0ffwl3bAIHOInv6etvAd3KmKVGAP28/IpqreiDO4iIhbQBObnSMABz3Ats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tRCiJlmK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRCiJlmK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xEBbC7SwkA5EPzU+0FdhiAqp8AX7jj0UYBAgxF7dfSY=; b=tRCiJlmKWm4AhIz+DUrk4cpFg1
	KLzbFTQMBJYUdvK0Jbe43c0kJAa3R7OSiWFvdmZ8GYnTuvoQTxG5EjYQQHSPwgvwoxc+M72GGpGTs
	Jci0btsoLrFlM+9mKTyWLjgTdBsDYlb6TMLvqgyVZUk9hMVCZLN6WviQKlDC68gW3k9sbXXzc1SvX
	/dWBg9ZF0W1AKOuUq6edUY69vd0JDokW3R3ytY2zCzJ2or1Gw3JM21mh8yy7k99Zi4lSRhSI+a3Wu
	7se1JkRDn8LrwW+vXH8FJRtDPdYFFQmkGoaqxqJJNGIkTVoT0kGYzfcki6bh+CZ1g3nAD6FT97i69
	YMfNt4Ww==;
Received: from [2001:4bb8:2d1:7d59:587c:5e75:3ec0:23ae] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2VBY-00000007Eix-1rzt;
	Wed, 09 Apr 2025 13:09:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: djwong@kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Date: Wed,  9 Apr 2025 15:09:40 +0200
Message-ID: <20250409130940.3685677-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

vfs_iter_{read,write} always perform direct I/O when the file has the
O_DIRECT flag set, which breaks disabling direct I/O using the
LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.

This was recenly reported as a regression, but as far as I can tell
was only uncovered by better checking for block sizes and has been
around since the direct I/O support was added.

Fix this by using the existing aio code that calls the raw read/write
iter methods instead.  Note that despite the comments there is no need
for block drivers to ever call flush_dcache_page themselves, and the
call is a left-over from prehistoric times.

Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 112 +++++++------------------------------------
 1 file changed, 17 insertions(+), 95 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..0e925f1642cc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -211,72 +211,6 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
-{
-	struct iov_iter i;
-	ssize_t bw;
-
-	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
-
-	bw = vfs_iter_write(file, &i, ppos, 0);
-
-	if (likely(bw ==  bvec->bv_len))
-		return 0;
-
-	printk_ratelimited(KERN_ERR
-		"loop: Write error at byte offset %llu, length %i.\n",
-		(unsigned long long)*ppos, bvec->bv_len);
-	if (bw >= 0)
-		bw = -EIO;
-	return bw;
-}
-
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
-static int lo_read_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
-{
-	struct bio_vec bvec;
-	struct req_iterator iter;
-	struct iov_iter i;
-	ssize_t len;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
-		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
-		if (len < 0)
-			return len;
-
-		flush_dcache_page(bvec.bv_page);
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
 static void loop_clear_limits(struct loop_device *lo, int mode)
 {
 	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
@@ -342,7 +276,7 @@ static void lo_complete_rq(struct request *rq)
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
+	if (cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
 		if (cmd->ret < 0)
 			ret = errno_to_blk_status(cmd->ret);
@@ -358,14 +292,13 @@ static void lo_complete_rq(struct request *rq)
 		cmd->ret = 0;
 		blk_mq_requeue_request(rq, true);
 	} else {
-		if (cmd->use_aio) {
-			struct bio *bio = rq->bio;
+		struct bio *bio = rq->bio;
 
-			while (bio) {
-				zero_fill_bio(bio);
-				bio = bio->bi_next;
-			}
+		while (bio) {
+			zero_fill_bio(bio);
+			bio = bio->bi_next;
 		}
+
 		ret = BLK_STS_IOERR;
 end_io:
 		blk_mq_end_request(rq, ret);
@@ -445,9 +378,14 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 
 	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
-	cmd->iocb.ki_complete = lo_rw_aio_complete;
-	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	if (cmd->use_aio) {
+		cmd->iocb.ki_complete = lo_rw_aio_complete;
+		cmd->iocb.ki_flags = IOCB_DIRECT;
+	} else {
+		cmd->iocb.ki_complete = NULL;
+		cmd->iocb.ki_flags = 0;
+	}
 
 	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
@@ -458,7 +396,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
-	return 0;
+	return -EIOCBQUEUED;
 }
 
 static int do_req_filebacked(struct loop_device *lo, struct request *rq)
@@ -466,15 +404,6 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
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
@@ -490,15 +419,9 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
-		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
-		else
-			return lo_write_simple(lo, rq, pos);
+		return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
 	case REQ_OP_READ:
-		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
-		else
-			return lo_read_simple(lo, rq, pos);
+		return lo_rw_aio(lo, cmd, pos, ITER_DEST);
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
@@ -1921,7 +1844,6 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
-	const bool use_aio = cmd->use_aio;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
@@ -1951,7 +1873,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	}
  failed:
 	/* complete non-aio request */
-	if (!use_aio || ret) {
+	if (ret != -EIOCBQUEUED) {
 		if (ret == -EOPNOTSUPP)
 			cmd->ret = ret;
 		else
-- 
2.47.2

