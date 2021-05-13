Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005EC433B4
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836EE61408
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEMRQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 13:16:53 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33659 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhEMRQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 13:16:52 -0400
Received: by mail-pg1-f169.google.com with SMTP id i5so17324197pgm.0
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXQ/0WtfCHSTYcInhx/k7/MjIY7jZP2/sSyWOnQKzwY=;
        b=K/Fy14jsDzZgbTHWI154A6ao4H2pXcr6Og4BYUxKC8VvpvINxiuyjrt5kcNWOR/6Xt
         gTscRWyE3GTJ3qYG2GKm1lOmkPnOr9lPqPT85hlt1LmRE5WUJ61khoP5Fu+RCUockc9A
         ak/dw6rhNVZQIT/QNr17LZXvbeRz/KCCUrBMaCwt9UxAffqVnt+kVcfUJye6I92bQW+n
         D270tQGFIzuQFBTdDjnUYk9oIGP1rCy8fem63upIXB0r1Lz5sQLnmY3YFcmP0DUWWcZz
         pR4xQTfLPezN5aCI0+aYx+aJx10SPn9H9v/ZK6+lUVH+VSjgvzTzpGPkWgpde1sU74X/
         QEKg==
X-Gm-Message-State: AOAM533iEAsL6eBk7oxGZjmEaE1NhedNJsYk2odb8iHeYRNKbLEO9B0X
        Skv60pNA0JQyOzmt+9yTOGc=
X-Google-Smtp-Source: ABdhPJzr7Rj/lxTMVi8GOWP0ZYP5xMcpDC1GICMDtNoTV5qv2MXYmwhSn2KupSMaH9+/z3oqIQiHHA==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr6486010pjf.158.1620926141589;
        Thu, 13 May 2021 10:15:41 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6dd7:5386:8c63:ccae])
        by smtp.gmail.com with ESMTPSA id i197sm2499043pgc.13.2021.05.13.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:15:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] blk-mq: Swap two calls in blk_mq_exit_queue()
Date:   Thu, 13 May 2021 10:15:29 -0700
Message-Id: <20210513171529.7977-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a tag set is shared across request queues (e.g. SCSI LUNs) then the
block layer core keeps track of the number of active request queues in
tags->active_queues. blk_mq_tag_busy() and blk_mq_tag_idle() update that
atomic counter if the hctx flag BLK_MQ_F_TAG_QUEUE_SHARED is set. Make
sure that blk_mq_exit_queue() calls blk_mq_tag_idle() before that flag is
cleared by blk_mq_del_queue_tag_set().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Fixes: 0d2602ca30e4 ("blk-mq: improve support for shared tags maps")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ea012de60eb..96b8e3164835 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3289,10 +3289,12 @@ EXPORT_SYMBOL(blk_mq_init_allocated_queue);
 /* tags can _not_ be used after returning from blk_mq_exit_queue */
 void blk_mq_exit_queue(struct request_queue *q)
 {
-	struct blk_mq_tag_set	*set = q->tag_set;
+	struct blk_mq_tag_set *set = q->tag_set;
 
-	blk_mq_del_queue_tag_set(q);
+	/* Checks hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED. */
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	/* May clear BLK_MQ_F_TAG_QUEUE_SHARED in hctx->flags. */
+	blk_mq_del_queue_tag_set(q);
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
