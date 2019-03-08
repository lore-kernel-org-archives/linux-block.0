Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571CEC4360F
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7D208E4
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCHRjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:33276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfCHRjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132430646"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 09:39:35 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/5] blk-mq: Iterate tagset over all requests
Date:   Fri,  8 Mar 2019 10:40:04 -0700
Message-Id: <20190308174006.5032-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let the driver's iterator callback decide what request state it should
handle. While there may be other uses, the intention here is to allow
drivers to terminate requests that have entered a dying queue without
needing to unquiesce that queue.

It also turns out no current callback wanted to see COMPLETED requests
that were being returned before, so this also fixes that for all existing
callback handlers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq-tag.c                | 12 ++++++------
 drivers/block/mtip32xx/mtip32xx.c |  6 ++++++
 drivers/block/nbd.c               |  2 ++
 drivers/block/skd_main.c          |  4 ++++
 drivers/nvme/host/core.c          |  2 ++
 drivers/nvme/host/fc.c            |  2 ++
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4ba91b332b0..012f6d8e9631 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -288,7 +288,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq)
 		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
@@ -299,7 +299,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @tags:	Tag map to iterate over.
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
- * @fn:		Pointer to the function that will be called for each started
+ * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @data,
  *		@reserved) where rq is a pointer to a request. Return true
  *		to continue iterating tags, false to stop.
@@ -322,9 +322,9 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 }
 
 /**
- * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
+ * blk_mq_all_tag_busy_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
+ * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
@@ -340,9 +340,9 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 }
 
 /**
- * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
+ * blk_mq_tagset_busy_iter - iterate over all requests in a tag set
  * @tagset:	Tag set to iterate over.
- * @fn:		Pointer to the function that will be called for each started
+ * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 9a6f40cd8df6..88df90ee0a3c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2690,6 +2690,8 @@ static bool mtip_abort_cmd(struct request *req, void *data, bool reserved)
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct driver_data *dd = data;
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	dbg_printk(MTIP_DRV_NAME " Aborting request, tag = %d\n", req->tag);
 
 	clear_bit(req->tag, dd->port->cmds_to_issue);
@@ -2702,6 +2704,8 @@ static bool mtip_queue_cmd(struct request *req, void *data, bool reserved)
 {
 	struct driver_data *dd = data;
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	set_bit(req->tag, dd->port->cmds_to_issue);
 	blk_abort_request(req);
 	return true;
@@ -3852,6 +3856,8 @@ static bool mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
 {
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
+	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
+		return true;
 	cmd->status = BLK_STS_IOERR;
 	blk_mq_complete_request(rq);
 	return true;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90ba9f4c03f3..4811746f189b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -739,6 +739,8 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	cmd->status = BLK_STS_IOERR;
 	blk_mq_complete_request(req);
 	return true;
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d3ad6c22ee5..530d14e6b97b 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -387,6 +387,8 @@ static bool skd_inc_in_flight(struct request *rq, void *data, bool reserved)
 {
 	int *count = data;
 
+	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
+		return true;
 	count++;
 	return true;
 }
@@ -1899,6 +1901,8 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
 	struct skd_device *const skdev = data;
 	struct skd_request_context *skreq = blk_mq_rq_to_pdu(req);
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	if (skreq->state != SKD_REQ_STATE_BUSY)
 		return true;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1597efae6af8..cc5d9a83d5af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -284,6 +284,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b29b12498a1a..0deba51575b0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2373,6 +2373,8 @@ nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
 
+	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
+		return true;
 	__nvme_fc_abort_op(ctrl, op);
 	return true;
 }
-- 
2.14.4

