Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5572C08C0
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530592; cv=none; b=PyToaeQrhMQGSg/1QhrEAVy9DbvhPgesrQeCr7aO1FJ6DAfo68me7C1jxI/U6atG6GSv7V1yRDvQxniZlhmcoYF7/fHiczfk8UoijomFh1B6mszARzZ/0wO9TBF5kJJPpcg7kcZYnjWfImkwNAspilIObnVMCQAe18USNE4ReXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530592; c=relaxed/simple;
	bh=sxkKbdlsh3OuceAnLMYjBI941r+CSc45HUmaifG7JaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCXhdooDAIbzOHiJK0T4dby9FLRhe4bUsv8d3tYj3IGvaX/svTGdDelni4nnGkkTcwyc9gR9+2nViiHikZBYHOxmWdm3J6Ld40Ng4I4/IBNbBTuQXAtWbsG/ynHuvSHYg0mOrUHS8AZk6oYZU30LfKX+bA9kfUcVizUgLHT0poI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QZQW5OdK; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QZQW5OdK"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-47103531eeeso1296595e9.1
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530588; x=1762135388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHIrYr/JL4uQvWk8eoQKjYhwgUps+99ZLq7CmULDbo=;
        b=QZQW5OdKhGYBuBxt2mPjc6WzFgIbkJTRRRHRUeKGXNCbDaF3NI1hP+7kkDjR+KiJ1F
         fGNa8xmPr9kPGZapGTAi+Uhwobk1/3zSd+PrWFsFBeSXGJvnOYM8xB8WowEKgPb7T2q8
         6gRdxLeLqTGNyRNEYYodXVAWV06TA+B2ymR5lmldK8KDkc6q4P0v3q9mviWD1VroUAw+
         rkN9zdWvbT2B2u/ehbTvedXcD7hEIbqHyBb2GizSKwx/lueMwboTjYmRbnYkH4NuXK4E
         3zqbeDMmElzFaozP67tCbVsTFCBVFlfPfkm/9mKwmkerUjsBBPExerxsqOitvbhpsF3m
         kAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530588; x=1762135388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTHIrYr/JL4uQvWk8eoQKjYhwgUps+99ZLq7CmULDbo=;
        b=I++/ZpIj5ufWCVwWPexq+obMg2aw72X+jlmTGGkO/61+zwXY1HeDnz7r0hOyPmRbjy
         rjPZwfspBQHSCprCQTnt6w65Oc1hfyaMohbB8rpg8neTrlcJJZF6zDC1oH+4irbyAqcq
         XoZeqCJZhjE8vaYnxKCxMkDtWzn6/IdfNZ3vW9vp63L6F8DxJNPiyP61fOqkTk75BDPS
         rXRa6aWryxXT0zEUvZrlna9Sf3f1byU+Ki039snNatG6GcN9zrFj2MB+F54gCpbtNwka
         Nkw8osIINapBCHk8JwwHkiUZb9xCUyhOU8Vl9sZGNaYhMUW0/wY8P12W97PdFs/vZM89
         gDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthkn2P74CLW6Ll0RlD4WOiSo9EQj8f2PTNVYaZ0BqVh1BWEEVAAaGLStsmYGKTTrfgppYuCTEgxjZvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxfi7glDLm9bjqC4/Jbt5WnlqJy+xg/tQA4cuPVHe7PzM4tVW
	Cl1zbHDh3tmMGw4hkxS0b9t4OQV6OYtMVkri9zsRIo+3bwQQUP/XbgV8xaZslygzmWNSWhG0DUU
	nMEuZjrNdpMJw8jo2s4h568BZFB8vV18drFieq69z4PpDsv4W1KLC
X-Gm-Gg: ASbGncvY4tTQKyx70RDkUdH8nGGscPsfZqMzZDyyouJrUpL4fuBsCnJrpwAmW4ErgsF
	EOiFgihlFNvBlchlyLlP+YsTxj56XcsVH0PMuugmo+yxb2yMOTEcElz7/K+aHXtkA2tTiWGlJ9l
	8ZgG7vMceZWMuPXbD3jvYbrLYNNRSi1vD1rpX3Tz8G67auV5FXVpuyJluxy09sO2DCP+4TlR4n/
	axPe+BK739sTcybZy7DWXZc4yxyql1tby60u9n2QwfRmYAh2AuI/T3Zw1W46PzMNaRENAyKWI3a
	Elu3bRwlhw8FwYomP3u+g4ayn81j2Q/hAAgjS3Rb1tl/M2kCF4zSFXGx/KWkZSHzcP8Ztu0/h+y
	fCEZ+ZGmbrU3hyfai
X-Google-Smtp-Source: AGHT+IEzJHwSYBWzz7Sy75kcuAarkrE8pEDkVMhr61B/a1LvJ1VT5CSEpon9FdrgrKuk8HVDvv4MPWdgxEtI
X-Received: by 2002:a05:600c:4fcb:b0:471:c4c:5ef with SMTP id 5b1f17b1804b1-4749437b584mr97004145e9.4.1761530588469;
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-475dd021cb9sm6122735e9.4.2025.10.26.19.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 297753420A1;
	Sun, 26 Oct 2025 20:03:07 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 266E0E46586; Sun, 26 Oct 2025 20:03:07 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/4] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Sun, 26 Oct 2025 20:03:02 -0600
Message-ID: <20251027020302.822544-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251027020302.822544-1-csander@purestorage.com>
References: <20251027020302.822544-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring task work dispatch makes an indirect call to struct io_kiocb's
io_task_work.func field to allow running arbitrary task work functions.
In the uring_cmd case, this calls io_uring_cmd_work(), which immediately
makes another indirect call to struct io_uring_cmd's task_work_cb field.
Change the uring_cmd task work callbacks to functions whose signatures
match io_req_tw_func_t. Add a function io_uring_cmd_from_tw() to convert
from the task work's struct io_tw_req argument to struct io_uring_cmd *.
Define a constant IO_URING_CMD_TASK_WORK_ISSUE_FLAGS to avoid
manufacturing issue_flags in the uring_cmd task work callbacks. Now
uring_cmd task work dispatch makes a single indirect call to the
uring_cmd implementation's callback. This also allows removing the
task_work_cb field from struct io_uring_cmd, freeing up 8 bytes for
future storage.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/ioctl.c                |  4 +++-
 drivers/block/ublk_drv.c     | 15 +++++++++------
 drivers/nvme/host/ioctl.c    |  5 +++--
 fs/btrfs/ioctl.c             |  4 +++-
 fs/fuse/dev_uring.c          |  5 +++--
 include/linux/io_uring/cmd.h | 22 +++++++++++++---------
 io_uring/uring_cmd.c         | 14 ++------------
 7 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d7489a56b33c..44de038660e7 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -767,12 +767,14 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 struct blk_iou_cmd {
 	int res;
 	bool nowait;
 };
 
-static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
 
 	if (bic->res == -EAGAIN && bic->nowait)
 		io_uring_cmd_issue_blocking(cmd);
 	else
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..bdccd15ba577 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1346,13 +1346,14 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 
 	if (ublk_prep_auto_buf_reg(ubq, req, io, issue_flags))
 		ublk_complete_io_cmd(io, req, UBLK_IO_RES_OK, issue_flags);
 }
 
-static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
-			   unsigned int issue_flags)
+static void ublk_cmd_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
@@ -1364,13 +1365,14 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 
 	pdu->req = rq;
 	io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
 }
 
-static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
+static void ublk_cmd_list_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
 	struct request *next;
 
 	do {
@@ -2521,13 +2523,14 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
 
-static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
+static void ublk_ch_uring_cmd_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 
 	if (ret != -EIOCBQUEUED)
 		io_uring_cmd_done(cmd, ret, issue_flags);
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..6a2a0ef29674 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -396,13 +396,14 @@ static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
 	return io_uring_cmd_to_pdu(ioucmd, struct nvme_uring_cmd_pdu);
 }
 
-static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
-			       unsigned issue_flags)
+static void nvme_uring_task_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
 	io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, issue_flags);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 185bef0df1c2..1936927ee6a4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4647,12 +4647,14 @@ struct btrfs_uring_priv {
 struct io_btrfs_cmd {
 	struct btrfs_uring_encoded_data *data;
 	struct btrfs_uring_priv *priv;
 };
 
-static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int issue_flags)
+static void btrfs_uring_read_finished(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
 	struct btrfs_uring_priv *priv = bc->priv;
 	struct btrfs_inode *inode = BTRFS_I(file_inode(priv->iocb.ki_filp));
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	pgoff_t index;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 71b0c9662716..30923495e80f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1207,13 +1207,14 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission
  * to write to it - this has to be executed in ring task context.
  */
-static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
-				    unsigned int issue_flags)
+static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
+	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
 	if (!io_uring_cmd_should_terminate_tw(cmd)) {
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index b84b97c21b43..8e3322fb6fa5 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -9,21 +9,17 @@
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
 #define IORING_URING_CMD_REISSUE	(1U << 31)
 
-typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
-				  unsigned issue_flags);
-
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
-	/* callback to defer completions to task context */
-	io_uring_cmd_tw_t task_work_cb;
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
+	u8		unused[8];
 };
 
 static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
 {
 	return sqe->cmd;
@@ -58,11 +54,11 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
  */
 void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
 			 unsigned issue_flags, bool is_cqe32);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			    io_uring_cmd_tw_t task_work_cb,
+			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
 
 /*
  * Note: the caller should never hard code @issue_flags and only use the
  * mask provided by the core io_uring code.
@@ -107,11 +103,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags, bool is_cqe32)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			    io_uring_cmd_tw_t task_work_cb, unsigned flags)
+			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
 }
 static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -130,19 +126,27 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 {
 	return true;
 }
 #endif
 
+static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
+{
+	return io_kiocb_to_cmd(tw_req.req, struct io_uring_cmd);
+}
+
+/* task_work executor checks the deferred list completion */
+#define IO_URING_CMD_TASK_WORK_ISSUE_FLAGS IO_URING_F_COMPLETE_DEFER
+
 /* users must follow the IOU_F_TWQ_LAZY_WAKE semantics */
 static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb)
+			io_req_tw_func_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
 }
 
 static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb)
+			io_req_tw_func_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
 static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index fc2955e8caaf..5a80d35658dc 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -111,30 +111,20 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		io_ring_submit_unlock(ctx, issue_flags);
 	}
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
-static void io_uring_cmd_work(struct io_tw_req tw_req, io_tw_token_t tw)
-{
-	struct io_kiocb *req = tw_req.req;
-	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-
-	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
-}
-
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
-			io_uring_cmd_tw_t task_work_cb,
+			io_req_tw_func_t task_work_cb,
 			unsigned flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
 
-	ioucmd->task_work_cb = task_work_cb;
-	req->io_task_work.func = io_uring_cmd_work;
+	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
 static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
-- 
2.45.2

