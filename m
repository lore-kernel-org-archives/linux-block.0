Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75137C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DE720892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Oc2uevk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLGWUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35823 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLGWUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so2440766plo.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=Oc2uevk+FZE9kvl1eEmR3zJM8jmKRQ+wDkct5aKFAOcWqcwgBPWY9oVqQEVt/Mblrt
         ZFUUD5yODEwyJiQREbGBqA0L2VDJWi8YwLoX+8oXC3ZOVt/c5NnTsIBN/Qz9+qH59LQR
         7O/x9kT3djcxOw8urpV83mgO46PxTZD+viR6d1vNn/tWsZesNj26UmjAb1LsE6jDBVWx
         CSUEUp+QdiHQVHVAUtoQGyTU/qXfGq5/jUU3H2D0TTgZvHekOlal7LiiwvLg+OGgi38T
         Emx9hCF1Hmcpj+ATsyvIkzimk2N64YTFckUvDIvw7uZijm/bikBNALN6MMj6Zr/6OQHE
         39Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=itkhy9VVXQ1bq7jXFUsaAY6F2jgdp78PXzVlKz4ERcgucx2aK/Brlgqwtj8k0+WOKC
         Lv7LoRZc1fgPJlf8gujm8SEliuBSbPsLHE8UyfhwHQaMeH1XUvJ85k/+2F93fyJEFfMZ
         So83rMd5ZlLyHlCw+7PGjIprJBahCH+VqLC3vg9U8qHJco00jjJtxZKvoqMLrjTEmCIZ
         LcJp8HwUz8GjezSA5824GJG/ibXh7elEVj+l2fIGw378MGpuOevdaqT/HN2JjrsaK+dG
         WFESkqLF2uT5F4Da2RBLu1F1zlFfFi0yQwOzMGmR9nlgAwIUQ+9nTYBqnpEjo0sxbeJi
         KAoA==
X-Gm-Message-State: AA+aEWbRcvVMkBEcibOJDEYPdyTv0yqNra65+vbCNLHJ5apwJr/gb59s
        QlCAAoKZrNizWNdSOisYKLIkI3cjIcA=
X-Google-Smtp-Source: AFSGD/XleFk33AYQfgDFs9iSjvPjE0+sZDwoKrwTkg4KIcYgnfJ5wnbV0YCcpatCe/3gF3eTsHDzgQ==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr3774951plo.133.1544221239880;
        Fri, 07 Dec 2018 14:20:39 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/26] aio: only use blk plugs for > 2 depth submissions
Date:   Fri,  7 Dec 2018 15:19:59 -0700
Message-Id: <20181207222016.29387-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugging is meant to optimize submission of a string of IOs, if we don't
have more than 2 being submitted, don't bother setting up a plug.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 522c04864d82..ed6c3914477a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -69,6 +69,12 @@ struct aio_ring {
 	struct io_event		io_events[0];
 }; /* 128 bytes + ring size */
 
+/*
+ * Plugging is meant to work with larger batches of IOs. If we don't
+ * have more than the below, then don't bother setting up a plug.
+ */
+#define AIO_PLUG_THRESHOLD	2
+
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
@@ -1919,7 +1925,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
@@ -1932,7 +1939,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
@@ -1959,7 +1967,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		compat_uptr_t user_iocb;
 
@@ -1972,7 +1981,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
-- 
2.17.1

