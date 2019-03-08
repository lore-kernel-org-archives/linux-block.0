Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D21FC10F0D
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B39208E4
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCHRjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:33276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfCHRjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132430649"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 09:39:36 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/5] nvme: Fail dead namespace's entered requests
Date:   Fri,  8 Mar 2019 10:40:05 -0700
Message-Id: <20190308174006.5032-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

End the entered requests on a quieced queue directly rather than flush
them through the low level driver's queue_rq().

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc5d9a83d5af..7095406bb293 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static bool nvme_fail_request(struct blk_mq_hw_ctx *hctx, struct request *req,
+			      void *data, bool reserved)
+{
+	blk_mq_end_request(req, BLK_STS_IOERR);
+	return true;
+}
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -104,8 +111,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 		return;
 	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_queue_tag_busy_iter(ns->queue, nvme_fail_request, NULL);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.14.4

