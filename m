Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F4C43612
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5217E2086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UwO2tP/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfALVav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfALVau (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so8559642pfo.7
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+QRhJk0MXmcBlpj1fw6MhS+bnf5QaKKqC3bc/BXBzqQ=;
        b=UwO2tP/ElljBAGpZmLbt8szeLpll+tp26zd0c7Wwf3R1W36lXSL+Cqs7aDu7lUoM/f
         /nq9oNIx/eNjo1M3bCoLgbqoARbTJh1lP6+Fcf5Ziwe3gN44JJ7zLGWdKpx6t0sXNoet
         wtEWWbL/1hGrssQ2vWTAkhhoPdluIusL/B0B8MaizbJf/KYADiwOm1VXVDye4oUnsb9M
         3u1AqFOyW86MFao0ckTUJhNEc7FuwPVfjcQg7+y8Whq9A4Mykvt+6I9BFCep3hDe3xou
         7oXBER7XKpjKzSJ11hwtHfqHgxZ6uyf6lg15+bcOP8NknnoANUayexidOCpDpE0bDICM
         wuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+QRhJk0MXmcBlpj1fw6MhS+bnf5QaKKqC3bc/BXBzqQ=;
        b=KNnFpkv8OgA0dSiU4xaNrYgqe38Nodig+eH68VyHtvEeskBnb7zrPuXIM7F02ikyyF
         0RU/y2K3WiDzS730No5OZxjgvRsmsb9OTXrefa2Cupcyr8Q6se6nTzC6WGKi+uukrbGj
         IjR5AR9a+ulDKsuYjPGDdI/ibkbdSwyrqYHo36QZG/rkFi6WTOmuvCy31mWLZhrOUfxp
         VRTnrlzLzmESUP3ejaigh47EDVPq1EoF+X7MccXlKGauidvnLCGZ9lb4cy4FugKfyV4I
         4rTkIqeSVyFldRymQqNE+tNIC8kjdvTeW9bMMDXzikPPtRq6kXtRo63ciSlPIpRUAZJ4
         LD1Q==
X-Gm-Message-State: AJcUuke9XiNURdUKAqWdWpyhIWagnGr+G3EvwamKaet5OT9++fcRQ+Kk
        h5uTA4nhzuGGrf8EYkmdgseIIQ==
X-Google-Smtp-Source: ALg8bN5sieoHokZROfPSSs9hEYsV4JoJMo19+NEYc2uQ3gv4z9SHweXzhDZAui+itOLQduEgBgYOqQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr18096292pgj.24.1547328649475;
        Sat, 12 Jan 2019 13:30:49 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] io_uring: add io_uring_event cache hit information
Date:   Sat, 12 Jan 2019 14:30:11 -0700
Message-Id: <20190112213011.1439-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 7 ++++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 66a76f9fa7af..5074cdd85f43 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -573,11 +573,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_fill_event(req->ki_ctx, req->ki_user_data, res, 0);
+
+	if (res > 0 && (req->ki_flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(req->ki_ctx, req->ki_user_data, res, ev_flags);
 	io_free_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ffdaf46f19dd..74370aed5f71 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -67,6 +67,11 @@ struct io_uring_cqe {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOCQE_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

