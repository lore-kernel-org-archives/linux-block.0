Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C93C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F2D2077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TRvU8MvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfCMRzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCMRzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=du7OY6+O/mZwC2uBEZsIAYP5eMrpb1EpabSawxTROJw=; b=TRvU8MvKatlZTgIFLZdyubIIiZ
        oIR3P1AQmhnJEW3ymQ4h0IwXZ2QnAZwfEmfZbUEDA1PCUhr3UVh9TLvbMdoDu/+7jSYt8aDBmnOxU
        CQFvJLV1CXxGHMWmJYRzG1oFBTTynCcnroYxd+aahYWQWFi/9zoaK6dzLO+CViuql6rbA6E+Mn+Tl
        e0hAmy0fTYoNd2nPLzkgyi2uPkALxwykAUbxWW2j4vj1EweBgLZIh7NNRE8pHGPnKlxoPRiJ+gIUK
        +r3fmGXy9fBzrqpRfkIAFmGJaCSyp+HMHiqLiJvW7LfH8IMs4QCwswQY2nBsxNmj01S+zMkqz+ps2
        GeZAWN6w==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486P-0001Vm-I4; Wed, 13 Mar 2019 17:55:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/17] nvme-loop: init nvmet_ctrl fatal_err_work when allocate
Date:   Wed, 13 Mar 2019 18:54:59 +0100
Message-Id: <20190313175510.20725-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

After commit 4d43d395fe (workqueue: Try to catch flush_work() without
INIT_WORK()), it can cause warning when delete nvme-loop device, trace
like:

[   76.601272] Call Trace:
[   76.601646]  ? del_timer+0x72/0xa0
[   76.602156]  __cancel_work_timer+0x1ae/0x270
[   76.602791]  cancel_work_sync+0x14/0x20
[   76.603407]  nvmet_ctrl_free+0x1b7/0x2f0 [nvmet]
[   76.604091]  ? free_percpu+0x168/0x300
[   76.604652]  nvmet_sq_destroy+0x106/0x240 [nvmet]
[   76.605346]  nvme_loop_destroy_admin_queue+0x30/0x60 [nvme_loop]
[   76.606220]  nvme_loop_shutdown_ctrl+0xc3/0xf0 [nvme_loop]
[   76.607026]  nvme_loop_delete_ctrl_host+0x19/0x30 [nvme_loop]
[   76.607871]  nvme_do_delete_ctrl+0x75/0xb0
[   76.608477]  nvme_sysfs_delete+0x7d/0xc0
[   76.609057]  dev_attr_store+0x24/0x40
[   76.609603]  sysfs_kf_write+0x4c/0x60
[   76.610144]  kernfs_fop_write+0x19a/0x260
[   76.610742]  __vfs_write+0x1c/0x60
[   76.611246]  vfs_write+0xfa/0x280
[   76.611739]  ksys_write+0x6e/0x120
[   76.612238]  __x64_sys_write+0x1e/0x30
[   76.612787]  do_syscall_64+0xbf/0x3a0
[   76.613329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

We fix it by moving fatal_err_work init to nvmet_alloc_ctrl(), which may
more reasonable.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d44ede147263..2d73b66e3686 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1163,6 +1163,15 @@ static void nvmet_release_p2p_ns_map(struct nvmet_ctrl *ctrl)
 	put_device(ctrl->p2p_client);
 }
 
+static void nvmet_fatal_error_handler(struct work_struct *work)
+{
+	struct nvmet_ctrl *ctrl =
+			container_of(work, struct nvmet_ctrl, fatal_err_work);
+
+	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
+	ctrl->ops->delete_ctrl(ctrl);
+}
+
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
 {
@@ -1205,6 +1214,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
+	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
@@ -1308,21 +1318,11 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
 
-static void nvmet_fatal_error_handler(struct work_struct *work)
-{
-	struct nvmet_ctrl *ctrl =
-			container_of(work, struct nvmet_ctrl, fatal_err_work);
-
-	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
-	ctrl->ops->delete_ctrl(ctrl);
-}
-
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
 	mutex_lock(&ctrl->lock);
 	if (!(ctrl->csts & NVME_CSTS_CFS)) {
 		ctrl->csts |= NVME_CSTS_CFS;
-		INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 		schedule_work(&ctrl->fatal_err_work);
 	}
 	mutex_unlock(&ctrl->lock);
-- 
2.20.1

