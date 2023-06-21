Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E87DEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFUUMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjFUUMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:45 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F719A3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38e04d1b2b4so4418286b6e.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378363; x=1689970363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKCGSxqskKmjef6IhtNXH4tDBl4jyiZFFvA/uvxn5ls=;
        b=ZB1LAuZcTUYIatBHfPxgfG9aU0S165iXg6FLVKq49DCtW4G25yrZMUSfSHdF8TrDqa
         9MwulbbQqLBdwCzqxkKVe/FNILeR8nNcxTTQtd4GQeqke8XN00ua560iWvWZOCzXM8Xv
         DctDDj59UghbgiFvg+h9o7xZf272rDGxUZbflvvr7iMaFJcVr96Rd1ncQYaidqTra0cG
         L1Vn320sDOB3hgO3DA314WFY0VW4iLo/6EQigXQ+rnMqcZ3Zr9n0EZ54nPd1sUh/G5vO
         PuhOy+3f2qdeuZqDHFEBTzsmWxhYtrD/s3flnkwawAc/dtGRDWNpEgvkCnS8WkFr47Y7
         +wnw==
X-Gm-Message-State: AC+VfDxg/5e1DTt8A65Y0HN1jBU3hAe60yBIymOHkQ8NxoM0osYo4YBt
        MZf96brgauiywzuxo/0xMtIznTJiHN8=
X-Google-Smtp-Source: ACHHUZ5/JgyMfA9t84BiUOeYxpQakkMfromwF+M2qnTfhMH7GO42UtuZ1cnXNEdCFgmYEyFS0EvVjw==
X-Received: by 2002:a05:6808:3d3:b0:3a0:3a17:a12c with SMTP id o19-20020a05680803d300b003a03a17a12cmr5205403oie.13.1687378363174;
        Wed, 21 Jun 2023 13:12:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 1/7] block: Rename a local variable in blk_mq_requeue_work()
Date:   Wed, 21 Jun 2023 13:12:28 -0700
Message-ID: <20230621201237.796902-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two data structures in blk_mq_requeue_work() represent request lists. Make
it clear that rq_list holds requests that come from the requeue list by
renaming that data structure.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 720b5061ffe8..41ee393c80a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1441,17 +1441,17 @@ static void blk_mq_requeue_work(struct work_struct *work)
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
