Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86FC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB5A218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q5B2XIA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfCOO7s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:59:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46914 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfCOO7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:59:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so6621759pgg.13
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP0RIMIP0Dhv0Z3VwimEl1gZSo5mPCskMpjat/g+ZWI=;
        b=Q5B2XIA3o13t9GSzsQbK8sE651mnRmz0FDF04NOuh0sqpEH7gMaXegRLvfuDuulYDe
         mRKiRP+DEBaYzjjo3wArP3GZQ0bGCEuFChN4YEKgJQaU1WtFM2SQkJynmQWYD3Fzj8I8
         gwR6ExlEVWAjvCmWBt6xDVHQtSA4SPYp6cunpok9yTdip8WhdAeB2W8PtyQc4BdZp3vC
         Inyun33YXY3iAbaem/JIHpqcLxekLGghmMYaADq2JV7EvZHhFXkUTOctlbbZ2tEwk6x3
         GEj/h/Riz26DKvA30dmbr5VecNcorRCqqfYT69XsKkbPLidrw1uGLoHXdqRy71um9+BX
         ES3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP0RIMIP0Dhv0Z3VwimEl1gZSo5mPCskMpjat/g+ZWI=;
        b=j4qnioMDfiUkha51fpbOfGTtrdWkdasDOWXmg+tlyBW6vJ/uF55rXmk7bcqsCbaJ/G
         wWbL1ZJ3BKtOFncRnpa1Z1qzPk0StJxVwcP1jYr2YtTiVlMVlLp06i1hSwMUZKe5aiT1
         kplJDyn9iSzdAQUy3ydaJTWsw8A40rEnR016KU2GnL2mHBHLVT0NPVjXkBCt6yZLcgHz
         CcEBLRvY3iMizFarI6B2juNNKJ9pBDSdwCSR9sUIZBxe59P157AR07rwd33Vp1pZ7x7h
         2CIxhE6266TXG8yRstAIrFPPjNsGREp/RhEkzQ82Svx8FHyFHnCebt2LKKGzVXFk+meD
         cNRA==
X-Gm-Message-State: APjAAAU7oHc04ob12ah5vuwEizOkICHA0IeydrODwRVTgXfi0P5az4J/
        eadCW5pyENC5WtQlL4foBaJVxg==
X-Google-Smtp-Source: APXvYqys/fbXqgURwR1PbWrDiThPOX1HA8pdaQ59Q3iqAm147y+KQTuhOCcF7kRmF6ppefgBEartMw==
X-Received: by 2002:a62:1d8c:: with SMTP id d134mr4453958pfd.185.1552661987812;
        Fri, 15 Mar 2019 07:59:47 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f28sm4287179pfh.178.2019.03.15.07.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:59:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add io_uring_event cache hit information
Date:   Fri, 15 Mar 2019 08:59:38 -0600
Message-Id: <20190315145938.21516-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145938.21516-1-axboe@kernel.dk>
References: <20190315145938.21516-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add hint on whether a read was served out of the page cache, or if it
hit media. This is useful for buffered async IO, O_DIRECT reads would
never have this set (for obvious reasons).

If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 6 +++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f66a4a5daf35..513df722702e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -635,10 +635,14 @@ static void kiocb_end_write(struct kiocb *kiocb)
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
-	io_cqring_add_event(req->ctx, req->user_data, res, 0);
+	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
 	io_put_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e23408692118..24906e99fdc7 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -69,6 +69,11 @@ struct io_uring_cqe {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOCQE_FLAG_CACHEHIT	(1U << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

