Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E69C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128B02145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PF6DjIKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128B02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeLAEHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39320 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:07 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so10218366itl.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZTxn1zH/8CPF8nHBpvAZQPHd/ePx+TIdDehIsUuIw4=;
        b=PF6DjIKPcdZe1CBhbS6eeoI6rDzt1xIY1lMVAhkjZc2kK6cIgRUv+ge1JZkHY5iLHQ
         0aTFMKYBtuFWjAwlouTgK2XuF4PIMBHBQB4EgTM5sYP5yUY/mvyMZOspVLA5dvSpN2EX
         qzvEj3XhXRaxpTsrfUqKSkMBcIgsuYdikHuuTaImMl4V9RRdyVuOB5Jf6ssAg+6e4ND+
         zFc6y1PsRr+lLU3gOcXL5lKhkEJlrj6CcAWmzRHFaKxBG9H2wfr8O+edPp2j4jWCA/Pa
         7CLa+5WSiAYWjUzo6tTriwB4r6PCdNTGPXD0gEitpHm46cDSUb75QNRJ3+2EyJ1eoenh
         OrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZTxn1zH/8CPF8nHBpvAZQPHd/ePx+TIdDehIsUuIw4=;
        b=IJPAtrIRC0KExdwS/aquTRaz0CP0xjksveZUv8m+oxfc+Ii91krqgXN9Q9pejt1co4
         7rIvrLAqhVc0GG0z0A1Wq5zHQj5aJ33R3TGX6LbhbyEEEZJyaiWXdi0NJYONukGujQB6
         cByIM6NwmYNuiiFYdSeAi440Qyi2EE9yvLdzb6i6JRKxILQM2zEPJ8bkPW0Tp7ZWE0BR
         yXbSvTvyb0HNFMOk0HwdJseoYPh+td0Np4FjQnKO259cQg9pKHBQx3jD0C+Ut1iYmC7M
         lRWNiZSijg1dopOgn4dt5IwD51m0SIaEMSl5w4/ZFpUx6yhiT7EcecZUIT68SXyWZuih
         QV+A==
X-Gm-Message-State: AA+aEWb0U+Np5UgeFuPlZT6JrUkuWjPrVl6nAQG0rkm0ViCcPPJhm3dW
        o05yF03jUyRnvZ+XV4I2rgkglHGKh9c=
X-Google-Smtp-Source: AFSGD/XQJvlN3HNzAc9gngyQfLrMfsCydzu0/WcespMZxacupaztQVkZDsYMOi+LAED00YfgM5Uh2Q==
X-Received: by 2002:a02:284:: with SMTP id 126mr5931001jau.47.1543597030497;
        Fri, 30 Nov 2018 08:57:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/27] aio: split out iocb copy from io_submit_one()
Date:   Fri, 30 Nov 2018 09:56:32 -0700
Message-Id: <20181130165646.27341-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation of handing in iocbs in a different fashion as well. Also
make it clear that the iocb being passed in isn't modified, by marking
it const throughout.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 68 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e8457f9486e3..ba5758c854e8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1414,7 +1414,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	aio_complete(iocb, res, res2);
 }
 
-static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
+static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 {
 	int ret;
 
@@ -1455,7 +1455,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 	return ret;
 }
 
-static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
+static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
 		bool vectored, bool compat, struct iov_iter *iter)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
@@ -1494,8 +1494,8 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
-static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
+			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1527,8 +1527,8 @@ static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
 	return ret;
 }
 
-static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
+			 bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1583,7 +1583,8 @@ static void aio_fsync_work(struct work_struct *work)
 	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
 }
 
-static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
+static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
+		     bool datasync)
 {
 	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
 			iocb->aio_rw_flags))
@@ -1711,7 +1712,7 @@ aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->iocb->poll.wait);
 }
 
-static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 {
 	struct kioctx *ctx = aiocb->ki_ctx;
 	struct poll_iocb *req = &aiocb->poll;
@@ -1783,27 +1784,23 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
 	return 0;
 }
 
-static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 bool compat)
+static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
+			   struct iocb __user *user_iocb, bool compat)
 {
 	struct aio_kiocb *req;
-	struct iocb iocb;
 	ssize_t ret;
 
-	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
-		return -EFAULT;
-
 	/* enforce forwards compatibility on users */
-	if (unlikely(iocb.aio_reserved2)) {
+	if (unlikely(iocb->aio_reserved2)) {
 		pr_debug("EINVAL: reserve field set\n");
 		return -EINVAL;
 	}
 
 	/* prevent overflows */
 	if (unlikely(
-	    (iocb.aio_buf != (unsigned long)iocb.aio_buf) ||
-	    (iocb.aio_nbytes != (size_t)iocb.aio_nbytes) ||
-	    ((ssize_t)iocb.aio_nbytes < 0)
+	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
+	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
+	    ((ssize_t)iocb->aio_nbytes < 0)
 	   )) {
 		pr_debug("EINVAL: overflow check\n");
 		return -EINVAL;
@@ -1817,14 +1814,14 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
-	if (iocb.aio_flags & IOCB_FLAG_RESFD) {
+	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
 		/*
 		 * If the IOCB_FLAG_RESFD flag of aio_flags is set, get an
 		 * instance of the file* now. The file descriptor must be
 		 * an eventfd() fd, and will be signaled for each completed
 		 * event using the eventfd_signal() function.
 		 */
-		req->ki_eventfd = eventfd_ctx_fdget((int) iocb.aio_resfd);
+		req->ki_eventfd = eventfd_ctx_fdget((int) iocb->aio_resfd);
 		if (IS_ERR(req->ki_eventfd)) {
 			ret = PTR_ERR(req->ki_eventfd);
 			req->ki_eventfd = NULL;
@@ -1839,32 +1836,32 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	}
 
 	req->ki_user_iocb = user_iocb;
-	req->ki_user_data = iocb.aio_data;
+	req->ki_user_data = iocb->aio_data;
 
-	switch (iocb.aio_lio_opcode) {
+	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(&req->rw, &iocb, false, compat);
+		ret = aio_read(&req->rw, iocb, false, compat);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(&req->rw, &iocb, false, compat);
+		ret = aio_write(&req->rw, iocb, false, compat);
 		break;
 	case IOCB_CMD_PREADV:
-		ret = aio_read(&req->rw, &iocb, true, compat);
+		ret = aio_read(&req->rw, iocb, true, compat);
 		break;
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(&req->rw, &iocb, true, compat);
+		ret = aio_write(&req->rw, iocb, true, compat);
 		break;
 	case IOCB_CMD_FSYNC:
-		ret = aio_fsync(&req->fsync, &iocb, false);
+		ret = aio_fsync(&req->fsync, iocb, false);
 		break;
 	case IOCB_CMD_FDSYNC:
-		ret = aio_fsync(&req->fsync, &iocb, true);
+		ret = aio_fsync(&req->fsync, iocb, true);
 		break;
 	case IOCB_CMD_POLL:
-		ret = aio_poll(req, &iocb);
+		ret = aio_poll(req, iocb);
 		break;
 	default:
-		pr_debug("invalid aio operation %d\n", iocb.aio_lio_opcode);
+		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
 		ret = -EINVAL;
 		break;
 	}
@@ -1886,6 +1883,17 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	return ret;
 }
 
+static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
+			 bool compat)
+{
+	struct iocb iocb;
+
+	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
+		return -EFAULT;
+
+	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+}
+
 /*
  * Plugging is meant to work with larger batches of IOs. If we don't
  * have more than the below, then don't bother setting up a plug.
-- 
2.17.1

