Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] blk-mq: improve IO perf in case of none io sched
Date: Thu, 28 Jun 2018 11:19:15 +0800
Message-Id: <20180628031918.17694-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st 2 patch improves ctx->lock uses, and it is observed that IOPS
may be improved by ~5% in rand IO test on MegaRaid SAS run by Kashyap.

The 3rd patch fixes rand IO performance regression on MegaRaid SAS
test, still reported by Kashyap.

Ming Lei (3):
  blk-mq: use list_splice_tail() to insert requests
  blk-mq: only attempt to merge bio if there is rq in sw queue
  blk-mq: dequeue request one by one from sw queue iff hctx is busy

 block/blk-mq-sched.c   | 14 ++++----------
 block/blk-mq.c         | 38 ++++++++++++++++++++++++++++++--------
 include/linux/blk-mq.h |  1 +
 3 files changed, 35 insertions(+), 18 deletions(-)

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>

-- 
2.9.5
