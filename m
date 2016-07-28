Return-Path: <kimran@codeaurora.org>
From: "Khan, Imran" <kimran@codeaurora.org>
To: "axboe@kernel.dk;akinobu.mita@gmail.com; axboe@fb.com;hch@lst.de;tom.leiming"@gmail.com
Cc: "linux-block@vger.kernel.org ;linux-kernel"@vger.kernel.org
Subject: [Query] increased latency observed in cpu hotplug path
Message-ID: <9e0a5975-4097-2819-3619-af7140ccf77b@codeaurora.org>
Date: Thu, 28 Jul 2016 18:48:36 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


Hi,

Recently we have observed some increased latency in CPU hotplug
event in CPU online path. For online latency we see that block
layer is executing notification handler for CPU_UP_PREPARE event
and this in turn waits for RCU grace period resulting (sometimes)
in an execution time of 15-20 ms for this notification handler.
This change was not there in 3.18 kernel but is present in 4.4
kernel and was introduced by following commit:

 
commit 5778322e67ed34dc9f391a4a5cbcbb856071ceba
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun Sep 27 02:09:23 2015 +0900
 
    blk-mq: avoid inserting requests before establishing new mapping

    Notifier callbacks for CPU_ONLINE action can be run on the other CPU
    than the CPU which was just onlined.  So it is possible for the
    process running on the just onlined CPU to insert request and run
    hw queue before establishing new mapping which is done by
    blk_mq_queue_reinit_notify().

    This can cause a problem when the CPU has just been onlined first time
    since the request queue was initialized.  At this time ctx->index_hw
    for the CPU, which is the index in hctx->ctxs[] for this ctx, is still
    zero before blk_mq_queue_reinit_notify() is called by notifier
    callbacks for CPU_ONLINE action.

    For example, there is a single hw queue (hctx) and two CPU queues
    (ctx0 for CPU0, and ctx1 for CPU1).  Now CPU1 is just onlined and
    a request is inserted into ctx1->rq_list and set bit0 in pending
    bitmap as ctx1->index_hw is still zero.

    And then while running hw queue, flush_busy_ctxs() finds bit0 is set
    in pending bitmap and tries to retrieve requests in
    hctx->ctxs[0]->rq_list.  But htx->ctxs[0] is a pointer to ctx0, so the
    request in ctx1->rq_list is ignored.

    Fix it by ensuring that new mapping is established before onlined cpu
    starts running.

    Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
    Reviewed-by: Ming Lei <tom.leiming@gmail.com>
    Cc: Jens Axboe <axboe@kernel.dk>
    Cc: Ming Lei <tom.leiming@gmail.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>

 
Upon reverting this commit I could see an improvement of 15-20 ms in
online latency. So I am looking for some help in analyzing the effects
of reverting this or should some other approach to reduce the online
latency must be taken.

Can you please provide some feedback in this regard?

-- 
Imran Khan
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
