Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5BEB64DA
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 01:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFTBfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFTBfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 21:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB8E55
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687224869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDCU23Tg71ixu26B1Q5DI34+DtwzuYkE4QTPUCZ8gbM=;
        b=ZXKxHyRs7haeAx9tv1kKW1X9WtJK1FyAiA3vnN/c8EXLcf4dSntSXxdxc7CFqqVpzuNi38
        vYRxlJb3MAW/anr6zUobWeADe7aPAcvGQI2B19ny7GY9911452RfQcDzY3pVHSdpm7M4hc
        Kx5crqDMWoyNA1iipwq1grC9tML3C5M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-sPBOnxV0Mv6z7FTqZz490Q-1; Mon, 19 Jun 2023 21:34:26 -0400
X-MC-Unique: sPBOnxV0Mv6z7FTqZz490Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 156CC1C08DB8;
        Tue, 20 Jun 2023 01:34:26 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A402112132C;
        Tue, 20 Jun 2023 01:34:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/4] nvme: add nvme_unfreeze_force()
Date:   Tue, 20 Jun 2023 09:33:47 +0800
Message-Id: <20230620013349.906601-3-ming.lei@redhat.com>
In-Reply-To: <20230620013349.906601-1-ming.lei@redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add nvme_unfreeze_force() for fixing IO hang during removing namespaces
from error recovery.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76e8f8b4098e..6b3f12368196 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4579,17 +4579,32 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
-void nvme_unfreeze(struct nvme_ctrl *ctrl)
+static void __nvme_unfreeze(struct nvme_ctrl *ctrl, bool force)
 {
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unfreeze_queue(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (force)
+			blk_mq_unfreeze_queue_force(ns->queue);
+		else
+			blk_mq_unfreeze_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
+
+void nvme_unfreeze(struct nvme_ctrl *ctrl)
+{
+	__nvme_unfreeze(ctrl, false);
+}
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
+void nvme_unfreeze_force(struct nvme_ctrl *ctrl)
+{
+	__nvme_unfreeze(ctrl, true);
+}
+EXPORT_SYMBOL_GPL(nvme_unfreeze_force);
+
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 78308f15e090..b583bab985c3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -765,6 +765,7 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_unfreeze_force(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
-- 
2.40.1

