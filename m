Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D21CC47409
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A22214D8
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1d+W57Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgAGQan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46663 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQan (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:43 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so53255152ioi.13
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QX8yZUBrOqiAGP6vlQsEk/ggNO5z+OMPNA91V6ToLSk=;
        b=1d+W57RzX1j2qLwiyoZK/MNAKYv2Vhx+KdlMlr6Ah1F3LoDy+PLwIE9XBqV6UpLIHM
         3alPEKrF+ZLp084rXlsfi2KqkKobz1+yCcd1xADmuj5XkTfAxigepvooACGy/pAzLnJZ
         As844RluVUEw+f9EN7iqzXWaU4ZfPCNUTiNr+LeUT8+ajqn2YQO3eGuTnzNo8gj3mD9T
         FY/IARUWCytq8h4m9UeusFd1pYptuMiK0nH+4oVKgqWYWRMf3FICVIiMaKFIQUK7t6cT
         817wPdWlcJR/lwyiMVmcamQ6q6wWWlxf+h4U53LlD2Hw85sKwfk+m7PspfkvNXdSvgXT
         Le2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QX8yZUBrOqiAGP6vlQsEk/ggNO5z+OMPNA91V6ToLSk=;
        b=LDYxtl1EIGwOPABHYLRI6DsYayVXck7r8tvIs38BM2dt4a5yfntHtsJ0rsYLbraZtL
         VwZOic4nUKb4zrTcBYo8lR7yPERY6mi1KRR2Yr9rAIb9zoDDu2nAHG6L081JnWo7WryG
         3vtyf72HH2xzcxG9uic6lc/nSM3+h5ECOjXNijJPw5QcAFZmtTflizkC2+nsKTcRGIgI
         Z8uoMFkvjCzEHiofI9O1jBYU2b9N0gaGcwf5r1z6rA5e/F2muL6M3Je7lMZF4xlm6GZu
         08TexVrWvi7z3MvBKyiVa05gttQdTbep5bp08Dalzq+7bL7MM9hldC2WbqNBzP1yqD+g
         GClA==
X-Gm-Message-State: APjAAAXQC/gnUy6vlYT8+MDGhJlJyl5GOhabI19PLmIUSCR1EJRdX3gV
        lWdYvR/gkXd4enlOahdz/mRVM0LJUYQ=
X-Google-Smtp-Source: APXvYqw0HoSUBH2PNRQpv/NDXOQ5NebMk5aAcJVJnCz0o2D0j79+YN3GWrv8t6kQrYf9gNz0cJ1whg==
X-Received: by 2002:a6b:7e02:: with SMTP id i2mr72395384iom.172.1578414642605;
        Tue, 07 Jan 2020 08:30:42 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] blk-mq: remove 'clear_ctx_on_error'
Date:   Tue,  7 Jan 2020 09:30:34 -0700
Message-Id: <20200107163037.31745-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We used to have this because getting the ctx meant disabling preemption,
but that hasn't been the case since commit c05f42206f4d.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..6a68e8a246dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -338,7 +338,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
 
 	blk_queue_enter_live(q);
@@ -348,10 +347,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		alloc_time_ns = ktime_get_ns();
 
 	data->q = q;
-	if (likely(!data->ctx)) {
+	if (likely(!data->ctx))
 		data->ctx = blk_mq_get_ctx(q);
-		clear_ctx_on_error = true;
-	}
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
 						data->ctx);
@@ -376,8 +373,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
 		blk_queue_exit(q);
 		return NULL;
 	}
-- 
2.24.1

