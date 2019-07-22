Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBD2C76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043E22296
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfGVFkQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfGVFkQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 01:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E87E485541;
        Mon, 22 Jul 2019 05:40:15 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C41055D704;
        Mon, 22 Jul 2019 05:40:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] blk-mq: introduce blk_mq_request_completed()
Date:   Mon, 22 Jul 2019 13:39:50 +0800
Message-Id: <20190722053954.25423-2-ming.lei@redhat.com>
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 22 Jul 2019 05:40:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe needs this function to decide if one request to be aborted has
been completed in normal IO path already.

So introduce it.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..e1d0b4567388 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -665,6 +665,12 @@ int blk_mq_request_started(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
+int blk_mq_request_completed(struct request *rq)
+{
+	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_completed);
+
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3fa1fa59f9b2..baac2926e54a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -296,6 +296,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 
 
 int blk_mq_request_started(struct request *rq);
+int blk_mq_request_completed(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.20.1

