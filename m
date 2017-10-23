Return-Path: <hch@lst.de>
Date: Mon, 23 Oct 2017 08:26:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
	Linux-nvme <linux-nvme-bounces@lists.infradead.org>,
	linux-block@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
	blk_mq_tagset_iter()
Message-ID: <20171023062627.GD16899@lst.de>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com> <2c27d643-a7d9-3077-2875-cea768cbf386@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c27d643-a7d9-3077-2875-cea768cbf386@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Sun, Oct 22, 2017 at 09:32:00PM +0300, Sagi Grimberg wrote:
>
>> Currently, blk_mq_tagset_iter() iterate over initial hctx tags only.
>> In case scheduler is used, it doesn't iterate the hctx scheduler tags
>> and the static request aren't been updated.
>> For example, while using NVMe over Fabrics RDMA host, this cause us not to
>> reinit the scheduler requests and thus not re-register all the memory regions
>> during the tagset re-initialization in the reconnect flow.
>
> I think this is a sign that we should cease from embedding memory
> regions on the pre-allocated requests. Its too much resources
> that we waste. In our case, tags are not really cheap given
> that they take a physical HW resource (rdma memory region).
>
> I think we should switch (again) to a pool design instead. I guess its
> time for a generic MR pool that will serve nvmf, xprt, srp, iser and
> friends.

Liks drivers/infiniband/core/mr_pool.c? :)
