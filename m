Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82A5C3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F72166E
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103344;
	bh=5GRht+bIAa0hz22+5MeBH34xCjSsB4QkhPYcDHuiw80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUljqq+hiUVe9msU+4s1l8ckx2HOdtXYPdGq8FOwwKGPtVlfaQiGt1ypJqyuLbHAG
	 FboHvguS+j9cOcclgyHNtumGjDEd2oARjgJmCuGy6qSFUwgqPPnGfgG9HZwar3amhi
	 S7TjW4yfKhXHH36WwyMcrRgGjNhgJL+IcLw/ATkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfH2S3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfH2SPI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BFF2189D;
        Thu, 29 Aug 2019 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102508;
        bh=5GRht+bIAa0hz22+5MeBH34xCjSsB4QkhPYcDHuiw80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5QQ9ubKlBOvZqQV5UvFpfDzIU0eDuoaHG0BqF9UzHr/3f2m1seoD5jETrNHaAxKr
         RxzaNnfHtGrIP0i02WYOXzQ6xGsO2Ag/MFFgSEroKvGGf6g4eJP5VxSNroacC6JSLW
         cDK1C40y/Exeq/E498rbNeQvPXy1MLwaeBeNgtyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 58/76] io_uring: don't enter poll loop if we have CQEs pending
Date:   Thu, 29 Aug 2019 14:12:53 -0400
Message-Id: <20190829181311.7562-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a3a0e43fd77013819e4b6f55e37e0efe8e35d805 ]

We need to check if we have CQEs pending before starting a poll loop,
as those could be the events we will be spinning for (and hence we'll
find none). This can happen if a CQE triggers an error, or if it is
found by eg an IRQ before we get a chance to find it through polling.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5bb01d84f38d3..83e3cede11220 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -618,6 +618,13 @@ static void io_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
+static unsigned io_cqring_events(struct io_cq_ring *ring)
+{
+	/* See comment at the top of this file */
+	smp_rmb();
+	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
+}
+
 /*
  * Find and free completed poll iocbs
  */
@@ -756,6 +763,14 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 	do {
 		int tmin = 0;
 
+		/*
+		 * Don't enter poll loop if we already have events pending.
+		 * If we do, we can potentially be spinning for commands that
+		 * already triggered a CQE (eg in error).
+		 */
+		if (io_cqring_events(ctx->cq_ring))
+			break;
+
 		/*
 		 * If a submit got punted to a workqueue, we can have the
 		 * application entering polling for a command before it gets
@@ -2232,13 +2247,6 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	return submit;
 }
 
-static unsigned io_cqring_events(struct io_cq_ring *ring)
-{
-	/* See comment at the top of this file */
-	smp_rmb();
-	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
-}
-
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
-- 
2.20.1

