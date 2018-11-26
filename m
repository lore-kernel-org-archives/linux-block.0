Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA4C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE6820659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="twSTElw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE6820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeK0Dkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39107 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeK0Dkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:53 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so28747763itl.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZTxn1zH/8CPF8nHBpvAZQPHd/ePx+TIdDehIsUuIw4=;
        b=twSTElw0XBXHI+TBUuoeQhhzB44s8bN7TWF1ai59+6+lJRxcPmTYBV9AUMPs56RZ5l
         8S8ud2EQino2u7l5kp6zxXMOx/xUsl/1AFWLjFrJrh4BrV/kMwJJIjc7mcWg0gY9igD0
         9+uX8XOfAHUFWBSjnMGiH0YkfYj2Rk2euOd+tfV2VNmyarI0Al1EVq6X5v/iRJwTLxpf
         Qo18lWjTUPYxGyIgVQqspm5gpRP4s65nImvS5C8vdrsjBff8TBhDj1HA86rIMPE3udI9
         /ixLdvwM4xGgnnsu9NYpEM+9HSOKPB1hhTeraqBczvpD6A4JoFIIgFZsOSszi4a+HMeL
         AXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZTxn1zH/8CPF8nHBpvAZQPHd/ePx+TIdDehIsUuIw4=;
        b=bJLMRx6EMhBbgR791WFDIMmqvEtukJe0j33aujWWCfHy73dI6h/8iSDIO2XiGNEcur
         hVZg4UNcIkgxXUMpmQCAJ205gTivrva1Dkl91VnfxeeXw0VA8oQdPgZwhPgbmBEDiMxY
         mez2RO1Qc49KVv4OvlpXY0SXgk8a7aTV5/lT++j/nVyMwkAsvd52Zy3QE+EeLk77Ym2h
         JP3biA4S3eEnJqFIjunDV6GUgZQZY1Lm8vuX2M7IaoimUEEWbaPpCnENRxRL6sqna1ea
         gx1RPqp6+bLU4YLirUUzFcxTQ0Lvkn12oi0V9KOM+Y+H/dhgOaU90M/dZ6DJ/1t9sJ+1
         6kHA==
X-Gm-Message-State: AA+aEWZJt5LLNF4i+XqQRDfHhuPqQ3nFfcRoP4aYzDUfftnwYtA8YABU
        zTFhFf8IwgD0tn7fWUSTGnfGn6+gKOo=
X-Google-Smtp-Source: AJdET5ei1HolyyBHYDajRdKoGslkIO6WSbeT9qNPxLX+3xtsgM8lesRvT9c11Y3LayTxrmC1cd1GNg==
X-Received: by 2002:a24:85c2:: with SMTP id r185-v6mr24905151itd.104.1543250772982;
        Mon, 26 Nov 2018 08:46:12 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/20] aio: split out iocb copy from io_submit_one()
Date:   Mon, 26 Nov 2018 09:45:37 -0700
Message-Id: <20181126164544.5699-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

