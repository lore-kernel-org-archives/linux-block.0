Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271A9C6377B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BF4611CE
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhGUIqT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237268AbhGUIhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 04:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626859077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXbuJkSDozONpCP3inmO1HXTiLW2EK6lklIH1KTLKPw=;
        b=eQF9pKymfm982k9rtNH7tV/xgvzeQCM7hEOdBycSGIGvp2upBHGMdI6QEih+7mLb2KEqVB
        f2XoGqQnRU9UxU6EfyRLq3Id/Oxj7zKsQsMzoI494MOi3jTzitSHjaSVyn2Ojrpgsv1OSa
        Xj5Mk3Tp8GoqLToA17qAswFLFAUP8OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-oggdKhdFPkWoigx4DsDCVQ-1; Wed, 21 Jul 2021 05:17:53 -0400
X-MC-Unique: oggdKhdFPkWoigx4DsDCVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7127980415C;
        Wed, 21 Jul 2021 09:17:52 +0000 (UTC)
Received: from localhost (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8E0B369A;
        Wed, 21 Jul 2021 09:17:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 2/3] blk-mq: mark if one queue map uses managed irq
Date:   Wed, 21 Jul 2021 17:17:22 +0800
Message-Id: <20210721091723.1152456-3-ming.lei@redhat.com>
In-Reply-To: <20210721091723.1152456-1-ming.lei@redhat.com>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Retrieve this info via new added helper of device_has_managed_msi_irq,
then we can decide if one hctx needs to be drained before all its CPUs
become offline.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-pci.c                     | 1 +
 block/blk-mq-rdma.c                    | 3 +++
 block/blk-mq-virtio.c                  | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 1 +
 include/linux/blk-mq.h                 | 3 ++-
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..7011854a562a 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -37,6 +37,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = device_has_managed_msi_irq(&pdev->dev);
 
 	return 0;
 
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..7b10d8bd2a37 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -36,6 +36,9 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
+	/* So far RDMA doesn't use managed irq */
+	map->use_managed_irq = false;
+
 	return 0;
 
 fallback:
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..bea91ac5996d 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -38,6 +38,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
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
index 1d18447ebebc..d54a795ec971 100644
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

