Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF42C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0E21928
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h3rgJGeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbeLUTXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:23:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41652 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391697AbeLUTXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:23:14 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so4488762ioc.8
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svESWgD0ciKM/+mOIh/4jEfbiuye9Bk8tge4nuPgSO8=;
        b=h3rgJGeS17f73IaoHZAmYKroFQ/a7XQIDPVs7x/4Yke+wbVJ5NAfIQKmg+T49Eja/B
         7nk3dtL384WsdWz9PGRqGEUFXjN1oFgfiSdgRW73E2mBmbRMkFIt/fAs424gfgrFgEL7
         4cuYLsnhwwqfkGeVGssZbJCl+qkrP9SF0ESStszS2mx3jNj2lqIj3SzL+DtZNOdk7AKM
         ZmRZHy+fHXVig7yAWRrUkbufS03V+VswyAlqsrdgeiLWeiPMVHhIyeDs6LVhzWqJGxtF
         4WJpl/ICsXIa7/SNmseOBmGbVzGeYdOJg/tqyriy7CqRdIuayZrdnPRiFEjvRoqyHRKg
         wJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svESWgD0ciKM/+mOIh/4jEfbiuye9Bk8tge4nuPgSO8=;
        b=Dr83zCi/9fPgIJSMXTgy4zKZDAbedtjaPLKC0FeQtghprAa1ExJDKYt7I+N7W8AoNA
         Q60MgqJDQSBubT0fOfsKlGkyJRwGstLKRpAxAal5hj8yzD+tKh9Za4Etr0caiGpWMzQX
         u/NdnzRkE4rccQd4Yoy78Y/C7bEKmLqk920BkgCx8csMIz+4frjFuAZAbh2xIp3Rugur
         F31+GwP0Jl/a/P5JsKEL5Jzej2BQloUrTzvHF8NO8uCtiaQuiaTE1VkgL/0XhNrpkHhI
         fdsTpxqQSynBlpUY8xGRF2sfzPEZ5XMptBDPwYo67IdELVTjTuLPb6yJq76/TueCCpS7
         zdKA==
X-Gm-Message-State: AJcUukcmn+uPsal5y6dv0zHWzo49iL0Qptpfz9dzFRsktDqyzncjrGTp
        5jq8KRW3H3qW3JAp7KWLQYuwtA==
X-Google-Smtp-Source: ALg8bN6NPKS84d546tfg7/xIIk0aNGTHlmpxHl+U0OYgjV5ZwYcjfe7cWqfabgeOPdDUb1NDip0x0g==
X-Received: by 2002:a6b:b556:: with SMTP id e83mr2624547iof.195.1545420193755;
        Fri, 21 Dec 2018 11:23:13 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:23:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/22] aio: utilize io_event->res2 for CQ ring
Date:   Fri, 21 Dec 2018 12:22:35 -0700
Message-Id: <20181221192236.12866-22-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't use this at all, grab it to provide hints about the data.
The first hint we add is IORING_RES2_CACHEHIT, whether a read was
served out of the page cache, or if it hit media. This is useful
for buffered aio, O_DIRECT reads would never have this set (for
obvious reasons).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c                     | 7 +++++--
 include/uapi/linux/aio_abi.h | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 8894c9299b39..a433503a2dc3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1361,6 +1361,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	struct kioctx *ctx = iocb->ki_ctx;
 
 	if (ctx->flags & IOCTX_FLAG_SCQRING) {
+		int nowait = test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags);
 		unsigned long flags;
 		struct io_event *ev;
 		unsigned int tail;
@@ -1372,10 +1373,12 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		 * see it and punt to workqueue. This is just for buffered
 		 * aio reads.
 		 */
-		if (res == -EAGAIN &&
-		    test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags)) {
+		if (res == -EAGAIN && nowait) {
 			ctx->submit_eagain = 1;
 		} else {
+			if (nowait)
+				res2 = IOEV_RES2_CACHEHIT;
+
 			/*
 			 * If we can't get a cq entry, userspace overflowed the
 			 * submission (by quite a lot). Flag it as an overflow
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 26173de01fee..809c6f33f5e6 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -66,6 +66,12 @@ struct io_event {
 	__s64		res2;		/* secondary result */
 };
 
+/*
+ * aio CQ ring commandeers the otherwise unused ev->res2 to provide
+ * metadata about the IO.
+ */
+#define IOEV_RES2_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
 /*
  * we always use a 64bit off_t when communicating
  * with userland.  its up to libraries to do the
-- 
2.17.1

