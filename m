Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DDC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F072084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z2vb28R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F072084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeLKAQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38711 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeLKAQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so6197176pfi.5
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xk1RHxu77EhoWQ2KrK3JOFsMR8MJBsimunzriwFtjX4=;
        b=z2vb28R1yacueiHcy/Ehtp94uaUv814p97EktZb+1JNRhOIXdHDMJRzZ+u0wVrfSYm
         sPDtILsFJwvmPZcvDHhnlssD/doLGlSO3/nbQT5MFtpWzoWt1sAGjHdSwMCCuqAOtsLR
         Zm8RsHN2GkFH+lE2CnWuS7xS4rmYdIGUQys8cecyNJO9n3Du2RuK65WJZ9TijyUW8q6g
         tCpwDvZyqFuh9IiPvgxf7Hdmn4F0ugYsNT4SDkek57PXSyEmNJ1v/WL/+rPhgpOcGsc5
         NHZg/CgSaE52Sg01+obJQE9SNeyo6Nzm30/bECp9kLM+i+tPTXckmg4sUa+GSXIAt0tc
         zdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xk1RHxu77EhoWQ2KrK3JOFsMR8MJBsimunzriwFtjX4=;
        b=qvFFJLuHal33ZG7x+fLsaTnGhzCmmM8bdtchMgagCt1T77ThvVZpCd8d0kCtniPaSn
         kz3EOxYDgWnLh5+4h/VWqW9s2RGG1SPBksjcPl9FCcQg2SoldURFuRAxiTMgZp+8RQZL
         9yTxbAKWTynFvH044My/y7pK8jQ+NZxFUV/uh5/Md9Lh8OGuuhXCJgJvwrnwKtd8DsZc
         wX/EGo3ukRpOk3q18j1q6LQWiRQiJjCoYIGEey7qH7sEG6+NUrdXLHAZ9Qfui/CUr/m1
         S4tQxcFmTXEBxwqt+RxQ91kZa6ahhXNfXWeRSUmW5a4BLhLhnvFxJgMwmpHGH0LB/shJ
         /XWw==
X-Gm-Message-State: AA+aEWYlU1CdOln2vNmaJ643USdpxOMq19dAlEUw2ouvho8UOnjBLJXd
        V5DkPfKaC2pKkYc5Omg63eEwhVrX3p27BQ==
X-Google-Smtp-Source: AFSGD/XBmYiSfaIEgVDuXfJS8eF/OInHdcEmU7M6OakGczFQIFkbtdzHpHyYdNi53hTqrhgAYn4ZNQ==
X-Received: by 2002:a63:4044:: with SMTP id n65mr12309997pga.90.1544487396140;
        Mon, 10 Dec 2018 16:16:36 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/27] aio: batch aio_kiocb allocation
Date:   Mon, 10 Dec 2018 17:15:42 -0700
Message-Id: <20181211001549.30085-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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
index e9dbaedda7ae..a385e7c06bfa 100644
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
@@ -2371,7 +2398,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EAGAIN;
 
 	ret = -EAGAIN;
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx, state);
 	if (unlikely(!req))
 		goto out_put_reqs_available;
 
@@ -2503,6 +2530,9 @@ static void aio_submit_state_end(struct aio_submit_state *state)
 	if (!list_empty(&state->req_list))
 		aio_flush_state_reqs(state->ctx, state);
 	aio_file_put(state);
+	if (state->free_iocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_iocbs,
+					&state->iocbs[state->cur_iocb]);
 }
 
 /*
@@ -2514,6 +2544,7 @@ static void aio_submit_state_start(struct aio_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_iocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

