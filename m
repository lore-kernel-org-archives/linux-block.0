Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [BUG] nvme driver crash
To: Max Gurtovoy <maxg@mellanox.com>, Omar Sandoval <osandov@osandov.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Shaohua Li <shli@kernel.org>, linux-block@vger.kernel.org,
 axboe@kernel.dk, Keith Busch <keith.busch@intel.com>
References: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
 <20170726173443.GA25527@infradead.org>
 <20170726191221.GA22421@vader.DHCP.thefacebook.com>
 <53919f26-3886-350a-119b-59e9c4b8ea4d@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <03ed5208-443b-fe5e-5c65-1d67ef371ce0@grimberg.me>
Date: Thu, 27 Jul 2017 17:05:52 +0300
MIME-Version: 1.0
In-Reply-To: <53919f26-3886-350a-119b-59e9c4b8ea4d@mellanox.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Adding Sagi and Keith.
> 
> Christoph,
> I've send some fix few months ago to that but haven't got a green light:
> 
> 
> nvme: don't ignore tagset allocation failures
> 
> the nvme_dev_add() function silently ignores failures.
> In case blk_mq_alloc_tag_set fails, we hit NULL deref while
> calling blk_mq_init_queue during nvme_alloc_ns with tagset == NULL.
> Instead, we'll not issue the scan_work in case tagset allocation
> failed and leave the ctrl functional.
> 

IIRC I argued that the core should not check the tagset existence,

Regardless that its the wrong layer to check it, it means that
all drivers need to make sure to take care of getting this dereference
correct.

Perhaps we need to come up with a new state for this stage (something
like CTRL_ADMIN_READY), and state transition is:

NEW -> ADMIN_READY (admin queue configured) -> LIVE (if we have
one or more IO queues ready).

> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> ---
>   drivers/nvme/host/core.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9b3b57f..493722a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2115,9 +2115,9 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   {
>       /*
>        * Do not queue new scan work when a controller is reset during
> -     * removal.
> +     * removal or if the tagset doesn't exist.
>        */
> -    if (ctrl->state == NVME_CTRL_LIVE)
> +    if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
>           schedule_work(&ctrl->scan_work);
>   }
>   EXPORT_SYMBOL_GPL(nvme_queue_scan);
> 
> 
> maybe we can rebase and consider it again ?
> 
