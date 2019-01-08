Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3CC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74E92173C
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bpehgh9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfAHQ5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35293 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfAHQ5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:22 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so6945161itp.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNGzHMnuawXZ2jXlVzeC+GxiAaklWr1vP40pdXT+hKc=;
        b=bpehgh9DDK5WDCcCbulj1IgtC8kIw5R84av9H6wjlTzTFX8FN6a8UR7lIEIc3y1r4+
         1KgSl5dTK7cJArcwvlOPO34wzP0/1myHfRURDPqgDreCRdSTHdn1XgHIEpw2Wz/bDnQ1
         SxsIu9yf9QiiaQYahYWNnEcC/L5vdTN8tDokuElcoFhfc0yrXEU7HfE4sz0QbiYTBNf6
         WG2k5sFj1ejGrpameQizvszKIS/Y3jFeLN9K+b3982XXVqXouSL3Yql9bRBdFGoejjBm
         3PNbSXl62S2nS8tez9iyVXCx5OB75RJs4Lxkth12VCoatA3LEnw22YYDMVlLdL8694gS
         OwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNGzHMnuawXZ2jXlVzeC+GxiAaklWr1vP40pdXT+hKc=;
        b=ulqcHIDy0FSzpBUaaKecphnP2VhA68YvifikL83RjkA6Rdie+h20Vru95jFedz4+ym
         TK4h7UbN9btglh0FdOJiBkq/I/UNiVBr6PFqd9Ozw9TX7uyp9NQQBLLWeeS2hdmDbGEh
         f3uz9G2veRAXF9zqOdnW+7w0sA4Hhtq1wsdx3yLT9bJymVOg/PiJwWATOSL/p5D7nOeK
         Y4W3EVCXVqJ0cQhazv2d8Vr2TxoJlTsPyWTgaRjHwOuM+AUaVKRApCECENWwjgyZdIbC
         9y860b0mu3X5T1nk41fg79ynVrguRh0srjAsgdLUbT8gnh7ZBMAMBMfWNdrnue3r9Mjj
         WRtw==
X-Gm-Message-State: AJcUukeiA4cjJFeDegc4DnBt1rmpWjE3Y06KbeAndb7dqzaow1Fx415R
        bWhYlykAcNe9R0cgVmDMCZoW3g==
X-Google-Smtp-Source: ALg8bN41HEg0pjekki/EOMUuCmJZVFsL8lHd3AR+Kh06EZzPQAQhJkKttRGANOf9fkwD17ny83bhFw==
X-Received: by 2002:a24:52cc:: with SMTP id d195mr1565683itb.29.1546966641543;
        Tue, 08 Jan 2019 08:57:21 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] io_uring: add io_uring_event cache hit information
Date:   Tue,  8 Jan 2019 09:56:45 -0700
Message-Id: <20190108165645.19311-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add hint on whether a read was served out of the page cache, or if it
hit media. This is useful for buffered async IO, O_DIRECT reads would
never have this set (for obvious reasons).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 6 +++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6c10841e4342..50b9cfa8c861 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -524,12 +524,16 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, unsigned ki_index,
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
 
-	io_complete_scqring(iocb, res, 0);
+	if (res > 0 && test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags))
+		ev_flags = IOEV_FLAG_CACHEHIT;
+
+	io_complete_scqring(iocb, res, ev_flags);
 }
 
 static void io_complete_scqring_iopoll(struct kiocb *kiocb, long res, long res2)
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index bd665d38dd97..7dd21126f142 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -56,6 +56,11 @@ struct io_uring_event {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOEV_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

