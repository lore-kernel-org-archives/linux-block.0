Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A5BFC6195
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A734222C5
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Yx1NM9Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfKGQAu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:00:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44615 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfKGQAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 11:00:50 -0500
Received: by mail-io1-f65.google.com with SMTP id j20so2571725ioo.11
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwKDpLHKHDEde65OtvYB2l6aiaJYEM2FwAHO+K+WpHc=;
        b=Yx1NM9KjVGyBJ8ufxQQrHN4VizTbRJuqmh9XgnllbSYkKhes02ezPxmWxGixijqHzP
         j+51Md0UFgVSQCPLCAXPEnNBO5CNI7nXnmTDrn3DDRezvIYBWncbGyYmRjuIAP/4r9Ri
         Q7adKmg45BmUoRJ+J3aE24+cGPPwE7cbiGr5zLEQw1NIDKofgf0FYHX54MZslVSkuaWL
         CPV1TtSHJTRczmCz/KRVNmmhikf77nLhxAiSsTdrVgCcUTsuisrhuU29o96jfb5rs9Tv
         tx2cbGuyL6jhf91ar20eGa3kpzeTjdwsNHS/VoijhbXWGGvZqfE2FgQeiZndTWOk22xW
         GlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwKDpLHKHDEde65OtvYB2l6aiaJYEM2FwAHO+K+WpHc=;
        b=fL9aILcot/KeypueRDre7SHNlfPjxWe/m8udsCqBG7MjfZXRumoc3JHgJCpqsxIYhC
         q+GNJD9mR81W2uNPgU7HFQTwNATlnjdM42vJCdZGI5yHB2x6N3PxVbeUmlk+M+zaphWY
         Gk7MzviY+IjWrJA7zRczJuW3j3kGI1oZF27A/CGbl1xCcjClSMAFJPhEdbIsuyZARZ7j
         Q8qcwztLgddIQjMgbXuQc/lwKu0c1QlIPl+9upV1av8ivTjG7o1XNutvLEG1TrC/b9yp
         RYIbV9HP5sQRVS25noiOqr1J6w8zA8V1pWFCU600625oxOl+m8cOColaEeKo6NdLIHRM
         vQ6Q==
X-Gm-Message-State: APjAAAWH37SzxZJ9ibp1bopIlOx3oiBLMyKJHTEdADvpTFeqm6I5rOOW
        6xfr76xCTu5+Ghv3OE/jo8yxsQ==
X-Google-Smtp-Source: APXvYqyFgIB8VCHdpzDsp1oamhbl0L1JMSHDWmx7dKmqImC4O9ene2YbZMyY5EOyFrF8U/CsFfNsLQ==
X-Received: by 2002:a02:c4cd:: with SMTP id h13mr4944158jaj.33.1573142448891;
        Thu, 07 Nov 2019 08:00:48 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v130sm210438iod.32.2019.11.07.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:00:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io_uring: make io_cqring_events() take 'ctx' as argument
Date:   Thu,  7 Nov 2019 09:00:41 -0700
Message-Id: <20191107160043.31725-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107160043.31725-1-axboe@kernel.dk>
References: <20191107160043.31725-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The rings can be derived from the ctx, and we need the ctx there for
a future change.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 22c948db536a..da0fac4275d3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -866,8 +866,10 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
-static unsigned io_cqring_events(struct io_rings *rings)
+static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
+	struct io_rings *rings = ctx->rings;
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -1023,7 +1025,7 @@ static int __io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		 * If we do, we can potentially be spinning for commands that
 		 * already triggered a CQE (eg in error).
 		 */
-		if (io_cqring_events(ctx->rings))
+		if (io_cqring_events(ctx))
 			break;
 
 		/*
@@ -3076,7 +3078,7 @@ static inline bool io_should_wake(struct io_wait_queue *iowq)
 	 * started waiting. For timeouts, we always want to return to userspace,
 	 * regardless of event count.
 	 */
-	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+	return io_cqring_events(ctx) >= iowq->to_wait ||
 			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
 }
 
@@ -3111,7 +3113,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	struct io_rings *rings = ctx->rings;
 	int ret = 0;
 
-	if (io_cqring_events(rings) >= min_events)
+	if (io_cqring_events(ctx) >= min_events)
 		return 0;
 
 	if (sig) {
-- 
2.24.0

