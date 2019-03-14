Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B5C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F61D20854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dpwVwuZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfCNUo4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35507 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfCNUo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:56 -0400
Received: by mail-it1-f193.google.com with SMTP id 188so7371823itb.0
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGFJ5HGPoz/ktnKoEe1M9JMfYCh1Xl63PfrPUdXe2mU=;
        b=dpwVwuZfEY46gyqEya30pK4loHBgwJ0o32ppkgOurjxCt0x7yxUa2cqsjEp6bM1Wgc
         pwtsDuM9qi5q5+Uz1umiQB1BIH27t0EgOhEi9k9mxgK3BMLIjvM4lUtkROhx12B00WW8
         /Q8Hub2ikfHdg7QglxI9rH1zz/EHz009umbnKy0jx+0FDtys9SI1oy9Kbs4HD66g20Bz
         5VMDhsC/xEBwNZgTja/UJ/EiaSb2LbdNO/wKAOiFiAmZOausj39K9QJ0HW2/Wr61FRnb
         0HevPn3k2XnqykEyyTxCcIKguy8buPvmimMeVoxLLVg6qYUPyyziZN6MbjYHlk2IjPjI
         +80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGFJ5HGPoz/ktnKoEe1M9JMfYCh1Xl63PfrPUdXe2mU=;
        b=YwrMN4xzvPK34Vfb/G7B1PxYAfMNu6rDW1cfGBI/qYFnCu4Q9bxl+AQKzRW748nWAv
         Zt7ysZmiJhkvIvHbSbtQwN0FY4vJWUDPzX3ajWYGglY3bCtlFoYZsTxI/vz3d/6csUiO
         m3v687diWF3Tt0GEXRQVxR5QT879by3JIC7LzguNAOAqZ0T/dxQ5ivb9hm92VUzIKY1X
         WvZirLEIpTMd/aS36dgNU0mEJxnTc5JDNZQ7E/KAr4y80h8k4/Yoaw1eSFpfhwhGtKGU
         VhTemCYEFLE3k4tPWqC8z5zYG54sfNwb679jPwyHoC46yJO23h+mEISvxGMPbPz3/M8V
         XB6w==
X-Gm-Message-State: APjAAAWpf+dgygKGq0tqeIvxgPlZ08jjXogMIiJ8Q4BAWlofoWTtLzfI
        qkKe1z0eizkNY4HYnjJVJWFCMQ==
X-Google-Smtp-Source: APXvYqzh7OViW2aFBiKTuBennqWW2dDjWk3E5qSf4Y4qA51RoR1yywPEuiY+bO7OMV06pEVMtOo5RQ==
X-Received: by 2002:a02:a903:: with SMTP id n3mr148847jam.3.1552596295243;
        Thu, 14 Mar 2019 13:44:55 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 8/8] io_uring: add io_uring_event cache hit information
Date:   Thu, 14 Mar 2019 14:44:35 -0600
Message-Id: <20190314204435.7692-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
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
index b89f91ab6e32..3437f538b377 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -625,10 +625,14 @@ static void kiocb_end_write(struct kiocb *kiocb)
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

