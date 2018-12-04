Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CECFC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE420878
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NLvp1mIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEE420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLDXi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36867 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeLDXi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so8093313pge.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+la47KDAQKGmZHMhrQqv7/JmZ/DmBCr3wt9bubXBUw=;
        b=NLvp1mIghPnkZPt4HnF+MITp2xKyPiKxKfKVvWgGOyITdVy6OuPu+1kFyvM1dlR3OU
         3qZC8BjlyGqcUFo33JkytHBmYN4ZSvNRImN1loOjbtMeAmeXzMHwK7ghJbwOBYUJsf4M
         Y0CxeD26tysB5NV3VP/tPLrQ8lVt6I2x9dTvq+nbbwCBgmkbTl93jO2d1KajWiaWhsMd
         hCVVSPbmKc4t6UgXKjQ/wfq/amC/KRx54y3suXPKX6R1bo+Z0Dob0m+Z5a1Uy8nZr9hf
         IVfVN46xB9cqOQ2WI+Y1KYrfEDl6FfH49qQYUGnqGbqrBBVMFOOgiHHcHiMmwQbCgzJF
         Ky8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+la47KDAQKGmZHMhrQqv7/JmZ/DmBCr3wt9bubXBUw=;
        b=fNutr8Ftt+Io6ryTA5qg20CZB+fHMYxvPkajwZ3AZHvNMLklH9CYdNDL3yWAPhU591
         3QROPiaP/CqAbLBKATgyw3f82FX+lHBM/lgzv19CBXrs66JvKpugrcAZ8YwW+zL+uW3+
         lENICqPK46VfcpWlZdv04aD97Olw9k/4bS0sujEBbFunQHWuINvAj5jKK7xI9lir8fza
         NkkbtRKK/Q3DhQrnnO4aqT+A3a/NfxCXpMge6KecFrNNBX43Wj+mHeRyypDuChM58vJb
         ZnKp8ho4B8zVl2k56YgGq6Lv6qRGyMuPhbiAHr9jRrchdDJW0PlQVv6oGTd97Vuw44dN
         PXzA==
X-Gm-Message-State: AA+aEWafjhk2VnAUTS1NWZmV9CKKDnP3BK75+yiosr5DwNQfhyaNhwRR
        /6zhXi/GBDchx5G2LcRl6atZsUPOo7w=
X-Google-Smtp-Source: AFSGD/UBTBuH7VXnjUcNx3kOh9ltHSVTgMCaGnlsITE34Qg0JI35OogHS10AMdtRpikm5fK1hGYHQg==
X-Received: by 2002:a63:741:: with SMTP id 62mr17982025pgh.352.1543966704697;
        Tue, 04 Dec 2018 15:38:24 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/26] aio: batch aio_kiocb allocation
Date:   Tue,  4 Dec 2018 16:37:23 -0700
Message-Id: <20181204233729.26776-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the aio_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 416bb2e365e0..1735ec556089 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -240,6 +240,8 @@ struct aio_kiocb {
 	};
 };
 
+#define AIO_IOPOLL_BATCH	8
+
 struct aio_submit_state {
 	struct kioctx *ctx;
 
@@ -254,6 +256,13 @@ struct aio_submit_state {
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
@@ -1113,15 +1122,35 @@ static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
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
+
+		size = min_t(size_t, state->ios_left, ARRAY_SIZE(state->iocbs));
+		size = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, size,
+						state->iocbs);
+		if (size < 0)
+			return ERR_PTR(size);
+		else if (!size)
+			return ERR_PTR(-ENOMEM);
+		state->free_iocbs = size - 1;
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
 
@@ -1359,8 +1388,6 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
 	return ret < 0 || *i >= min_nr;
 }
 
-#define AIO_IOPOLL_BATCH	8
-
 /*
  * Process completed iocb iopoll entries, copying the result to userspace.
  */
@@ -2357,7 +2384,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2489,6 +2516,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2500,6 +2530,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

