Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE765C6377D
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2A561249
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 09:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhGVJMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231271AbhGVJMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626947592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t2UkVKskP6LSL8vEdsSM8XBBg/0bPIX0t4SvrMOGJHE=;
        b=CwWeqkb+Jz5cEeMQG2wlKl5J8PHbloJZSTCnAzjv3nEEbzdmLkq87KbBVxot0jbjkr4CLD
        NhOARvvKlLAvcPXkIxzdmFLqZReYgy6xhXq7reF7grgYoV8CyTn67DsYDT/cXa7DvQIEYv
        4yZSBIQ59JcKtXsnc56RexTvMSrJVpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-SV8WboRiOPyNn-5kP11HMQ-1; Thu, 22 Jul 2021 05:53:09 -0400
X-MC-Unique: SV8WboRiOPyNn-5kP11HMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15247100F76F;
        Thu, 22 Jul 2021 09:53:07 +0000 (UTC)
Received: from localhost (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA845D9DD;
        Thu, 22 Jul 2021 09:53:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Date:   Thu, 22 Jul 2021 17:52:43 +0800
Message-Id: <20210722095246.1240526-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 block/blk-mq-rdma.c                    |  7 +++++++
 block/blk-mq-virtio.c                  |  2 ++
 block/blk-mq.c                         | 27 ++++++++++++++++----------
 block/blk-mq.h                         |  8 ++++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 include/linux/blk-mq.h                 |  3 ++-
 include/linux/msi.h                    |  5 +++++
 kernel/irq/msi.c                       | 18 +++++++++++++++++
 9 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.31.1

