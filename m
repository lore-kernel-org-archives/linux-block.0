Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46269C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193B721925
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS9HhO+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfI3I1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:27:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53831 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfI3I1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 04:27:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so12301788wmd.3;
        Mon, 30 Sep 2019 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiTcmPDYabLVsrG/rT8p2yH7iyQnfMv9x4MrXjPTSFE=;
        b=MS9HhO+7iOI0ANTzC8eeXY69uqbX1ZKLieUihRJGY0Y92z2C9Jq59TiCvRLWY4uwLi
         YihCYfDy+xEY0VWxZ+3gI9PD/KzSM8UF4K2v7H893+PDlEAt6npoWumkmVhspT+RQsvR
         6BXwzHzgRxzjvGWUyC9MYB5WNBBzZSOjg+Au0fQW5uv91CAUCnf7LGhQgoi8MsAU1xpO
         uKKel+QMc03610cTRPHI8gcq6Hz0XZZ9FRMYfhXtjXXv5u/5hpq1+OIU9nPrxq6YOqKT
         JikolwjVLwinF2EoPzTmLn6phRIFmxrbS0hsH0ga5owmYp/mGYhGIJd2mpSI3jvw7cZc
         lgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiTcmPDYabLVsrG/rT8p2yH7iyQnfMv9x4MrXjPTSFE=;
        b=WE/+pjo7Zua7jh7lNNFPt3o+2lUpS9LzHL5mb/DOOmz9LCJHlUJ2XNUJo+IFhFG2VC
         hsI7YM5rUCch3Cj/fwSOsWOFrVejZOIWsuSILZopw+5jm6XQbXdiwydrG131Msuk4kZP
         eaVZAAlfY4m61DgQtX3RQVqOFA8GO5D8AehDXF8l93L2antZy/VVQ1jQoCp2D8zxIXvp
         BQ7d9vab+stiKlmuRPxiC2vihdDozcRMWd/6bYEmrjw9XRQe1gqriAF6hOXQx6xjhvUb
         Mn808rNZp0QmW2c0pWVTN6HBIg+KgOSWq4bmc0dqtjoJpgL4pXC+LwjCAMRYE39rCcaX
         dPpw==
X-Gm-Message-State: APjAAAU53nc20m9VENkbFOGj4FE61Y00Qq0gQsk0LwoosMX3MXBrvoqc
        hXFyf8GWWK8TviBr53p6rECph9JTSsc=
X-Google-Smtp-Source: APXvYqyIX+qV44kxnRmjcwfsgERt//xfxYJStkbqIEyO3d9ltGMOK7DBOWf2ZLkHQOI4XNjgQsqLfg==
X-Received: by 2002:a1c:4485:: with SMTP id r127mr15324789wma.59.1569832065145;
        Mon, 30 Sep 2019 01:27:45 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id u22sm15076664wru.72.2019.09.30.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:27:44 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] blk-mq: reuse code in blk_mq_check_inflight*()
Date:   Mon, 30 Sep 2019 11:27:32 +0300
Message-Id: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

1. Reuse the same walker callback for both blk_mq_in_flight() and
blk_mq_in_flight_rw().

2. Store inflight counters immediately in struct mq_inflight.
It's type-safer and removes extra indirection.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c4e5070c2ecd..d97181d9a3ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -93,7 +93,7 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 
 struct mq_inflight {
 	struct hd_struct *part;
-	unsigned int *inflight;
+	unsigned int inflight[2];
 };
 
 static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
@@ -102,45 +102,29 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	/*
-	 * index[0] counts the specific partition that was asked for.
-	 */
 	if (rq->part == mi->part)
-		mi->inflight[0]++;
+		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
 }
 
 unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 {
-	unsigned inflight[2];
-	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+	struct mq_inflight mi = { .part = part };
 
-	inflight[0] = inflight[1] = 0;
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 
-	return inflight[0];
-}
-
-static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
-				     struct request *rq, void *priv,
-				     bool reserved)
-{
-	struct mq_inflight *mi = priv;
-
-	if (rq->part == mi->part)
-		mi->inflight[rq_data_dir(rq)]++;
-
-	return true;
+	return mi.inflight[0] + mi.inflight[1];
 }
 
 void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 			 unsigned int inflight[2])
 {
-	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+	struct mq_inflight mi = { .part = part };
 
-	inflight[0] = inflight[1] = 0;
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	inflight[0] = mi.inflight[0];
+	inflight[1] = mi.inflight[1];
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
-- 
2.23.0

