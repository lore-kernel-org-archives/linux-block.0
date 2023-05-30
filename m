Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1333C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjE3Jo4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjE3Jor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 05:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032993
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685439843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbmmNJpTUBx/mhD31ayJAdVovQnAKFyVZmv2TY8GeLI=;
        b=e2eO/GaunJgOssYgoYExSwWRO89AmbMSQMIjUf0McrecGo67rWBGvBRDg1giFs5sGMd5v4
        nZP6elarBBysW1IzpyLWoOf+cahlHvX/Dp80wreVuWQBYyEUZICJNV3C5FWF0PJsQp95zt
        2sCx7NqEYivOGpeTpL08fVXy1fHsL2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-kLRZiKxqN9iX-twHfKbEdw-1; Tue, 30 May 2023 05:43:59 -0400
X-MC-Unique: kLRZiKxqN9iX-twHfKbEdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4473C185A7A8;
        Tue, 30 May 2023 09:43:59 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CF5C2166B2B;
        Tue, 30 May 2023 09:43:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] nvme: rdma/tcp: call nvme_delete_dead_ctrl for handling reconnect failure
Date:   Tue, 30 May 2023 17:43:22 +0800
Message-Id: <20230530094322.258090-3-ming.lei@redhat.com>
In-Reply-To: <20230530094322.258090-1-ming.lei@redhat.com>
References: <20230530094322.258090-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reconnect failure has been reached after trying enough times, and controller
is actually incapable of handling IO, so it should be marked as dead, so call
nvme_delete_dead_ctrl() to handle the failure for avoiding the following IO
deadlock:

1) writeback IO waits in __bio_queue_enter() because queue is frozen
during error recovery

2) reconnect failure handler removes controller, and del_gendisk() waits
for above writeback IO in fsync/invalidate bdev

Fix the issue by calling nvme_delete_dead_ctrl() which call
nvme_mark_namespaces_dead() before deleting disk, so the above writeback
IO will be failed, and IO deadlock is avoided.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 drivers/nvme/host/tcp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..cdf5855c3009 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1028,7 +1028,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
-		nvme_delete_ctrl(&ctrl->ctrl);
+		nvme_delete_dead_ctrl(&ctrl->ctrl);
 	}
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d57..2c119bff7010 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2047,7 +2047,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
-		nvme_delete_ctrl(ctrl);
+		nvme_delete_dead_ctrl(ctrl);
 	}
 }
 
-- 
2.40.1

