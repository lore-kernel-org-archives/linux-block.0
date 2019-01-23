Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2092C282C2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01442184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lQ6tTm1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAWPgb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36410 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfAWPgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so1239887pgm.3
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=je9ei4LMcX4NnvUJXJVHh3/Mgly0/gzwZl7hkm7tlLw=;
        b=lQ6tTm1zy5EeN8Q9LBYq4S4aeEoyTvjdLv/yJogl6NsS12JhtF07avdso0t6otYqJF
         5qCnmsIzN2Pbb96Ib1WYVxzddaciv/XKN07XJ4BraxyfGixY8rwGs1XIrCjz0q2SIxfB
         f/cWcKyoKuSGqn8kYnoiMW2YWUFOXPR5S9tJN1WFz2KmUKpeClR6w3BEs6OraiTiYlnd
         bG8kf62OQuk4a6x9Xs9XoTDOcrhDsnP6iimrOHYF52NN2OLiGT4WpVcc8WuXpfopOW3E
         5bzI22avdEtjEmUPMqtEcXusEqmgdR2AfUi88X61btikNypAKls1h3nV32mjL+5JuTfx
         8cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=je9ei4LMcX4NnvUJXJVHh3/Mgly0/gzwZl7hkm7tlLw=;
        b=QIy0q0SdKLULWV0zFFgSBBQCF5sax0E49gGZHgKRkbES2VjlhuTYXz0+zd9wH+6oKA
         Bb9MDDeBtHOkvR0Bl+FHkhulwROGxGzvqnFQj2Xbrbj7YsldKONARM5+8SaC/tCxXtS7
         GO9hRk7TzNysgqOMI23jyt6loG4CV4Omxnb8Bu7QY+x3MsDiKNoMxkYrvRAs/tnjVDXn
         3rmfHlehEQ6x92voKdizz2JnCgINdzDUb9fBeTHvJ8RRGpGS2IURbX+nVe0yrJWKhNf+
         3Kjy0z7psfY/hjBuAM6tmh/CZufEKa72fvZCLZklDuUGizV2ACegmM6AC3De4N4QP8uU
         rcsQ==
X-Gm-Message-State: AJcUukc0sFrKQcp2FR3Ojl0dR9Bd5yGemICamBE1X35VtzvhOqnCSV3f
        lIMzig0Q2doGldkIXJG6hO3IsA==
X-Google-Smtp-Source: ALg8bN5lSKl5bbQk3oUVv1HTyx1w6zfvE1ajZX+fD2mZzs7XeNZYzT7DktZT6nTX98XlBZ1hp5o6WA==
X-Received: by 2002:a63:f006:: with SMTP id k6mr2328528pgh.259.1548257790424;
        Wed, 23 Jan 2019 07:36:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:36:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Wed, 23 Jan 2019 08:35:36 -0700
Message-Id: <20190123153536.7081-26-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
index aa903fa902d5..a40b1af356e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -561,11 +561,16 @@ static void io_fput(struct io_kiocb *req)
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
index 60b52c551c87..3b8d623031ad 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -71,6 +71,11 @@ struct io_uring_cqe {
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

