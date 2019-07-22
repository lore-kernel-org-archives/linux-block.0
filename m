Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE88C76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63A22296
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 05:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGVFkK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGVFkK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 01:40:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E75AA30C583B;
        Mon, 22 Jul 2019 05:40:09 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96C545C22D;
        Mon, 22 Jul 2019 05:40:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/5] blk-mq: wait until completed req's complete fn is run
Date:   Mon, 22 Jul 2019 13:39:49 +0800
Message-Id: <20190722053954.25423-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 22 Jul 2019 05:40:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

blk-mq may schedule to call queue's complete function on remote CPU via
IPI, but never provide any way to synchronize the request's complete
fn.

In some driver's EH(such as NVMe), hardware queue's resource may be freed &
re-allocated. If the completed request's complete fn is run finally after the
hardware queue's resource is released, kernel crash will be triggered.

Fixes this issue by waitting until completed req's complete fn is run.

Thanks,
Ming

Ming Lei (5):
  blk-mq: introduce blk_mq_request_completed()
  blk-mq: introduce blk_mq_tagset_wait_completed_request()
  nvme: don't abort completed request in nvme_cancel_request
  nvme: wait until all completed request's complete fn is called
  blk-mq: remove blk_mq_complete_request_sync

 block/blk-mq-tag.c         | 32 ++++++++++++++++++++++++++++++++
 block/blk-mq.c             | 13 ++++++-------
 drivers/nvme/host/core.c   |  6 +++++-
 drivers/nvme/host/pci.c    |  2 ++
 drivers/nvme/host/rdma.c   |  8 ++++++--
 drivers/nvme/host/tcp.c    |  8 ++++++--
 drivers/nvme/target/loop.c |  2 ++
 include/linux/blk-mq.h     |  3 ++-
 8 files changed, 61 insertions(+), 13 deletions(-)

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>

-- 
2.20.1

