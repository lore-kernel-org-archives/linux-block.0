Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Andrew Jones <drjones@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/5] blk-mq: dispatch related cleanup, fix and optimization
Date: Mon, 25 Jun 2018 19:31:44 +0800
Message-Id: <20180625113149.29449-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st two patches cleanes up blk_mq_get_driver_tag() and
blk_mq_mark_tag_wait().

The 3rd patch fixes one race between adding hctx->dispatch_wait to
wq and removing it from wq.

The 4th patch avoids to iterate on all queues which share same tags
after completing one request, so that we can kill the synchronize_rcu()
in patch of queue cleanup, then long delay can be avoided during SCSI LUN
probe. Meantime IO performance can be improved.

The 5th patch avoids to synchronizing rcu in blk_cleanup_queue() when
queue isn't initialized, so long delay can be avoided during SCSI LUN
probe too.

Ming Lei (5):
  blk-mq: cleanup blk_mq_get_driver_tag()
  blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
  blk-mq: introduce new lock for protecting hctx->dispatch_wait
  blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
  blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()

 block/blk-core.c       |  8 +++--
 block/blk-mq-sched.c   | 85 +++-----------------------------------------------
 block/blk-mq.c         | 68 +++++++++++++++++++---------------------
 block/blk-mq.h         |  3 +-
 include/linux/blk-mq.h |  1 +
 include/linux/blkdev.h |  2 --
 6 files changed, 45 insertions(+), 122 deletions(-)

Cc: Omar Sandoval <osandov@fb.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>


-- 
2.9.5
