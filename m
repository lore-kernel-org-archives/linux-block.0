Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39340C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0667B21929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qVSq05CH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbeLUTXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39532 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391665AbeLUTXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:02 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so8024079itl.4
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m8JZeS9KbnWxYLam/2YmCF5OT6qc7l1mrTQmfc17bac=;
        b=qVSq05CH6WuQj5saphOXjPa5ld/kiUNwu6ETrkN0KhxyObiLa62KRiFFO9p1SbW3XT
         CGma0nTZYrpwUl2H/3sGtk9ck2Y6OCDNfZYKgKFKb1K1UIWt11buD+gPByDEFqpgDQ4F
         gYZlJqHFdPGm6RwzZ9kXmI5Vy8Mv/OUmnY0Ptqjd3xZTinE+msH2xmkvmFxMBwARvlXB
         3KzSTblDDjs6K4b4doIMbnihYUljidyucG65+WF0I6KdRpjdKYWIaSME48u/QK6FFRQ8
         GTyFOPjKvq3YO+8bFuIBsj93QRrkYLGE/OjtkXiSc9zv1+rzXcAdRGhCqhgfm+lNPMn4
         d2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8JZeS9KbnWxYLam/2YmCF5OT6qc7l1mrTQmfc17bac=;
        b=jBkb3ETYICyewjg32fyCnwtssUyKy8d/Z3gi2gvnD4vFdEIR2aurimijOGsiGO9Odx
         jeWtKyAC4LHLaDdHMVApj0A6HBK6XoxS95+qjEbvQbYj44WDPG2ivG+ExrE5NkV1+6Vr
         vvXuAi1/TbUAO67CB6cLXi2+mo68qKgyNLsawXP7vkygKqYfh9JaxngOyCDA0VxD7Lic
         R1MpdFERm/tIYrnM1TdCvJBUJ46j6QRkup8mXVZPSSeQ48jKZtqr7c/Q0H2hb7Ryn4l6
         r62kgr3lkcqPE1WxP44TLXO6mlmQVFhjrnYRX25EBf95nxdxqV8i+/Rr5Y4pz5DOgboF
         IY6A==
X-Gm-Message-State: AA+aEWZ/lvtKsXMDwCSPOoRB/32CRwTdDYA49BAbEnQqL6fzcvslMogs
        Sy2qnDBhvPvqlj1gUEpijZRrEg==
X-Google-Smtp-Source: AFSGD/VYpaUOUhSpVGo1yQa3w0JnLd+QHeJLVXfULOrJAgRK8TPdDKuVU5897ArkxcNopqpA45ixfA==
X-Received: by 2002:a24:1aca:: with SMTP id 193mr2833394iti.150.1545420181164;
        Fri, 21 Dec 2018 11:23:01 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/22] aio: batch aio_kiocb allocation
Date:   Fri, 21 Dec 2018 12:22:27 -0700
Message-Id: <20181221192236.12866-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the aio_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 093e6c8e9e09..513ecd3fa681 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -250,6 +250,13 @@ struct aio_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * aio_kiocb alloc cache
+	 */
+	void *iocbs[AIO_IOPOLL_BATCH];
+	unsigned int free_iocbs;
+	unsigned int cur_iocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -1105,15 +1112,34 @@ static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
  */
-static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
+static struct aio_kiocb *aio_get_req(struct kioctx *ctx,
+				     struct aio_submit_state *state)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (unlikely(!req))
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
+
+	if (req)
+		aio_iocb_init(ctx, req);
 
-	aio_iocb_init(ctx, req);
 	return req;
 }
 
@@ -2293,7 +2319,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2414,6 +2440,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state, NULL);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2425,6 +2454,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

