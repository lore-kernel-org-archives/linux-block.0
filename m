Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 0/3] block: fix mismatch of figuring out physical segment number
Date: Tue, 31 Jul 2018 18:49:11 +0800
Message-Id: <20180731104914.17249-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

This patchset fixes one issue related with physical segment computation,
which is found by Mike. In case of dm-rq, the warning of 'blk_cloned_rq_check_limits:
over max segments limit' can be triggered easily.

Follows the cause:

1) in IO fast path(blk_queue_split()), we always figure out physical segment number
no matter the flag of QUEUE_FLAG_NO_SG_MERGE is set or not.

2) only blk_recount_segments() and blk_recalc_rq_segments() uses the flag of
QUEUE_FLAG_NO_SG_MERGE, but the two are only called in some unusual
cases, such as request clone in dm-rq.

3) the above two computation don't match, and cause the warning of
"blk_cloned_rq_check_limits: over max segments limit".

This patchset fixes this issue by killing the queue flag since it is basically
bypassed since v4.4, and no one complains that at all. Also multipage bvec will
come soon, and it doesn't make sense to keep QUEUE_FLAG_NO_SG_MERGE any more.


Ming Lei (3):
  block: don't use bio->bi_vcnt to figure out segment number
  block: kill QUEUE_FLAG_NO_SG_MERGE
  block: kill BLK_MQ_F_SG_MERGE

 block/blk-merge.c            | 39 +++++++--------------------------------
 block/blk-mq-debugfs.c       |  2 --
 block/blk-mq.c               |  3 ---
 drivers/block/loop.c         |  2 +-
 drivers/block/nbd.c          |  2 +-
 drivers/block/rbd.c          |  2 +-
 drivers/block/skd_main.c     |  1 -
 drivers/block/xen-blkfront.c |  2 +-
 drivers/md/dm-rq.c           |  2 +-
 drivers/md/dm-table.c        | 13 -------------
 drivers/mmc/core/queue.c     |  3 +--
 drivers/scsi/scsi_lib.c      |  2 +-
 include/linux/blk-mq.h       |  1 -
 include/linux/blkdev.h       |  1 -
 14 files changed, 14 insertions(+), 61 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>

-- 
2.9.5
