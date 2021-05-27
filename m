Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3969C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD73A6128B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhE0BD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:26 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:53101 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhE0BDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:25 -0400
Received: by mail-pj1-f48.google.com with SMTP id q6so1781905pjj.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8hyuqg/tAJ17moIrqTXZyuv3MUbSAHq4QLZ5IGOWpY=;
        b=Xam8NIY8u7uBLCa6mJK4Y2x4mpEv9RrYIcwVs1hiU3pE6BKM4zhI5IzwA2OjLY8EvH
         F9SXYUVqhgL5aJsZomxIOhVJy2HLJ8aKX8CEzxn6GUEnLhFnO7qL+hVZECW9iEXeCZ7v
         tZZvMFIyc6+ADp1Bx2EuqrLP7mv2WR8zxdBTYHJ86azSHEl5uO86B9laJACAgbsrXBbE
         T2FgkU+6/O8CnU2byc4q4jpcnJmFfTtuyqW8lU2kQvVjCSXa+55kp3OvHRndmePLcnbX
         CXcI81r5cIYcZ7m/WEl2B3EhCYUUrjXBJJ6uFUv9KwECfPhDPB5CbvuF5YR0SjsKAxCI
         fGfA==
X-Gm-Message-State: AOAM531RejY8Ty9Xp3y7MDNFkqIlNPRobN7Sh+o2b/adFOWXcvrzgo3v
        8aWz7WK2T7TnZfly5/u//3E=
X-Google-Smtp-Source: ABdhPJzmifAG0Rp1KT4nHuCId/lkxiaDeZHJqE1uy3WLklKVSiSy0kS2RFysk7ehin+7tC4HTi1T/g==
X-Received: by 2002:a17:902:d4cd:b029:f5:4ec0:d593 with SMTP id o13-20020a170902d4cdb02900f54ec0d593mr841845plg.19.1622077312342;
        Wed, 26 May 2021 18:01:52 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
Date:   Wed, 26 May 2021 18:01:29 -0700
Message-Id: <20210527010134.32448-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change "queue" into "sched" to make the function names reflect better the
purpose of these functions.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index cc9d0fc72db2..c4f51e7884fb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -395,7 +395,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-static void dd_exit_queue(struct elevator_queue *e)
+static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
 
@@ -408,7 +408,7 @@ static void dd_exit_queue(struct elevator_queue *e)
 /*
  * initialize elevator private data (deadline_data).
  */
-static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
+static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
@@ -800,8 +800,8 @@ static struct elevator_type mq_deadline = {
 		.requests_merged	= dd_merged_requests,
 		.request_merged		= dd_request_merged,
 		.has_work		= dd_has_work,
-		.init_sched		= dd_init_queue,
-		.exit_sched		= dd_exit_queue,
+		.init_sched		= dd_init_sched,
+		.exit_sched		= dd_exit_sched,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
