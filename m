Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] blk-mq: fix and improve queue mapping
Date: Sun,  8 Apr 2018 17:48:06 +0800
Message-Id: <20180408094814.28953-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

The first two patches fix issues about queue mapping.

The other 6 patches improve queue mapping for blk-mq.

Christian, this patches should fix your issue, so please give
a test, and the patches can be found in the following tree:

	https://github.com/ming1/linux/commits/v4.17-rc-blk-fix_mapping_v1

Thanks,
Ming

Ming Lei (8):
  blk-mq: make sure that correct hctx->next_cpu is set
  blk-mq: don't keep offline CPUs mapped to hctx 0
  blk-mq: avoid to write intermediate result to hctx->next_cpu
  blk-mq: introduce blk_mq_hw_queue_first_cpu() to figure out first cpu
  blk-mq: remove blk_mq_delay_queue()
  blk-mq: don't check queue mapped in __blk_mq_delay_run_hw_queue()
  blk-mq: reimplement blk_mq_hw_queue_mapped
  blk-mq: remove code for dealing with remapping queue

 block/blk-mq-cpumap.c  |   5 ---
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 101 +++++++++++--------------------------------------
 block/blk-mq.h         |   2 +-
 include/linux/blk-mq.h |   2 -
 5 files changed, 24 insertions(+), 87 deletions(-)

-- 
2.9.5
