Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA56C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951152086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kwCDzfkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951152086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeLKAQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47037 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeLKAQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so5740515pgp.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=kwCDzfkPee4ZtPzlWVNLI+lJRi5gToNUPBgEc56domEEAg4IR5gD306QKokM9D83QO
         GST5HWe5HOSi1eV1lraM7vurWHttSvDO7/x/c5+jsOHHEiiDsJqKsLTCiNFka5TDxckL
         OMHw/6fBXIGZ8FBdpxiv50jLuMU4wjAXUhh+LRGDIwrsEQUFJyLW9e4a+aGpXLHeSr4i
         IbGrC4GQ5iILQEkDXb/P0ftb1e0eyMCwuoiLkI2LAIqrZRIDvzv0Rd/VyrPpxY/AJqNx
         3emZDCZSbHr3qzKFMu1L17S0E5mHHwZU4KV4cUARmiaJM0RaqKVV5/FrBaMPFLVDf4c+
         D68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=H/HRFOGkRSWbkoILAejgyzGQCknjHEe+Ad9JDGR7lsyGteUOvLv+VXbC8qlP/WNH2a
         LpNbUOHSBkW6AwCkpS4sqH9/S7pnN1aNgtcDSQcQ1le/uoWe+9CG80TgQJPT3+kbIUeq
         YRFcc5dDFYMmWryF0A/UvrsIMbw8yAlFexJp2pt3dKGnw6JMkTTV+5OcL0SshJ0SqKDe
         u0rsPd7BpPptKqqG7jHLH0RgNMO7SQ7gvaGwXo/4/EgR2qy1oI82almDKV9ItcJOu3kp
         vfhNrbAR9xlI30mK7EiFEHZ9bU0n8D5Vuew7N2ikG8Boz6rWT/p7QNnjT9wrPTryXZDq
         5IBg==
X-Gm-Message-State: AA+aEWZFLbHpWSiWkxFLaHNt9JyZzQocGwY73U+gdqw73ttQm9IS6TZP
        +ErgDTxDLXvxPr63ZoG86h9hC6hEIm4L+A==
X-Google-Smtp-Source: AFSGD/XvYERFo0Vz9cDYn7LnxLMrIx/U/rmSwCOFvKBEe4f0B1NbhrDYzsqLsmggbSYfaUkgqaZLzg==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr12587322pgr.432.1544487374939;
        Mon, 10 Dec 2018 16:16:14 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/27] aio: only use blk plugs for > 2 depth submissions
Date:   Mon, 10 Dec 2018 17:15:31 -0700
Message-Id: <20181211001549.30085-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugging is meant to optimize submission of a string of IOs, if we don't
have more than 2 being submitted, don't bother setting up a plug.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 522c04864d82..ed6c3914477a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -69,6 +69,12 @@ struct aio_ring {
 	struct io_event		io_events[0];
 }; /* 128 bytes + ring size */
 
+/*
+ * Plugging is meant to work with larger batches of IOs. If we don't
+ * have more than the below, then don't bother setting up a plug.
+ */
+#define AIO_PLUG_THRESHOLD	2
+
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
@@ -1919,7 +1925,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
@@ -1932,7 +1939,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
@@ -1959,7 +1967,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		compat_uptr_t user_iocb;
 
@@ -1972,7 +1981,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
-- 
2.17.1

