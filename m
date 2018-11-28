Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 23:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C932081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 23:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C932081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeK2Kmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:42:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:37081 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeK2Kmq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 05:42:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 15:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="95536845"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2018 15:39:26 -0800
Date:   Wed, 28 Nov 2018 16:36:30 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181128233629.GA8332@localhost.localdomain>
References: <20181126165430.4519-1-keith.busch@intel.com>
 <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
 <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de>
 <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de>
 <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
 <20181128162655.GF6401@localhost.localdomain>
 <20181128223146.GH6401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128223146.GH6401@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 03:31:46PM -0700, Keith Busch wrote:
> Waiting for a freeze isn't really the criteria we need anyway: we don't
> care if there are entered requests in REQ_MQ_IDLE. We just want to wait
> for dispatched ones to return, and we currently don't have a good way
> to sync with that condition.

One thing making this weird is that blk_mq_request_started() returns true
for COMPLETED requests, and that makes no sense to me. Completed is
the opposite of started, so I'm not sure why we would return true for
such states. Is anyone actually depending on that?

If we can return true only for started commands, the following
implements the desired wait criteria:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a82830f39933..d0ef540711c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -647,7 +647,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
 
 int blk_mq_request_started(struct request *rq)
 {
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
+	return blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT;
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..ae50b6ed95fb 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/scatterlist.h>
 #include <linux/blk-mq.h>
+#include <linux/delay.h>
 #include <linux/nvme.h>
 #include <linux/module.h>
 #include <linux/parser.h>
@@ -425,12 +426,37 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	return error;
 }
 
+bool nvme_count_active(struct request *req, void *data, bool reserved)
+{
+	unsigned int *active = data;
+
+	(*active)++;
+	return true;
+}
+
+/*
+ * It is the backing device driver's responsibility to ensure all dispatched
+ * requests are eventually completed.
+ */
+static void nvme_wait_for_stopped(struct nvme_loop_ctrl *ctrl)
+{
+	unsigned int active;
+
+	do {
+		active = 0;
+		blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_count_active,
+					&active);
+		if (!active)
+			return;
+		msleep(100);
+	} while (true);
+}
+
 static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+		nvme_wait_for_stopped(ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
--
