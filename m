Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B3C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjEVSjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjEVSjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:18 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F8107
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:11 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-253520adb30so3836296a91.1
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780751; x=1687372751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P42AMbHjoovuYjV7C0RFYJSUCStog/KsS81yzUjYhuc=;
        b=CrDN0rTIr+Kk21Cce8fknIlDbvD03pGiELWBO6Rk/fbfHQKQSwJaUK6mQMZGZpbI4h
         n0aYOn2kYccTh4P48v+3r/dky1wRUa19C9T946WfauA/NjcAxDDpo1nxR9iGy6HMYCvT
         I9WHb8gfqkSB3+U3spPQbHuTZCuUEtgun3GmGupGZfwjZpMMkqg6yWI+Awm5Rw7OeIbw
         G4vvOK5Db6m/pwrcBs4mR4UwiEjAGKHBM0nEDWFcJJnpsoInyi7Qd+kqcoLJjMiYh+DJ
         fAjmfc31f7R8lRQkCyi+9srnZCT3gcrXcBo/MvBV7njLHSayipHcI7Bw6oH8j9qY/uQk
         n1cQ==
X-Gm-Message-State: AC+VfDzS6jMQuZv5jYFCf4heetmh2lcjQtBMw0FPpFn0S85ELmvbT199
        C2rAxfxXOpvoX4+ffibfakY=
X-Google-Smtp-Source: ACHHUZ7zt9ulxprYFw+ApuJrhWWiBOFVHSLux/YGMQuxVCydPG5EmOACBG7aZQKGTXI9r4pqmBMmRQ==
X-Received: by 2002:a17:90a:8541:b0:255:75e5:b456 with SMTP id a1-20020a17090a854100b0025575e5b456mr3166477pjw.1.1684780750966;
        Mon, 22 May 2023 11:39:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Date:   Mon, 22 May 2023 11:38:37 -0700
Message-ID: <20230522183845.354920-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522183845.354920-1-bvanassche@acm.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Send requeued requests to the I/O scheduler such that the I/O scheduler
can control the order in which requests are dispatched.

This patch reworks commit aef1897cd36d ("blk-mq: insert rq with DONTPREP
to hctx dispatch list when requeue").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 36 +++++++++++++++++++++++-------------
 include/linux/blk-mq.h |  4 ++--
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e79cc34ad962..632aee9af60f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1438,30 +1438,26 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		container_of(work, struct request_queue, requeue_work.work);
 	LIST_HEAD(requeue_list);
 	LIST_HEAD(flush_list);
-	struct request *rq;
+	struct request *rq, *next;
 
 	spin_lock_irq(&q->requeue_lock);
 	list_splice_init(&q->requeue_list, &requeue_list);
 	list_splice_init(&q->flush_list, &flush_list);
 	spin_unlock_irq(&q->requeue_lock);
 
-	while (!list_empty(&requeue_list)) {
-		rq = list_entry(requeue_list.next, struct request, queuelist);
-		/*
-		 * If RQF_DONTPREP ist set, the request has been started by the
-		 * driver already and might have driver-specific data allocated
-		 * already.  Insert it into the hctx dispatch list to avoid
-		 * block layer merges for the request.
-		 */
-		if (rq->rq_flags & RQF_DONTPREP) {
-			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, 0);
-		} else {
+	list_for_each_entry_safe(rq, next, &requeue_list, queuelist) {
+		if (!(rq->rq_flags & RQF_DONTPREP)) {
 			list_del_init(&rq->queuelist);
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 		}
 	}
 
+	while (!list_empty(&requeue_list)) {
+		rq = list_entry(requeue_list.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_insert_request(rq, 0);
+	}
+
 	while (!list_empty(&flush_list)) {
 		rq = list_entry(flush_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
@@ -2064,14 +2060,28 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		bool no_tag = prep == PREP_DISPATCH_NO_TAG &&
 			((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
 			blk_mq_is_shared_tags(hctx->flags));
+		LIST_HEAD(for_sched);
+		struct request *next;
 
 		if (nr_budgets)
 			blk_mq_release_budgets(q, list);
 
 		spin_lock(&hctx->lock);
+		list_for_each_entry_safe(rq, next, list, queuelist)
+			if (rq->rq_flags & RQF_USE_SCHED)
+				list_move_tail(&rq->queuelist, &for_sched);
 		list_splice_tail_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
 
+		if (q->elevator) {
+			if (q->elevator->type->ops.requeue_request)
+				list_for_each_entry(rq, &for_sched, queuelist)
+					q->elevator->type->ops.
+						requeue_request(rq);
+			q->elevator->type->ops.insert_requests(hctx, &for_sched,
+							BLK_MQ_INSERT_AT_HEAD);
+		}
+
 		/*
 		 * Order adding requests to hctx->dispatch and checking
 		 * SCHED_RESTART flag. The pair of this smp_mb() is the one
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d778cb6b2112..363894aea0e8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -62,8 +62,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_RESV		((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
-#define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+#define RQF_NOMERGE_FLAGS                                               \
+	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_DONTPREP | RQF_SPECIAL_PAYLOAD)
 
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
