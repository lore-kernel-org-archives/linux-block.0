Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABCC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5165C2083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PsO5M1NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5165C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLGWVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38046 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeLGWU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2573918pfi.5
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdzcXBictQlYbUlStHxqWqhzWxN3PnIKj/R9vsgka+c=;
        b=PsO5M1NZ/rF8/n9dzwaRjhm3pJMN1CMINpKOUo4iOb0uO7zbw/torLf5p7AUR+4v2F
         UcVUsWaeGSoqj9bI6GyYSQdreZMFHYehZb2lwtBQgSS00fpMrcq69bmWE9t91ESkkU4+
         gmLlECDbyJaJU4u3Yi4OdZPQqlLRTfJ1KVMDSv01kQgqfHVI1Lii2NcBJrCN27A4p5BI
         iOzCBc9zdbNjxbP6/HYkxAnW3DNrXdo/uHqwvEHt+h1kUi+UK1KQ0Xw8L2lRrV/atc3p
         zifr/4YRWiEeVsZQokSgINtkttT61ykJzb6xXw9/VBsmyNLBc6fzeCiRVT6hLZZGmAAu
         rCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdzcXBictQlYbUlStHxqWqhzWxN3PnIKj/R9vsgka+c=;
        b=TC7uy8X3omyMnXKSxHXmdu9TMvipZVGDtiiUcVLFI4ec3tjsjTxNxi5XCaS5by8Rp4
         dT0JgRYwdU/OaSUTqycZzuYCc8TZHKpsCdbWyIQkJCgsDoDxawDmTBaRiVNFq2NGv/92
         eqrTDuTtqpPSR51VXK+5hz7IYGBGp8aCQYhl06CSd3gtH7V3bb9SnxNgJzTsrP0EceX2
         5PuNtLhsA9JERI92nB6EdSAeCIp/ulyoXZP4hb345SCTnYyqkui5KKXp4TSy9RCF65QS
         mi9NaYkVj5WgWp2PMvUT5lP2kUP6v/ZB40LvXTnje978DEbap/jtfKTpUmLMbsztEr6C
         jiYw==
X-Gm-Message-State: AA+aEWaoCpy11q0tMzK/JF15B6UFwo6MXXJK393DyQkvFb9mBzPDcKju
        Nbpq2GxA7/tPO4M9xigQUuP0hLbGoUE=
X-Google-Smtp-Source: AFSGD/X2tb6Tl7VAekiPGQmP2AYLfPJTu9UbZZxILVGaHZ/LYeMfl2yJY406ym01aM7K+RLk9X8hJw==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr3563577pgj.340.1544221258789;
        Fri, 07 Dec 2018 14:20:58 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/26] aio: split iocb init from allocation
Date:   Fri,  7 Dec 2018 15:20:09 -0700
Message-Id: <20181207222016.29387-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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
index 3c07cc9cb11a..51c7159f09bf 100644
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

