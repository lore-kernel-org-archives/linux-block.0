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
Subject: [PATCH V3 0/3] blk-mq: improve IO perf in case of none io sched
Date: Mon,  2 Jul 2018 17:35:57 +0800
Message-Id: <20180702093600.10315-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st 2 patch improves ctx->lock uses, and it is observed that IOPS
may be improved by ~5% in rand IO test on MegaRaid SAS run by Kashyap.

The 3rd patch fixes rand IO performance regression on MegaRaid SAS
test, still reported by Kashyap.

V3:
	- export dispatch busy from debugfs as suggested by Jens
	- add comment on blk_mq_update_hctx_busy() as suggested by Christoph

V2:
	- fix list corruption in patch 1/3


Ming Lei (3):
  blk-mq: use list_splice_tail_init() to insert requests
  blk-mq: only attempt to merge bio if there is rq in sw queue
  blk-mq: dequeue request one by one from sw queue iff hctx is busy

 block/blk-mq-debugfs.c |  9 +++++++++
 block/blk-mq-sched.c   | 14 ++++----------
 block/blk-mq.c         | 44 ++++++++++++++++++++++++++++++++++++--------
 include/linux/blk-mq.h |  3 ++-
 4 files changed, 51 insertions(+), 19 deletions(-)

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>

-- 
2.9.5
