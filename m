Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87DC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6729820855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6729820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK0DwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:52:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:52438 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeK0DwQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:52:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 08:57:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="95155572"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2018 08:57:34 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 3/3] blk-mq: Simplify request completion state
Date:   Mon, 26 Nov 2018 09:54:30 -0700
Message-Id: <20181126165430.4519-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181126165430.4519-1-keith.busch@intel.com>
References: <20181126165430.4519-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are no more users relying on blk-mq request states to prevent
double completions, so replace the relatively expensive cmpxchg operation
with WRITE_ONCE.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         |  4 +---
 include/linux/blk-mq.h | 14 --------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7c8cfa0cd420..cda698804422 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -568,9 +568,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	if (!blk_mq_mark_complete(rq))
-		return;
-
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 	/*
 	 * Most of single queue controllers, there is only one irq vector
 	 * for handling IO completion, and the only irq's affinity is set
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6e3da356a8eb..b8de11e0603b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -329,20 +329,6 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-/**
- * blk_mq_mark_complete() - Set request state to complete
- * @rq: request to set to complete state
- *
- * Returns true if request state was successfully set to complete. If
- * successful, the caller is responsibile for seeing this request is ended, as
- * blk_mq_complete_request will not work again.
- */
-static inline bool blk_mq_mark_complete(struct request *rq)
-{
-	return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
-			MQ_RQ_IN_FLIGHT;
-}
-
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
-- 
2.14.4

