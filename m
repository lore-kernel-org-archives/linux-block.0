Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdINQmZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 12:42:25 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] blk-mq: don't allocate driver tag beforehand for flush rq
Date: Fri, 15 Sep 2017 00:42:07 +0800
Message-Id: <20170914164213.17859-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchset avoids to allocate driver tag beforehand for flush rq
in case of I/O scheduler, then flush rq isn't treated specially
wrt. get/put driver tag, code gets cleanup much, such as,
reorder_tags_to_front() is removed, and we needn't to worry
about request order in dispatch list for avoiding I/O deadlock.

'dbench -t 30 -s -F 64' has been run on different devices(shared tag,
multi-queue, singele queue, ...), and no issues are observed,
even very low queue depth(1) test are run, debench still works
well.

Any comments are welcome!

Thanks,
Ming

Ming Lei (6):
  blk-flush: don't run queue for requests of bypassing flush
  block: pass 'run_queue' to blk_mq_request_bypass_insert
  blk-flush: use blk_mq_request_bypass_insert()
  blk-mq: decide how to handle flush rq via RQF_FLUSH_SEQ
  blk-mq: move __blk_mq_put_driver_tag() into blk-mq.h
  blk-mq: don't allocate driver tag beforehand for flush rq

 block/blk-core.c     |  2 +-
 block/blk-flush.c    | 43 +++++++++++++++++++++++++++++------
 block/blk-mq-sched.c | 64 ++++++++++++++--------------------------------------
 block/blk-mq.c       | 55 ++++++--------------------------------------
 block/blk-mq.h       | 15 +++++++++++-
 5 files changed, 75 insertions(+), 104 deletions(-)

-- 
2.9.5
