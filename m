Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DDC7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjEVSjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEVSjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:17 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6BFE
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:10 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-25566708233so1335611a91.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780750; x=1687372750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ3ll9KfhA8di3a4Aa3elUb1kDyTnSn3kC+CHTgCiXE=;
        b=axGDpbpymeuyGKGAj7vptCzm2pN0W9AWi6iaTvtn/VfaLfdpEFHxbhhbxcthntDZi+
         cg5GaCTMTlu1jyJstT391Uka9ek5zphAUOu7+jf2UfoU3nbw484DXDd/z/DdQvyFsp04
         +ssz55SmcfuaO1J3u9LR/dnHWQ6eGQIlw+S1Iw0FCOL1hbNmUs5ssRhrUSMDeT2laJPD
         HKmLWO4aBrySmEbZEQq4qmlJos0QnLgCL5nw2ESi24BQZkdMdvAzW6QnhExK7CuZQuEH
         iDDGA3OXPxnR8oddJ57Eh8c9pOCD8auA+oewf9vvCKgBuxQmjbG0W5bgdTkPM4MrBD8R
         RB5Q==
X-Gm-Message-State: AC+VfDxy1q/k2KS/uv8Fr+VvwsCJSJFZD3uKuXhgunP1iyvi81J29H9I
        QJ3xNEiyLiEEuuQQAYWRHOU=
X-Google-Smtp-Source: ACHHUZ7Dmk4TTkMHFAPl64Lpn3cOr5rlGckkkKI8Drh7SczaDlmRA+nqjSykAjNirK4fSqSpBd5W1g==
X-Received: by 2002:a17:90b:4a91:b0:253:728c:c1f8 with SMTP id lp17-20020a17090b4a9100b00253728cc1f8mr10317348pjb.13.1684780749582;
        Mon, 22 May 2023 11:39:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 1/7] block: Rename a local variable in blk_mq_requeue_work()
Date:   Mon, 22 May 2023 11:38:36 -0700
Message-ID: <20230522183845.354920-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two data structures in blk_mq_requeue_work() represent request lists. Make
it clear that rq_list holds requests that come from the requeue list by
renaming that data structure.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 551e7760f45e..e79cc34ad962 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1436,17 +1436,17 @@ static void blk_mq_requeue_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, requeue_work.work);
-	LIST_HEAD(rq_list);
+	LIST_HEAD(requeue_list);
 	LIST_HEAD(flush_list);
 	struct request *rq;
 
 	spin_lock_irq(&q->requeue_lock);
-	list_splice_init(&q->requeue_list, &rq_list);
+	list_splice_init(&q->requeue_list, &requeue_list);
 	list_splice_init(&q->flush_list, &flush_list);
 	spin_unlock_irq(&q->requeue_lock);
 
-	while (!list_empty(&rq_list)) {
-		rq = list_entry(rq_list.next, struct request, queuelist);
+	while (!list_empty(&requeue_list)) {
+		rq = list_entry(requeue_list.next, struct request, queuelist);
 		/*
 		 * If RQF_DONTPREP ist set, the request has been started by the
 		 * driver already and might have driver-specific data allocated
