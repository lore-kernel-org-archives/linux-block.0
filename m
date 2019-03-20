Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2AEC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F048821873
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCTUOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39738 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfCTUOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2712572pfo.6
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qBvESQuu/fA8SvnGni6urYu8lV3gettIVj8agTfGU14=;
        b=FDmBwk/3z2kl+KeYFg0mEZkZvHJp15t0e0+tLDoib8S57YGATqX52sjDX30nmcI3W1
         pi/fmLSYPa7ssN1py1youskp8uBD27ufijY4w/XLWGpdo9CbMAk10OpDkvo6WyR6IXxt
         hir2xqwEQmmdRA5ppl/sVBHLZ9I0grbmHyxAKV9sUXaRAnomxZ3Ls/6weBw/BXRwdskf
         pT1reZ0apXsPGH0eS7lt/IAi/mqSuR092vJ6ajVaGotp4aqfKhgAXRAhzB45vY9oKsc+
         YNqYhKzsBRUxAETsgoMpKPjdOt1QW4hJdcv5DshX2f7tp7hVSPJm8nu+c0w6iVliaxZh
         TZFA==
X-Gm-Message-State: APjAAAWG13Q4bxcjUF1JSKHvjIAygOGzRhG3M7IOQyQuAebE0aGmOzZ2
        48os9pbbV4aCGpIJYEomJEH1X5NclSY=
X-Google-Smtp-Source: APXvYqzIDeEf87hJIM5fXRnmco0jSEXHbo3kPmrbaTZY0OJI3toOe3FC+CyeQQv41kiKop127scZKw==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr9754805plo.92.1553112884620;
        Wed, 20 Mar 2019 13:14:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l187sm3376863pgl.75.2019.03.20.13.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:14:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: Unexport blk_mq_add_to_requeue_list()
Date:   Wed, 20 Mar 2019 13:14:37 -0700
Message-Id: <20190320201437.36672-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function is not used outside the block layer core. Hence unexport it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 1 -
 block/blk-mq.h         | 2 ++
 include/linux/blk-mq.h | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fa024bce2b38..aaa4a3a49fde 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -778,7 +778,6 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
 }
-EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c11353a3749d..0ed8e5a8729f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -41,6 +41,8 @@ void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
+				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 bool blk_mq_get_driver_tag(struct request *rq);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..5186fa09ab14 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -300,8 +300,6 @@ void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
-				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
-- 
2.21.0.155.ge902e9bcae20

