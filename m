Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BDC07E85
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1A214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F1A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKOCdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:33:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:17706 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeKOCdZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:33:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 08:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,233,1539673200"; 
   d="scan'208";a="279794059"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2018 08:29:29 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/3] scsi: Do not rely on blk-mq for double completions
Date:   Wed, 14 Nov 2018 09:26:00 -0700
Message-Id: <20181114162601.11477-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181114162601.11477-1-keith.busch@intel.com>
References: <20181114162601.11477-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The scsi timeout error handling had been directly updating the request
state to prevent a natural completion and error handling from completing
the same request twice. Fix this layering violation by having scsi
control the fate of its commands with scsi owned flags rather than
use blk-mq's.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/scsi/scsi_error.c | 17 +++--------------
 drivers/scsi/scsi_lib.c   |  6 +++++-
 include/scsi/scsi_cmnd.h  |  5 ++++-
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c736d61b1648..f89e829a1c51 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -199,6 +199,9 @@ scsi_abort_command(struct scsi_cmnd *scmd)
 		return FAILED;
 	}
 
+	if (test_and_set_bit(__SCMD_COMPLETE, &scmd->flags))
+		return SUCCESS;
+
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (shost->eh_deadline != -1 && !shost->last_reset)
 		shost->last_reset = jiffies;
@@ -296,20 +299,6 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		rtn = host->hostt->eh_timed_out(scmd);
 
 	if (rtn == BLK_EH_DONE) {
-		/*
-		 * For blk-mq, we must set the request state to complete now
-		 * before sending the request to the scsi error handler. This
-		 * will prevent a use-after-free in the event the LLD manages
-		 * to complete the request before the error handler finishes
-		 * processing this timed out request.
-		 *
-		 * If the request was already completed, then the LLD beat the
-		 * time out handler from transferring the request to the scsi
-		 * error handler. In that case we can return immediately as no
-		 * further action is required.
-		 */
-		if (req->q->mq_ops && !blk_mq_mark_complete(req))
-			return rtn;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c7fccbb8f554..1e74137f1073 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2044,8 +2044,11 @@ static int scsi_mq_prep_fn(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
+	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
+		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	if (unlikely(!blk_mq_complete_request(cmd->request)))
+		clear_bit(__SCMD_COMPLETE, &cmd->flags);
 }
 
 static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
@@ -2104,6 +2107,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_dec_host_busy;
 		req->rq_flags |= RQF_DONTPREP;
 	} else {
+		cmd->flags &= ~SCMD_COMPLETE;
 		blk_mq_start_request(req);
 	}
 
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index c891ada3c5c2..acef13c628d3 100644
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

