Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7D27586C
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667178; cv=none; b=qnnuSCLefvK8+E/euGEl/VswYGtxcfs6GLsXZc53GYCa1vEvVhJrdoLz4vjqkxfP3YbvX147YnUfJ7wAEex1g139MEkN9fKh7ZYYyJP3RQReijo3nrI7NipLC1ASSvt0kvU4F15uhaLUjrbH/nr1iCmVrkPlVpDNA++tpK3pNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667178; c=relaxed/simple;
	bh=IS69J4Woj5ZXyujoYxIpwp8colPZsPGMNh3TgiyJVrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0K6Lnf+0jI4Lw1Rz5TsTz9rpOLeGGyGS0gCzY4SXsUYlYO+wAWzYeloTfrZoDFAe666KNO4648CPaYAk5v0nOR9WpvgMTLbO6uQA0mBgLOXhL7w0Tr4aSUVcjapyDXYwRzbCDaxLmuN8gcVf7l7n//NQuw2QVPBmQia5lbbfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D4eeTnGe; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D4eeTnGe"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b42309a87easo415389a12.1
        for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754667174; x=1755271974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFS1VU+xxXDhWSIHSP0knjeqg1G+JdeALd8o0pFSlGQ=;
        b=D4eeTnGeuVGyWv/tDLbNwRdHKhsE9pOnyeBlwCMweIuaDlMmqIxJnIjVZSrRXqdZpM
         6JJhhNvXqo4/IcO9Ixwfu0wIMPa5h9R3g6tQg5Mr6dZZY1nFMhfmX5zX2K+zr9icDsAX
         PZ9ywkyA4+Q2yOxL3ektf8EUBghK2Fal/fFqLyuAuftxw6fYF+s7FZeElWlGcWRlR05x
         eTdqRVay4beUdz4BhQv8oKHI2oSIcPsZp878Djns4iAy2UW3lmbAdm62keEa3+ru2oqU
         qgFd+dZ7Yc+gzN8mYEMNtJllKGOH+ZYJsDz98rvDRPTN+6kwq1NY06JOHDwuI6hfrfYE
         hHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667174; x=1755271974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFS1VU+xxXDhWSIHSP0knjeqg1G+JdeALd8o0pFSlGQ=;
        b=nSF2sWKvOQFZZLuQnj+DRTIbd5OQPF6RcoVrONadQezjO9cb9FiLxsvs5vQvZ10qN2
         d7SyinIbjQkCEalQ2TlQaIuBBH8kdkIe3YPrq14a3jMGIXFBxy4nW0Tx9GSl5/x3j37i
         OnMrDvhkbwxqFEwHYdwe0E4HEeXjnZKE5UK7Q/9M98yyJGpyneHVGUfPe9XDpxzIpFaq
         CjvRpQOgE3MEf2m7nhulYCYHT+rcNRyTo2/4nLUyflHXj8BwZPXyGyw9DxJGPqkX6Out
         f2vssEX1eBPMmnkDZnbJFjtc4WTvkvAZZFemXUL7fArfIEW/779bExHkNxgq26cUyeqf
         1u0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXttKbXM0p3vniRqH48Lw4vtCuG+GHoNrbZGo07nW2C+MVxK+jMKjG/n4wBRJ2Pu76dpLv9UvwmAneJ3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFpotN7//PjfWkOaYXs/BfjSEybluGg7pEmq3a9hkVF/pAyAu
	+ccbIc4VJ1ZAwSXD2IX5YDWxoZZw6Y4vj8NVYXcXiVDoc/M5P3/nNVsgHOXRgiEwkaj651L7NQD
	JlVhyJWZEPKNYIcz8/Mt0XHh5fzSGUTZyQ0U/
X-Gm-Gg: ASbGncvDJnq8RlhynAefkzj6C/0FQ30zjxp//66TU+srU5WdLLlT9nfw2aFTkShoDtz
	2mSd7QEigdc/d7/jdR9u2awVBSOkQ1yv1+g4RTnadfKAb/LOXDSQJLqLP1r3ushvaicd30QsOzg
	C8i2CAgj/1f1jUWXT+dOPI3esUj32Iu2lYdw/cdnBzwGQVqFX0QhHojH3AnRKDQEvhozex+u1S4
	0eZAzRkyHZvNN/+e+FVJYvKWlKRLXVEFFca3B+xadZVdYuif0Cm5AVvX/fTjBB/bSX+R6OmiKdV
	O9ZXqTnTa2VgJD2S3l4IAY1PQb+NYZfhiv8Redyi7YnsrD2Z0kjgQeeJ6/F8K1745sg80CUA
X-Google-Smtp-Source: AGHT+IGhpx9s6fR+tWCvJtaZZGyYEAZtta7MRb7sT1KDG6vK3LINOyHBWuwfPTtfw5T6THxbCkmowgGGQbBr
X-Received: by 2002:a17:902:dac3:b0:234:bfcb:5c0a with SMTP id d9443c01a7336-242c21f3c6bmr22494105ad.5.1754667174317;
        Fri, 08 Aug 2025 08:32:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241d1f0f6casm14426025ad.31.2025.08.08.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:32:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C541F34026B;
	Fri,  8 Aug 2025 09:32:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BE431E43D31; Fri,  8 Aug 2025 09:32:53 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: inline __ublk_ch_uring_cmd()
Date: Fri,  8 Aug 2025 09:32:50 -0600
Message-ID: <20250808153251.282107-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
that copies the ublksrv_io_cmd from user-mapped memory to the stack
using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
__ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
local variables with READ_ONCE(). This allows the compiler to delay
loading the fields until they are needed and choose whether to store
them in registers or on the stack.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 62 +++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6561d2a561fa..a0ac944ec965 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2267,56 +2267,60 @@ static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
 			ublk_get_iod(ubq, req->tag)->addr);
 
 	return ublk_start_io(ubq, req, io);
 }
 
-static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
-			       unsigned int issue_flags,
-			       const struct ublksrv_io_cmd *ub_cmd)
+static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
+		unsigned int issue_flags)
 {
+	/* May point to userspace-mapped memory */
+	const struct ublksrv_io_cmd *ub_src = io_uring_sqe_cmd(cmd->sqe);
 	u16 buf_idx = UBLK_INVALID_BUF_IDX;
 	struct ublk_device *ub = cmd->file->private_data;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
-	unsigned tag = ub_cmd->tag;
+	u16 q_id = READ_ONCE(ub_src->q_id);
+	u16 tag = READ_ONCE(ub_src->tag);
+	s32 result = READ_ONCE(ub_src->result);
+	u64 addr = READ_ONCE(ub_src->addr); /* unioned with zone_append_lba */
 	struct request *req;
 	int ret;
 	bool compl;
 
+	WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED);
+
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
-			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
-			ub_cmd->result);
+			__func__, cmd->cmd_op, q_id, tag, result);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
 	/*
 	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
 	 * so no need to validate the q_id, tag, or task
 	 */
 	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
-		return ublk_unregister_io_buf(cmd, ub, ub_cmd->addr,
-					      issue_flags);
+		return ublk_unregister_io_buf(cmd, ub, addr, issue_flags);
 
 	ret = -EINVAL;
-	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
+	if (q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
-	ubq = ublk_get_queue(ub, ub_cmd->q_id);
+	ubq = ublk_get_queue(ub, q_id);
 
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-		ret = ublk_check_fetch_buf(ubq, ub_cmd->addr);
+		ret = ublk_check_fetch_buf(ubq, addr);
 		if (ret)
 			goto out;
-		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		ret = ublk_fetch(cmd, ubq, io, addr);
 		if (ret)
 			goto out;
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
@@ -2326,11 +2330,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		/*
 		 * ublk_register_io_buf() accesses only the io's refcount,
 		 * so can be handled on any task
 		 */
 		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
-			return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr,
+			return ublk_register_io_buf(cmd, ubq, io, addr,
 						    issue_flags);
 
 		goto out;
 	}
 
@@ -2348,26 +2352,26 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->addr,
+		return ublk_daemon_register_io_buf(cmd, ubq, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_check_commit_and_fetch(ubq, io, ub_cmd->addr);
+		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
-		io->res = ub_cmd->result;
+		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
+		ret = ublk_config_io_buf(ubq, io, cmd, addr, &buf_idx);
 		compl = ublk_need_complete_req(ubq, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
-			req->__sector = ub_cmd->zone_append_lba;
+			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req);
 
 		if (ret)
 			goto out;
@@ -2377,11 +2381,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 * ublk_get_data() may fail and fallback to requeue, so keep
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, NULL);
+		ret = ublk_config_io_buf(ubq, io, cmd, addr, NULL);
 		WARN_ON_ONCE(ret);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
 		}
@@ -2428,30 +2432,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
 
-static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
-{
-	/*
-	 * Not necessary for async retry, but let's keep it simple and always
-	 * copy the values to avoid any potential reuse.
-	 */
-	const struct ublksrv_io_cmd *ub_src = io_uring_sqe_cmd(cmd->sqe);
-	const struct ublksrv_io_cmd ub_cmd = {
-		.q_id = READ_ONCE(ub_src->q_id),
-		.tag = READ_ONCE(ub_src->tag),
-		.result = READ_ONCE(ub_src->result),
-		.addr = READ_ONCE(ub_src->addr)
-	};
-
-	WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED);
-
-	return __ublk_ch_uring_cmd(cmd, issue_flags, &ub_cmd);
-}
-
 static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 
-- 
2.45.2

