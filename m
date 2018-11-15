Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25325C43610
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F52087A
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnkXY4Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30F52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbeKPDZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbeKPDZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qXl4BEdy/cGe0bSpWDeatOfmGtPhywzz7wfCsHYjtA8=; b=tnkXY4XgwecsneUfX3PSj7w6N
        AizPiD9em705r/SsVC1kEAr0vx5YwMAZPSOtN/S739LS2Ln0teLBVIxLpV6puJdJfGnUDls/PSK72
        8uNR+g6VgAdjSPW9Fc2IFk8H0/qceV7/Y1tXecrZJt9QccGrG9dY7TUkPV2DPuTFzzhijZ1M1BYcA
        C+AA6EWBM/g71gUYWiqz6JBIgz5ME9u+2FBIDs1ooqps1c1thyqy0jA+1RwTqibq6JlWbUNPTFVaA
        cMvvtI0i7WXwv0yy9skX/pTyZ5TKJM3jbrGNJYNfHvE6zwO7/rrMRMrVjz1Ex+9KrzGWoXyGAo5/9
        t6QuFiiSg==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFm-0002LK-Sl; Thu, 15 Nov 2018 17:16:31 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 04/11] nvme-core: add work elements to struct nvme_ctrl
Date:   Thu, 15 Nov 2018 09:16:16 -0800
Message-Id: <20181115171626.9306-5-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

connect_work and err_work will be reused by nvme-tcp so
share those in nvme_ctrl for rdma and fc to share.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/nvme/host/fc.c   | 18 ++++++++----------
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c | 19 ++++++++-----------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 83131e42b336..16812e427e17 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -159,8 +159,6 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
-	struct delayed_work	connect_work;
-
 	struct kref		ref;
 	u32			flags;
 	u32			iocnt;
@@ -547,7 +545,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 			"NVME-FC{%d}: connectivity re-established. "
 			"Attempting reconnect\n", ctrl->cnum);
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0);
 		break;
 
 	case NVME_CTRL_RESETTING:
@@ -2815,7 +2813,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -2850,7 +2848,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
 			recon_delay = rport->dev_loss_end - jiffies;
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, recon_delay);
 	} else {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE)
 			dev_warn(ctrl->ctrl.device,
@@ -2918,7 +2916,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 
 	struct nvme_fc_ctrl *ctrl =
 			container_of(to_delayed_work(work),
-				struct nvme_fc_ctrl, connect_work);
+				struct nvme_fc_ctrl, ctrl.connect_work);
 
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
@@ -3015,7 +3013,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kref_init(&ctrl->ref);
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
-	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvme_fc_connect_ctrl_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
@@ -3086,7 +3084,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	nvme_get_ctrl(&ctrl->ctrl);
 
-	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+	if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0)) {
 		nvme_put_ctrl(&ctrl->ctrl);
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
@@ -3094,7 +3092,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto fail_ctrl;
 	}
 
-	flush_delayed_work(&ctrl->connect_work);
+	flush_delayed_work(&ctrl->ctrl.connect_work);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
@@ -3105,7 +3103,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
 	ctrl->ctrl.opts = NULL;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 27663ce3044e..031195e5d7d3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -240,6 +240,8 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+	struct delayed_work connect_work;
+	struct work_struct err_work;
 };
 
 struct nvme_subsystem {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4468d672ced9..779c2c043242 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -101,12 +101,9 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -910,8 +907,8 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	cancel_work_sync(&ctrl->ctrl.err_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -943,7 +940,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		nvme_delete_ctrl(&ctrl->ctrl);
@@ -1015,7 +1012,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+			struct nvme_rdma_ctrl, ctrl.connect_work);
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -1038,7 +1035,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+			struct nvme_rdma_ctrl, ctrl.err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1059,7 +1056,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1932,9 +1929,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-- 
2.17.1

