Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3D2BDC2F
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432220; cv=none; b=p8jLtwy7VfOQfB4vLmGU76s6EWoD3ohtV9t6hNQj4iTlqiZAgAVaxCC4UPrK+WeKu+lutwox2Oa+SnBGwom6lP9t7K9V22tyRz8+k9d+/fQMA7A+65MeKW9kp0ICdWMC6MeCA9nWMvdihCmx9CXuG616+QNddLXleMAlY9WWdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432220; c=relaxed/simple;
	bh=3PPgL+rkVbKaqe94aVboPKn/2zCr7VemGonwESdMi4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cx+Ld9CcU13f41hDh4AwqYrNOo3g1z7Iep2N7CbFLlM7quln6aK4Axvq6FGhG5U6XNPXyMplYwElS/7JAqoYGAYPvk3c+2RmCVXgAENOcBaAYQl+/BI+2K49fXNl6jbDKpLuE87bIFwdpF5FUmdrX1nuGNtU/+lyGKSIKLnUKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Rgao8C7h; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Rgao8C7h"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-748d70b21fcso78404b3a.3
        for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750432217; x=1751037017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UQnnwwJ1Ru93TFSi677JCx86dktyFTMaGwKO0rV5Ag=;
        b=Rgao8C7hMYuzOouQ459p1rV9ymUZuqQJY0nI10RP/nsDWm2JiLefOlap+RW1IyEZO2
         6zMAprD4XvuRBEGNM1wl/wCjXwRoBPQm7hOfr52Dx+jsBTXJSEM2AjdevBTLokGZO6Bw
         rqUCIDb2Dxz56RkbGD5KOb/N6TcXZ8Hc4J2q+3G0k+COqPOCXKKu7w2ugwEcOhA52Hip
         xBHF+q1KOIFevllE2n6ccYj5DxZ72GlsmYddUyki3gEAF4TrX3W4ZAbyV0F9lg9Grk1r
         h+1qVSu4SkwYP9ZzHKSyNqz2Zfh+F6TEK0x/wW9oUMUQPE43WqFyRbLZtkyXZ/codFKR
         PW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750432217; x=1751037017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UQnnwwJ1Ru93TFSi677JCx86dktyFTMaGwKO0rV5Ag=;
        b=SmPUuDkcl4oE44Eh7vXYtyBIIzD/ZJToFVlB4OJSNEvmJmKXtp3PGnWvBphEuRtIqL
         M7dxuogtKhr+NInbrbJnoBELM9GiDpAs4uiDdZGYNo4sHbU6GO+tvrQD/SHu8yNUD4LO
         i9SIr9XfSiryKRd91CURLxhljii9XjEVrE2bSGl0Hcop98mEpmFC9muUfJG+TXfZgw3J
         6LF2nyk80mp/pAS60fw+cY/O8QFCYX54oXBild1tSy7CzaFRHPgQe8jzBrqU0BgDDlAD
         CMdg9L7hvSQUk5nLfxu0WmcVAP6JMDUYT1/VgJ6cUjJp91gx9gmHsdKDpaY7eHOQ6K6h
         AU0A==
X-Gm-Message-State: AOJu0YzXkOCwd44mETc0aVQCJLmn6hW8+EKfPxD8cxvkqbf6DWx2xGdd
	L012Qj4bcDc/ukcI2o2crA4TLqA3b2N6ABAZBkPTSqPc096hzZ+t+y7qkS4HtsUCOP/k/BQp1tv
	DmuVFEyqLk97yhcZXSctrgypjPBifA5OITXwc
X-Gm-Gg: ASbGncuGTGEQzGexxWUDYSZLh0+3EXon2zaxcp/vgqai/9uSUDwVIJshCC4VvjWSBCY
	0PcwHuwazkx+qYbxWuIc1rg2pPxF4kt+bPp7iboqz2bxONzvG4qG+OaEuDHDUnlddgOobx7HiGK
	Cfqdk8ltaXna6unpFj6Ep0RKrW1iC50rERfYZseO3teYHedDERhepprZ/iD+swDVx/mHoc7FItQ
	GElXuKt26f47x5dF0ivmDuhkSymC4dXi0Ve3VnvQ9zJk/Y1vHR8asOe/Ofooi8oKiZKwHVkit4A
	mTm5PGp9zIWgvaYgRvFY2CJyHCwbH+Vu6VLFV/98T6/h1VJyd8BgJjM=
X-Google-Smtp-Source: AGHT+IG6jOYspFnTmwbzbucYlmioVDaQ6sW8sk6+g/TZsjhA5SaHqq0zlFWSpWSURaj3+pbTt+tka/bzpX47
X-Received: by 2002:a05:6a00:4b56:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-7490d66055fmr1855180b3a.5.1750432217008;
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b31f11b7d82sm48174a12.12.2025.06.20.08.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:10:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 699DF3403AF;
	Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 67353E4548E; Fri, 20 Jun 2025 09:10:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 11/14] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
Date: Fri, 20 Jun 2025 09:10:05 -0600
Message-ID: <20250620151008.3976463-12-csander@purestorage.com>
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

ublk_register_io_buf() performs an expensive atomic refcount increment,
as well as a lot of pointer chasing to look up the struct request.

Create a separate ublk_daemon_register_io_buf() for the daemon task to
call. Initialize ublk_io's reference count to a large number, introduce
a field task_registered_buffers to count the buffers registered on the
daemon task, and atomically subtract the large number minus
task_registered_buffers in ublk_commit_and_fetch().

Also obtain the struct request directly from ublk_io's req field instead
of looking it up on the tagset.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 70 ++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f53618391141..b2925e15279a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -146,10 +146,17 @@ struct ublk_uring_cmd_pdu {
 #define UBLK_IO_FLAG_AUTO_BUF_REG 	0x10
 
 /* atomic RW with ubq->cancel_lock */
 #define UBLK_IO_FLAG_CANCELED	0x80000000
 
+/*
+ * Initialize refcount to a large number to include any registered buffers.
+ * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minus those for
+ * any buffers registered on the io daemon task.
+ */
+#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
+
 struct ublk_io {
 	/* userspace buffer address from io cmd */
 	__u64	addr;
 	unsigned int flags;
 	int res;
@@ -164,18 +171,21 @@ struct ublk_io {
 	struct task_struct *task;
 
 	/*
 	 * The number of uses of this I/O by the ublk server
 	 * if user copy or zero copy are enabled:
-	 * - 1 from dispatch to the server until UBLK_IO_COMMIT_AND_FETCH_REQ
+	 * - UBLK_REFCOUNT_INIT from dispatch to the server
+	 *   until UBLK_IO_COMMIT_AND_FETCH_REQ
 	 * - 1 for each inflight ublk_ch_{read,write}_iter() call
-	 * - 1 for each io_uring registered buffer
+	 * - 1 for each io_uring registered buffer not registered on task
 	 * The I/O can only be completed once all references are dropped.
 	 * User copy and buffer registration operations are only permitted
 	 * if the reference count is nonzero.
 	 */
 	refcount_t ref;
+	/* Count of buffers registered on task and not yet unregistered */
+	unsigned task_registered_buffers;
 
 	/* auto-registered buffer, valid if UBLK_IO_FLAG_AUTO_BUF_REG is set */
 	u16 buf_index;
 	void *buf_ctx_handle;
 };
@@ -684,11 +694,11 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct ublk_io *io)
 {
 	if (ublk_need_req_ref(ubq))
-		refcount_set(&io->ref, 1);
+		refcount_set(&io->ref, UBLK_REFCOUNT_INIT);
 }
 
 static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
 		struct ublk_io *io)
 {
@@ -707,10 +717,19 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	} else {
 		__ublk_complete_rq(req);
 	}
 }
 
+static inline void ublk_sub_req_ref(struct ublk_io *io, struct request *req)
+{
+	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
+
+	io->task_registered_buffers = 0;
+	if (refcount_sub_and_test(sub_refs, &io->ref))
+		__ublk_complete_rq(req);
+}
+
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
 }
 
@@ -1188,11 +1207,10 @@ ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk_io *io)
 {
 	unsigned tag = io - ubq->ios;
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
-	refcount_set(&io->ref, 1);
 }
 
 static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 			      struct ublk_io *io, unsigned int issue_flags)
 {
@@ -1207,13 +1225,12 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 			return true;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
-	/* one extra reference is dropped by ublk_io_release */
-	refcount_set(&io->ref, 2);
 
+	io->task_registered_buffers = 1;
 	io->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
 	/* store buffer index in request payload */
 	io->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
@@ -1221,14 +1238,14 @@ static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct request *req,
 
 static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
 				   struct request *req, struct ublk_io *io,
 				   unsigned int issue_flags)
 {
+	ublk_init_req_ref(ubq, io);
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
 		return ublk_auto_buf_reg(ubq, req, io, issue_flags);
 
-	ublk_init_req_ref(ubq, io);
 	return true;
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
@@ -1488,10 +1505,11 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 			put_task_struct(io->task);
 			io->task = NULL;
 		}
 
 		WARN_ON_ONCE(refcount_read(&io->ref));
+		WARN_ON_ONCE(io->task_registered_buffers);
 	}
 }
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
@@ -2023,10 +2041,39 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	}
 
 	return 0;
 }
 
+static int
+ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
+			    const struct ublk_queue *ubq, struct ublk_io *io,
+			    unsigned index, unsigned issue_flags)
+{
+	unsigned new_registered_buffers;
+	struct request *req = io->req;
+	int ret;
+
+	/*
+	 * Ensure there are still references for ublk_sub_req_ref() to release.
+	 * If not, fall back on the thread-safe buffer registration.
+	 */
+	new_registered_buffers = io->task_registered_buffers + 1;
+	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
+		return ublk_register_io_buf(cmd, ubq, io, index, issue_flags);
+
+	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
+		return -EINVAL;
+
+	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
+				      issue_flags);
+	if (ret)
+		return ret;
+
+	io->task_registered_buffers = new_registered_buffers;
+	return 0;
+}
+
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 				  const struct ublk_device *ub,
 				  unsigned int index, unsigned int issue_flags)
 {
 	if (!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY))
@@ -2146,11 +2193,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		req->__sector = ub_cmd->zone_append_lba;
 
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return 0;
 
-	ublk_put_req_ref(ubq, io, req);
+	if (ublk_need_req_ref(ubq))
+		ublk_sub_req_ref(io, req);
+	else
+		__ublk_complete_rq(req);
 	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 {
@@ -2244,11 +2294,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, io, ub_cmd->addr, issue_flags);
+		return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->addr,
+						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 
@@ -2473,10 +2524,11 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 		if (io->task)
 			put_task_struct(io->task);
 		WARN_ON_ONCE(refcount_read(&io->ref));
+		WARN_ON_ONCE(io->task_registered_buffers);
 	}
 
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
-- 
2.45.2

