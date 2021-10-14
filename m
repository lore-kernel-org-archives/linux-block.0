Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8283EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C71B610E8
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJNIT5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230117AbhJNIT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634199471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kv5fvG9KZriDjoofQEBWp898Mk3hvdOZp76TKP2/6jo=;
        b=ObLX6WcZv4bMnQRZpTqb/HASrZJbYPhF4INXWDXcLh4Evs15RfKQNq6B67frHDwJK3L9KP
        BlOAG/vbAVK1XoXPgkizhpG1jRvdQbobsZ+M2P1ahgJJIwCbI205DjuPFOza/6j0d9mzqk
        3Ik4FVEAU3fECns0X5GVcJOIhpOoRO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MWBkp6otPwCo7Jamuqw7Rg-1; Thu, 14 Oct 2021 04:17:48 -0400
X-MC-Unique: MWBkp6otPwCo7Jamuqw7Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E0A805750;
        Thu, 14 Oct 2021 08:17:47 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 817FA5DF35;
        Thu, 14 Oct 2021 08:17:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/6] nvme: prepare for pairing quiescing and unquiescing
Date:   Thu, 14 Oct 2021 16:17:07 +0800
Message-Id: <20211014081710.1871747-4-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

