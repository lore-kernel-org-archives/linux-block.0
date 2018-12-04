Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D83C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E037720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ham/5gv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E037720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLDXiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37141 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLDXiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so9090385plr.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjXjGJpzxG4sQV1Ooff1P7NVDuSBRD7W2guw+LhTNUo=;
        b=Ham/5gv2xLuPADAHF5xChPpcYg9sAWSUG37GpArjNIWoqeQCp08uH+aQopZnY82gHB
         PKCYhKQan5Qbl+ubZKdR+HV3G3DGm6Oh7ji5wOTKECNjb7+tUunokcsV24Qx6xzNsZBD
         iZUcYI+1mobfx/C7b0+zJPHQi45ke7U18DuRvM/1jmQ5Uy3WGe8e74s8n1BoZRNNmGoe
         gIwJjfPEiO+ofAldZx308hFdmh9XHT5RQYDbzL2WDp+qBAPdUPlJGagsY4C3LR5iKfaQ
         myH+G/GUqGyMCdqzGAoRyxp/aiYzfY1O2KNYCH/KYx3Y837SPCmkbhDWPZU9D69YQB6F
         3LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjXjGJpzxG4sQV1Ooff1P7NVDuSBRD7W2guw+LhTNUo=;
        b=R0wFr+LCqPf9O6fKJqlwdyj6XgN758ndu4giL4KgoTg9Nn5YQMZGy64w4AIFovPB+n
         APkfpkKCUhXc3wf5CPBrOuOARAgNx3P8JQ/kLoHkrY2vTEJuxeBT1e7YR0IWvtytR7CU
         ccxWH0MpzZB1ObysN5kuPmDCVgOggtymfxRufAxVSbdv2EElm+dTXmHhRzxETuwWZzKX
         0+oJm1vxsdAKdwqCYkaBHx4/U/ierODnrGrGOEVBmsbieX2GENfwtfcukB27Djw5vgwY
         lNyJc2Uma8vtm1wOSvz/EhnzyKH2yKWKupLl2R4DeuhT1EEESICps6v45mxA8BOYk2TT
         gsXQ==
X-Gm-Message-State: AA+aEWbxOlcLnqJ60bKvrT1KA94a9/Dugk0o2IFMwZKaXVuorywXvfFn
        b1K6BI6dwz9kxFSpZxSD0KhMh/EhnXk=
X-Google-Smtp-Source: AFSGD/Ui3ZeGiirUXpj5J6naNTcOnb2Pdkc7dwerpON9tBL2WJnQvo0vdIuGmvMKsZefrfvh5Etgxg==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr21406695pls.71.1543966681410;
        Tue, 04 Dec 2018 15:38:01 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/26] aio: split out iocb copy from io_submit_one()
Date:   Tue,  4 Dec 2018 16:37:14 -0700
Message-Id: <20181204233729.26776-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index cf93b92bfb1e..06c8bcc72496 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1420,7 +1420,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 	aio_complete(iocb, res, res2);
 }
 
-static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
+static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 {
 	int ret;
 
@@ -1461,7 +1461,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 	return ret;
 }
 
-static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
+static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
 		bool vectored, bool compat, struct iov_iter *iter)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
@@ -1500,8 +1500,8 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
-static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
+			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1533,8 +1533,8 @@ static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
 	return ret;
 }
 
-static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
-		bool compat)
+static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
+			 bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1589,7 +1589,8 @@ static void aio_fsync_work(struct work_struct *work)
 	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
 }
 
-static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
+static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
+		     bool datasync)
 {
 	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
 			iocb->aio_rw_flags))
@@ -1717,7 +1718,7 @@ aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->iocb->poll.wait);
 }
 
-static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 {
 	struct kioctx *ctx = aiocb->ki_ctx;
 	struct poll_iocb *req = &aiocb->poll;
@@ -1789,27 +1790,23 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
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
@@ -1823,14 +1820,14 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -1845,32 +1842,32 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -1892,6 +1889,17 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
 /* sys_io_submit:
  *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
  *	the number of iocbs queued.  May return -EINVAL if the aio_context
-- 
2.17.1

