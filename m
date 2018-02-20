Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:60556
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750979AbeBTJ4t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Feb 2018 04:56:49 -0500
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Ming Lei <ming.lei@redhat.com>,
        <linux-nvme@lists.infradead.org>
From: Max Gurtovoy <maxg@mellanox.com>
Subject: how can one drain MQ request queue ?
Message-ID: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
Date: Tue, 20 Feb 2018 11:56:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1255"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

hi all,
is there a way to drain a blk-mq based request queue (similar to 
blk_drain_queue for non MQ) ?

I try to fix the following situation:
Running DM-multipath over NVMEoF/RDMA block devices, toggling the switch 
ports during traffic using fio and making sure the traffic never fails.

when the switch port goes down the initiator driver start an error 
recovery process
- blk_mq_quiesce_queue for each namespace request queue
- cancel all requests of the tagset using blk_mq_tagset_busy_iter
- destroy the QPs/RDMA connections and MR pools
- blk_mq_unquiesce_queue for each namespace request queue
- reconnect to the target (after creating RDMA resources again)

During the QP destruction, I see a warning that not all the memory 
regions were back to the mr_pool. For every request we get from the 
block layer (well, almost every request) we get a MR from the MR pool.
So what I see is that, depends on the timing, some requests are 
dispatched/completed after we blk_mq_unquiesce_queue and after we 
destroy the QP and the MR pool. Probably these request were inserted 
during quiescing, and I want to flush/drain them before I destroy the QP.

Is there a way in the block layer that I can do it (we don't want to 
destroy the tagset and the request_queue on each reconnection)?

I'm open for suggestion :)

Cheers,
Max.
