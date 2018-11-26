Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39355C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73F20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A73F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeK0DwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:52:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:52441 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeK0DwP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:52:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 08:57:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="95155565"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2018 08:57:33 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 2/3] scsi: Do not rely on blk-mq for double completions
Date:   Mon, 26 Nov 2018 09:54:29 -0700
Message-Id: <20181126165430.4519-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181126165430.4519-1-keith.busch@intel.com>
References: <20181126165430.4519-1-keith.busch@intel.com>
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
 drivers/scsi/scsi_lib.c   | 13 ++++++++++++-
 include/scsi/scsi_cmnd.h  |  4 ++++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index dd338a8cd275..16eef068e9e9 100644
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
+		if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
+			return BLK_EH_RESET_TIMER;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0df15cb738d2..0dbf25512778 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1642,8 +1642,18 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
+	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
+		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+
+	/*
+	 * If the block layer didn't complete the request due to a timeout
+	 * injection, scsi must clear its internal completed state so that the
+	 * timeout handler will see it needs to escalate its own error
+	 * recovery.
+	 */
+	if (unlikely(!blk_mq_complete_request(cmd->request)))
+		clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
 }
 
 static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
@@ -1702,6 +1712,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!scsi_host_queue_ready(q, shost, sdev))
 		goto out_dec_target_busy;
 
+	clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = scsi_mq_prep_fn(req);
 		if (ret != BLK_STS_OK)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index d6fd2aba0380..3de905e205ce 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -61,6 +61,9 @@ struct scsi_pointer {
 /* flags preserved across unprep / reprep */
 #define SCMD_PRESERVED_FLAGS	(SCMD_UNCHECKED_ISA_DMA | SCMD_INITIALIZED)
 
+/* for scmd->state */
+#define SCMD_STATE_COMPLETE	(1 << 0)
+
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
@@ -145,6 +148,7 @@ struct scsi_cmnd {
 
 	int result;		/* Status code from lower level driver */
 	int flags;		/* Command flags */
+	unsigned long state;	/* Command completion state */
 
 	unsigned char tag;	/* SCSI-II queued command tag */
 };
-- 
2.14.4

