Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: pci: fix & improve timeout handling
Date: Thu, 26 Apr 2018 20:39:54 +0800
Message-Id: <20180426123956.26039-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This first patch introduces EH kthread for handling timeout, and
simplifies the logics a lot, and fixes reports on block/011.

The 2nd one fixes the issue reported by Jianchao, in which admin
req may time out in EH.


Ming Lei (2):
  nvme: pci: simplify timeout handling
  nvme: pci: guarantee EH can make progress

 drivers/nvme/host/core.c |  11 ++++
 drivers/nvme/host/nvme.h |   1 +
 drivers/nvme/host/pci.c  | 161 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 158 insertions(+), 15 deletions(-)

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org


-- 
2.9.5
