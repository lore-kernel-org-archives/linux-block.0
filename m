Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCBC28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AB72414F
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qcxwTiq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE2UaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:30:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33462 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE2UaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:30:00 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so3081211iop.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xwqHfFzvp//A7fFROzl2SfyH58AGCl7NmlrDZu9c+C8=;
        b=qcxwTiq0zfMYFrBjwDIM3AObmHaPRrsXW6sRdNIOpC9rfIrdTkw04bHVaPIJcDP5GF
         caALCE8jK8vWraQqwuXn0wAxhRwhhXqtppiXb9m5xaaH0jB8bfgkFAzL9mIoZ54vpgJS
         g6qPP6i2hB3rL4HqwWRXnwmZ5LpV3JSiHeptNIvHPoIwgJ030es4DG/bWqvkUSM0vl/L
         w8adg8aYtLwSaG8g1G/C+uvZUV9J7nhGw8j1HXkfLY6vYWigaE43lZXiJhUfTF+Vlzn3
         qPsqBwdEcUGtMTihyrIL0H8S4U0GrCwhMDv3cpJ5NO6HdIsnS8HHi0cjl+K9hL/V+tD3
         xyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xwqHfFzvp//A7fFROzl2SfyH58AGCl7NmlrDZu9c+C8=;
        b=fpRRddB5+N85tLiA2dKPN5Ap+t+z27iHW2n/bAtj+mOXhFL7jWiJx6AaNTiTGl1+kb
         +qkqR4mSa/QS8LHMoMEivXt+KBnb4azi6Fag/mYynU0vy4JvBy6WMY1pZnnMf4UXWnXO
         s3WabsoVIdDIiA1IXQi8rpEyVtvjwjnDdIwr3T1DwAnGeW9PsnHDhITUD8ZzBtItxTGu
         gXQLWOSpAsyEZbgkX5V5f3ZvBDniXz8I5hoMeBqdctWxtyjA4LdQb6w3r2hcU3BCmlqr
         esxv5vpwtOeyn30VlKlt/y0VpEJxuWqcAtpqzuvGke/1RRNGNifshPQO3MGe18CCbI3L
         DNyg==
X-Gm-Message-State: APjAAAX8PWVThCVHtjLhv/r5e9Q09Ag8ZY6Y3AV5HJlKsvWPoFilUSli
        mLwBSJD2TFtRjAhOUFd9SY4eFw==
X-Google-Smtp-Source: APXvYqz4yg2/bU+0PwxuFSy+MV8uIcETkt6D6JZUeu2sr5jU8J+1HXr4xkEUFvODM6iuVo5jW+pU0A==
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr8560120iog.269.1559161794670;
        Wed, 29 May 2019 13:29:54 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm179105ita.6.2019.05.29.13.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io_uring: punt short reads to async context
Date:   Wed, 29 May 2019 14:29:47 -0600
Message-Id: <20190529202948.20833-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529202948.20833-1-axboe@kernel.dk>
References: <20190529202948.20833-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can encounter a short read when we're doing buffered reads and the
data is partially cached. Right now we just return the short read, but
that forces the application to read that CQE, then issue another SQE
to finish the read. That read will not be cached, and hence will result
in an async punt.

It's more efficient to do that async punt from within the kernel, as
that will the not need two round trips more to the kernel.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 23e08c10f486..92debd8be535 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1089,7 +1089,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t ret;
+	ssize_t read_size, ret;
 
 	ret = io_prep_rw(req, s, force_nonblock);
 	if (ret)
@@ -1105,13 +1105,24 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
+	read_size = ret;
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
 
-		/* Catch -EAGAIN return for forced non-blocking submission */
 		ret2 = call_read_iter(file, kiocb, &iter);
+		/*
+		 * In case of a short read, punt to async. This can happen
+		 * if we have data partially cached. Alternatively we can
+		 * return the short read, in which case the application will
+		 * need to issue another SQE and wait for it. That SQE will
+		 * need async punt anyway, so it's more efficient to do it
+		 * here.
+		 */
+		if (force_nonblock && ret2 > 0 && ret2 < read_size)
+			ret2 = -EAGAIN;
+		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
 		} else {
-- 
2.17.1

