Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898EC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940792192D
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cp/Jii7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbeLUTXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:04 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38662 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391631AbeLUTXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:03 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so8019258ith.3
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YmQh69OWzMNazR4KrWCsmkjt1yT30wP5g9jvy5MLpIs=;
        b=cp/Jii7SBmo3EhtD1ncY3a8m96TLgDO09oejwE8faq6w8Q+uDuP/IfJv12OfQq11vd
         MtyrsItRDAOumwjpIbSTKTPtujz9Hmugyc4QEs/KzVw2QQwmDAsdUn1J2MKSbnECfX1R
         HyvzT8dMD3g5mXFgokS1+JpU6zyQ2bvKRvLWoZMn5VzuE38NIM37YtJOiqJPECcebSH9
         TiJA36NVkxCA89jryWjbeT31n0e8KXQmag29XRL4XAwjdW/xYJ18KvF19APrcTr94it+
         ce3ZKxKiXp47TIFUubTWtTv/TRK9RAgXjXba0BF73KlJQRPD0N84SGR/CVnO7I/6usUu
         8LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YmQh69OWzMNazR4KrWCsmkjt1yT30wP5g9jvy5MLpIs=;
        b=I43lkYPtBPMGMJTf7q6KUtm85oSZlAQtSugQ1E3dT/4AIfX4Hbk1XmNE6GgJULaVR9
         yaX/LwyxzFPihr9RN6wnQNXDVM80CbdLm7trbK0W6S17JnAjA7+sCAv1IPdRB4p+drxK
         T5aXd7J9+w1I9NAF6Wjn4x8HZ9hzhGizUb3H/sqZatQ+wMY0uaTbMDDdEs51Iy1EMTyS
         XQIM9Y8L5Qn58reR0X7vlEJEy2Ijv7EeZNBUPYXSS5m2+YcLyAp9EwQW7wU1oCq8YbZ6
         ItC9j2yBloynQs9fxIB4DbMbfQnWxQXdyLSbhOEHJrkn1riOGx4LeZRPrRwoJj08tirf
         pIXA==
X-Gm-Message-State: AA+aEWZkvkA3PbauSFTT2u9sEKz3a+U2GdyTU+KPq5JUL5mT44D16z7Y
        TJtk7P02PSVKYlJTIQD9o+dUwg==
X-Google-Smtp-Source: AFSGD/WQugzEmJWuku7bCPQqogQu+14Ams5MXrL+s1Fm4fTd8//hkzO4luC2E3rw0iwymYjOSMHwwQ==
X-Received: by 2002:a24:838c:: with SMTP id d134mr2700519ite.3.1545420182796;
        Fri, 21 Dec 2018 11:23:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/22] aio: split old ring complete out from aio_complete()
Date:   Fri, 21 Dec 2018 12:22:28 -0700
Message-Id: <20181221192236.12866-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 513ecd3fa681..d33417bee594 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1198,12 +1198,9 @@ static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 	ev->res2 = res2;
 }
 
-/* aio_complete
- *	Called when the io request on the given iocb is complete.
- */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_ring_complete(struct kioctx *ctx, struct aio_kiocb *iocb,
+			      long res, long res2)
 {
-	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
@@ -1253,6 +1250,16 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	pr_debug("added to ring %p at [%u]\n", iocb, tail);
+}
+
+/* aio_complete
+ *	Called when the io request on the given iocb is complete.
+ */
+static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+{
+	struct kioctx *ctx = iocb->ki_ctx;
+
+	aio_ring_complete(ctx, iocb, res, res2);
 
 	/*
 	 * Check if the user asked us to deliver the result through an
-- 
2.17.1

