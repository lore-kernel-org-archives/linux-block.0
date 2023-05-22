Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F4C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjEVSjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjEVSjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:23 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF418C
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:16 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5341737d7aeso5704717a12.2
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780756; x=1687372756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWxgWNnKgm5KG0jN8kGjy/OofTMJ6svxGrxL31gZyHs=;
        b=EvZsRhoIAaVHDVZ4+uwWZ5O2jL1RteTi9cbcVBkRNgAohcXpENo2VjYxWgKqdffgin
         BZajNskd7B+gyJK1+dLRRQqNlZUrr7vagt4AE649/i+iXNyLgeqaYgwtSyRCBNWfhQvj
         aCVjPHXET4Iart15mqwy9FaazW/ftOmM6PpRTvCWrYwfkQSkKrLZ+Q3g8p1XIEpUOVdY
         rqBrLAFD9RbRczxj56pBJoTm313WjHS1xx95eOePpLoT0JICcwHLFnV5Hg0E40/jQ/Fd
         6J6Z8DPo6aNFQsWUq+IL4c1G2/T7QLfp4ArbEXvidV2i/zn9/xMxf8g3IuP+KcSn5doB
         t7ag==
X-Gm-Message-State: AC+VfDz9X7+95ewtkD0BCYTi9waH+bPjQmvN4w1oxubPlX710oaao/Gk
        w3m8aXHA4R2rsESmwFABwtg=
X-Google-Smtp-Source: ACHHUZ6z/g9p0NV520TyAsWdJ9HWycolZkWSEwE/RpWObBsF2OG2R2mR47ItJvW8y966M50G7eZyaA==
X-Received: by 2002:a17:90a:440f:b0:24e:5a5a:1050 with SMTP id s15-20020a17090a440f00b0024e5a5a1050mr10647892pjg.24.1684780756033;
        Mon, 22 May 2023 11:39:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com
Subject: [PATCH v3 6/7] dm: Inline __dm_mq_kick_requeue_list()
Date:   Mon, 22 May 2023 11:38:41 -0700
Message-ID: <20230522183845.354920-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped
queues") the function __dm_mq_kick_requeue_list() is too short to keep it
as a separate function. Hence, inline this function.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-rq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f7e9a3632eb3..bbe1e2ea0aa4 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -168,21 +168,16 @@ static void dm_end_request(struct request *clone, blk_status_t error)
 	rq_completed(md);
 }
 
-static void __dm_mq_kick_requeue_list(struct request_queue *q, unsigned long msecs)
-{
-	blk_mq_delay_kick_requeue_list(q, msecs);
-}
-
 void dm_mq_kick_requeue_list(struct mapped_device *md)
 {
-	__dm_mq_kick_requeue_list(md->queue, 0);
+	blk_mq_kick_requeue_list(md->queue);
 }
 EXPORT_SYMBOL(dm_mq_kick_requeue_list);
 
 static void dm_mq_delay_requeue_request(struct request *rq, unsigned long msecs)
 {
 	blk_mq_requeue_request(rq, false);
-	__dm_mq_kick_requeue_list(rq->q, msecs);
+	blk_mq_delay_kick_requeue_list(rq->q, msecs);
 }
 
 static void dm_requeue_original_request(struct dm_rq_target_io *tio, bool delay_requeue)
