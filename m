Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9049C433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC55D613D1
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhI2ESt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhI2ESt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 00:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632889028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78Fsgf1h+RTfDgrnE/nQEe6tYqMqnM7d0kWUC6K8lx0=;
        b=FVDt8sF7IevfrineaYGRIMVADFvHgYqbbaEOrP4siljWMIlP/kiBALrqHbVSNMriedx1ok
        I/kZwxTzmt5LbQ6s/BAQ1kk5rmB9w01oFYgrFSM/RLACKet2ahmQs7W233JXo50hgGZzBu
        oLSbG8H4bbToWUI/MZn2PFjElweZsZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-V4ec62t6MJq9enBSN7ieYg-1; Wed, 29 Sep 2021 00:17:06 -0400
X-MC-Unique: V4ec62t6MJq9enBSN7ieYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 117C5802921;
        Wed, 29 Sep 2021 04:17:05 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE6A5C1D5;
        Wed, 29 Sep 2021 04:16:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] nvme: paring quiesce/unquiesce
Date:   Wed, 29 Sep 2021 12:15:58 +0800
Message-Id: <20210929041559.701102-5-ming.lei@redhat.com>
In-Reply-To: <20210929041559.701102-1-ming.lei@redhat.com>
References: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
stops and starts the queue unconditionally. And there can be concurrent
quiesce/unquiesce coming from different unrelated code paths, so
unquiesce may come unexpectedly and start queue too early.

Prepare for supporting nested / concurrent quiesce/unquiesce, so that we
can address the above issue.

NVMe has very complicated quiesce/unquiesce use pattern, add one mutex
and queue stopped state in nvme_ctrl, so that we can make sure that
quiece/unquiesce is called in pair.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  4 ++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23fb746a8970..5d0b2eb38e43 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4375,6 +4375,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
+	mutex_init(&ctrl->queues_stop_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
@@ -4450,14 +4451,44 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+static void __nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
+{
+	lockdep_assert_held(&ctrl->queues_stop_lock);
+
+	if (!ctrl->admin_queue_stopped) {
+		blk_mq_quiesce_queue(ctrl->admin_q);
+		ctrl->admin_queue_stopped = true;
+	}
+}
+
+static void __nvme_start_admin_queue(struct nvme_ctrl *ctrl)
+{
+	lockdep_assert_held(&ctrl->queues_stop_lock);
+
+	if (ctrl->admin_queue_stopped) {
+		blk_mq_unquiesce_queue(ctrl->admin_q);
+		ctrl->admin_queue_stopped = false;
+	}
+}
+
 static void nvme_start_ns_queue(struct nvme_ns *ns)
 {
-	blk_mq_unquiesce_queue(ns->queue);
+	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
+
+	if (test_bit(NVME_NS_STOPPED, &ns->flags)) {
+		blk_mq_unquiesce_queue(ns->queue);
+		clear_bit(NVME_NS_STOPPED, &ns->flags);
+	}
 }
 
 static void nvme_stop_ns_queue(struct nvme_ns *ns)
 {
-	blk_mq_quiesce_queue(ns->queue);
+	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
+
+	if (!test_bit(NVME_NS_STOPPED, &ns->flags)) {
+		blk_mq_quiesce_queue(ns->queue);
+		set_bit(NVME_NS_STOPPED, &ns->flags);
+	}
 }
 
 /*
@@ -4490,16 +4521,18 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&ctrl->queues_stop_lock);
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		nvme_start_admin_queue(ctrl);
+		__nvme_start_admin_queue(ctrl);
 
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
 	up_read(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->queues_stop_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -4555,10 +4588,12 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&ctrl->queues_stop_lock);
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_stop_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->queues_stop_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -4566,22 +4601,28 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
+	mutex_lock(&ctrl->queues_stop_lock);
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_start_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->queues_stop_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
 void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
 {
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	mutex_lock(&ctrl->queues_stop_lock);
+	__nvme_stop_admin_queue(ctrl);
+	mutex_unlock(&ctrl->queues_stop_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
 
 void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
 {
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	mutex_lock(&ctrl->queues_stop_lock);
+	__nvme_start_admin_queue(ctrl);
+	mutex_unlock(&ctrl->queues_stop_lock);
 }
 EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 47877a5f1515..3a02a370f025 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -341,6 +341,9 @@ struct nvme_ctrl {
 	struct page *discard_page;
 	unsigned long discard_page_busy;
 
+	bool	admin_queue_stopped;
+	struct mutex	queues_stop_lock;
+
 	struct nvme_fault_inject fault_inject;
 };
 
@@ -457,6 +460,7 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
+#define NVME_NS_STOPPED		5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.31.1

