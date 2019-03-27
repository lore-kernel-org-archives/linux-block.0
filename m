Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A44C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14A2075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfC0Ivd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfC0Ivd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAD4680082;
        Wed, 27 Mar 2019 08:51:32 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B81FF6198C;
        Wed, 27 Mar 2019 08:51:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Date:   Wed, 27 Mar 2019 16:51:13 +0800
Message-Id: <20190327085114.12111-2-ming.lei@redhat.com>
In-Reply-To: <20190327085114.12111-1-ming.lei@redhat.com>
References: <20190327085114.12111-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 27 Mar 2019 08:51:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In NVMe's error handler, follows the typical steps of tearing down
hardware for recovering controller:

1) stop blk_mq hw queues
2) stop the real hw queues
3) cancel in-flight requests via
	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
cancel_request():
	mark the request as abort
	blk_mq_complete_request(req);
4) destroy real hw queues

However, there may be race between #3 and #4, because blk_mq_complete_request()
may run q->mq_ops->complete(rq) remotelly and asynchronously, and
->complete(rq) may be run after #4.

This patch introduces blk_mq_complete_request_sync() for fixing the
above race.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 20 ++++++++++++++++----
 include/linux/blk-mq.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c181603cbd..bc3524428b96 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -569,7 +569,7 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+static void __blk_mq_complete_request(struct request *rq, bool sync)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -586,7 +586,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	 * So complete IO reqeust in softirq context in case of single queue
 	 * for not degrading IO performance by irqsoff latency.
 	 */
-	if (q->nr_hw_queues == 1) {
+	if (q->nr_hw_queues == 1 && !sync) {
 		__blk_complete_request(rq);
 		return;
 	}
@@ -594,8 +594,11 @@ static void __blk_mq_complete_request(struct request *rq)
 	/*
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
+	 *
+	 * If driver requires to complete the request synchronously,
+	 * complete it locally, and it is usually done in error handler.
 	 */
-	if ((rq->cmd_flags & REQ_HIPRI) ||
+	if ((rq->cmd_flags & REQ_HIPRI) || sync ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
 		q->mq_ops->complete(rq);
 		return;
@@ -648,11 +651,20 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+	__blk_mq_complete_request(rq, false);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+bool blk_mq_complete_request_sync(struct request *rq)
+{
+	if (unlikely(blk_should_fake_timeout(rq->q)))
+		return false;
+	__blk_mq_complete_request(rq, true);
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..6a514e5136f4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -305,6 +305,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+bool blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.9.5

