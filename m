Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E605C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C22146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cXKb3aOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576C22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeLAEHI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:08 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40623 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeLAEHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:07 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so10216297ita.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RA6SARsil7zOqlPTyhrfo176dQaQeNwiqXCQQq9Z3o8=;
        b=cXKb3aOYD6f2kYsDTK5bOdZz8yeyWYXjvNbeRg2EVolRnF/oVZGdpMZrt5tgBb9+DU
         ncEsoOaeILYqgqJaJhjQadqUli/mEoWF0TeoDHa0/KB9Qce0OEybVDkqlUkn2pUiw+n6
         ZR7sbZVPECT9MbjodsIHF9Sxa59OuzoW1mh+2SyLvmUOv6cGg7rcy7p7uVpVpvvQ2QY/
         YKzFECV4d+1L8hjoExG6FzQpZwOrf80R+NSHVhunjzCewK0hj7neuflrb6OVDClJCs36
         qQvumqz899pTdrgyCUcicQJpHKi7C4nzqjrZTwgIJzX3AzysEcrBuqEEbtbdGt6i7qUV
         sDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RA6SARsil7zOqlPTyhrfo176dQaQeNwiqXCQQq9Z3o8=;
        b=ozPRG/rs8wNHOx9MdVBLnAwlmp96AKK+2KLHe+SacjMPzMfPZIunPWHvH74BEz2SkA
         Lc9d8FRNE13rD0Ijmdzioy8nN3WGOUwThcDXyJnaL+8PTSw2nzXuk0bQ8u+jZ01xWZSK
         wMm/TzNTYXlvONAvhMO/dbU+fO3CunXQv+eXiTqbOpKZ55KVp+3xLfyxkQBMcMnFIk/V
         l3bagyoqmFcmmq2gmvss0dtgZb0Ka+o4MaXgpb9UzAztUYBUElNhroz5QCwccPsTSTct
         gXK6hZZVyb0p+mHfyDaG7ZeEbvnrdU6jpPV/LDVVzwKRIzSt4LpAVR1/BlVBOh6Mudux
         054Q==
X-Gm-Message-State: AA+aEWZZftcWILrv1dlXTySR6PnI15nuiMDYK/bcIqaTgzaRd+7xuBPS
        GeBHANsLr8bkB5RLbZDmM3NHbAQhRGo=
X-Google-Smtp-Source: AFSGD/Wn4z2tODm+l3fGGPykhpju4YxFoTGQtbJIDaIbhlFRtJoaoR51V27WrZ4R8mE9x4HCNPF38Q==
X-Received: by 2002:a24:9a01:: with SMTP id l1mr5788132ite.113.1543597031767;
        Fri, 30 Nov 2018 08:57:11 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/27] aio: abstract out io_event filler helper
Date:   Fri, 30 Nov 2018 09:56:33 -0700
Message-Id: <20181130165646.27341-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ba5758c854e8..12859ea1cb64 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1057,6 +1057,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
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
@@ -1084,10 +1093,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
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

