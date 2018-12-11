Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B6CC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B01420870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GCnoPPUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B01420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeLKAQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46550 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeLKAQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so6013873ply.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=GCnoPPUoagNq0kOwllOvPwQlYFRv/5BkOJlrw4jvQfsgDG1Ae6xGy+dthV6G9g6+ZQ
         IFqGL7YskI6o9mX4YWKoxWchXjm4XGdd6+EPZZfHvETv9AABLvNrkNcABH0+5AzU/a1c
         zYLProS0ZI/Hlq9fl3XKC+MPRDSgUTnBPQI36y2VejSPQTT3oKIMtgWpWYkkCEmJyVTc
         0+Yy80GZhODptHiU74Ke50zMa0JsnuTaa/mEKvCY9/2yjJyn+p7PYMcSRqMmxVKWcLVy
         hYEcb1trx/uR+jFabA/qCcLQ4T1IQCLo/bbGyXhhvJo3sUjSK4sfYxtqx/CYqwh14OWm
         I1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=RWv1fQg3y8WrNT2hJCi7ritmCUsy/lf8E5ZeknybTVzMFlHIZa2wYhbgQHFM7Hzvas
         4C2kbcg8P2bruntuJCFziyp8gTkYwWCuIbqhd6GyxN/5ZJxKHci+6oJgXepvTZHmq7eQ
         dT/FyZD17zCt+UV6yA6/6iQtFWCwLfPPSvi+n4UTC9UeydxK6niebBYobhqZrMW62Z82
         NKXm4ljTl+x9Wp9f6rgZxGcwTH9lfu38KS6RGe+p1koDQAiLEwJUwEFGJRHDaPzDobJW
         wjEx3nYeuTaF07JH+WVILcdieGtTORf7I+HmhstTiOXlVV1I+DqLrgw7jOOJGNKoALNa
         JDAw==
X-Gm-Message-State: AA+aEWZU9y9+7TKUYYeszZ3BEgtoXQCTF5YZGYcD/WoNZEhYimMVUbDy
        ty1Y8PZ1OWjVtqqm+llIwy5edVAVpCOfpQ==
X-Google-Smtp-Source: AFSGD/Xrsck6afU4P2Mfh9U0ZAqNvpmAN/Gqg+zayLhwzo45glZp8XkqY5tHxWS0fulXouT190WmPQ==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11mr13871283pls.177.1544487380952;
        Mon, 10 Dec 2018 16:16:20 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/27] aio: abstract out io_event filler helper
Date:   Mon, 10 Dec 2018 17:15:34 -0700
Message-Id: <20181211001549.30085-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 06c8bcc72496..173f1f79dc8f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1063,6 +1063,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 	}
 }
 
+static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
+			   long res, long res2)
+{
+	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
+	ev->data = iocb->ki_user_data;
+	ev->res = res;
+	ev->res2 = res2;
+}
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1090,10 +1099,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
-	event->obj = (u64)(unsigned long)iocb->ki_user_iocb;
-	event->data = iocb->ki_user_data;
-	event->res = res;
-	event->res2 = res2;
+	aio_fill_event(event, iocb, res, res2);
 
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
-- 
2.17.1

