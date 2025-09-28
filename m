Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066322129B
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066197; cv=none; b=affCiDMlSOAevspou4HttkLpr2Xi+yThK4KmIAMoSWyaoEXTDVCwLnzAk5+Hb/Mid2WWCW86AGIY0tVl+DtrqYgSbn/q09jMa+liS1qRnGTBywAUpYPDiBjaFRb/s/L6O8Ip5gnR3okY1/9MezauWwJR4DYjzU0v8U6s7JcnL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066197; c=relaxed/simple;
	bh=zQPYxgk/kBP7JZNT/wjJfTNLJcGSxOykEe1zoG6bVMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCIa0kSTyZkOzAk+At12/4uUaVpeR6bjXii2zQtXdp+0wTUUMrt7eBbWgx9qWZCfNe0PZfjg6g8WO9Qa0iGjXtTxvl9hWuz8JqVj4kgaU5fPduVi1iI0t0Dxy2p3e/LWw15QoIYTJlbsjZL7xEoEGmd8ePqseE40x2+i6I0+TNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWCV/mjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWCV/mjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QskTw+TC7YBNDdaCgP79WuTSF6e2r45ImIYsKfbNgS8=;
	b=NWCV/mjPQOoWIERjwM84hXpAddfhB77JYnnXfw8/5rHYMtviUECchTWUq8HXhpIWP2i/kQ
	zaK3owjdbRtoSiXczDSRV9z+wVYjjhY3aa+NVGeisNtVIEZu6MwcpB+kcpNpFJHnau7gD+
	SR1h3e5juKSwbLDtO1/FVbvYLhkRCyA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-g-RqwkcuNdmtZLj_Ac080g-1; Sun,
 28 Sep 2025 09:29:51 -0400
X-MC-Unique: g-RqwkcuNdmtZLj_Ac080g-1
X-Mimecast-MFC-AGG-ID: g-RqwkcuNdmtZLj_Ac080g_1759066190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 247F31800452;
	Sun, 28 Sep 2025 13:29:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B3981956095;
	Sun, 28 Sep 2025 13:29:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/6] loop: add lo_submit_rw_aio()
Date: Sun, 28 Sep 2025 21:29:22 +0800
Message-ID: <20250928132927.3672537-4-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add lo_submit_rw_aio() and refactor lo_rw_aio().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b065892106a6..3ab910572bd9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -393,38 +393,32 @@ static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
 	return 0;
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+			    int nr_bvec, int rw)
 {
-	struct iov_iter iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
-	unsigned int offset;
-	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	struct iov_iter iter;
 	int ret;
 
-	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
-	if (unlikely(ret))
-		return ret;
-
 	if (cmd->bvec) {
-		offset = 0;
-		bvec = cmd->bvec;
+		iov_iter_bvec(&iter, rw, cmd->bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = 0;
 	} else {
+		struct bio *bio = rq->bio;
+		struct bio_vec *bvec = __bvec_iter_bvec(bio->bi_io_vec,
+				bio->bi_iter);
+
 		/*
 		 * Same here, this bio may be started from the middle of the
 		 * 'bvec' because of bio splitting, so offset from the bvec
 		 * must be passed to iov iterator
 		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = bio->bi_iter.bi_bvec_done;
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
 
 	if (rw == ITER_SOURCE) {
 		kiocb_start_write(&cmd->iocb);
@@ -433,7 +427,20 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
+	return ret;
+}
+
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+		     loff_t pos, int rw)
+{
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret;
+
+	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+	if (unlikely(ret))
+		return ret;
 
+	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return -EIOCBQUEUED;
-- 
2.47.0

