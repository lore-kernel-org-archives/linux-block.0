Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] blk-mq: some fixes about updating hw queues
Date: Fri, 12 Oct 2018 18:07:24 +0800
Message-Id: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

This patch set fixes some defects during update hw queues.

1st patch refactor the blk-mq debugfs and sysfs register during
blk_mq_update_nr_hw_queues.

2nd patch change the GFP_KERNEL to GFP_NOIO during blk_mq_realloc_hw_ctxs,

3rd patch try to realloc hctx when this hctx is mapped to a different node.

4th patch should be able to fix the panic reported in follwing link
https://marc.info/?l=linux-block&m=153799465603723&w=2

V2:
 - Newly add 2nd and 3rd patch.
 - Use blk_mq_map_queues when __blk_mq_update_nr_hw_queues fallbacks to
   previous nr_hw_queues to avoid driver's .map_queues leak mapping of
   some cpus due the fallback nr_hw_queues.
 - Add Ming's Reviewed-by in 1st patch.


Jianchao Wang[4]
blk-mq: adjust debugfs and sysfs register when
blk-mq: change gfp flags to GFP_NOIO in
blk-mq: realloc hctx when hw queue is mapped to
blk-mq: fallback to previous nr_hw_queues when

 block/blk-core.c  |   2 +-
 block/blk-flush.c |   6 +--
 block/blk-mq.c    | 155 ++++++++++++++++++++++++++++++++++--------------------
 block/blk.h       |   2 +-
 4 files changed, 102 insertions(+), 63 deletions(-)
