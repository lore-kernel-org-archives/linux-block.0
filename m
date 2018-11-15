Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C6C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72638223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72638223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbeKPEIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:08:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:61131 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPEIl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 23:08:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 09:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="280206591"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2018 09:59:50 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/3] blk-mq: Return true if request was completed
Date:   Thu, 15 Nov 2018 10:56:24 -0700
Message-Id: <20181115175626.13293-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A driver may have internal state to cleanup if we're pretending a request
timeout occured. Return 'false' if the command wasn't actually completed
due to the error injection, and true otherwise.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 5 +++--
 include/linux/blk-mq.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..f91951800a64 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -630,11 +630,12 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
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
index 2286dc12c6bc..dec6ef385492 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -264,7 +264,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
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

