Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B1C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4591B20679
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329975;
	bh=92uIhca7GyB1gsgvc9RN3WLo8M/n3LZi80oUxUqUW44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrNzDTGpPYSiSiHP1IUE5mHQPUWQQq0nvSS8NS9qDJoTwA0BYGMeIFeItYsLpTLJV
	 l7jpjy3DqrprjDmYKxZnaq7GvVgkYl88T/Fat+DFrFR5bwAO34L8WrpNCZQIj1Mslo
	 sPl2FimLtOX9IjDqCmn+fCR6+BXe0r37SbL94vKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfD0Bws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfD0BkZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFC220B7C;
        Sat, 27 Apr 2019 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329225;
        bh=92uIhca7GyB1gsgvc9RN3WLo8M/n3LZi80oUxUqUW44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnLBp2W4kIXAi8NjGJEM9sYcTSv1EP+qoYh4REyPF55oXHfiwjtguytuXK++1QPMN
         fkfZjCgVLK6Syg143gv9/ZUuRvZ6qt/4VISe+mcs9VMyvQt4hnvSWtzw5wYeWrGZIu
         a/2cmmID6BGpG/e17pHDCTjjI6HDtVQVF5yAwXjY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 66/79] blk-mq: introduce blk_mq_complete_request_sync()
Date:   Fri, 26 Apr 2019 21:38:25 -0400
Message-Id: <20190427013838.6596-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 1b8f21b74c3c9c82fce5a751d7aefb7cc0b8d33d ]

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

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c         | 7 +++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16f9675c57e6..ce462c313806 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -657,6 +657,13 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+void blk_mq_complete_request_sync(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e030f5f76b6..7e092bdac27f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -306,6 +306,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.19.1

