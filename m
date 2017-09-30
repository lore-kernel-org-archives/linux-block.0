Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdI3L1Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Sep 2017 07:27:24 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 0/8] blk-mq: improve bio merge for none scheduler
Date: Sat, 30 Sep 2017 19:26:47 +0800
Message-Id: <20170930112655.31451-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

Patch 1 ~ 2 uses q->queue_depth as hint for setting up
scheduler queue depth.

Patch 3 ~ 8 improve bio merge via hash table in sw queue,
which makes bio merge more efficient than current approch
in which only the last 8 requests in sw queue are checked.

Also this way has been used in block legacy path for long time,
and blk-mq scheduler uses hash table to do bio merge too.

V5:
	- splitted from previous patchset of 'blk-mq-sched: improve
	SCSI-MQ performance V4'

Ming Lei (8):
  blk-mq-sched: introduce blk_mq_sched_queue_depth()
  blk-mq-sched: use q->queue_depth as hint for q->nr_requests
  block: introduce rqhash helpers
  block: move actual bio merge code into __elv_merge
  block: add check on elevator for supporting bio merge via hashtable
    from blk-mq sw queue
  block: introduce .last_merge and .hash to blk_mq_ctx
  blk-mq-sched: refactor blk_mq_sched_try_merge()
  blk-mq: improve bio merge from blk-mq sw queue

 block/blk-mq-sched.c | 75 +++++++++++++++---------------------------
 block/blk-mq-sched.h | 23 +++++++++++++
 block/blk-mq.c       | 55 ++++++++++++++++++++++++++++---
 block/blk-mq.h       |  5 +++
 block/blk-settings.c |  2 ++
 block/blk.h          | 55 +++++++++++++++++++++++++++++++
 block/elevator.c     | 93 +++++++++++++++++++++++++++++++---------------------
 7 files changed, 216 insertions(+), 92 deletions(-)

-- 
2.9.5
