Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A3C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F720855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887F720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeK0DwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:52:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:52438 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeK0DwO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:52:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 08:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="95155560"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2018 08:57:32 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 1/3] blk-mq: Return true if request was completed
Date:   Mon, 26 Nov 2018 09:54:28 -0700
Message-Id: <20181126165430.4519-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181126165430.4519-1-keith.busch@intel.com>
References: <20181126165430.4519-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A driver may have internal state to cleanup if we're pretending a request
didn't complete. Return 'false' if the command wasn't actually completed
due to the timeout error injection, and true otherwise.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 5 +++--
 include/linux/blk-mq.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37674c1766a7..7c8cfa0cd420 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -638,11 +638,12 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
  *	Ends all I/O on a request. It does not handle partial completions.
  *	The actual completion happens out-of-order, through a IPI handler.
  **/
-void blk_mq_complete_request(struct request *rq)
+bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
-		return;
+		return false;
 	__blk_mq_complete_request(rq);
+	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ca0520ca6437..6e3da356a8eb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -298,7 +298,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
-void blk_mq_complete_request(struct request *rq);
+bool blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.14.4

