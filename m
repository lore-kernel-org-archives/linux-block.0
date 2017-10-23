Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
 blk_mq_tagset_iter()
To: Christoph Hellwig <hch@lst.de>
Cc: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme-bounces@lists.infradead.org>,
 linux-block@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 Jens Axboe <axboe@kernel.dk>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
 <2c27d643-a7d9-3077-2875-cea768cbf386@grimberg.me>
 <20171023062627.GD16899@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68bf7dff-d186-eb09-b853-254d0ae6f3e5@grimberg.me>
Date: Mon, 23 Oct 2017 10:27:29 +0300
MIME-Version: 1.0
In-Reply-To: <20171023062627.GD16899@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> Currently, blk_mq_tagset_iter() iterate over initial hctx tags only.
>>> In case scheduler is used, it doesn't iterate the hctx scheduler tags
>>> and the static request aren't been updated.
>>> For example, while using NVMe over Fabrics RDMA host, this cause us not to
>>> reinit the scheduler requests and thus not re-register all the memory regions
>>> during the tagset re-initialization in the reconnect flow.
>>
>> I think this is a sign that we should cease from embedding memory
>> regions on the pre-allocated requests. Its too much resources
>> that we waste. In our case, tags are not really cheap given
>> that they take a physical HW resource (rdma memory region).
>>
>> I think we should switch (again) to a pool design instead. I guess its
>> time for a generic MR pool that will serve nvmf, xprt, srp, iser and
>> friends.
> 
> Liks drivers/infiniband/core/mr_pool.c? :)

Yea :)

forgot we had that...

Note that it does introduce a new spinlock to our hot-path, but given
the current over-allocation scheme with schedulers, its probably better
off.
