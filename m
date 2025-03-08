Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6D81720
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451038; cv=none; b=ZK5WYHT7E1yMBExEcDdkUjH7qTyY5tmNd/j2kt0brQ0Z3Em4KBGrZgzNz7PYp5iGHj6EpwYDtSuN0833w8cT9BI9uONV2gvpzJvio/nJoxvKjUz0SsbBjqsGV083mCKpwfnYWQHMndJz432aPFoMCrIXXsMwlpAYcI8b1fdVewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451038; c=relaxed/simple;
	bh=KBgRzZAbBGIQ69PfZ+7dGozNCyjO2VGPL3YMzUSFfpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRbWwK2+58B7xyXl6D3jeJqn4n/hShChlaaU/2IeXc1xkIsRJrYTgg4gxhvLtQfiusA1g2PhMijL72qM7DL5xB6q36V4RRhEUH+a0Xri8jspPzCw6I5RaynKbFm9O+jAaWzGeSxRrLfeIX4MsSArJYLp0YFZdjqLUJzhKhZkvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdQL84gJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdQL84gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741451036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exaflMSl1un4CsRdVEleWfiozXNaKVaxajlaSlzzCVU=;
	b=UdQL84gJGwLShwaNaOHJgaCAh8xtppoazhcTaPMk0q1ZtH6Sf8yU/NsQXs2ZXVRRe/vutp
	OSLlUI1tBIZwNlngEbhN7XrWla0kF73fx/0Za15n/0mYghrtVAPbNMfhQcYgfifyg5shvn
	LyU1NYlAUKuswdHQXf/2kPg+H92XTeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-P982ZrE2Md-kGLQnCqQWHg-1; Sat,
 08 Mar 2025 11:23:52 -0500
X-MC-Unique: P982ZrE2Md-kGLQnCqQWHg-1
X-Mimecast-MFC-AGG-ID: P982ZrE2Md-kGLQnCqQWHg_1741451031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0C9F1801A1A;
	Sat,  8 Mar 2025 16:23:51 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84EA3180174F;
	Sat,  8 Mar 2025 16:23:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH 2/5] loop: cleanup lo_rw_aio()
Date: Sun,  9 Mar 2025 00:23:06 +0800
Message-ID: <20250308162312.1640828-3-ming.lei@redhat.com>
In-Reply-To: <20250308162312.1640828-1-ming.lei@redhat.com>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Cleanup lo_rw_aio() a bit by refactoring it into three parts:

- lo_cmd_nr_bvec(), for calculating how many bvecs in this request

- lo_rw_aio_prep(), for preparing loop command, which need to be called
once

- lo_submit_rw_aio(), for submitting this lo command, which can be
called multiple times

Prepare for trying to handle loop command by NOWAIT read/write IO
first.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 83 +++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6bbbaa4aaf2c..eae38cd38b7b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -394,24 +394,63 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
+static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+			    loff_t pos, int nr_bvec)
 {
-	struct iov_iter iter;
-	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
-	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
-	struct bio_vec tmp;
+	struct iov_iter iter;
+	struct bio_vec *bvec;
 	unsigned int offset;
-	int nr_bvec = 0;
 	int ret;
 
+	if (rq->bio != rq->biotail) {
+		bvec = cmd->bvec;
+		offset = 0;
+	} else {
+		struct bio *bio = rq->bio;
+
+		offset = bio->bi_iter.bi_bvec_done;
+		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+	}
+	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
+	iter.iov_offset = offset;
+	cmd->iocb.ki_pos = pos;
+
+	atomic_set(&cmd->ref, 2);
+	if (dir == ITER_SOURCE)
+		ret = file->f_op->write_iter(&cmd->iocb, &iter);
+	else
+		ret = file->f_op->read_iter(&cmd->iocb, &iter);
+	lo_rw_aio_do_completion(cmd);
+
+	return ret;
+}
+
+static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
+{
+	struct req_iterator rq_iter;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct bio_vec tmp;
+	int nr_bvec = 0;
+
 	rq_for_each_bvec(tmp, rq, rq_iter)
 		nr_bvec++;
 
+	return nr_bvec;
+}
+
+static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
+			  unsigned nr_bvec)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct file *file = lo->lo_backing_file;
+
 	if (rq->bio != rq->biotail) {
+		struct req_iterator rq_iter;
+		struct bio_vec *bvec;
+		struct bio_vec tmp;
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
@@ -429,35 +468,23 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
-		offset = 0;
-	} else {
-		/*
-		 * Same here, this bio may be started from the middle of the
-		 * 'bvec' because of bio splitting, so offset from the bvec
-		 * must be passed to iov iterator
-		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	}
-	atomic_set(&cmd->ref, 2);
-
-	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
-
-	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (dir == ITER_SOURCE)
-		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-	else
-		ret = file->f_op->read_iter(&cmd->iocb, &iter);
+	return 0;
+}
 
-	lo_rw_aio_do_completion(cmd);
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
+{
+	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec);
 
+	if (ret < 0)
+		return ret;
+	ret = lo_submit_rw_aio(lo, cmd, pos, nr_bvec);
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
-- 
2.47.0

