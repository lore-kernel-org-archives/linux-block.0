Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbdIBPRp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Sep 2017 11:17:45 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 00/14] blk-mq-sched: improve SCSI-MQ performance
Date: Sat,  2 Sep 2017 23:17:15 +0800
Message-Id: <20170902151729.6162-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

In Red Hat internal storage test wrt. blk-mq scheduler, we
found that I/O performance is much bad with mq-deadline, especially
about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
SRP...)

Turns out one big issue causes the performance regression: requests
are still dequeued from sw queue/scheduler queue even when ldd's
queue is busy, so I/O merge becomes quite difficult to make, then
sequential IO degrades a lot.

The 1st five patches improve this situation, and brings back
some performance loss.

Patch 6 ~ 7 uses q->queue_depth as hint for setting up
scheduler queue depth.

Patch 8 ~ 15 improve bio merge via hash table in sw queue,
which makes bio merge more efficient than current approch
in which only the last 8 requests are checked. Since patch
6~14 converts to the scheduler way of dequeuing one request
from sw queue one time for SCSI device, and the times of
acquring ctx->lock is increased, and merging bio via hash
table decreases holding time of ctx->lock and should eliminate
effect from patch 14. 

With this changes, SCSI-MQ sequential I/O performance is
improved much, Paolo reported that mq-deadline performance
improved much[2] in his dbench test wrt V2. Also performanc
improvement on lpfc/qla2xx was observed with V1.[1]

Also Bart worried that this patchset may affect SRP, so provide
test data on SCSI SRP this time:

- fio(libaio, bs:4k, dio, queue_depth:64, 64 jobs)
- system(16 cores, dual sockets, mem: 96G)

          |v4.13-rc6+*  |v4.13-rc6+   | patched v4.13-rc6+ 
-----------------------------------------------------
 IOPS(K)  |  DEADLINE   |    NONE     |    NONE     
-----------------------------------------------------
read      |      587.81 |      511.96 |      518.51 
-----------------------------------------------------
randread  |      116.44 |      142.99 |      142.46 
-----------------------------------------------------
write     |      580.87 |       536.4 |      582.15 
-----------------------------------------------------
randwrite |      104.95 |      124.89 |      123.99 
-----------------------------------------------------


          |v4.13-rc6+   |v4.13-rc6+   | patched v4.13-rc6+ 
-----------------------------------------------------
 IOPS(K)  |  DEADLINE   |MQ-DEADLINE  |MQ-DEADLINE  
-----------------------------------------------------
read      |      587.81 |       158.7 |      450.41 
-----------------------------------------------------
randread  |      116.44 |      142.04 |      142.72 
-----------------------------------------------------
write     |      580.87 |      136.61 |      569.37 
-----------------------------------------------------
randwrite |      104.95 |      123.14 |      124.36 
-----------------------------------------------------

*: v4.13-rc6+ means v4.13-rc6 with block for-next


Please consider to merge to V4.4.

[1] http://marc.info/?l=linux-block&m=150151989915776&w=2
[2] https://marc.info/?l=linux-block&m=150217980602843&w=2

V4:
	- add Reviewed-by tag
	- some trival change: typo fix in commit log or comment,
	variable name, no actual functional change

V3:
	- totally round robin for picking req from ctx, as suggested
	by Bart
	- remove one local variable in __sbitmap_for_each_set()
	- drop patches of single dispatch list, which can improve
	performance on mq-deadline, but cause a bit degrade on
	none because all hctxs need to be checked after ->dispatch
	is flushed. Will post it again once it is mature.
	- rebase on v4.13-rc6 with block for-next

V2:
	- dequeue request from sw queues in round roubin's style
	as suggested by Bart, and introduces one helper in sbitmap
	for this purpose
	- improve bio merge via hash table from sw queue
	- add comments about using DISPATCH_BUSY state in lockless way,
	simplifying handling on busy state,
	- hold ctx->lock when clearing ctx busy bit as suggested
	by Bart


Ming Lei (14):
  blk-mq-sched: fix scheduler bad performance
  sbitmap: introduce __sbitmap_for_each_set()
  blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
  blk-mq-sched: move actual dispatching into one helper
  blk-mq-sched: improve dispatching from sw queue
  blk-mq-sched: don't dequeue request until all in ->dispatch are
    flushed
  blk-mq-sched: introduce blk_mq_sched_queue_depth()
  blk-mq-sched: use q->queue_depth as hint for q->nr_requests
  block: introduce rqhash helpers
  block: move actual bio merge code into __elv_merge
  block: add check on elevator for supporting bio merge via hashtable
    from blk-mq sw queue
  block: introduce .last_merge and .hash to blk_mq_ctx
  blk-mq-sched: refactor blk_mq_sched_try_merge()
  blk-mq: improve bio merge from blk-mq sw queue

 block/blk-mq-debugfs.c  |   1 +
 block/blk-mq-sched.c    | 186 +++++++++++++++++++++++++++++++-----------------
 block/blk-mq-sched.h    |  23 ++++++
 block/blk-mq.c          |  93 +++++++++++++++++++++++-
 block/blk-mq.h          |   7 ++
 block/blk-settings.c    |   2 +
 block/blk.h             |  55 ++++++++++++++
 block/elevator.c        |  93 ++++++++++++++----------
 include/linux/blk-mq.h  |   3 +
 include/linux/sbitmap.h |  54 ++++++++++----
 10 files changed, 399 insertions(+), 118 deletions(-)

-- 
2.9.5
