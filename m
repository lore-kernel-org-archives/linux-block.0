Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47887C43610
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111D9208E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111D9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbeKPELB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:11:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:28722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKPELB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 23:11:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 10:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="91428166"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2018 10:02:10 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 1/3] blk-mq: Return true if request was completed
Date:   Thu, 15 Nov 2018 10:58:18 -0700
Message-Id: <20181115175820.13391-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181115175820.13391-1-keith.busch@intel.com>
References: <20181115175820.13391-1-keith.busch@intel.com>
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
index 352051ea30f7..1fb0f2050d31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -633,11 +633,12 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
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
index 929e8abc5535..f0dc26fc86a9 100644
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

