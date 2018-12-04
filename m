Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF24C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBA820850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HDkYULpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBA820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDXiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40344 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeLDXiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so9075866plq.7
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ul+VE0yRWp7wiLWglojNjFDoqMVcfJibb/mrajeGb/U=;
        b=HDkYULpaTdjG0VndsOVCNomLAWFR4ZR48+pVNOT+806Kdx+3UuNvb4egZJc2ruX0xJ
         rdmtYtl4PBnZJFZPqJPL2e5wiRhpqy416tjkMNbJjcuzt0cFNSb5VKne8/gfEz6zkHXJ
         t4jcsYZeIHHm5k27h7+ML+vNw56rAAtgA8G8yUdCFaFEZInDns34Ojk9VTvRHoGXFyiv
         Jj8hRCtqHPp56Swv2cQKeIjVP2AoirEkAMn62Ylot7wBN7hWAO3Mc26gpTnWe6W/fwtX
         o5ohTOxbj3Y3PzgrMt8pcmH71Dcc53/mF70offPhYkggYbnFXXex1h9lQjdNK7ga8avE
         nfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ul+VE0yRWp7wiLWglojNjFDoqMVcfJibb/mrajeGb/U=;
        b=oR4cXdGyF4/evPA+dPb+ODTYnF7t2+GTeiNTP+OsnE9MnwxkxKM7ZkBxmpznSVS1/V
         z9yL75z8ZfFBf4yLrY+E3v0wNW1+yD+NzpX2jTO82mXBzAo8GoirBJK+8PWPI/b3hkJJ
         V3Y8dh3w+CTdt+blu4HREnvsw0gXef2XwYWOdcdQ1f/hZPfX1DaoSUKOm82s+dbkDpOu
         JEgulvg4KBWpInqzjhSA19k7tWD9L4ewpu+eYaMdEiBH0OTaGQvvpRlyaRkKb8UB2pzY
         dPysp7zHjuFzwsaXp+FWdWTKZ5ns0q4IC0IbU/RluHMGeKpheErQyY9qrDchBHK1Qpds
         gqTA==
X-Gm-Message-State: AA+aEWY+sbyjqKV9rDl58nzEdIAOYXnM2tqQUU7dI/6FkmlXowLPw1lB
        2p3+yiMtJfavtFpblnBabzhHaMkGAKs=
X-Google-Smtp-Source: AFSGD/WBeY9LmV7DIXmFZwKfJD2sYa+bqdvhbeR06tOSq2igIBMpnjnFi+kiNZ1wh5eEeQYWStd4kw==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3mr20525665plz.124.1543966702841;
        Tue, 04 Dec 2018 15:38:22 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/26] aio: split iocb init from allocation
Date:   Tue,  4 Dec 2018 16:37:22 -0700
Message-Id: <20181204233729.26776-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 634b540b0c92..416bb2e365e0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1099,6 +1099,16 @@ static bool get_reqs_available(struct kioctx *ctx)
 	return __get_reqs_available(ctx);
 }
 
+static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
+{
+	percpu_ref_get(&ctx->reqs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+	refcount_set(&req->ki_refcnt, 0);
+	req->ki_eventfd = NULL;
+}
+
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
@@ -1111,12 +1121,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	if (unlikely(!req))
 		return NULL;
 
-	percpu_ref_get(&ctx->reqs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	refcount_set(&req->ki_refcnt, 0);
-	req->ki_eventfd = NULL;
+	aio_iocb_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1

