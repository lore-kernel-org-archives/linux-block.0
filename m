Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A85C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B715F6052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhJMQ4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbhJMQ43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:29 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D601C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id g2so437864ild.1
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQbLAMYZvChZM1eTcfqVnB+m/wLbIopxB4L7QBJlFdU=;
        b=7NpYDl9IUxlyrxikKFILhgejJP22cql/pkHdWWS6DKS4yvufoevkSOfVrVThBLmKfF
         gw0PLyLS6IFHx1NmzcOzkkpdFsEkz9ZC80Mb8lf+XgyCRos5PkC471nYhhIz6Em2PGG4
         bo2a9CKBs6170FetKuHruhnh5X8pPrZ24HvBy1mwJp38xNGQQDEecYe8TRITKeiG/PEY
         QMUOqWVb8Oyk2dk3g88sWdPJp0iWj9PmPTATz5X4jpwnxs4mFpBfj9hQ0czuB9M7Ypdu
         B1cVqEJeGjK4mhXcBrn6io8v5JmasLxtOzGPKEIb3+Pa1I3Vqjzv0nyIWAARJdtK2Ct4
         +QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQbLAMYZvChZM1eTcfqVnB+m/wLbIopxB4L7QBJlFdU=;
        b=RkpTEyDUl55vdS//8FQwIALpE3xSh7q4g/dMvH4TXLk/xuWRyWwUsKRmn2xEkQC6s0
         sj4RuzkQBCf5lIVmlNkmVGCVXT1EUaPtAxccv6bW4y20MVwretguq1tHVGyWQWSKyA1A
         O0C7PLLk4+lbyeGYZbmLpRyGvTLz93RMJvWi7Gj6kp4TPf83nKWh6IsDcJzS9/z1WBLm
         G2zLNcwPKi7HejN5XRG/ont7Xzjieg55QNWve3cAepObReQCqMV0HeOFBQYqVwo6xeuR
         QWbYqn4IqkRpu9/YQR34CLSOigcqLSfk1Zik+2gvisIXq2pYtxOikLArA4Gg7qpoCAAp
         h2TA==
X-Gm-Message-State: AOAM530hmJ7aovDAUAEmVRY/5j3+34ZSK7fPotIdGvDBsYF/axMVFDAi
        zDQ8oFC1bhWgMIYspKq3GgbkTxQlO9fRtA==
X-Google-Smtp-Source: ABdhPJxgFrCNDC46tAEXdRHVTjTHJxfmS5C7xXMo/PBovScHJw5ot4naQhCMSWaI8d5B0jWrVv95qA==
X-Received: by 2002:a05:6e02:148f:: with SMTP id n15mr107849ilk.121.1634144065783;
        Wed, 13 Oct 2021 09:54:25 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for more efficient polled IO
Date:   Wed, 13 Oct 2021 10:54:15 -0600
Message-Id: <20211013165416.985696-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Wire up using an io_batch for f_op->iopoll(). If the lower stack supports
it, we can handle high rates of polled IO more efficiently.

This raises the single core efficiency on my system from ~6.1M IOPS to
~6.6M IOPS running a random read workload at depth 128 on two gen2
Optane drives.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 082ff64c1bcb..5c031ab8f77f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2390,6 +2390,8 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 {
 	struct io_wq_work_node *pos, *start, *prev;
 	unsigned int poll_flags = BLK_POLL_NOSLEEP;
+	struct file *file = NULL;
+	DEFINE_IO_BATCH(iob);
 	int nr_events = 0;
 
 	/*
@@ -2404,6 +2406,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		struct kiocb *kiocb = &req->rw.kiocb;
 		int ret;
 
+		if (!file)
+			file = kiocb->ki_filp;
+		else if (file != kiocb->ki_filp)
+			break;
+
 		/*
 		 * Move completed and retryable entries to our local lists.
 		 * If we find a request that requires polling, break out
@@ -2412,19 +2419,21 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		if (READ_ONCE(req->iopoll_completed))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, NULL, poll_flags);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, &iob, poll_flags);
 		if (unlikely(ret < 0))
 			return ret;
 		else if (ret)
 			poll_flags |= BLK_POLL_ONESHOT;
 
 		/* iopoll may have completed current req */
-		if (READ_ONCE(req->iopoll_completed))
+		if (iob.req_list || READ_ONCE(req->iopoll_completed))
 			break;
 	}
 
-	if (!pos)
+	if (!pos && !iob.req_list)
 		return 0;
+	if (iob.req_list)
+		iob.complete(&iob);
 
 	prev = start;
 	wq_list_for_each_resume(pos, prev) {
-- 
2.33.0

