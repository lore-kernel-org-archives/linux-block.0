Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F1C11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3E561DBC
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhF2Hw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232284AbhF2Hw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 03:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624953030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fb3NfJSaKCyP+3LF0nxY2+VvsfNZpDDwj+kt0oYzUHc=;
        b=Sg3JzceZsUc2xKGOCze7qQL82RB5yiIP3dsALlMkKNvRnrwNcMuxp3jRZY/XfuxzHs4OGc
        1dIAn7qUAMG+KaU8dtPKJwsmxnFsHLXhjPSAGurgZJ3uqJjHaL2YkPC41FjdHH6AI6UPEl
        z1nFPl1+6t4KA9n91kCZJ4zpm2rznNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-efNjEU4RMf-k80bsUSTaXg-1; Tue, 29 Jun 2021 03:50:25 -0400
X-MC-Unique: efNjEU4RMf-k80bsUSTaXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B54231023F44;
        Tue, 29 Jun 2021 07:50:23 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEB8B369A;
        Tue, 29 Jun 2021 07:50:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop
Date:   Tue, 29 Jun 2021 15:49:51 +0800
Message-Id: <20210629074951.1981284-3-ming.lei@redhat.com>
In-Reply-To: <20210629074951.1981284-1-ming.lei@redhat.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All the 4 host drivers don't use managed irq for completing request, so
it is correct to pass the flag to blk-mq.

Secondly with this flag, blk-mq will help us dispatch connect request
allocated via blk_mq_alloc_request_hctx() to driver even though all
CPU in the specified hctx's cpumask are offline.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/fc.c     | 3 ++-
 drivers/nvme/host/rdma.c   | 3 ++-
 drivers/nvme/host/tcp.c    | 3 ++-
 drivers/nvme/target/loop.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 256e87721a01..c563a2b6e9fc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 	ctrl->tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37943dc4c2c1..4b7bdc829109 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -817,7 +817,8 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE |
+			BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
 		if (nctrl->max_integrity_segments)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 34f4b3402f7c..0125463b7d77 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1600,7 +1600,8 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING |
+			BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb30cb942e1d..bf032249e010 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -524,7 +524,8 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->tag_set.driver_data = ctrl;
-- 
2.31.1

