Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1ADC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A02721872
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zr1JOoLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfCNUoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52154 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfCNUoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:46 -0400
Received: by mail-it1-f193.google.com with SMTP id e24so6945894itl.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aGgfBQgJx68zZgA7Gpk3ttCJRvX4djiuuqiwUtjZX4=;
        b=zr1JOoLAv36LoNKK4bcvAZSxtrMxrxa5ySaeDX03leFwFX0nWvtUMVlZ92m+weAX4x
         5NJXOVlq9SwCe+7XNYs6L0bZcwoejjnCm4EKdFTA37FrUcGr/bQzDOhhOpnmTlNlxr6K
         LLQQOP+qKKpU94SCjgwTpHAnvF1Su78eGno7K1xJsQzEfEwXLXq7TBBBAaKxf25dYws2
         S8PyLWcX+tGZ9Dr8VNm1nSAGdmzaJkjbk4iEq3N2E7eA3veFatbXS8r2dWppOUJla7Sb
         B5Cih+36uyKPp00vZQVSZvBxs61xaxyrcedg5QEuHyEGNoblVxa8fmcHxQBdjlZka7TJ
         gMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6aGgfBQgJx68zZgA7Gpk3ttCJRvX4djiuuqiwUtjZX4=;
        b=DH1pSTKQSsf2T/T2cSWZM1gat4Qsyc/3UnwDQi4W73N/m6+F/Y1/vdBVlq7sWDlQPj
         DveFvaQjDkV2LbSB5MsVTG5m3vvaMN6CtWbf2xB0VGqnYhB5EDiJwZfJb1BdqCFjG7uP
         bqGcfDw6w8AMZK+mSSmZUM8ZbuoU8Hqc4MzcN/POm77A1bmNrVPsn2EctipeiQK9REi6
         f4U1AO/ZnZp9raoeX0jyJRFIQS1PdEmdBEyIgQ8KsMmia8HtYczZY6Njv8ylCsYY7gUr
         1irE9RE0RZedyBJwqoQTXz0Y1rFYQh56/36mP1OtXb/ZoKPkIIcEMjvkrkBTh8L9kr+g
         1eAQ==
X-Gm-Message-State: APjAAAVPJvuBVuTc7yP3tOAI4leAkZ/EdfgkQe3k3/Ubqui+lOMW0dAn
        jg11dgIc52F5/OzYv/zv/4yCjQ==
X-Google-Smtp-Source: APXvYqz76O6bFRt6AM0woI74PnUReqyn62Wd3fhf2tom6b253YrUnABg1uFkMAq50ASWnf4EcCRbOg==
X-Received: by 2002:a02:3c07:: with SMTP id m7mr187046jaa.26.1552596285456;
        Thu, 14 Mar 2019 13:44:45 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] io_uring: add prepped flag
Date:   Thu, 14 Mar 2019 14:44:30 -0600
Message-Id: <20190314204435.7692-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently use the fact that if ->ki_filp is already set, then we've
done the prep. In preparation for moving the file assignment earlier,
use a separate flag to tell whether the request has been prepped for
IO or not.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ecb93bb9d84e..d8468594a483 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -214,6 +214,7 @@ struct io_kiocb {
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
+#define REQ_F_PREPPED		16	/* prep already done */
 	u64			user_data;
 	u64			error;
 
@@ -741,7 +742,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	int fd, ret;
 
 	/* For -EAGAIN retry, everything is already prepped */
-	if (kiocb->ki_filp)
+	if (req->flags & REQ_F_PREPPED)
 		return 0;
 
 	flags = READ_ONCE(sqe->flags);
@@ -799,6 +800,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		}
 		kiocb->ki_complete = io_complete_rw;
 	}
+	req->flags |= REQ_F_PREPPED;
 	return 0;
 out_fput:
 	if (!(flags & IOSQE_FIXED_FILE)) {
@@ -1099,8 +1101,8 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned flags;
 	int fd;
 
-	/* Prep already done */
-	if (req->rw.ki_filp)
+	/* Prep already done (EAGAIN retry) */
+	if (req->flags & REQ_F_PREPPED)
 		return 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
@@ -1122,6 +1124,7 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 			return -EBADF;
 	}
 
+	req->flags |= REQ_F_PREPPED;
 	return 0;
 }
 
@@ -1633,8 +1636,6 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(!req))
 		return -EAGAIN;
 
-	req->rw.ki_filp = NULL;
-
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		struct io_uring_sqe *sqe_copy;
-- 
2.17.1

