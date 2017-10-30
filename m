Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Keith Busch <keith.busch@intel.com>,
	"Hannes Reinecke" <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
	niuhaoxin <niuhaoxin@huawei.com>, "Shenhong (C)" <shenhong09@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <70b681c5-5fae-ae40-2ff6-60cf75d52616@huawei.com>
Date: Mon, 30 Oct 2017 11:37:55 +0800
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-17-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>



On 2017/10/23 22:51, Christoph Hellwig wrote:
> @@ -2427,20 +2681,46 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	if (ret) {
>  		dev_err(ctrl->device,
>  			"duplicate IDs for nsid %d\n", nsid);
> -		goto out_free_head;
> +		goto out_release_instance;
>  	}
>  
> +	ret = -ENOMEM;
> +	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
> +	if (!q)
> +		goto out_free_head;
> +	q->queuedata = head;
> +	blk_queue_make_request(q, nvme_ns_head_make_request);
> +	q->poll_fn = nvme_ns_head_poll;
> +	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
> +	/* set to a default value for 512 until disk is validated */
> +	blk_queue_logical_block_size(q, 512);
> +	nvme_set_queue_limits(ctrl, q);
> +
> +	head->disk = alloc_disk(0);
> +	if (!head->disk)
> +		goto out_cleanup_queue;
> +	head->disk->fops = &nvme_ns_head_ops;
> +	head->disk->private_data = head;
> +	head->disk->queue = q;
> +	head->disk->flags = GENHD_FL_EXT_DEVT;
> +	sprintf(head->disk->disk_name, "nvme%dn%d",
> +			ctrl->subsys->instance, nsid);

Is it okay to use head->instance instead of nsid for disk name nvme#n# ?
Becuase _nsid_ sets are not continuous sometimes, so disk name is ugly in that case.
