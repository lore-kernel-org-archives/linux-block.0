Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8313D61107
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJ1L1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:27:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:57642 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhJ1L1B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 07:27:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2C7D64616B;
        Thu, 28 Oct 2021 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1635420271; x=1637234672; bh=8Be58/dAPBmvYIlI3IDXDz0Dc4G9SVTmLL1
        LsMKwS+I=; b=tnz85F+YVu48KgFtF+oegooA0PZDODAkmdrpfJ+5IgaP8aJU156
        LYrdkEZmGWKs46RtgZyEEN89wNjIPX8CaW7S+hKrxuWNu/Zcj4gZ5UzCUDFi9Ew7
        fASKuKxRWq9GrT1QMZfkhr8WDEBK1LtJuf4CcjORFdPSic3qIVQSnMb0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z1fD6xYj8AEw; Thu, 28 Oct 2021 14:24:31 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BDF9246179;
        Thu, 28 Oct 2021 14:24:30 +0300 (MSK)
Received: from localhost.localdomain (10.199.10.99) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 28 Oct 2021 14:24:29 +0300
From:   "Alexander V. Buev" <a.buev@yadro.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>,
        "Alexander V. Buev" <a.buev@yadro.com>
Subject: [PATCH 2/3] block: io_uring: add IO_WITH_PI flag to SQE
Date:   Thu, 28 Oct 2021 14:24:05 +0300
Message-ID: <20211028112406.101314-3-a.buev@yadro.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028112406.101314-1-a.buev@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.10.99]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add new IOSQE_IO_WITH_PI flag to sqe struct flags.
Add IOCB_USE_PI flag to kiocb struct flags.
Correct range checking at uring layer in case of
READV/WRITEV operations with IOCB_USE_PI.

Based on: https://patchwork.kernel.org/patch/11405557/

Signed-off-by: Alexander V. Buev <a.buev@yadro.com>
---
 fs/io_uring.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fs.h            |  1 +
 include/uapi/linux/io_uring.h |  3 +++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bc18af5e0a93..bce8488fb849 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -105,7 +105,7 @@
 
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK|	\
 				IOSQE_IO_HARDLINK | IOSQE_ASYNC | \
-				IOSQE_BUFFER_SELECT)
+				IOSQE_BUFFER_SELECT | IOSQE_IO_WITH_PI)
 #define IO_REQ_CLEAN_FLAGS (REQ_F_BUFFER_SELECTED | REQ_F_NEED_CLEANUP | \
 				REQ_F_POLLED | REQ_F_INFLIGHT | REQ_F_CREDS)
 
@@ -726,6 +726,7 @@ enum {
 	REQ_F_HARDLINK_BIT	= IOSQE_IO_HARDLINK_BIT,
 	REQ_F_FORCE_ASYNC_BIT	= IOSQE_ASYNC_BIT,
 	REQ_F_BUFFER_SELECT_BIT	= IOSQE_BUFFER_SELECT_BIT,
+	REQ_F_IO_WITH_PI_BIT    = IOSQE_IO_WITH_PI_BIT,
 
 	/* first byte is taken by user flags, shift it to not overlap */
 	REQ_F_FAIL_BIT		= 8,
@@ -2850,6 +2851,13 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (unlikely(ret))
 		return ret;
 
+	if (sqe->flags & IOSQE_IO_WITH_PI) {
+		if (!(req->file->f_flags & O_DIRECT))
+			return -EINVAL;
+
+		kiocb->ki_flags |= IOCB_USE_PI;
+	}
+
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
 	 * supports async. Otherwise it's impossible to use O_NONBLOCK files
@@ -3451,6 +3459,7 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	struct iov_iter_state __state, *state;
 	ssize_t ret, ret2;
+	size_t iov_data_size;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3483,7 +3492,15 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		return ret ?: -EAGAIN;
 	}
 
-	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), req->result);
+	iov_data_size = req->result;
+	/* in case of PI present we must verify ranges only by data size */
+	if (req->opcode == IORING_OP_READV &&
+	     kiocb->ki_flags & IOCB_USE_PI &&
+	     iter->nr_segs >= 2) {
+		iov_data_size -= iter->iov[iter->nr_segs-1].iov_len;
+	}
+
+	ret = rw_verify_area(READ, req->file, io_kiocb_ppos(kiocb), iov_data_size);
 	if (unlikely(ret)) {
 		kfree(iovec);
 		return ret;
@@ -3586,6 +3603,7 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	struct iov_iter_state __state, *state;
 	ssize_t ret, ret2;
+	size_t iov_data_size;
 
 	if (rw) {
 		iter = &rw->iter;
@@ -3616,7 +3634,15 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	    (req->flags & REQ_F_ISREG))
 		goto copy_iov;
 
-	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), req->result);
+	iov_data_size = req->result;
+	/* in case of PI present we must verify ranges only by data size */
+	if (req->opcode == IORING_OP_WRITEV &&
+	     kiocb->ki_flags & IOCB_USE_PI &&
+	     iter->nr_segs >= 2) {
+		iov_data_size -= iter->iov[iter->nr_segs-1].iov_len;
+	}
+
+	ret = rw_verify_area(WRITE, req->file, io_kiocb_ppos(kiocb), iov_data_size);
 	if (unlikely(ret))
 		goto out_free;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..874afc7bc28b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -321,6 +321,7 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+#define IOCB_USE_PI		(1 << 22)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b270a07b285e..6b2dd4449ea5 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -70,6 +70,7 @@ enum {
 	IOSQE_IO_HARDLINK_BIT,
 	IOSQE_ASYNC_BIT,
 	IOSQE_BUFFER_SELECT_BIT,
+	IOSQE_IO_WITH_PI_BIT,
 };
 
 /*
@@ -87,6 +88,8 @@ enum {
 #define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
 /* select buffer from sqe->buf_group */
 #define IOSQE_BUFFER_SELECT	(1U << IOSQE_BUFFER_SELECT_BIT)
+/* perform IO with PI (protection information) */
+#define IOSQE_IO_WITH_PI	(1U << IOSQE_IO_WITH_PI_BIT)
 
 /*
  * io_uring_setup() flags
-- 
2.33.0

