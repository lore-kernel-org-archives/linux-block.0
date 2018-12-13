Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D4CC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F652087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EPf1AMV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F652087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeLMR5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeLMR5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:14 -0500
Received: by mail-io1-f67.google.com with SMTP id l3so2282532ioc.10
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=EPf1AMV38c6QbiYrRYp8twmPBH67m35TDItx+s1+vl9Nv2Ex4wOUvyjzzQOhREoJ7R
         WqsC3FQSs73r6w6BXHYeNU5e9NIiOBlb868OZb6NV9KuUkRsFOo7uU6QEqKZwuWDQm9d
         H3KaPWvizbSj3f2OoO+Tfj9s/ikHlbZy2GUaL+XlaC44Dzp2QMTJWM0+fT2tO6zL/l14
         SFLVtsbSEHoK0RsnyfOXyIbyQjRbvstVTtde9nzrSOrG40RaGCVxpJS51kjMZKfaphbS
         KZNTg9zJcb8PxpwjB7z6IvsX8JA4U6gKWwE89gs+JRq2LnpyJiQxBVcKYENYjERkdJLF
         DzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8yxXuFlKRVZGhU6vByhKAQcKxwaMq31dRwuK5kkt+A=;
        b=ZYCKV4vIuUKdoX95WlpywNBezoEXSq3qPNefXoVcutp4pqomaMqtcyh8iH68tp9shx
         TdbZDyh5lfDQjESx+2UCy1Ujk4bQ8D8Ac+ApMdHsgjIATxM35Rw5pIdqcNb3P0OXUUZF
         Pw9CHqnRXrScal8RSIVQmQySMhp+gdfRzbA9sQlaXoWNeocM2K9pJ5LjsEGUdA/uGMqD
         I5pQLaXHDBOkiyUVXOHkijYIveZlr973P3r3/D7pwZVhkmib35oDs3X3CVwhHRo/JsfD
         mLd6gJaW5LWnsGRQLLUhzuLNot3iGv+skoCiSn03vJQHGAE5yLGSKYk8tjtpDdXZoCdu
         3/Hg==
X-Gm-Message-State: AA+aEWafUmKCTsp5mzJQyJ+uJt1nviJ070Ut4y+FqBqaSjm2X/SrM/tk
        PPKlgZIv1t2UawqdAECPbzjeyPDkW8fVuA==
X-Google-Smtp-Source: AFSGD/XWw3oW5UdfuS3ELzet6YOTbKrkVq1suqQwvq/HO/W+GPuJEuxBHdWjFSyKyCO/uWKBtqx+lQ==
X-Received: by 2002:a6b:ea05:: with SMTP id m5mr9102536ioc.97.1544723833113;
        Thu, 13 Dec 2018 09:57:13 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/26] aio: abstract out io_event filler helper
Date:   Thu, 13 Dec 2018 10:56:31 -0700
Message-Id: <20181213175645.22181-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

