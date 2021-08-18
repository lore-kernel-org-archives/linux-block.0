Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABBC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B75610CB
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhHROqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239606AbhHROpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629297896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKD3jspsN2Vq2GAXh73xNoL6XuoN6rE5oaiLLBXPCN0=;
        b=FptoR/oR/U0IE7KNqwT63pywAoZ+E9Qsctu6kemVkxfAS1M+PrbIyb3GLUzGoxW2UcsNt8
        iw5WR3DkIziZ4uWHFaUZx/YcMkXXvAE1xqqIQzyAp88kFwS2rZQ6eNQWer+gGlk2DOW5fr
        VBd34TUaSHRqv688eQIdoBGIX6vzHFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-vlpBsBHrNSKQSYzogCQogg-1; Wed, 18 Aug 2021 10:44:55 -0400
X-MC-Unique: vlpBsBHrNSKQSYzogCQogg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD8F0801AC0;
        Wed, 18 Aug 2021 14:44:53 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6466A8FE;
        Wed, 18 Aug 2021 14:44:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 2/3] blk-mq: mark if one queue map uses managed irq
Date:   Wed, 18 Aug 2021 22:44:27 +0800
Message-Id: <20210818144428.896216-3-ming.lei@redhat.com>
In-Reply-To: <20210818144428.896216-1-ming.lei@redhat.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Retrieve this info via new added helper of device_has_managed_msi_irq,
then we can decide if one hctx needs to be drained before all its CPUs
become offline.

Tested-by: Wen Xiong <wenxiong@us.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-pci.c                     | 2 ++
 block/blk-mq-rdma.c                    | 7 +++++++
 block/blk-mq-virtio.c                  | 2 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 1 +
 include/linux/blk-mq.h                 | 3 ++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..e452cda0896a 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -8,6 +8,7 @@
 #include <linux/blk-mq-pci.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 
 #include "blk-mq.h"
 
@@ -37,6 +38,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = device_has_managed_msi_irq(&pdev->dev);
 
 	return 0;
 
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..19ad31c44eab 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -36,6 +36,13 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
+	/*
+	 * RDMA doesn't use managed irq, and nvme rdma driver can allocate
+	 * and submit requests on specified hctx via
+	 * blk_mq_alloc_request_hctx
+	 */
+	map->use_managed_irq = false;
+
 	return 0;
 
 fallback:
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..2ce39fb77dce 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -7,6 +7,7 @@
 #include <linux/blk-mq-virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include "blk-mq.h"
 
 /**
@@ -38,6 +39,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = device_has_managed_msi_irq(&vdev->dev);
 
 	return 0;
 fallback:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b0b2361e63fe..7d7df261d346 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3562,6 +3562,7 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = true;
 
 	return 0;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 22215db36122..fd5540fba4ef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -192,7 +192,8 @@ struct blk_mq_hw_ctx {
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
-	unsigned int queue_offset;
+	unsigned int queue_offset:31;
+	unsigned int use_managed_irq:1;
 };
 
 /**
-- 
2.31.1

