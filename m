Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Martin Steigerwald <Martin@Lichtvoll.de>,
	Israel Rukshin <israelr@mellanox.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/2] blk-mq: fix race between completion and BLK_EH_RESET_TIMER
Date: Sun, 15 Apr 2018 23:43:55 +0800
Message-Id: <20180415154357.19788-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

This two patches fixes the recently discussed race between completion
and BLK_EH_RESET_TIMER.

Israel & Martin, this one is a simpler fix on this issue and can
cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request, could
you test V4 and see if your issue can be fixed?

Thanks,

V4:
	- run synchronize_rcu() once for handling all timed out request
	between .timeout() and the following handling
	- address tj's concern about reorder between blk_add_timer() and
    blk_mq_rq_update_aborted_gstate(req, 0)

V3:
	- before completing rq for BLK_EH_HANDLED, sync with normal completion path
	- make sure rq's state updated as MQ_RQ_IN_FLIGHT before completing
V2:
	- rename the new flag as MQ_RQ_COMPLETE_IN_TIMEOUT
	- fix lock uses in blk_mq_rq_timed_out
	- document re-order between blk_add_timer() and
	blk_mq_rq_update_aborted_gstate(req, 0)


Ming Lei (2):
  blk-mq: set RQF_MQ_TIMEOUT_EXPIRED when the rq's timeout isn't handled
  blk-mq: fix race between complete and BLK_EH_RESET_TIMER

 block/blk-mq.c         | 120 +++++++++++++++++++++++++++++++++++++++----------
 block/blk-mq.h         |   1 +
 block/blk-timeout.c    |   1 -
 include/linux/blkdev.h |   6 +++
 4 files changed, 104 insertions(+), 24 deletions(-)

-- 
2.9.5
