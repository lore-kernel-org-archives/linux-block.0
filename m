Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435F3C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076FF21738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SyhX9X+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1VgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:36:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40445 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfA1VgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:36:09 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so14794673iog.7
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/XAr2vyV/XHvX/9ZvYRHh4DpAQkfq6Eiqq81E9nEzY=;
        b=SyhX9X+n218cgFR7enjSGB3W0TbM28l/qNssiXkat9aTdgBKi3IdpeS3vLDaXwvFdO
         WooTGJMAi0TsEKowosnt6sxVo1iLcjDlZRdLdi8ywFCrU4w0sfay4KnHJuFJ5NJHO2EM
         qu1VX76DROrlyXcVkI3+oJSIPJ83oCwxBb+ckVwTa3eR/zyMkT48pB8yBkh7tBJ65fIj
         FHZ7Oi0oZjT5cb6nbr+AGSkQfihisXHaoOZHVBGKRnrokNiXVuCKnnnoZzXZg7W67vvE
         PDLBDHNCHDBN9qtQsRNopRNw0KJ++4HQ5ikoenukGGrDV76plMPqKboBuaaavq2TsaHq
         aFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/XAr2vyV/XHvX/9ZvYRHh4DpAQkfq6Eiqq81E9nEzY=;
        b=UETcxnksT2zfCre+eH5K9UGZ1mIzKb8uQ0ZUuJvIijOLx73ZzRpI6Gkr3PbP+8E1v7
         05juBP3hsy157Ae5hStMIRNYT8Xe/0M4ZnxTne1FYhbFmFNAzrtlUQduoGOW6II2Ob4V
         IuZErxGjNPd3x4vDFe8F3L0gvPSzOxukwWRnBCD/b3ATPnzmv5jHlcnViaPYAl81zJOh
         jj53yUvrXlksPWOFxe9a5lh/scFBx6ISFXDj5jKjr5EQdHohxNONJycxRMnNDYGb4MSD
         4VVSb4Qy9vjbcc8a2Fqr+596KlTGMA0jtRslNgDyRS+hEEF/7sT/FtMf2I6AotfDUMC/
         74kw==
X-Gm-Message-State: AHQUAuYgXzzaZmqjxH395XHKQMEBUeLtVlgbRCBJqYuBWP5K/dgoLzRO
        fCzcHMQWnVCrkF3MMzI8izIiZA==
X-Google-Smtp-Source: AHgI3IZC5UAIcOecQAYB4DjC3NLQBzhcSy7h1IjsVrKvP1DZhu68OMXd54UHKTgGsmvWk8nfD3zp+g==
X-Received: by 2002:a6b:f404:: with SMTP id i4mr12396586iog.281.1548711367827;
        Mon, 28 Jan 2019 13:36:07 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:36:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/18] io_uring: add file set registration
Date:   Mon, 28 Jan 2019 14:35:33 -0700
Message-Id: <20190128213538.13486-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We normally have to fget/fput for each IO we do on a file. Even with
the batching we do, the cost of the atomic inc/dec of the file usage
count adds up.

This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
for the io_uring_register(2) system call. The arguments passed in must
be an array of __s32 holding file descriptors, and nr_args should hold
the number of file descriptors the application wishes to pin for the
duration of the io_uring context (or until IORING_UNREGISTER_FILES is
called).

When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
to the index in the array passed in to IORING_REGISTER_FILES.

Files are automatically unregistered when the io_uring context is
torn down. An application need only unregister if it wishes to
register a few set of fds.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 125 +++++++++++++++++++++++++++++-----
 include/uapi/linux/io_uring.h |   9 ++-
 2 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 682714d6f217..77993972879b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -98,6 +98,10 @@ struct io_ring_ctx {
 		struct fasync_struct	*cq_fasync;
 	} ____cacheline_aligned_in_smp;
 
+	/* if used, fixed file set */
+	struct file		**user_files;
+	unsigned		nr_user_files;
+
 	/* if used, fixed mapped user buffers */
 	unsigned		nr_user_bufs;
 	struct io_mapped_ubuf	*user_bufs;
@@ -135,6 +139,7 @@ struct io_kiocb {
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
+#define REQ_F_FIXED_FILE	8	/* ctx owns file */
 	u64			user_data;
 	u64			res;
 
@@ -357,15 +362,17 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -502,13 +509,19 @@ static void kiocb_end_write(struct kiocb *kiocb)
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
 	io_cqring_add_event(req->ctx, req->user_data, res, 0);
 	io_free_req(req);
 }
@@ -612,7 +625,14 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct kiocb *kiocb = &req->rw;
 	int ret;
 
-	kiocb->ki_filp = io_file_get(state, sqe->fd);
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
@@ -651,7 +671,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	io_file_put(state, kiocb->ki_filp);
+	if (!(sqe->flags & IOSQE_FIXED_FILE))
+		io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
 
@@ -769,7 +790,7 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -824,7 +845,7 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	kfree(iovec);
 out_fput:
 	if (unlikely(ret))
-		fput(file);
+		io_fput(req);
 	return ret;
 }
 
@@ -862,14 +883,23 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
 	io_cqring_add_event(ctx, sqe->user_data, ret, 0);
 	io_free_req(req);
 	return 0;
@@ -987,7 +1017,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(s->sqe->flags))
+	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
 		return -EINVAL;
 
 	req = io_get_req(ctx, state);
@@ -1195,6 +1225,57 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	return submitted ? submitted : ret;
 }
 
+static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
+{
+	int i;
+
+	if (!ctx->user_files)
+		return -ENXIO;
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
+static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
+				 unsigned nr_args)
+{
+	__s32 __user *fds = (__s32 __user *) arg;
+	int fd, i, ret = 0;
+
+	if (ctx->user_files)
+		return -EBUSY;
+	if (!nr_args)
+		return -EINVAL;
+
+	ctx->user_files = kcalloc(nr_args, sizeof(struct file *), GFP_KERNEL);
+	if (!ctx->user_files)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_args; i++) {
+		ret = -EFAULT;
+		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
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
 static int io_sq_offload_start(struct io_ring_ctx *ctx)
 {
 	int ret;
@@ -1482,6 +1563,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	destroy_workqueue(ctx->sqo_wq);
 	io_iopoll_reap_events(ctx);
 	io_sqe_buffer_unregister(ctx);
+	io_sqe_files_unregister(ctx);
 
 	io_mem_free(ctx->sq_ring);
 	io_mem_free(ctx->sq_sqes);
@@ -1777,6 +1859,15 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_sqe_buffer_unregister(ctx);
 		break;
+	case IORING_REGISTER_FILES:
+		ret = io_sqe_files_register(ctx, arg, nr_args);
+		break;
+	case IORING_UNREGISTER_FILES:
+		ret = -EINVAL;
+		if (arg || nr_args)
+			break;
+		ret = io_sqe_files_unregister(ctx);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 03ce7133c3b2..8323320077ec 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -18,7 +18,7 @@
  */
 struct io_uring_sqe {
 	__u8	opcode;		/* type of operation for this sqe */
-	__u8	flags;		/* as of now unused */
+	__u8	flags;		/* IOSQE_ flags */
 	__u16	ioprio;		/* ioprio for the request */
 	__s32	fd;		/* file descriptor to do IO on */
 	__u64	off;		/* offset into file */
@@ -35,6 +35,11 @@ struct io_uring_sqe {
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
@@ -114,5 +119,7 @@ struct io_uring_params {
  */
 #define IORING_REGISTER_BUFFERS		0
 #define IORING_UNREGISTER_BUFFERS	1
+#define IORING_REGISTER_FILES		2
+#define IORING_UNREGISTER_FILES		3
 
 #endif
-- 
2.17.1

