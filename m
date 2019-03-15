Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FEEC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617F218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S+vB3OAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfCOOyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:54:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46172 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfCOOyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:54:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so6501909pfe.13
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIi4VzMT1X1u9pm4Nir4DVemESOOMMWl9QaKO0EzHRw=;
        b=S+vB3OAh6VkVMR2ruPyXezbjsJrdML4whtAmfDrA9iH+Pxdx2+VsFscRqyzrswElzY
         euB7jviOFgI91Gn7U3oqDLwHKOBURBYCrySbn3I2ex1Zi51YuKUD/M3OF3XDhZQLtgP/
         V1UBJh929GumUi+3RkDXLUZ+/rDmriIwCcwOwtFLSJcUdS8T/djQnHsDm9QcaXDA4Yse
         H9Y+LCYnrXmdfccy7D8IZZ3WtFCeAdUC1KZnByzLI+daOYrksEBS71V0eCiBqNOtMqFt
         3RPD0qDQkZd5M4Qxwgbv41um/iXsDZ5FQjAxASG998G6E7n/yaDNwEM8OrddCCURtl81
         0eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIi4VzMT1X1u9pm4Nir4DVemESOOMMWl9QaKO0EzHRw=;
        b=iF1rzvv9S1T9QqdUFXbpV80QyO0s/nT8+Q9ENx5Q0M1Gz6bTQr0/ELJjihKgfw5sQl
         1VEbz5EEaNkrhgujpA5otk7MaT5yyfG/iLLs5wvsyPBCSRWKUUTV0N6qQrsL4i0JcvvR
         5I1vyJn5sAua/AqnsG9mFclEvToiYnV2Dcmh+Fc2hdvlBVAt0ikCmwzO26EXYXilT29M
         NPTaMe0Im7KzvIhYxH25dO4iSfiV9Eq6OT2ALNn1363D4r2QcVGoah09VUEBek2vNuUq
         NNlUGospOENzfGdscMYpkqha2hQTLyGSiWHXxujOAGXh6DwG4cqQQ37bAfvJjXivWwTU
         WZFg==
X-Gm-Message-State: APjAAAVRJulr6+DFoQuHg6zyDLpgBJ8JDplMcnizPCVQUtAhXNNZ1aYU
        YENojqueILERsjo+GagdU0YfSg==
X-Google-Smtp-Source: APXvYqzFctntzhP71QP4nVH82f+PLKqdUVBkejjagHJjUaQ7uiFmNkZy8zRE+lf9r0Q5WHn9EAteiw==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr4726151plc.161.1552661693264;
        Fri, 15 Mar 2019 07:54:53 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] io_uring: add prepped flag
Date:   Fri, 15 Mar 2019 08:54:38 -0600
Message-Id: <20190315145442.21127-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145442.21127-1-axboe@kernel.dk>
References: <20190315145442.21127-1-axboe@kernel.dk>
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
index caf39663466f..d259e8a6cb2e 100644
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
 
@@ -1632,8 +1635,6 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(!req))
 		return -EAGAIN;
 
-	req->rw.ki_filp = NULL;
-
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		struct io_uring_sqe *sqe_copy;
-- 
2.17.1

