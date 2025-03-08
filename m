Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8351DEFEB
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451031; cv=none; b=jNXGM4QsGWdwH9WgKcr0QshS86cdZIGt/pApid4DMA9vHfg2eOi2f113wSmr6JOPUZvOJ+T1u1j6/OIr90WBUBs31zn/u9jqhiP50ZXqyl+40l8PVhPjwZgOrvq8cLL2056YXOuwNR3Xst2us3UU1aufvSmnuGRFxAwU0GEQmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451031; c=relaxed/simple;
	bh=uCNXI+GJ0vao/4PujxQcbbNp8M2U6z90czkJ9T5PyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyqqyEMtOBS+F4Xo/aPNYM6BXX2D5fzp2eJGlZV66ZSBcH7jcwioBsQckTd9IeRSBcgFJiuSLX6bmibhFOnuZVdHCRSg45eVf2ju9CSTHt174otTFs6JEdm/loTfwsHUnBfaFLoAtqdbnv36aYQho8fg203VqZDWforlDfHKN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9Aw1bv5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9Aw1bv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741451029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUfmfH8sGxGCZFYEG3nJrljYQw9Ko3dmbRiQod3+HBk=;
	b=O9Aw1bv5XEYeh32Kj+l5xoqZMzpzpTOftKMbe8mqj6IrfoEx6FVzjKcTs+0yt8AYfp92Np
	3bFPWrdlJLerUpVItPCI8dyysoc80HGa8X2OKHz/F/ZBki+YFWWCN3imwN4NdxafBPo6UQ
	Ng7VDeHQ4rxzT4lMv6n7jAHlURTyOCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-95hZ2LccPh6qyoa_3MkbiA-1; Sat,
 08 Mar 2025 11:23:48 -0500
X-MC-Unique: 95hZ2LccPh6qyoa_3MkbiA-1
X-Mimecast-MFC-AGG-ID: 95hZ2LccPh6qyoa_3MkbiA_1741451027
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53ADA1956083;
	Sat,  8 Mar 2025 16:23:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D37D219560AB;
	Sat,  8 Mar 2025 16:23:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH 1/5] loop: remove 'rw' parameter from lo_rw_aio()
Date: Sun,  9 Mar 2025 00:23:05 +0800
Message-ID: <20250308162312.1640828-2-ming.lei@redhat.com>
In-Reply-To: <20250308162312.1640828-1-ming.lei@redhat.com>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

lo_rw_aio() is only called for READ/WRITE operation, which can be
figured out from request directly, so remove 'rw' parameter from
lo_rw_aio(), meantime rename the local variable as 'dir' which matches
the actual use more.

Meantime merge lo_read_simple() and lo_write_simple() into
lo_rw_simple().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 48 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 657bf53decf3..6bbbaa4aaf2c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -239,31 +239,25 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
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
-static int lo_read_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+static int lo_rw_simple(struct loop_device *lo, struct request *rq, loff_t pos)
 {
 	struct bio_vec bvec;
 	struct req_iterator iter;
 	struct iov_iter i;
 	ssize_t len;
 
+	if (req_op(rq) == REQ_OP_WRITE) {
+		int ret;
+
+		rq_for_each_segment(bvec, rq, iter) {
+			ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
+			if (ret < 0)
+				break;
+			cond_resched();
+		}
+		return ret;
+	}
+
 	rq_for_each_segment(bvec, rq, iter) {
 		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
@@ -400,13 +394,13 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
 	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
 	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
@@ -448,7 +442,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
@@ -457,7 +451,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == ITER_SOURCE)
+	if (dir == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
@@ -498,15 +492,11 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
-		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
-		else
-			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
+			return lo_rw_aio(lo, cmd, pos);
 		else
-			return lo_read_simple(lo, rq, pos);
+			return lo_rw_simple(lo, rq, pos);
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-- 
2.47.0

