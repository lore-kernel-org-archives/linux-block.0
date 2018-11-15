Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E8C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA925223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 18:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA925223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbeKPELB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:11:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:28722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPELB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 23:11:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 10:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="91428169"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2018 10:02:10 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
Date:   Thu, 15 Nov 2018 10:58:19 -0700
Message-Id: <20181115175820.13391-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181115175820.13391-1-keith.busch@intel.com>
References: <20181115175820.13391-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The scsi timeout error handling had been directly updating the block
layer's request state to prevent a error handling and a natural completion
from completing the same request twice. Fix this layering violation
by having scsi control the fate of its commands with scsi owned flags
rather than use blk-mq's.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/scsi/scsi_error.c | 22 +++++++++++-----------
 drivers/scsi/scsi_lib.c   |  6 +++++-
 include/scsi/scsi_cmnd.h  |  5 ++++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index dd338a8cd275..e92e088f636f 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -297,19 +297,19 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 
 	if (rtn == BLK_EH_DONE) {
 		/*
-		 * For blk-mq, we must set the request state to complete now
-		 * before sending the request to the scsi error handler. This
-		 * will prevent a use-after-free in the event the LLD manages
-		 * to complete the request before the error handler finishes
-		 * processing this timed out request.
+		 * Set the command to complete first in order to prevent a real
+		 * completion from releasing the command while error handling
+		 * is using it. If the command was already completed, then the
+		 * lower level driver beat the timeout handler, and it is safe
+		 * to return without escalating error recovery.
 		 *
-		 * If the request was already completed, then the LLD beat the
-		 * time out handler from transferring the request to the scsi
-		 * error handler. In that case we can return immediately as no
-		 * further action is required.
+		 * If timeout handling lost the race to a real completion, the
+		 * block layer may ignore that due to a fake timeout injection,
+		 * so return RESET_TIMER to allow error handling another shot
+		 * at this command.
 		 */
-		if (!blk_mq_mark_complete(req))
-			return rtn;
+		if (test_and_set_bit(__SCMD_COMPLETE, &scmd->flags))
+			return BLK_EH_RESET_TIMER;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5d83a162d03b..c1d5e4e36125 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
+	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
+		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	if (unlikely(!blk_mq_complete_request(cmd->request)))
+		clear_bit(__SCMD_COMPLETE, &cmd->flags);
 }
 
 static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
@@ -1701,6 +1704,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_dec_host_busy;
 		req->rq_flags |= RQF_DONTPREP;
 	} else {
+		cmd->flags &= ~SCMD_COMPLETE;
 		blk_mq_start_request(req);
 	}
 
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index d6fd2aba0380..ded7c7194a28 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -58,6 +58,9 @@ struct scsi_pointer {
 #define SCMD_TAGGED		(1 << 0)
 #define SCMD_UNCHECKED_ISA_DMA	(1 << 1)
 #define SCMD_INITIALIZED	(1 << 2)
+
+#define __SCMD_COMPLETE		3
+#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)
 /* flags preserved across unprep / reprep */
 #define SCMD_PRESERVED_FLAGS	(SCMD_UNCHECKED_ISA_DMA | SCMD_INITIALIZED)
 
@@ -144,7 +147,7 @@ struct scsi_cmnd {
 					 * to be at an address < 16Mb). */
 
 	int result;		/* Status code from lower level driver */
-	int flags;		/* Command flags */
+	unsigned long flags;	/* Command flags */
 
 	unsigned char tag;	/* SCSI-II queued command tag */
 };
-- 
2.14.4

