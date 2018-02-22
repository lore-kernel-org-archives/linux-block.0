Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751810AbeBVDAL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 22:00:11 -0500
Date: Thu, 22 Feb 2018 10:59:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: how can one drain MQ request queue ?
Message-ID: <20180222025943.GB1150@ming.t460p>
References: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Max,

On Tue, Feb 20, 2018 at 11:56:07AM +0200, Max Gurtovoy wrote:
> hi all,
> is there a way to drain a blk-mq based request queue (similar to
> blk_drain_queue for non MQ) ?

Generally speaking, blk_mq_freeze_queue() should be fine to drain blk-mq
based request queue, but it may not work well when the hardware is broken.

> 
> I try to fix the following situation:
> Running DM-multipath over NVMEoF/RDMA block devices, toggling the switch
> ports during traffic using fio and making sure the traffic never fails.
> 
> when the switch port goes down the initiator driver start an error recovery

What is the code you are referring to?

> process
> - blk_mq_quiesce_queue for each namespace request queue

blk_mq_quiesce_queue() only guarantees that no requests can be dispatched to
low level driver, and new requests still can be allocated, but can't be
dispatched until the queue becomes unquiesced.

> - cancel all requests of the tagset using blk_mq_tagset_busy_iter

Generally blk_mq_tagset_busy_iter() is used to cancel all in-flight
requests, and it depends on implementation of the busy_tag_iter_fn, and
timed-out request can't be covered by blk_mq_tagset_busy_iter().

So blk_mq_tagset_busy_iter() is often used in error recovery path, such
as nvme_dev_disable(), which is usually used in resetting PCIe NVMe controller.

> - destroy the QPs/RDMA connections and MR pools
> - blk_mq_unquiesce_queue for each namespace request queue
> - reconnect to the target (after creating RDMA resources again)
> 
> During the QP destruction, I see a warning that not all the memory regions
> were back to the mr_pool. For every request we get from the block layer
> (well, almost every request) we get a MR from the MR pool.
> So what I see is that, depends on the timing, some requests are
> dispatched/completed after we blk_mq_unquiesce_queue and after we destroy
> the QP and the MR pool. Probably these request were inserted during
> quiescing,

Yes.

> and I want to flush/drain them before I destroy the QP.

As mentioned above, you can't do that by blk_mq_quiesce_queue() &
blk_mq_tagset_busy_iter().

The PCIe NVMe driver takes two steps for the error recovery: nvme_dev_disable() &
nvme_reset_work(), and you may consider the similar approach, but the in-flight
requests won't be drained in this case because they can be requeued.

Could you explain a bit what your exact problem is?

Thanks,
Ming
