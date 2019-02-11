Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F0C282D7
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFC42229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mUGWBufn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfBKTBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55349 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbfBKTBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:31 -0500
Received: by mail-it1-f196.google.com with SMTP id f18so844293itb.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMslq0N8X0t1H0ZLeYb4gEGrDwD3teAaU8eAnimA430=;
        b=mUGWBufn4wcyW+HO0KyTqNIVRGzO3XqzBm/LtFbCITxllraKTtIQ+E77/tcV6nQxy9
         ZqWUr/3RuG4mzPaDhiocvNQWidwcHhpMUyG3ptAZ0U+Z5NU3oIero/P5dD8xJ15es38t
         lvbWbmt3u/OkR/nlOQ2UFez7GCHekTC7/4TGBc8oBAkl5c7UQiMNijRECkUcvoHQ8/1Q
         QwFu/FeLaFKk6z+HATuycUiG0hhfWiA47gNHSwGwWRN+2g5QLQViKyz4Jd+DQI6dS073
         KgYqkRglV3ZUovDfFMD3KbjC4+Lw55xoGsdKzHukNdlakVHpkLWRmSx7rwPe+I6cXzE4
         rmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dMslq0N8X0t1H0ZLeYb4gEGrDwD3teAaU8eAnimA430=;
        b=obWt3r7g8caNI3Jhka9fnjQdh7vqXcMDIpK45accSja5bdpPHN2v414P3fAi52T2Yr
         MNVNURHs7BRVNNM4y2VuTZ4EmsPTYYoxTW42rprbHXh/5G+tn/TC5auWMq95uHsRjoQn
         wUftlIYhlVxKdt+r60l2aqo4HBhMY0YAjPtvqVlfJOCHeLJGiel3xLIKwaS5Qne/W/zb
         H5L7ot4OW9bj+4KWrF51o1IbQ7QdDPy5Hd6HGy2g2Iz68yHsxTkas6eaUe8WeqQTGmwL
         ctyg6RE5LINoV+ExRaeqvBEZkHFICigx21czMZzMSm0u8Q3uJt6zjA5qHL6JBbmyzYUr
         XKSA==
X-Gm-Message-State: AHQUAuaZWCH3SdHYsQrKbQXl7iSJZQJOgFzK0NRvzlY778vZNUZ7YusT
        3NzVwtAWOcKz5oeQS5WSfgKFcd638bsg4Q==
X-Google-Smtp-Source: AHgI3IY+Cyoy72RcMCSAyVY0KhC9DiD4rvauwBtj7oHyWgWqcTzq3XmtTgNsI9BzlFMySxx2hPba8A==
X-Received: by 2002:a5e:df03:: with SMTP id f3mr17491310ioq.292.1549911690399;
        Mon, 11 Feb 2019 11:01:30 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/19] io_uring: add io_uring_event cache hit information
Date:   Mon, 11 Feb 2019 12:00:49 -0700
Message-Id: <20190211190049.7888-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
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
index ce446f59f092..a4973af1c272 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -611,11 +611,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_add_event(req->ctx, req->user_data, res, 0);
+
+	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
 	io_free_req(req);
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

