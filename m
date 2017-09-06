Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] Move tagset reinit to its only current consumer, nvme-core
Date: Wed,  6 Sep 2017 18:30:29 +0300
Message-Id: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

As suggested by Bart Van Assche, get rid of
blk_mq_reinit_tagset and move it to nvme-core (its
only current consumer).

Instead, introduce a more generic tagset iterator helper.

Sagi Grimberg (3):
  block: introduce blk_mq_tagset_iter
  nvme: introduce nvme_reinit_tagset
  block: remove blk_mq_reinit_tagset

 block/blk-mq-tag.c       | 11 +++++------
 drivers/nvme/host/core.c | 13 +++++++++++++
 drivers/nvme/host/fc.c   |  3 ++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c |  7 +++----
 include/linux/blk-mq.h   |  4 ++--
 6 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.7.4
