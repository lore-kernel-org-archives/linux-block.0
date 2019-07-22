Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A5C76195
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52722296
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfGVFkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfGVFkf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 01:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5C7D3083391;
        Mon, 22 Jul 2019 05:40:34 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 983DF5C22D;
        Mon, 22 Jul 2019 05:40:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] blk-mq: remove blk_mq_complete_request_sync
Date:   Mon, 22 Jul 2019 13:39:54 +0800
Message-Id: <20190722053954.25423-6-ming.lei@redhat.com>
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 22 Jul 2019 05:40:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_wait_completed_request() has been applied for waiting
for completed request's fn, so not necessary to use
blk_mq_complete_request_sync() any more.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c           | 7 -------
 drivers/nvme/host/core.c | 2 +-
 include/linux/blk-mq.h   | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1d0b4567388..9836a00d8c07 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -652,13 +652,6 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-void blk_mq_complete_request_sync(struct request *rq)
-{
-	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
-	rq->q->mq_ops->complete(rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
-
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb8007cce4d1..4beaed3b5022 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -293,7 +293,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request_sync(req);
+	blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ee0719b649b6..1cdd2788cfa6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -305,7 +305,6 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
-void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.20.1

