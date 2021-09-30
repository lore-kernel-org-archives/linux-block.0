Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52EBC433F5
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80117613A7
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348530AbhI3M6x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348276AbhI3M6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Sep 2021 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633006630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kv5fvG9KZriDjoofQEBWp898Mk3hvdOZp76TKP2/6jo=;
        b=P8tBqLzVMxFvMaoqpCIaZTu5XUPsvOs3RA0pHh81q6EcCaFrZ1xLh1+Q0Rj/nCrSrIbQkb
        9acODPdyPQbX7deid3LetPDX2DHM5n1Q3CTWhonS5D1AX7iADeZud33GADeN4BbyQ+4NIV
        UUpRFHtqLn9/k2VizLqE5lv7l19rvDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-nYsoULG-P-GNKoJ9w8m35w-1; Thu, 30 Sep 2021 08:57:08 -0400
X-MC-Unique: nYsoULG-P-GNKoJ9w8m35w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCDA31006ADC;
        Thu, 30 Sep 2021 12:56:57 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 561D6843C6;
        Thu, 30 Sep 2021 12:56:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] nvme: prepare for pairing quiescing and unquiescing
Date:   Thu, 30 Sep 2021 20:56:19 +0800
Message-Id: <20210930125621.1161726-4-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-1-ming.lei@redhat.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two helpers so that we can prepare for pairing quiescing and
unquiescing which will be done in next patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 91d91d4f76d7..23fb746a8970 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -119,25 +119,6 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 
-/*
- * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
- */
-static void nvme_set_queue_dying(struct nvme_ns *ns)
-{
-	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-		return;
-
-	blk_set_queue_dying(ns->queue);
-	blk_mq_unquiesce_queue(ns->queue);
-
-	set_capacity_and_notify(ns->disk, 0);
-}
-
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -4469,6 +4450,35 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+static void nvme_start_ns_queue(struct nvme_ns *ns)
+{
+	blk_mq_unquiesce_queue(ns->queue);
+}
+
+static void nvme_stop_ns_queue(struct nvme_ns *ns)
+{
+	blk_mq_quiesce_queue(ns->queue);
+}
+
+/*
+ * Prepare a queue for teardown.
+ *
+ * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
+ * the capacity to 0 after that to avoid blocking dispatchers that may be
+ * holding bd_butex.  This will end buffered writers dirtying pages that can't
+ * be synced.
+ */
+static void nvme_set_queue_dying(struct nvme_ns *ns)
+{
+	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+		return;
+
+	blk_set_queue_dying(ns->queue);
+	nvme_start_ns_queue(ns);
+
+	set_capacity_and_notify(ns->disk, 0);
+}
+
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -4547,7 +4557,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		nvme_stop_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
@@ -4558,7 +4568,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_ns_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
-- 
2.31.1

