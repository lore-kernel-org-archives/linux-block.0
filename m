Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339591E5B9A
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429076; cv=none; b=CSpwQmmMCyTTdtgRfiKSN/sLB09cJn5/3gW7+y2qLN+7P412UxuZvFoJF2cSObdCIfoUJtyh9S3jLaGxLCS8NV9efnPxy1t51mU1ZBlsTtGAhEGe5jWWD4OqcZtTtB5XwVhtAGt4zUnIoQDQEVUBR2Mt56e4lpqRBIojFy//B38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429076; c=relaxed/simple;
	bh=mgBk4o+ygZvuAGiDDSVdv/kVzuVciMw8jm1m1S2iepE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaP1/r5dgD10tY7IcOaQddBJFMKlaijlILsz0/C+s9YA4nJRuP32yFl0Bs9PSalkNwB1Vth3lHbUbuhiCR9VUrQgYpGcIWYhg9VsVO/PsduIo6REP7IKLTmTxBmATkhKJAnAulOhj/P6dxGIqGZI9EekL6KzKKtjDMujV59iWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkVLp/yx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkVLp/yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ybVNcRRX8EvCJRtaDDSPPgbu4b5Me+/UulaC555YDw=;
	b=LkVLp/yx1HlClYmx8io+hyRImVHaphhGBNGLeXbdVrNtwgEw/lAsnnvfha7mwrn8yzkaUz
	YqgbuPEvTwdlJuaZxg2DWW2xfnppfn784MpbrR6DeSf4WgEYDfHPkPNotb6u8QL8n6D+ve
	AtzMrDotFfUwlZu8hDPrPV+1H9KFhl4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Nsn61YiAPC-6cOZcHUD9Pw-1; Wed,
 02 Jul 2025 00:04:31 -0400
X-MC-Unique: Nsn61YiAPC-6cOZcHUD9Pw-1
X-Mimecast-MFC-AGG-ID: Nsn61YiAPC-6cOZcHUD9Pw_1751429070
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF24018DA5D1;
	Wed,  2 Jul 2025 04:04:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C464B18003FC;
	Wed,  2 Jul 2025 04:04:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/16] ublk: remove ublk_commit_and_fetch()
Date: Wed,  2 Jul 2025 12:03:32 +0800
Message-ID: <20250702040344.1544077-9-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove ublk_commit_and_fetch() and open code request completion.

Now request reference is stored in 'ublk_io', which becomes one global
variable, the motivation is to centralize access 'struct ublk_io' reference,
then we can introduce lock to protect `ublk_io` in future for supporting
io batch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7fd2fa493d6a..13c6b1e0e1ef 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -711,13 +711,12 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 		__ublk_complete_rq(req);
 }
 
-static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *req)
+static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *req)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
 
 	io->task_registered_buffers = 0;
-	if (refcount_sub_and_test(sub_refs, &io->ref))
-		__ublk_complete_rq(req);
+	return refcount_sub_and_test(sub_refs, &io->ref);
 }
 
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
@@ -2224,21 +2223,13 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
 	return 0;
 }
 
-static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
-				  struct ublk_io *io, struct io_uring_cmd *cmd,
-				  struct request *req, unsigned int issue_flags,
-				  __u64 zone_append_lba, u16 buf_idx)
+static bool ublk_need_complete_req(const struct ublk_queue *ubq,
+				   struct ublk_io *io,
+				   struct request *req)
 {
-	if (buf_idx != UBLK_INVALID_BUF_IDX)
-		io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = zone_append_lba;
-
 	if (ublk_need_req_ref(ubq))
-		ublk_sub_req_ref(io, req);
-	else
-		__ublk_complete_rq(req);
+		return ublk_sub_req_ref(io, req);
+	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2271,6 +2262,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	unsigned tag = ub_cmd->tag;
 	struct request *req;
 	int ret;
+	bool compl;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2347,8 +2339,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		req = ublk_fill_io_cmd(io, cmd, ub_cmd->result);
 		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
-		ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
-				      ub_cmd->zone_append_lba, buf_idx);
+		compl = ublk_need_complete_req(ubq, io, req);
+
+		/* can't touch 'ublk_io' any more */
+		if (buf_idx != UBLK_INVALID_BUF_IDX)
+			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
+		if (req_op(req) == REQ_OP_ZONE_APPEND)
+			req->__sector = ub_cmd->zone_append_lba;
+		if (compl)
+			__ublk_complete_rq(req);
+
 		if (ret)
 			goto out;
 		break;
-- 
2.47.0

