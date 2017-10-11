Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <725347b9-661a-1c95-02d1-3c10b57dd8d4@grimberg.me>
Date: Wed, 11 Oct 2017 15:24:50 +0300
MIME-Version: 1.0
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> +static const struct block_device_operations nvme_subsys_ops = {
> +	.owner		= THIS_MODULE,
> +};

Nit - maybe better to name this nvme_ns_head_ops

> +	ret = -ENOMEM;
> +	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
> +	if (!q)
> +		goto out_free_head;
> +	q->queuedata = head;
> +	blk_queue_make_request(q, nvme_make_request);
> +	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
> +	/* set to a default value for 512 until disk is validated */
> +	blk_queue_logical_block_size(q, 512);
> +	nvme_set_queue_limits(ctrl, q);
> +
> +	head->disk = alloc_disk(0);
> +	if (!head->disk)
> +		goto out_cleanup_queue;
> +	head->disk->fops = &nvme_subsys_ops;
> +	head->disk->private_data = head;
> +	head->disk->queue = q;
> +	head->disk->flags = GENHD_FL_EXT_DEVT;
> +	sprintf(head->disk->disk_name, "nvm-sub%dn%d",
> +			ctrl->subsys->instance, nsid);

Did we end up in agreement on nvmsXnY?


> @@ -2669,8 +2905,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	}
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
> -	if (head)
> +	if (head) {
> +		rcu_assign_pointer(head->current_path, NULL);

Doesn't this assignment need to happen only when the ns *is* the
current_path?
