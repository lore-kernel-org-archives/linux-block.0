Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ABEB64DC
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjGFUOj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjGFUOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 16:14:38 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7941727
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 13:14:37 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-263253063f9so856490a91.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 13:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688674477; x=1691266477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YWu1Xdd7J4WBHpNlcQ+3KMnQQxzNDXk6H3JXf229Wo=;
        b=Np3lGFXh/F6wkRjSsMJe+PlVkql6J7YNCNjHIgSKionHhKmix1sAehWWqO4nx6MchO
         mK+HWmjd584MZuP9oM884GdCKg8rtxlLBA3/3aE0SLBA4pRSQjWLe4rhy2+3wb1eGodp
         fecUi6Ash+cMPjLDTx8s9yXN0QiHpCNoAts+FsxjOcHvyopAiZ3yffV6/DAGuQIJ8Bkh
         8EICXd9Lh3lnp9ox6GKbIdKcyHgMuj8dTEzPaENaWGkdHDvk4ABNzw0bVIuFjQuDXByw
         BPjuHb0SB5+F0/O8qgMq86jJh6PKhUmsufpUgL4S7BvcrmF5VYMA2DAyy8vJCPPcKAWp
         d58g==
X-Gm-Message-State: ABy/qLZv45WHXZCxLhFMX80t/0Td/b+CZBWu2qJE8dAQPTMFqWSTCLbA
        ArrMMXyvnor015tquijp40Q=
X-Google-Smtp-Source: APBJJlEZJ3uw5Ijdj+TIUCTMzOqY8b7idvyrP0uyl+fJexU1bVw8Ah8CBmmoCD6qESuhHT7YptVX3Q==
X-Received: by 2002:a17:90a:fc88:b0:263:27f5:d447 with SMTP id ci8-20020a17090afc8800b0026327f5d447mr2824794pjb.9.1688674477012;
        Thu, 06 Jul 2023 13:14:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a5d0d00b00263c8b33bcfsm182538pji.14.2023.07.06.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:14:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] block: Do not merge if merging is disabled
Date:   Thu,  6 Jul 2023 13:14:33 -0700
Message-ID: <20230706201433.3987617-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While testing the performance impact of zoned write pipelining, I
noticed that merging happens even if merging has been disabled via
sysfs. Fix this.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 67c95f31b15b..8883721f419a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -375,7 +375,8 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 				   struct list_head *free)
 {
-	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, free);
+	return !blk_queue_nomerges(q) && rq_mergeable(rq) &&
+		elv_attempt_insert_merge(q, rq, free);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
