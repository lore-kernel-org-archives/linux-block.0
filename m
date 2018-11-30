Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF2C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9F520867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1PjsMo2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9F520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeLAEHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35943 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:19 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so10245163itj.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QMzfrApNgSsegtiyNm54nDrw8Z5lsx9xH88UNkAmxlk=;
        b=1PjsMo2k/rQM43AQfyKScK5BXnVtVvpXb1LlF3gELn8KexP33dB3x7LFs0drxK7yqU
         TzKQ/vdBnbHRnAXC6/j4KlIgwbdM6X4P6ZTz9ifSOiyR0yI9drQQOYC84YIQ5QHwXEME
         8E1xOYc5LV/4lz+6RkyFTa9mR69lYNZHRggqubflttTMZdtEsJdID30cQnAi6Rar/xKI
         VL+cy2upK0AtiMN2tlWrDAlqwhDI7XzN7DrzIHae2jmGb9cKKeP7IXU4WzDyqyVxXoZM
         XqzjTOdhtEapoYTmnTsSLSEnsfWAUol5Qaac1+HgNYcfZ2NNb6KMwWfO4xEX3KwZI1qq
         v5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMzfrApNgSsegtiyNm54nDrw8Z5lsx9xH88UNkAmxlk=;
        b=iZRxprZwOkCc+0yCY90iF6U0dKRnOkjWEXScg3I2BfEzjZEFfn4o3VahoIobu7jKZX
         gePt28fZVO1L3/NdkUonypadmJcsKoKwr4R7U4dEMv67UjGi15Rus3kgZUQ64BISq49K
         q88MVD4KIsdTKpaAMns2DfJG9Bl/2bcDV5djtCj1mlNlarfqlPVw02pMpt0QE5DHdlYK
         Opw9Kt2+pbT/0MHKaAxf2hJAayp93JaLpDMQ1E1DJjfZmRZVtU2KdHAETAhNpMr22Huc
         Algx4EJrJqUEAUO+qmJJ93ytqr+xdBMFKHDHAxGRYhbyzbAsuY0mLktMZXHobiVZl3WS
         Uqsg==
X-Gm-Message-State: AA+aEWa3Qd5ahaZlUwWXXmSYwSeULS4MnSWC0/zRzA0in9nXXVPEkRXJ
        NMd1mgwAjNmYlp3VTD/JTUyaFYstWO0=
X-Google-Smtp-Source: AFSGD/WfVDvHOK1f3lWSyhg9zT73G1kmZ/RJiyHIjtEAanTVcHjuWMOIt6Hd55ywnKROuqocGmP2hA==
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr5563963itd.148.1543597043189;
        Fri, 30 Nov 2018 08:57:23 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/27] aio: split iocb init from allocation
Date:   Fri, 30 Nov 2018 09:56:40 -0700
Message-Id: <20181130165646.27341-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 291bbc62b2a8..341eb1b19319 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1088,6 +1088,16 @@ static bool get_reqs_available(struct kioctx *ctx)
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
@@ -1097,14 +1107,8 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	struct aio_kiocb *req;
 
 	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (req) {
-		percpu_ref_get(&ctx->reqs);
-		req->ki_ctx = ctx;
-		INIT_LIST_HEAD(&req->ki_list);
-		req->ki_flags = 0;
-		refcount_set(&req->ki_refcnt, 0);
-		req->ki_eventfd = NULL;
-	}
+	if (req)
+		aio_iocb_init(ctx, req);
 
 	return req;
 }
-- 
2.17.1

