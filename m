Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A93C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934242083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pT+EpGt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934242083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLGWVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36535 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLGWVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:21:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2304775pgm.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UcPqE80Ltl1zbvUwQf6KT+BSP/CUpMTJDTXygzw2sHo=;
        b=pT+EpGt+hVszXHU33vPKeNTnGsaNOM4uueWUYszxyxI8xegLRK6vcfCThfF5zUewA/
         CrI2U/VrGp2CUvjHp7cE+f55Mnsqg64Hy9yFUyfzIZFtHkwT//HeQP55MSlsGPPGsPrm
         LdvBOGkXIan67PXaQKIjFt3qBvulvEpc2Ku/5O9ClTAnG6i2M3USl9W4wGlnPzJDXwix
         jFskszHkvQYNwOWrU7yO+Kfu5o+4N/SShf6MUTr0DuAbswwyhMMsFaZOCnaOe9w/hdgZ
         zJ0ZyhEiLNC5bG7pfFO47PwNnR7G6Z/MxmgulrVEhjbhtEVxF77mT8r4n3IfKOSSz0BK
         wGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UcPqE80Ltl1zbvUwQf6KT+BSP/CUpMTJDTXygzw2sHo=;
        b=mJheQjGUNu/9TE/7CLWTJfX/Sh7s2r8JyHzgIwA9I7wFUVinxci7CrI89O8RkLeUd6
         FSdofqDVM9idzeOKrJfINLnJ8v22kxlnzoo8w8WxQQWpiI2OU5xbLsNNeCoSqcopACxn
         +euHtnq7Hm73P0ng2bd6XPg6wJ67bzQjh/V/uTYbB4+9IzHS5H57uSkMzdUurQnPB1Vf
         jRN9iHXW1Xm5Jc/oGqPOujp2uh6/YGYTOs0UeY8eaVBusiDPZGXmHDBQM3W72NXlnUtf
         570djOFsBMQ/iETKv0f0G4eE+NlL9qJ0UEby4gQKkoTUXeSvOObv6ZR8/EeY6A1YGoux
         x5nQ==
X-Gm-Message-State: AA+aEWZHwDY8AdX+aT9gxjSZViagkBIbhanASOkFRei3eJIzIwZaYoSw
        Xjq7kwht6QW9xkpw5GMmwmoVaW6nATo=
X-Google-Smtp-Source: AFSGD/UJYUBi0NbSbjuROEiJNNEr36E05T9Z1nf07ympULZ22V7AzBER1t/o4VK/YMBmfpcemjTKnA==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr4017377pfl.196.1544221260567;
        Fri, 07 Dec 2018 14:21:00 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/26] aio: batch aio_kiocb allocation
Date:   Fri,  7 Dec 2018 15:20:10 -0700
Message-Id: <20181207222016.29387-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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
index 51c7159f09bf..52a0b2291f71 100644
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
@@ -2360,7 +2387,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2492,6 +2519,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2503,6 +2533,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

