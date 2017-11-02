Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933418AbdKBPY7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Nov 2017 11:24:59 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/7] blk-mq: don't allocate driver tag beforehand for flush rq
Date: Thu,  2 Nov 2017 23:24:31 +0800
Message-Id: <20171102152438.25324-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

This patchset avoids to allocate driver tag beforehand for flush rq
in case of I/O scheduler, then flush rq isn't treated specially
wrt. get/put driver tag, code gets cleanup much, such as,
reorder_tags_to_front() is removed, and we needn't to worry
about request order in dispatch list for avoiding I/O deadlock.

'dbench -t 30 -s 64' has been run on different devices(shared tag,
multi-queue, singele queue, ...), and no issues are observed,
even very low queue depth test are run, debench still works well.

Please consider it for V4.15, thanks!


V3:
	- rebase on the latest for-next of block tree
	- clean up commit log and comment
	- include Jianchao's fix on put driver tag

V2:
	- release driver tag before requeue
	- warning on inserting a req with driver tag


Jianchao Wang (1):
  blk-mq: put the driver tag of nxt rq before first one is requeued

Ming Lei (6):
  blk-flush: don't run queue for requests of bypassing flush
  block: pass 'run_queue' to blk_mq_request_bypass_insert
  blk-flush: use blk_mq_request_bypass_insert()
  blk-mq-sched: decide how to handle flush rq via RQF_FLUSH_SEQ
  blk-mq: move blk_mq_put_driver_tag*() into blk-mq.h
  blk-mq: don't allocate driver tag beforehand for flush rq

 block/blk-core.c     |  2 +-
 block/blk-flush.c    | 37 ++++++++++++++------
 block/blk-mq-sched.c | 63 +++++++++-------------------------
 block/blk-mq.c       | 97 ++++++++++------------------------------------------
 block/blk-mq.h       | 35 ++++++++++++++++++-
 5 files changed, 97 insertions(+), 137 deletions(-)

-- 
2.9.5
