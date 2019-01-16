Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE8FC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D79F20840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YzkRa/Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfAPRul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43209 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfAPRuk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:40 -0500
Received: by mail-io1-f66.google.com with SMTP id b23so5557958ios.10
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/DvNz2vM1+v+EgzSGYDfy1TZh4qqowWiRaW7FUkcuYo=;
        b=YzkRa/MmKfbaUwhpK6ahRtdLT2JFKqtN/VVjh9C1VJqnHP11coZb/rNOIOqYmHeNYM
         oeWKXKfdaiTQUFn4aGTppZ0nngV1i5j49keTg3v2/fbibhjOeXP8jFqFALW4Y6B8pGu9
         Lj7M0inCqIKmb4WIQGPd2ospdYKBKObJdXd6KVZJ5w0hr0Yrf+b55UrEyBjIzDpDx5pj
         zwW4T4piYUXJvMqym29uJBxaVcWd3amw8EYVKfFzbWmL+JK6IsaaPATKEFxy36Pgaq4Y
         rEWpsmoC4FwG7dyADRWKqDpqHD+f3ekrmdVeJm6w8DNLCcfW++lkWrpyVAH21qjrLI3P
         sd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/DvNz2vM1+v+EgzSGYDfy1TZh4qqowWiRaW7FUkcuYo=;
        b=lOh9oDfKg2a1J4UNss/lfdzquJ/eVu54buSs4Msa3GUJbRxo7CbC/zbe6ypoTqHxzL
         uiPhrwnJbGJ9RcsCMC8QgqRKvoZ+JYVxg+ZlRXKYd9hX5bT0Pmxk8u4pCZCj+0ldK4LC
         r22qomSF4XEknNcu8qCM4702xpYDgZyBwMKcdBrEvVFH9JCoSohyCO0KEW56cpX5x7sq
         8MXHTIL02IkbbaAyZ3L7A525zD2/xpMgAnyAjRA9YBs41Lwvd+6Md6EdzD4uFtiWmOf8
         G1C66+oP5hu95mCKDy32y9X30gzYZFyb4KWFr1eK1lv14wZ9QLwgWADp9x/NS8rV37Yv
         8/Nw==
X-Gm-Message-State: AJcUukfG1ymK0V1NiN6uxBRToVZPhPRlkUQczDSmIHhVUtlhayzwz+4y
        PPyrL66wGd9MrkpdX7cb8bIgZQ==
X-Google-Smtp-Source: ALg8bN57kggkcwnoHTe7LXFFXvlX1dIDavzAMk6H14muG7S7ek6vd5WmUWmsdZG5CbbxSFPf0EICwQ==
X-Received: by 2002:a6b:b6c4:: with SMTP id g187mr5312308iof.197.1547661040040;
        Wed, 16 Jan 2019 09:50:40 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/15] io_uring: add io_uring_event cache hit information
Date:   Wed, 16 Jan 2019 10:50:03 -0700
Message-Id: <20190116175003.17880-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
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
index f73ee269f51b..c9be77c0bc85 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -516,11 +516,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_fill_event(req->ctx, req->user_data, res, 0);
+
+	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(req->ctx, req->user_data, res, ev_flags);
 	io_free_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 88ec687231be..9bb718168c86 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -66,6 +66,11 @@ struct io_uring_cqe {
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

