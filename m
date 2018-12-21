Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E0C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244B221928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N+Lt4/Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbeLUTXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55956 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391631AbeLUTXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:00 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so8432913ith.5
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JDeCVsy7jDLcbGUHdnLQfCWULqbGuJjXneNakcz9EtU=;
        b=N+Lt4/Zus7cYcd3vbDF015+9Z9P3hIMyV1hhIcz74/iSKQVo2YsXn+LaBlq/ZeB9TU
         tz7AGfNgRy9ZEGZncnLcX2K0fSXWmBK+6kEyJR3UeryQqALp+xZKXNsfy5e2C7z/Wf4g
         qQmndFcay8mOSzT4NqRCxxrvmW8d2Gr6WjRuHRcOKCIOkguVyzCb/ml54T2of3UBs88T
         zpJaHo70YV3dCk9rfEBAvoh3opddgKtN9GynsdfRqiO/7KgeywtXwCV5VqDt29AlWXEc
         WE1eIwsNxcGNiZ+cwG9wM560EbxxFhTJq7wQHBVgStFsdoUD5eRUrcYgP170/SiSix9j
         X7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JDeCVsy7jDLcbGUHdnLQfCWULqbGuJjXneNakcz9EtU=;
        b=jn+XGxo97vhPHlKsGo2hdcKTWi6GX2EK4h7LQoYa5nRj0dcYHFlETz13+vU2M2aXvC
         ohitBi31E1JogWEPtv+6keYmikRB0GtEPD0QjnqkTIVdL+YEgF17soeXzTvdqWPVSGqK
         /eVEkzLY8SKcBjUQe8bF0HwuYqu4SNj/g5iR/9c7QnERu5SjeVV6JOhGNqHDSrBkVXPV
         qq0Wbe+U/ULCajIDRwrrNQJTGAM08PTTn+1anktLlv1T2bB7oJJ1KlCeuUohVV8MgnjZ
         2xCxgE4pkOrONafzQNwhGli/yJR2UGuGWBforUJNlE/z+BxtJLNYX4ykOhOHUGfY7ixb
         GZBg==
X-Gm-Message-State: AA+aEWYcUz2CuIBMC4IzjNA4y7WHencFFS+XcwnKx62KTexXGVO1A8U+
        X5yWJ9UP5YzIPCFKtbsWJHKrvA==
X-Google-Smtp-Source: AFSGD/XNknEu1MesUURics0AZoJJ8UhJFgcMl0teTbiM2/r7DbS7mN/ahX4sGb6MBaG/PlTaXrt8kw==
X-Received: by 2002:a24:fa04:: with SMTP id v4mr2483408ith.175.1545420179465;
        Fri, 21 Dec 2018 11:22:59 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/22] aio: split iocb init from allocation
Date:   Fri, 21 Dec 2018 12:22:26 -0700
Message-Id: <20181221192236.12866-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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
index 33d1d2c0d6fe..093e6c8e9e09 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1091,6 +1091,16 @@ static bool get_reqs_available(struct kioctx *ctx)
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
@@ -1103,12 +1113,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
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

