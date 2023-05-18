Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0DC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 22:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERW1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERW1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 18:27:15 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A673DB3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 15:27:14 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-64d2981e3abso579199b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 15:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448834; x=1687040834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib63+Eee57H7hh2+fAjlZJzLjd4Hscoz4E3CWJVEZ/o=;
        b=XrhN/QMfqBbUkquQzK4Le5hgT9lvuXoS/q+K+0rKAzERhmlz0cy/ffPGqHg4Hp69Z+
         bnJGjFRBmKXQAZlvfibb5lyDqg9831GXWvmmTbZbKoc7vHHXrVldC/JHkkGPqhtH1e6n
         tuOTXH9iGOXP0WH3IhdCSl8r/kG8n2NATV2QrCqNXvtZtejFe8Qu48dv5t/1cRF9MjE2
         cHsqhnztEeZbX+FjjjYybMjKXKBMeTNMtb03OUarLVIM3+RqCTiC0IsqURLqDErN6GSv
         mmuecFbZ727+hLvCrz26HbulAoY6FIH6NJ+apCZYlfpRX2e6dciH9pZ7gk4PikP8Wyft
         Gpyg==
X-Gm-Message-State: AC+VfDxYpXWnlh3B2Muhrlia5mEzkQsl4aLvBy/amgBMLwGut+Zx8L16
        i/57Rfy9C3CgHIszejKbiuj/FktosEc=
X-Google-Smtp-Source: ACHHUZ5DfjqBl/Ml9/5N0gzf50x78Ls+r2ppDMkZQR6P2ChRD3rHoRWU+AgyI14F87gD106UkD8H4Q==
X-Received: by 2002:a17:903:2287:b0:1ad:b5f4:dfd5 with SMTP id b7-20020a170903228700b001adb5f4dfd5mr713640plh.32.1684448834016;
        Thu, 18 May 2023 15:27:14 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001a260b5319bsm1976242plh.91.2023.05.18.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:27:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2] block: Decode all flag names in the debugfs output
Date:   Thu, 18 May 2023 15:27:08 -0700
Message-ID: <20230518222708.1190867-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See also:
* Commit 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection").
* Commit 414dd48e882c ("blk-mq: add tagset quiesce interface").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: also decode QUEUE_FLAG_SYNCHRONOUS.

 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d23a8554ec4a..f89865a90dba 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -88,6 +88,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(IO_STAT),
 	QUEUE_FLAG_NAME(NOXMERGES),
 	QUEUE_FLAG_NAME(ADD_RANDOM),
+	QUEUE_FLAG_NAME(SYNCHRONOUS),
 	QUEUE_FLAG_NAME(SAME_FORCE),
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STABLE_WRITES),
@@ -103,6 +104,8 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(NOWAIT),
+	QUEUE_FLAG_NAME(SQ_SCHED),
+	QUEUE_FLAG_NAME(SKIP_TAGSET_QUIESCE),
 };
 #undef QUEUE_FLAG_NAME
 
