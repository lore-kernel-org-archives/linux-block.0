Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A3FC11F66
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6D961DC2
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 07:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhF2Hwm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhF2Hwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 03:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624953013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eYdPUpXHyBcnfyXYfLQSlAwhq5QQG5cRwiJRI/9Ji40=;
        b=QYM0VbFHZAlA4yaUhpEgkZ9LfOPJafs2yZSVB7Q4KDhVuKZDlGz0LkWTWV35mGh6Ey4+gG
        pufr75E7+g+ykcLjSsUbo9HK0PD4UjqiVXVZbRA0/+pIHJIhoTIdZU+i3mbfx0dkWvE7o6
        GG3qn2YqVzOMQ6zeMHIpuldpuHQ/p6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ZOYQ5WixPdmd7i_ApKj3pw-1; Tue, 29 Jun 2021 03:50:12 -0400
X-MC-Unique: ZOYQ5WixPdmd7i_ApKj3pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D83C73A1;
        Tue, 29 Jun 2021 07:50:10 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BD9B5D9FC;
        Tue, 29 Jun 2021 07:50:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Date:   Tue, 29 Jun 2021 15:49:49 +0800
Message-Id: <20210629074951.1981284-1-ming.lei@redhat.com>
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
(all cpus in hctx->cpumask are offline).

Fix blk_mq_alloc_request_hctx() by adding/passing flag of
BLK_MQ_F_NOT_USE_MANAGED_IRQ. 


Ming Lei (2):
  blk-mq: not deactivate hctx if the device doesn't use managed irq
  nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop

 block/blk-mq.c             | 6 +++++-
 drivers/nvme/host/fc.c     | 3 ++-
 drivers/nvme/host/rdma.c   | 3 ++-
 drivers/nvme/host/tcp.c    | 3 ++-
 drivers/nvme/target/loop.c | 3 ++-
 include/linux/blk-mq.h     | 1 +
 6 files changed, 14 insertions(+), 5 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: John Garry <john.garry@huawei.com>


-- 
2.31.1

