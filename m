Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: fix hang in path of removing disk
Date: Wed, 17 May 2017 09:27:27 +0800
Message-Id: <20170517012729.13469-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The 1st patch fixes one race between resettting failure and remove.

The 2nd patch avoids hanging in del_gendisk() if del_gendisk() waits
for these submitted writeback requests.

Keith, about the 1st patch, as we talked, there are two directions for
fixing the 1st issue, I know you may be working towards treating this
reset failure as controller dead, and not completed yet. But if
nvme_remove_dead_ctrl() is needed in any one of reset failure path,
this patch is still required. Seems both two directions aren't
contradictorily.

Ming Lei (2):
  nvme: fix race between removing and reseting failure
  nvme: avoid to hang in remove disk

 drivers/nvme/host/core.c | 8 ++++++++
 drivers/nvme/host/pci.c  | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.9.3
