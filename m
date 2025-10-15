Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6E31B83A
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526482; cv=none; b=ho955WvhYq8vT7o83ZC+yPHpOIumUAgrIeoC4mhvEgZc9Q/B5vXapfXOc02HZQBcDSD9Amf6+uO0od5TLpig5Jla3njlmDwjqeR1PDYzhAQa1YMMRlDi+BF8PBdKf4TUqxD0v6EtM+NJDorZOxXf8ywsYEr2qXfry7sWi1If3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526482; c=relaxed/simple;
	bh=MI8bs3EW7SLfSWgrjgQLTSMMXu5noQoOgWPynoKj2No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVrsrlquWWRwnVfu5OH09c7+UTSk+Y/jCexf47OODT7YlyPO6io+LEqwhKnqNApEFAW/Bd8cA0h5dWhwuj90MIptIaVa4un1NPFX1uT+fHMt/+y4qIad5SLZ6TjWltkfL6QvfTCGYD/pO7P0ohjDG+kT+Em0eon3F7m4Ky9pS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/ohvI0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/ohvI0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsViTIvtMgJRFh5hbwdXFpXf2M7spafQdOmf8ktMpkc=;
	b=F/ohvI0VO835OxaI/LcTZawu4Cy4pzuv1hvNLIAtigJcMWBc+IRt/18/ocsMgd3lVUpEzy
	Lg+qXIZXyt+fMccI16Sb2IEEa5E5HpYD558AcyVWP0JcHeh+lIg6dVUxeAsGkb1umdUkdM
	vDA/pDrPBAZFtvmSL183eOWrwOE2RL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-UD0epBKeOmSbf1XvD7kJMg-1; Wed,
 15 Oct 2025 07:07:56 -0400
X-MC-Unique: UD0epBKeOmSbf1XvD7kJMg-1
X-Mimecast-MFC-AGG-ID: UD0epBKeOmSbf1XvD7kJMg_1760526475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1F721800345;
	Wed, 15 Oct 2025 11:07:54 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B37D91800451;
	Wed, 15 Oct 2025 11:07:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 2/6] loop: add helper lo_rw_aio_prep()
Date: Wed, 15 Oct 2025 19:07:27 +0800
Message-ID: <20251015110735.1361261-3-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add helper lo_rw_aio_prep() to separate the preparation phase(setting up bio
vectors and initializing the iocb structure) from the actual I/O execution
in the loop block driver.

Prepare for using NOWAIT to improve loop performance.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 63 ++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index af443651dff5..b065892106a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -350,21 +350,15 @@ static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
 	return nr_bvec;
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
+			  unsigned nr_bvec, loff_t pos)
 {
-	struct iov_iter iter;
-	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
-	struct file *file = lo->lo_backing_file;
-	struct bio_vec tmp;
-	unsigned int offset;
-	int nr_bvec = lo_cmd_nr_bvec(cmd);
-	int ret;
 
 	if (rq->bio != rq->biotail) {
+		struct req_iterator rq_iter;
+		struct bio_vec *bvec;
+		struct bio_vec tmp;
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
@@ -382,8 +376,42 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
+	} else {
+		cmd->bvec = NULL;
+	}
+
+	cmd->iocb.ki_pos = pos;
+	cmd->iocb.ki_filp = lo->lo_backing_file;
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
+	if (cmd->use_aio) {
+		cmd->iocb.ki_complete = lo_rw_aio_complete;
+		cmd->iocb.ki_flags = IOCB_DIRECT;
+	} else {
+		cmd->iocb.ki_complete = NULL;
+		cmd->iocb.ki_flags = 0;
+	}
+	return 0;
+}
+
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+		     loff_t pos, int rw)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct bio *bio = rq->bio;
+	struct file *file = lo->lo_backing_file;
+	unsigned int offset;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret;
+
+	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+	if (unlikely(ret))
+		return ret;
+
+	if (cmd->bvec) {
 		offset = 0;
+		bvec = cmd->bvec;
 	} else {
 		/*
 		 * Same here, this bio may be started from the middle of the
@@ -398,17 +426,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
-	cmd->iocb.ki_pos = pos;
-	cmd->iocb.ki_filp = file;
-	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
-	if (cmd->use_aio) {
-		cmd->iocb.ki_complete = lo_rw_aio_complete;
-		cmd->iocb.ki_flags = IOCB_DIRECT;
-	} else {
-		cmd->iocb.ki_complete = NULL;
-		cmd->iocb.ki_flags = 0;
-	}
-
 	if (rw == ITER_SOURCE) {
 		kiocb_start_write(&cmd->iocb);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-- 
2.47.0

