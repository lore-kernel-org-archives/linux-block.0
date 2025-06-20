Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920F2951C9
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432219; cv=none; b=AcWbi6Xoao/boMgKeZHd3ikkmczQMTMqMJeRQyCZYonj6VnOVUxWgd74T3D3FFhcvqlICaRu5Cd9gXCPzkZtE3W1Cg7qUNJ8rPoHiL6SWeoVDNyHKBvj1HmG/JIunZFKerwYdGZ8tcKST71bE7zBtZABAM63WSRnlMrejKyxpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432219; c=relaxed/simple;
	bh=YyHkL3MW1SaE52XWQtj6o4cyoRJGo0SuyB5Vou1F9fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=febhsjbhLTInzg1rihONu0q8absbXVVm+XfpiZiEoMP4kq/Y50yN1DAwUyhVuM3FWWRkerlpNFNqE3gWm3DX9f2W105CzO/cc/JN/FNdprMONmfPQRynFO3y+yaQ5omUFZOUXU37rawi1GLDGSQJRfxo1T4hsjHq02e1GBoZ6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NVtRPrmh; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NVtRPrmh"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-235248ba788so1517575ad.0
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432215; x=1751037015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AzDKQScoaYiQlxNeo237/atJwdzJEUgOnN7wy4d1wU=;
        b=NVtRPrmhYdnrqEueJIXGfF8ALa9v8rdcd09HZEND36Iz5dRRbbd8t6NQZM7rxGNKX4
         b/ham/eoTPxStKI4Itib4OItSLK++63Zk9cKVb/269bCWyolDG539+5gf2on/93o5aXx
         auzDKb7mGlttAjPT7vUCRd9Y64TVC2bKNUajPdRT/n9NTO7bL1bd+0xEydXwYXW4l6py
         LZha8ZpYrQaAImbQRVvXzs9zQNcjGd35lKC1NJvBCHHMdIjJjwZVO/JSGOlZnYLUMVLg
         Ik1eLa+J6BiOc3vmTXVtTJd8qBtaLi7pZiFyZQ1ODBeV/pNMuRDgJ50luUK3f5iPpTGk
         9ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432215; x=1751037015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AzDKQScoaYiQlxNeo237/atJwdzJEUgOnN7wy4d1wU=;
        b=viwOWzh0c0k9rPICkivZeh69iu51KtPeEHs0LBqwf2mI5pWO7Wbsu6BrlowDnP3NzS
         g4IEdtHSYV0sOYdxVWghVZXplCqfvhdsoia5uFIqU+n6X+4OYmadBFOlNHcb+cy08x5I
         17TyXCRfQHjmSwAsNhyt3qy5xP/oOdC3cYfbhDdM25Gv98su7KmthAnHwBRKFO9s9WS4
         tn00BQmcYvnkvT1xCswuvM9Kr6tbVFaAHE8fHce/hrWOgr7ltQe5G+jRDwCLe5pIT55P
         NvLw7UetE0hbK1pK3wIBeo27kAGPYWFiwRJi+RvTqeOUmGOFiO7X6gpSLIltOhIC+q/e
         m/rA==
X-Gm-Message-State: AOJu0YxcGs8NyMDnmos0EgoK/4P21Jd519Yz4UIcbBczCOM46Lz73hNd
	hYdD8rKbF5BFPg5GW2R76uOIkkIO4E7DYQ19jniF7TK0TIhqZiRbfZI5Ahlf+51G65Y20rvutbi
	8KyomBMgoqFsTWs7LTpF4jS5A0AfhNodyNFoLV0UPZ+JG9G5HUfyl
X-Gm-Gg: ASbGnct/Im1rchAeo2+/HpmVqgFgDYo51wjf01g2HkDHe6NgIbmzY+IuwRUFJ/1pqGB
	2UyNT81Hr2MVKr/WkKiu7R79QrqPbgOxRIbmr7aBuDbcWHVkYU309aHNkvyb1NID7Z5Mgbb6SNG
	c8lZkvoVdyXeE+EwwnzDkEi+GqDulEpB6yuwf3lxnCVUHx/SMxF4aqtvhcbjh/2IuIbGCdl2DsO
	/N0SVAgHMKwFp1ru6m2zLPIoltarPoQb5b5FRs5uZfS9+ViXkNe1Ky38ujwmC2IKLmojApFgqfx
	ADehhB/s28oRXBaQ8YyZQjbSvQHboEPHS+mGWM5c
X-Google-Smtp-Source: AGHT+IFBv8tDwos6cGE1I9CT99fwE9WbtAyWDxJPyrUKX1Spif84LjjByQleLGK1hJdDO66poa61GwdlwWxQ
X-Received: by 2002:a17:903:2345:b0:234:bfd3:50df with SMTP id d9443c01a7336-237d9795576mr18774005ad.5.1750432215132;
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-237d862221bsm1205055ad.122.2025.06.20.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6808234031F;
	Fri, 20 Jun 2025 09:10:14 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 66CE0E4548E; Fri, 20 Jun 2025 09:10:14 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 02/14] ublk: remove struct ublk_rq_data
Date: Fri, 20 Jun 2025 09:09:56 -0600
Message-ID: <20250620151008.3976463-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620151008.3976463-1-csander@purestorage.com>
References: <20250620151008.3976463-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ublk_check_and_get_req() attempts to atomically look up the struct
request for a ublk I/O and take a reference on it. However, the request
can be freed between the lookup on the tagset in blk_mq_tag_to_rq() and
the increment of its reference count in ublk_get_req_ref(), for example
if an elevator switch happens concurrently.

Fix the potential use after free by moving the reference count from
ublk_rq_data to ublk_io. Move the fields buf_index and buf_ctx_handle
too to reduce the number of cache lines touched when dispatching and
completing a ublk I/O, allowing ublk_rq_data to be removed entirely.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 62fe99cef94a ("ublk: add read()/write() support for ublk char device")
---
 drivers/block/ublk_drv.c | 131 +++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 467769fc388f..55d5435f1ee2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -80,18 +80,10 @@
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
-struct ublk_rq_data {
-	refcount_t ref;
-
-	/* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
-	u16 buf_index;
-	void *buf_ctx_handle;
-};
-
 struct ublk_uring_cmd_pdu {
 	/*
 	 * Store requests in same batch temporarily for queuing them to
 	 * daemon context.
 	 *
@@ -167,10 +159,26 @@ struct ublk_io {
 		/* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
 		struct request *req;
 	};
 
 	struct task_struct *task;
+
+	/*
+	 * The number of uses of this I/O by the ublk server
+	 * if user copy or zero copy are enabled:
+	 * - 1 from dispatch to the server until UBLK_IO_COMMIT_AND_FETCH_REQ
+	 * - 1 for each inflight ublk_ch_{read,write}_iter() call
+	 * - 1 for each io_uring registered buffer
+	 * The I/O can only be completed once all references are dropped.
+	 * User copy and buffer registration operations are only permitted
+	 * if the reference count is nonzero.
+	 */
+	refcount_t ref;
+
+	/* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is set */
+	u16 buf_index;
+	void *buf_ctx_handle;
 };
 
 struct ublk_queue {
 	int q_id;
 	int q_depth;
@@ -226,11 +234,12 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		const struct ublk_queue *ubq, int tag, size_t offset);
+		const struct ublk_queue *ubq, struct ublk_io *io,
+		size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -671,38 +680,30 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq) ||
 		ublk_support_auto_buf_reg(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+		struct ublk_io *io)
 {
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		refcount_set(&data->ref, 1);
-	}
+	if (ublk_need_req_ref(ubq))
+		refcount_set(&io->ref, 1);
 }
 
 static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+		struct ublk_io *io)
 {
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		return refcount_inc_not_zero(&data->ref);
-	}
+	if (ublk_need_req_ref(ubq))
+		return refcount_inc_not_zero(&io->ref);
 
 	return true;
 }
 
 static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+		struct ublk_io *io, struct request *req)
 {
 	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		if (refcount_dec_and_test(&data->ref))
+		if (refcount_dec_and_test(&io->ref))
 			__ublk_complete_rq(req);
 	} else {
 		__ublk_complete_rq(req);
 	}
 }
@@ -1179,55 +1180,54 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static void ublk_auto_buf_reg_fallback(struct request *req)
+static void
+ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
 {
-	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	unsigned tag = io - ubq->ios;
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
-	refcount_set(&data->ref, 1);
+	refcount_set(&io->ref, 1);
 }
 
-static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
-			      unsigned int issue_flags)
+static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
+			      struct ublk_io *io, unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 	int ret;
 
 	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
 				      pdu->buf.index, issue_flags);
 	if (ret) {
 		if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
-			ublk_auto_buf_reg_fallback(req);
+			ublk_auto_buf_reg_fallback(ubq, io);
 			return true;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
 	/* one extra reference is dropped by ublk_io_release */
-	refcount_set(&data->ref, 2);
+	refcount_set(&io->ref, 2);
 
-	data->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
+	io->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
 	/* store buffer index in request payload */
-	data->buf_index = pdu->buf.index;
+	io->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
 }
 
 static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
 				   struct request *req, struct ublk_io *io,
 				   unsigned int issue_flags)
 {
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
-		return ublk_auto_buf_reg(req, io, issue_flags);
+		return ublk_auto_buf_reg(ubq, req, io, issue_flags);
 
-	ublk_init_req_ref(ubq, req);
+	ublk_init_req_ref(ubq, io);
 	return true;
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
@@ -1485,10 +1485,12 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		 */
 		if (io->task) {
 			put_task_struct(io->task);
 			io->task = NULL;
 		}
+
+		WARN_ON_ONCE(refcount_read(&io->ref));
 	}
 }
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
@@ -1989,33 +1991,35 @@ static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
 
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 
-	ublk_put_req_ref(ubq, rq);
+	ublk_put_req_ref(ubq, io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
-				const struct ublk_queue *ubq, unsigned int tag,
+				const struct ublk_queue *ubq,
+				struct ublk_io *io,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
 	struct request *req;
 	int ret;
 
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
+	req = __ublk_check_and_get_req(ub, ubq, io, 0);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret) {
-		ublk_put_req_ref(ubq, req);
+		ublk_put_req_ref(ubq, io, req);
 		return ret;
 	}
 
 	return 0;
 }
@@ -2118,14 +2122,12 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		 * one for registering the buffer, it is ublk server's
 		 * responsibility for unregistering the buffer, otherwise
 		 * this ublk request gets stuck.
 		 */
 		if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
-			struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-			if (data->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
-				io_buffer_unregister_bvec(cmd, data->buf_index,
+			if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
+				io_buffer_unregister_bvec(cmd, io->buf_index,
 						issue_flags);
 			io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
 		}
 
 		ret = ublk_set_auto_buf_reg(cmd);
@@ -2141,11 +2143,11 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
 	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
+		ublk_put_req_ref(ubq, io, req);
 
 	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
@@ -2220,11 +2222,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ubq, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
 		if (ret)
@@ -2252,19 +2254,24 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		const struct ublk_queue *ubq, int tag, size_t offset)
+		const struct ublk_queue *ubq, struct ublk_io *io, size_t offset)
 {
+	unsigned tag = io - ubq->ios;
 	struct request *req;
 
+	/*
+	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
+	 * which would overwrite it with io->cmd
+	 */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	if (!req)
 		return NULL;
 
-	if (!ublk_get_req_ref(ubq, req))
+	if (!ublk_get_req_ref(ubq, io))
 		return NULL;
 
 	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
 		goto fail_put;
 
@@ -2274,11 +2281,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 	if (offset > blk_rq_bytes(req))
 		goto fail_put;
 
 	return req;
 fail_put:
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(ubq, io, req);
 	return NULL;
 }
 
 static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -2341,11 +2348,12 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 
 	return false;
 }
 
 static struct request *ublk_check_and_get_req(struct kiocb *iocb,
-		struct iov_iter *iter, size_t *off, int dir)
+		struct iov_iter *iter, size_t *off, int dir,
+		struct ublk_io **io)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
 	size_t buf_off;
@@ -2375,11 +2383,12 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 		return ERR_PTR(-EACCES);
 
 	if (tag >= ubq->q_depth)
 		return ERR_PTR(-EINVAL);
 
-	req = __ublk_check_and_get_req(ub, ubq, tag, buf_off);
+	*io = &ubq->ios[tag];
+	req = __ublk_check_and_get_req(ub, ubq, *io, buf_off);
 	if (!req)
 		return ERR_PTR(-EINVAL);
 
 	if (!req->mq_hctx || !req->mq_hctx->driver_data)
 		goto fail;
@@ -2388,46 +2397,48 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 		goto fail;
 
 	*off = buf_off;
 	return req;
 fail:
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(ubq, *io, req);
 	return ERR_PTR(-EACCES);
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct ublk_queue *ubq;
 	struct request *req;
+	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
-	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST);
+	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
 	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(ubq, io, req);
 
 	return ret;
 }
 
 static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct ublk_queue *ubq;
 	struct request *req;
+	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
-	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE);
+	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
 	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(ubq, io, req);
 
 	return ret;
 }
 
 static const struct file_operations ublk_ch_fops = {
@@ -2448,10 +2459,11 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 		if (io->task)
 			put_task_struct(io->task);
+		WARN_ON_ONCE(refcount_read(&io->ref));
 	}
 
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
@@ -2600,11 +2612,10 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 {
 	ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
-	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
 }
 
 static void ublk_remove(struct ublk_device *ub)
-- 
2.45.2

