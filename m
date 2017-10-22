Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
 blk_mq_tagset_iter()
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme-bounces@lists.infradead.org>,
 linux-block@vger.kernel.org
Cc: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c27d643-a7d9-3077-2875-cea768cbf386@grimberg.me>
Date: Sun, 22 Oct 2017 21:32:00 +0300
MIME-Version: 1.0
In-Reply-To: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Currently, blk_mq_tagset_iter() iterate over initial hctx tags only.
> In case scheduler is used, it doesn't iterate the hctx scheduler tags
> and the static request aren't been updated.
> For example, while using NVMe over Fabrics RDMA host, this cause us not to
> reinit the scheduler requests and thus not re-register all the memory regions
> during the tagset re-initialization in the reconnect flow.

I think this is a sign that we should cease from embedding memory
regions on the pre-allocated requests. Its too much resources
that we waste. In our case, tags are not really cheap given
that they take a physical HW resource (rdma memory region).

I think we should switch (again) to a pool design instead. I guess its
time for a generic MR pool that will serve nvmf, xprt, srp, iser and
friends.
