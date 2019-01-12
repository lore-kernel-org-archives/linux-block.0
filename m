Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FAC43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A336F2084C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B941y95G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfALVat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46383 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfALVas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so8543386pfe.13
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AW7jsIB6hNhqzBATRVyZlWxRkDXvAdFtbb95X+jyjmo=;
        b=B941y95GgMIADycRcE44Rk58D82fKFMpV+hUFgg3aRbhPofanzduRmenlpsRr9Kqhs
         xA+kFmktWCf+18x6/usAkBK0iAlu1/KaCN17i7pV5psxxDybo9XVfrEtiCcscUzBDZC6
         qJi5cvePD3/1a44saLuy2tlqPbAHq1wjzZ9DhvA+RQmkbgcMqqovevXcpnoOGeXgUil2
         boGyb4BJmv/8teAVGXtIWeWjKJUtyuYqMZY6cLe3Xlj0sgc4fsdabg5VlcETzFMIUHGO
         iz+lyBzQyLmev/YH+srcvfm/aIxeKnmEwMqEGyaYwV7t2cStbS5zHuJHJaOcI01jC+0f
         qE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AW7jsIB6hNhqzBATRVyZlWxRkDXvAdFtbb95X+jyjmo=;
        b=hfVTqWFWX8u4d2Cs7m7OfbytcUqNxLx4QtG+YMEd2fvFHlzGMYR+7ua5Jg1gWbp+fy
         LBJxW+JyxedRx027N4QiHejuBDKHhkcXvJ9AoFiYdFGs8GF5do1pzMguQKSXMpHND/rr
         iJ8ewEwpAiJ+YFDoJeG+7lTIac/09JPv2PuRW8MwvOksMAhMuwkOyDq4XEYbRBk43nad
         zHkj79B+BpHmXYepf/F9J7VV39qaJInlnHDSblsODh5QSSSz3HhAOJO8RNyADYa7AGqy
         dxejy56SVjSYqb0Z1FMIja5Uv5W1JUzXbRfLt9ZigYxmKaq2b74FEnfcbUWKJJTO4vLo
         GkHg==
X-Gm-Message-State: AJcUukfXVO4ZKnnonkUnvolGP2qzgr6qGnGDUO/iWXFYGeJLh04bznLe
        0moA9zUbGMO0LEJhUyf6PYtrrw==
X-Google-Smtp-Source: ALg8bN7CJCZRLqA34VAoQHkLAyT9qeyJtUt5brK1P2LWiWnaAOgSU+j7wk+VcgfAAh3GHpX0yBSdmw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr15596830pge.130.1547328647672;
        Sat, 12 Jan 2019 13:30:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/16] io_uring: add file registration
Date:   Sat, 12 Jan 2019 14:30:10 -0700
Message-Id: <20190112213011.1439-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 131 +++++++++++++++++++++++++++++-----
 include/uapi/linux/io_uring.h |  14 +++-
 2 files changed, 127 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6f446d13b3d4..66a76f9fa7af 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -99,6 +99,10 @@ struct io_ring_ctx {
 	struct io_mapped_ubuf	*user_bufs;
 	unsigned		nr_user_bufs;
 
+	/* if used, fixed file set */
+	struct file		**user_files;
+	unsigned		nr_user_files;
+
 	struct completion	ctx_done;
 
 	/* iopoll submission state */
@@ -137,6 +141,7 @@ struct io_kiocb {
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
+#define REQ_F_FIXED_FILE	8	/* ctx owns file */
 	u64			ki_user_data;
 };
 
@@ -355,15 +360,17 @@ static void io_iopoll_reap(struct io_ring_ctx *ctx, unsigned int *nr_events)
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
+		if (!(req->ki_flags & REQ_F_FIXED_FILE)) {
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
 
 		(*nr_events)++;
@@ -557,13 +564,19 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		wake_up(&ctx->wait);
 }
 
+static void io_fput(struct io_kiocb *req)
+{
+	if (!(req->ki_flags & REQ_F_FIXED_FILE))
+		fput(req->rw.ki_filp);
+}
+
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	kiocb_end_write(kiocb);
 
-	fput(kiocb->ki_filp);
+	io_fput(req);
 	io_cqring_fill_event(req->ki_ctx, req->ki_user_data, res, 0);
 	io_free_req(req);
 }
@@ -680,7 +693,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
+		req->ki_flags |= REQ_F_FIXED_FILE;
+	} else {
+		kiocb->ki_filp = io_file_get(state, sqe->fd);
+	}
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
 	kiocb->ki_pos = sqe->off;
@@ -719,7 +742,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	io_file_put(state, kiocb->ki_filp);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -822,7 +846,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -884,7 +908,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -902,19 +926,30 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ki_ctx->flags & IORING_SETUP_IOPOLL))
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
@@ -928,7 +963,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(sqe->flags || sqe->__pad2 || sqe->__pad3))
+	if (unlikely(sqe->__pad2 || sqe->__pad3))
 		return -EINVAL;
 
 	if (unlikely(s->index >= ctx->sq_entries))
@@ -1394,6 +1429,52 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
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
+		ret = -EFAULT;
+		if (copy_from_user(&fd, &reg->fds[i], sizeof(fd)))
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
@@ -1615,6 +1696,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_files_unregister(ctx);
 	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
@@ -1871,6 +1953,21 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
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
index 7f9be0bd84ed..ffdaf46f19dd 100644
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
@@ -35,6 +35,11 @@ struct io_uring_sqe {
 	__u64	user_data;	/* data to be passed back at completion time */
 };
 
+/*
+ * sqe->flags
+ */
+#define IOSQE_FIXED_FILE	(1 << 0)	/* use fixed fileset */
+
 /*
  * io_uring_setup() flags
  */
@@ -121,10 +126,17 @@ struct io_uring_params {
  */
 #define IORING_REGISTER_BUFFERS		0
 #define IORING_UNREGISTER_BUFFERS	1
+#define IORING_REGISTER_FILES		2
+#define IORING_UNREGISTER_FILES		3
 
 struct io_uring_register_buffers {
 	struct iovec *iovecs;
 	__u32 nr_iovecs;
 };
 
+struct io_uring_register_files {
+	__s32 *fds;
+	__u32 nr_fds;
+};
+
 #endif
-- 
2.17.1

