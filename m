Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8948EC9C
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992958; cv=none; b=NebEgr+ziOc381G2tvz39174K6/wnr90G5oAdC/RqkKbPfixYm+pbGWGT5Rxk5445j+a8XQUdD6A+SvpZQCel3rbJkn+obu0Yju8Xi8YF7/YKSqANiw4I9IgpHhF6GxLEXGtMzEWgmwvzmuVITjGsDMW1/tMPLzSJR2/VOIlNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992958; c=relaxed/simple;
	bh=OdVOZ5O8bsyIlL1MZXztJGFmGTxDsLLSFGFWiYbuuh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+oOpgBZa4AbEkSiUonuxneoQnzdZj23W/UJu3sGtmoz4/O5mZuZqtyj9GrfAMFWLR/S/5pm7a+tTxYauAAoHq5ZgotLJWcCbJfhlLFldbN6nt3pDC1psORpa0kEjPaFJUSnLd+V3+gPVgzzJP2q1S0wPsgOo4uw/47a/tU5kS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=US7gi+ib; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="US7gi+ib"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2db3728f0c4so396595ad.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tubVMf7ZqCGq+soHl3bfDL6vCCu/4h0yxEEMGvUD99M=;
        b=US7gi+ib679tUwmyt5JgXnZ8F5gwTnEUKsksikAtRJxhWl5jgigBZ269pc+7Ut8i0g
         pKmb8pp7tyIG7P8ci/9dtwX1T0O6m5MSp2Ujg3MVuvwdlIIhagbU0c/eLkt2flXk8Z26
         iad9EmMoJ4ijNW+3r3BEKQn6pqv/9GnfS1V5xBr/hI+UMIfUcc4It9nENG5iSz7S8iHn
         rEzAhtOxzAUPSsopeYNytUTxvQNiByCLNePEknkjRJAtmmdR344Ei7R58gxIWlStwUEB
         CEeSezQivzHAenRG2D/jTcJWuhawqs5MAl/PFFn/Ng6SJn9/ikBYTaA22eoRu3JJATre
         jnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tubVMf7ZqCGq+soHl3bfDL6vCCu/4h0yxEEMGvUD99M=;
        b=YC4K7itfUWn7PeTk4Z9PVZZizMLnTKZzA7NZIv7HwX8O16Cb9YFska1qaC9uZWy/kv
         B/VBPT0PW2Abm2XlKtc0oxMdd/0FbV+vtqreOHjSqljmGdE3b7vdKmZ80BVqStKf75pI
         ZwXq5y3ML2izzXI8VttdEfO77PJX5ROjWYJNMEiS+oxCj63g+7ldejxT9jlpQenG78xF
         NF8iVzYWs1aslun4++lTIpcVpUr4ZUhNNWsm181dDPshbul3ug9GM4Bm0h0rOHCvoMRv
         EQ6lpvKQs3EqgfTUdfMUMbXtcB96jmxnd9fv4E6Are4fjiGlXuWJdzsOlYj+kuViG/NK
         ogHg==
X-Forwarded-Encrypted: i=1; AKwUvBwzCevFkN+W8P1jHzGViM5ieGOuvP1+cm4DxQqXwSLPo6rA1F6llFroehTdwwElW8mSCoCGU9AimzMAnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kqr+IwqETDzZ3E/EFM2W406JfPBD6l1nBQ0HTK4f3Ae9S3eTq5
	wp98JqAAY/jlA8F5Il1EbHdVjP6B8nQN+dxNOE87NzDLA4Blf7MoGM/mzqt3yC4ZsDknHDpqFQg
	d63lHHM/G6nR5Kfe7+WR4uF8M+pb4jgZ+OHL+sJtKC88y9qdZmogn
X-Gm-Gg: AYBFou2qi0BkPWkf0FilGRX51dFqGt/BWwCVjOM+RE20f5DwadE/CErxZ9/lGjbs3np
	Xi5E5yqlNt3N5dTkQmfCtB0F6yspqY2Lqym80l1Wfgzqvn02K+sztKmEk9Eg08Dx09u+e/X9ecH
	hSUwipKZ5tc7ppN/FIeSPnRuLBSOwd4zUk9ML5hiWz+7bMtTRz+HWGpV0gcK4oj3bLVzrl0UHbN
	cGQoPkuMc8nOllcsQjS4TlWY5NkI58/bozLx5C5juLp4hmoe4AvE87uSCFWbGXrpif0DimDVS1j
	sN61L/ckrobcr90QHDwLiAAEC+PfQt5h20c5oL1Y4Ja1qVc/i05H/ec+JRI9u2QZosWAiVVeXmj
	GlhMJdYk+TMRzLzK7cg==
X-Received: by 2002:a17:90b:3a48:b0:38e:480b:99a5 with SMTP id 98e67ed59e1d1-39b3d5e53d5mr26180113a91.2.1788992943993;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39cd207d69csm504304a91.3.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 2CF4E402B4;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2A37BE40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/6] nvme/ioctl: remove struct nvme_uring_data
Date: Wed,  9 Sep 2026 16:28:32 -0600
Message-ID: <20260909222836.2475352-3-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This struct is only used once as a local variable type. Make the fields
separate local variables and remove the struct type to shave some lines.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3aa5d2f2dfbb..748a4cbf7e90 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -406,18 +406,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 
 	return status;
 }
 
-struct nvme_uring_data {
-	__u64	metadata;
-	__u64	addr;
-	__u32	data_len;
-	__u32	metadata_len;
-	__u32	timeout_ms;
-};
-
 /*
  * This overlays struct io_uring_cmd pdu.
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
@@ -483,17 +475,19 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
 							       struct nvme_uring_cmd);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	bool open_for_write = ioucmd->file->f_mode & FMODE_WRITE;
-	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct iov_iter iter;
 	struct iov_iter *map_iter = NULL;
 	struct request *req;
 	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
+	u32 metadata_len, data_len;
+	u64 metadata, addr;
+	u32 timeout_ms;
 	int ret;
 
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -516,25 +510,25 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
 	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, open_for_write))
 		return -EACCES;
 
-	d.metadata = READ_ONCE(cmd->metadata);
-	d.addr = READ_ONCE(cmd->addr);
-	d.data_len = READ_ONCE(cmd->data_len);
-	d.metadata_len = READ_ONCE(cmd->metadata_len);
-	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
+	metadata = READ_ONCE(cmd->metadata);
+	addr = READ_ONCE(cmd->addr);
+	data_len = READ_ONCE(cmd->data_len);
+	metadata_len = READ_ONCE(cmd->metadata_len);
+	timeout_ms = READ_ONCE(cmd->timeout_ms);
 
-	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
+	if (data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		int ddir = nvme_is_write(&c) ? WRITE : READ;
 
 		if (vec)
 			ret = io_uring_cmd_import_fixed_vec(ioucmd,
-					u64_to_user_ptr(d.addr), d.data_len,
+					u64_to_user_ptr(addr), data_len,
 					ddir, &iter, issue_flags);
 		else
-			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+			ret = io_uring_cmd_import_fixed(addr, data_len,
 					ddir, &iter, ioucmd, issue_flags);
 		if (ret < 0)
 			return ret;
 
 		map_iter = &iter;
@@ -548,15 +542,15 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags |= REQ_POLLED;
 
 	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
+	req->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
 
-	if (d.data_len) {
-		ret = nvme_map_user_request(req, d.addr, d.data_len,
-			nvme_to_user_ptr(d.metadata), d.metadata_len,
+	if (data_len) {
+		ret = nvme_map_user_request(req, addr, data_len,
+			nvme_to_user_ptr(metadata), metadata_len,
 			map_iter, vec ? NVME_IOCTL_VEC : 0);
 		if (ret)
 			goto out_free_req;
 	}
 
-- 
2.55.0

