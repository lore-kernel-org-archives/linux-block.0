Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445E5C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153CE214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FDGktQLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfAHQ5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:14 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43425 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfAHQ5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:13 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so3654607ios.10
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1+rzmFAhsJFMNkbvjMPPUCScsMQNRxeiVOaxepJ4Zg=;
        b=FDGktQLBlh0jObXjQtHOQG7kOJVUuE+Bo4KU91owZt6HiDcOHKgXMPcZ0uFVeO4ZYs
         V1MAFrngFddIcB6aRxjvVYwpzheWWWKMF9XLBSbWab5UN9XxX1nF6tCgroCXMX002B83
         V7bYd5vLXWJIjgqliLcjOZYI35xRYZ4EYEy0bJ2ivVk1pgKuvCb/GTrtplaChXTuUKfx
         Vs64/JGc81svxSM1nJPjkXefwqIHulL+ntATAE2QaZjedXOaLKmN1DjBbN6QHKy4BTkC
         AThF8zZr3nTjzemBdxacxWywOQzZ8Td4qQg+ESNNzAkW7BQQlrUXhQjmzC8lZO9qeRlG
         ATYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1+rzmFAhsJFMNkbvjMPPUCScsMQNRxeiVOaxepJ4Zg=;
        b=Wvrxg9FaGpF+xNkf9KwB7U7jeGntGl8CH2IJHX8JGjOY/HWfUe09gL3hnpXnzbbRwo
         OsvWtQnTgK5IG1uyEneCtc8hvuPC42hprTqXVFK1QBfX4EDXRzurTukmIY0bzEEnuj65
         P+bOc5iTIHO1MEoovunZ+/5IWFaMP8uafjsb/qqjgDYJX+lsdfbfxNWCIqn01PAShV3n
         Kd8ulX7lcf8WuzYAy730OdiM22HNBlstcPLPFGtku6L4S3HduczXTktpdveZ/5nabKyP
         FQgalAxfy5DAAUqzmb+Ooxrc1ctlERzQw1my8PTfrTBZOTUHti62olI1oxU83IhKWAD7
         DhfQ==
X-Gm-Message-State: AJcUukc04TLmdCkqsAHjbOsf8VThxAUnNhUDdFBRjgKJl94AfVqSF4bp
        rYLBJAIjbul7Y30BmoN4sAAEOw==
X-Google-Smtp-Source: ALg8bN7ivUBLk9qzoowG1ma2oq1rWMqjlNmy/ynh5BD+ifEWlbP7VIytgwNJ39sBZT/bvaZnUY9k1A==
X-Received: by 2002:a6b:1604:: with SMTP id 4mr1483427iow.29.1546966632893;
        Tue, 08 Jan 2019 08:57:12 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] io_uring: batch io_kiocb allocation
Date:   Tue,  8 Jan 2019 09:56:40 -0700
Message-Id: <20190108165645.19311-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 11d045f0f799..62778d7ffb8d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -135,6 +135,13 @@ struct io_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void *iocbs[IO_IOPOLL_BATCH];
+	unsigned int free_iocbs;
+	unsigned int cur_iocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -210,15 +217,33 @@ static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	req->ki_flags = 0;
 }
 
-static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (!req)
-		return NULL;
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_iocbs) {
+		size_t size;
+		int ret;
+
+		size = min_t(size_t, state->ios_left, ARRAY_SIZE(state->iocbs));
+		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
+						state->iocbs);
+		if (ret <= 0)
+			return ERR_PTR(-ENOMEM);
+		state->free_iocbs = ret - 1;
+		state->cur_iocb = 1;
+		req = state->iocbs[0];
+	} else {
+		req = state->iocbs[state->cur_iocb];
+		state->free_iocbs--;
+		state->cur_iocb++;
+	}
 
-	io_req_init(ctx, req);
+	if (req)
+		io_req_init(ctx, req);
 	return req;
 }
 
@@ -773,7 +798,7 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 	if (unlikely(iocb->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -844,6 +869,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -855,6 +883,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

