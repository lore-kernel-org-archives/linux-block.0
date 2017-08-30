Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdH3PTy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 11:19:54 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: fix I/O hang during system resume
Date: Wed, 30 Aug 2017 23:19:32 +0800
Message-Id: <20170830151935.24253-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This two patches fix SCSI I/O hang during system resume.

The cause is that when SCSI device is put into SCSI's
quiesce state, normal I/O request can't be dispatched to lld
any more, only request with RQF_PREEMPT is allowed to be
sent to drive.

In current blk-mq implementation, if there is request in ->dispatch,
no new request can't be dispatched to driver any more.

This two patches fix the issue reported by Oleksandr.

Thanks,
Ming

Ming Lei (2):
  blk-mq: add requests in the tail of hctx->dispatch
  blk-mq: align to legacy's implementation of blk_execute_rq

 block/blk-core.c     |  2 +-
 block/blk-exec.c     |  2 +-
 block/blk-flush.c    |  2 +-
 block/blk-mq-sched.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq-sched.h |  2 ++
 block/blk-mq.c       |  2 +-
 6 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.9.5
