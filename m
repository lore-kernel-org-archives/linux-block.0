Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC5C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCA8610E5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhHROpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239422AbhHROpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629297880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ohxRW5B1dcCxo1hzkltnZYQPDrZIXytR6PXe3YOTHYA=;
        b=ihx9FVepbli8EQWKi1DEcmGF/BXXssd+1sDSJBlA8owEsIOTclcH8Jmwdudz4CUdtTu018
        GkpEt7eEPvt10+jRxuXNem074N+8V6VyK21n1WhXVOTUfJoFt2tL9yRxJc3XT53HVzJW38
        KZtcdsB095DCZMUYgirZsjPnCA7NtJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-LU7xoahGNtSjU-NG4W8V4Q-1; Wed, 18 Aug 2021 10:44:39 -0400
X-MC-Unique: LU7xoahGNtSjU-NG4W8V4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9541082925;
        Wed, 18 Aug 2021 14:44:38 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D371C60657;
        Wed, 18 Aug 2021 14:44:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Date:   Wed, 18 Aug 2021 22:44:25 +0800
Message-Id: <20210818144428.896216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
However, all cpus in hctx->cpumask may be offline.

This usage model isn't well supported by blk-mq which supposes allocator is
always done on one online CPU in hctx->cpumask. This assumption is
related with managed irq, which also requires blk-mq to drain inflight
request in this hctx when the last cpu in hctx->cpumask is going to
offline.

However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
them to ask for request allocation when the specified hctx is inactive
(all cpus in hctx->cpumask are offline). Fix blk_mq_alloc_request_hctx() by
allowing to allocate request when all CPUs of this hctx are offline.

Wen Xiong has verified V4 in her nvmef test.

V7:
	- move blk_mq_hctx_use_managed_irq() into block/blk-mq.c, 3/3

V6:
	- move device_has_managed_msi_irq() into kernel/irq/msi.c

V5:
	- take John Garry's suggestion to replace device field with
	new helper of device_has_managed_msi_irq()
V4:
	- remove patches for cleanup queue map helpers
	- take Christoph's suggestion to add field into 'struct device' for
	describing if managed irq is allocated from one device

V3:
	- cleanup map queues helpers, and remove pci/virtio/rdma queue
	  helpers
	- store use managed irq info into qmap

V2:
	- use flag of BLK_MQ_F_MANAGED_IRQ
	- pass BLK_MQ_F_MANAGED_IRQ from driver explicitly
	- kill BLK_MQ_F_STACKING


Ming Lei (3):
  genirq: add device_has_managed_msi_irq
  blk-mq: mark if one queue map uses managed irq
  blk-mq: don't deactivate hctx if managed irq isn't used

 block/blk-mq-pci.c                     |  2 ++
 block/blk-mq-rdma.c                    |  7 ++++++
 block/blk-mq-virtio.c                  |  2 ++
 block/blk-mq.c                         | 35 ++++++++++++++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 include/linux/blk-mq.h                 |  3 ++-
 include/linux/msi.h                    |  5 ++++
 kernel/irq/msi.c                       | 18 +++++++++++++
 8 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.31.1

