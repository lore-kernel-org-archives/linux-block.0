Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0408BC43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE16B20656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BWNPmGgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfAOC4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:56:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38189 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfAOC4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:56:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so579066plb.5
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvsJ/ig0iiKpF0/EJseRy0e9NO+B0XXmYaMtCgsMnUA=;
        b=BWNPmGgtSsNDqpPCWYipfHd9qEPBMGbUpHX3ZVJFB3cJvGYxZaUXgjQ5EnQRnMMw9n
         +LrvoKgUGJgpLSYfiZgOrQNHgJQfnadlosTyv99OAfwVXCQ5RDHNWrTxnLiydPj7W5mL
         7mXV/QfWZjdFleAZ00AZwcXMRj65bjJmnj8pP/Ut0Oyy4/8J1mcQqZoPiJfmHE93L4OZ
         D4vZ4WNRnmJgWcA09ZLilP33WIs37pQQzVRoSrQQUMYz5cMv2/NeAYc6FPinNP0r0p3S
         cXFVUr9FefM96Qbdfcyny1envQXNr9Ozm1fZvRr0OW0B4xgXsnNLdvWd846Rr7PtvqfB
         ZMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvsJ/ig0iiKpF0/EJseRy0e9NO+B0XXmYaMtCgsMnUA=;
        b=jemaCh5RVdBFhxahyh0wog63wjcHbcQ1RaKBlSTxwWIU00eGUyD6QnsHumvZzXCZFa
         KFIWpjwE3Y6f0bcyd+TQfat8y4VuG6QwZ9UIQ2i06DpTCiI/qoUaGe3VaeyBpfkJxy6G
         K2HOfFevSq9vO0ISBtocxN31K6DYZqQ6PYReRHxz/3ggSOuMVMowcD50jNlnzR71qd+K
         I7J9MWgjpJFVBIsjGUuyaFcPrFfdU9cKRl9s5mZz1/imzdmY4xveMFmZizf9uboHDa2z
         TXzI2eeARmf7ro52IeLP5AFwMQLxwo52cQjfUjCyy95iYftD6ZQMa4uSLMcb3k9B6P15
         ezTg==
X-Gm-Message-State: AJcUukf5Cow77dGrdYf58qgchigymbDseBJSHJlzW56nNNOLJT0rHNHu
        OQdEUymi7j8QxpGe9gHWSViIdw==
X-Google-Smtp-Source: ALg8bN6F1SrvP3hDND0CgTs/xEdz/aHO0BBF2GtC8s//SqMHOdsjCtRMrDq3IzD4yu8TR1dGtv+ffw==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr1810224pls.230.1547520967136;
        Mon, 14 Jan 2019 18:56:07 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:56:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/16] io_uring: add file registration
Date:   Mon, 14 Jan 2019 19:55:30 -0700
Message-Id: <20190115025531.13985-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We normally have to fget/fput for each IO we do on a file. Even with
the batching we do, this atomic inc/dec cost adds up.

This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
for the io_uring_register(2) system call. Pass in an array of fds
that are in use by the application, and we'll fget these for the
duration of the io_uring context.

When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
to the index in the array passed in to IORING_REGISTER_FILES.

Files are automatically unregistered when the io_uring context is
torn down. An application need only unregister if it wishes to
register a few set of fds.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 135 +++++++++++++++++++++++++++++-----
 include/uapi/linux/io_uring.h |  17 ++++-
 2 files changed, 131 insertions(+), 21 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6df5da8b5259..fd89fcecd8e2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -97,6 +97,10 @@ struct io_ring_ctx {
 	struct files_struct	*sqo_files;
 	wait_queue_head_t	sqo_wait;
 
+	/* if used, fixed file set */
+	struct file		**user_files;
+	unsigned		nr_user_files;
+
 	/* if used, fixed mapped user buffers */
 	unsigned		nr_user_bufs;
 	struct io_mapped_ubuf	*user_bufs;
@@ -137,6 +141,7 @@ struct io_kiocb {
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
+#define REQ_F_FIXED_FILE	8	/* ctx owns file */
 	u64			user_data;
 	u64			res;
 };
@@ -391,15 +396,17 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		 * Batched puts of the same file, to avoid dirtying the
 		 * file usage count multiple times, if avoidable.
 		 */
-		if (!file) {
-			file = req->rw.ki_filp;
-			file_count = 1;
-		} else if (file == req->rw.ki_filp) {
-			file_count++;
-		} else {
-			fput_many(file, file_count);
-			file = req->rw.ki_filp;
-			file_count = 1;
+		if (!(req->flags & REQ_F_FIXED_FILE)) {
+			if (!file) {
+				file = req->rw.ki_filp;
+				file_count = 1;
+			} else if (file == req->rw.ki_filp) {
+				file_count++;
+			} else {
+				fput_many(file, file_count);
+				file = req->rw.ki_filp;
+				file_count = 1;
+			}
 		}
 
 		if (to_free == ARRAY_SIZE(reqs))
@@ -530,13 +537,19 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
+static void io_fput(struct io_kiocb *req)
+{
+	if (!(req->flags & REQ_F_FIXED_FILE))
+		fput(req->rw.ki_filp);
+}
+
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	kiocb_end_write(kiocb);
 
-	fput(kiocb->ki_filp);
+	io_fput(req);
 	io_cqring_fill_event(req->ctx, req->user_data, res, 0);
 	io_free_req(req);
 }
@@ -646,7 +659,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
-	kiocb->ki_filp = io_file_get(state, sqe->fd);
+	if (unlikely(sqe->flags & ~IOSQE_FIXED_FILE))
+		return -EINVAL;
+
+	if (sqe->flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+			return -EBADF;
+		kiocb->ki_filp = ctx->user_files[sqe->fd];
+		req->flags |= REQ_F_FIXED_FILE;
+	} else {
+		kiocb->ki_filp = io_file_get(state, sqe->fd);
+	}
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = sqe->off;
@@ -685,7 +708,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	io_file_put(state, kiocb->ki_filp);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -801,7 +825,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -855,7 +879,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -888,19 +912,30 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
+	if (unlikely(sqe->flags & ~IOSQE_FIXED_FILE))
+		return -EINVAL;
 	if (unlikely(sqe->addr))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
 		return -EINVAL;
 
-	file = fget(sqe->fd);
+	if (sqe->flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+			return -EBADF;
+		file = ctx->user_files[sqe->fd];
+	} else {
+		file = fget(sqe->fd);
+	}
+
 	if (unlikely(!file))
 		return -EBADF;
 
 	ret = vfs_fsync_range(file, sqe->off, end > 0 ? end : LLONG_MAX,
 			sqe->fsync_flags & IORING_FSYNC_DATASYNC);
 
-	fput(file);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		fput(file);
+
 	io_cqring_fill_event(ctx, sqe->user_data, ret, 0);
 	io_free_req(req);
 	return 0;
@@ -913,10 +948,6 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	const struct io_uring_sqe *sqe = s->sqe;
 	ssize_t ret;
 
-	/* enforce forwards compatibility on users */
-	if (unlikely(sqe->flags))
-		return -EINVAL;
-
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
 	req->user_data = sqe->user_data;
@@ -1375,6 +1406,54 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	return ret;
 }
 
+static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
+{
+	int i;
+
+	if (!ctx->user_files)
+		return -EINVAL;
+
+	for (i = 0; i < ctx->nr_user_files; i++)
+		fput(ctx->user_files[i]);
+
+	kfree(ctx->user_files);
+	ctx->user_files = NULL;
+	ctx->nr_user_files = 0;
+	return 0;
+}
+
+static int io_sqe_files_register(struct io_ring_ctx *ctx,
+				 struct io_uring_register_files *reg)
+{
+	int fd, i, ret = 0;
+
+	ctx->user_files = kcalloc(reg->nr_fds, sizeof(struct file *),
+					GFP_KERNEL);
+	if (!ctx->user_files)
+		return -ENOMEM;
+
+	for (i = 0; i < reg->nr_fds; i++) {
+		__s32 __user *src = (__s32 __user *) &reg->fds[i];
+
+		ret = -EFAULT;
+		if (copy_from_user(&fd, src, sizeof(fd)))
+			break;
+
+		ctx->user_files[i] = fget(fd);
+
+		ret = -EBADF;
+		if (!ctx->user_files[i])
+			break;
+		ctx->nr_user_files++;
+		ret = 0;
+	}
+
+	if (ret)
+		io_sqe_files_unregister(ctx);
+
+	return ret;
+}
+
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
@@ -1647,6 +1726,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_files_unregister(ctx);
 	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -1922,6 +2002,21 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_sqe_buffer_unregister(ctx);
 		break;
+	case IORING_REGISTER_FILES: {
+		struct io_uring_register_files reg;
+
+		ret = -EFAULT;
+		if (copy_from_user(&reg, arg, sizeof(reg)))
+			break;
+		ret = io_sqe_files_register(ctx, &reg);
+		break;
+		}
+	case IORING_UNREGISTER_FILES:
+		ret = -EINVAL;
+		if (arg)
+			break;
+		ret = io_sqe_files_unregister(ctx);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index cb075971d8fb..3f367be56a9e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -16,7 +16,7 @@
  */
 struct io_uring_sqe {
 	__u8	opcode;		/* type of operation for this sqe */
-	__u8	flags;		/* as of now unused */
+	__u8	flags;		/* IOSQE_ flags */
 	__u16	ioprio;		/* ioprio for the request */
 	__s32	fd;		/* file descriptor to do IO on */
 	__u64	off;		/* offset into file */
@@ -36,6 +36,11 @@ struct io_uring_sqe {
 	};
 };
 
+/*
+ * sqe->flags
+ */
+#define IOSQE_FIXED_FILE	(1 << 0)	/* use fixed fileset */
+
 /*
  * io_uring_setup() flags
  */
@@ -123,6 +128,8 @@ struct io_uring_params {
  */
 #define IORING_REGISTER_BUFFERS		0
 #define IORING_UNREGISTER_BUFFERS	1
+#define IORING_REGISTER_FILES		2
+#define IORING_UNREGISTER_FILES		3
 
 struct io_uring_register_buffers {
 	union {
@@ -132,4 +139,12 @@ struct io_uring_register_buffers {
 	__u32 nr_iovecs;
 };
 
+struct io_uring_register_files {
+	union {
+		__s32 *fds;
+		__u64 pad;
+	};
+	__u32 nr_fds;
+};
+
 #endif
-- 
2.17.1

