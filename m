Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] nvme suspend/resume fix
Date: Wed,  1 Mar 2017 14:22:09 -0500
Message-Id: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

This is hopefully the last version to fix nvme stopping blk-mq's CPU
event from making forward progress. The solution requires a couple new
blk-mq exports so the nvme driver can properly sync with queue states.

Since this depends on the blk-mq parts, and if you approve of the
proposal, I think it'd be easiest if you can take this directly into
linux-block/for-linus. Otherwise, we can send you a pull request if you
Ack the blk-mq parts.

The difference from the previous patch is an update that Artur
confirmed passes hibernate on a stacked request queue. Personally,
I tested this for several hours with fio running buffered writes
in the back-ground and rtcwake running suspend/resume at intervals.
This succeeded with no fio errors.

Keith Busch (3):
  blk-mq: Export blk_mq_freeze_queue_wait
  blk-mq: Provide queue freeze wait timeout
  nvme: Complete all stuck requests

 block/blk-mq.c           | 12 +++++++++++-
 drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 33 ++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h   |  3 +++
 5 files changed, 93 insertions(+), 6 deletions(-)

-- 
2.5.5
