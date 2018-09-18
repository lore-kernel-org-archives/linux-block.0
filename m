Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeIRPpO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] blk-mq: allow to unfreeze queue when io isn't drained
Date: Tue, 18 Sep 2018 18:13:07 +0800
Message-Id: <20180918101310.13154-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch introduces percpu_ref_resurge() for implementing
blk_mq_unfreeze_queue_no_drain_io().

The 2nd patch introdces blk_mq_unfreeze_queue_no_drain_io() for
cases in which queue can be unfreeze without draininig IO.

The 3rd patch applies blk_mq_unfreeze_queue_no_drain_io() to
NVMe PCI timeout, so that IO hang may be avoided inside
nvme_reset_work() when new IO timeout is triggered. 

Part of idea is from Jianchao's early work:

https://marc.info/?l=linux-kernel&m=153612052611020&w=2

Ming Lei (3):
  lib/percpu-refcount: introduce percpu_ref_resurge()
  blk-mq: introduce blk_mq_unfreeze_queue_no_drain_io
  nvme: don't drain IO in nvme_reset_work()

 block/blk-mq.c                  | 25 ++++++++++++++--
 drivers/nvme/host/core.c        | 12 +++++---
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/pci.c         |  3 +-
 include/linux/blk-mq.h          |  1 +
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 63 ++++++++++++++++++++++++++++++++++-------
 7 files changed, 87 insertions(+), 20 deletions(-)

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>


-- 
2.9.5
