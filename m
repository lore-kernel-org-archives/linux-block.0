Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE931383A2
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450558; cv=none; b=dDJtfes6blpM1eyjGpsfWtobb/q+LxHlnhpXaAHVeAsZti/LQMeeQjf6XesL45b+WtFI8/baLdJujfZj4ogKrgD2BH482MVBycJt00LP2PJIjuy69o7+gVe/tHgsmjCNfzo2sbeTr9Dx6iW2/VRnRnGfaCE2ESWFnnrJCkT53eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450558; c=relaxed/simple;
	bh=Yb+POqdLdDFhux8EjKtMBpJkkYf3LItT4iridE1Yyo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhvcI2+/kzvhSrXNCES3d93QuuCc5KvFH00m36kTXe5dCW2u6a5AkOb3jnhItZpo+rjOxgxh4osuDDVHAM/4DgPwWQ5C0R2pvtxyTiNH9Bn6YRkKq1A/dAFoNSlDhiQMYjiLAgRQVX60yY79XrDmgXPS8alpYobUyPT/YADVLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O552+hI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O552+hI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQnzm1yJJEvXwxmfMQ+FJneaXetol1zINJDCTJAaLFk=;
	b=O552+hI4Qg1NsSeuUSFP4wGjlg4fKI2GLmgz/ybHoeV23yPenGq27V2DoGvE4AqlTpl9c7
	Wqf6dk9mtznA1aEAfkG9/lUeu0rzbAvba0GXdr9vZQisa9H4qD00WfDc69LyTULawwVc7/
	h7DAtdLXNOOPmcEXPIIucwefIdDUXzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-vPXAKRnCMCCDg-CLVzvhkw-1; Sat,
 08 Mar 2025 11:15:54 -0500
X-MC-Unique: vPXAKRnCMCCDg-CLVzvhkw-1
X-Mimecast-MFC-AGG-ID: vPXAKRnCMCCDg-CLVzvhkw_1741450553
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42DA71801A12;
	Sat,  8 Mar 2025 16:15:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E946C19560AB;
	Sat,  8 Mar 2025 16:15:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] loop: try to handle loop aio command via NOWAIT IO first
Date: Sun,  9 Mar 2025 00:14:57 +0800
Message-ID: <20250308161504.1639157-8-ming.lei@redhat.com>
In-Reply-To: <20250308161504.1639157-1-ming.lei@redhat.com>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Try to handle loop aio command via NOWAIT IO first, then we can avoid to
queue the aio command into workqueue.

Fallback to workqueue in case of -EAGAIN.

BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or
.write_iter() which might sleep even though it is NOWAIT.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 47 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f8d32d2dc4d..46be0c8e75a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -92,6 +92,8 @@ struct loop_cmd {
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
 
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
@@ -380,8 +382,17 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
+
+	if (cmd->ret == -EAGAIN) {
+		struct loop_device *lo = rq->q->queuedata;
+
+		loop_queue_work(lo, cmd);
+		return;
+	}
+
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
+
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -478,16 +489,34 @@ static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
+{
+	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret;
+
+	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
+	ret = lo_submit_rw_aio(lo, cmd, pos, nr_bvec);
+	if (ret != -EIOCBQUEUED)
+		lo_rw_aio_complete(&cmd->iocb, ret);
+	return 0;
+}
+
+static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
 {
 	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec);
 
 	if (ret < 0)
 		return ret;
+
+	cmd->iocb.ki_flags |= IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, pos, nr_bvec);
-	if (ret != -EIOCBQUEUED)
+	if (ret == -EIOCBQUEUED)
+		return 0;
+	if (ret != -EAGAIN) {
 		lo_rw_aio_complete(&cmd->iocb, ret);
-	return 0;
+		return 0;
+	}
+	return ret;
 }
 
 static int do_req_filebacked(struct loop_device *lo, struct request *rq)
@@ -1926,6 +1955,17 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	if (cmd->use_aio) {
+		loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+		int ret = lo_rw_aio_nowait(lo, cmd, pos);
+
+		if (!ret)
+			return BLK_STS_OK;
+		if (ret != -EAGAIN)
+			return BLK_STS_IOERR;
+		/* fallback to workqueue for handling aio */
+	}
+
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -2076,7 +2116,8 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
+	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT |
+		BLK_MQ_F_BLOCKING;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
-- 
2.47.0

