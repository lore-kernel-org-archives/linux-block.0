Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 7/9] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68479c83-cdaa-77e0-232e-45c94b704765@grimberg.me>
Date: Wed, 11 Oct 2017 15:04:14 +0300
MIME-Version: 1.0
In-Reply-To: <20170925134031.10548-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> +/*
> + * Anchor structure for namespaces.  There is one for each namespace in a
> + * NVMe subsystem that any of our controllers can see, and the namespace
> + * structure for each controller is chained of it.  For private namespaces
> + * there is a 1:1 relation to our namespace structures, that is ->list
> + * only ever has a single entry for private namespaces.
> + */
> +struct nvme_ns_head {
> +	struct list_head	list;

Didn't we agree to call this list_head siblings?

> +	struct srcu_struct      srcu;
> +	unsigned		ns_id;
> +	struct nvme_ns_ids	ids;
> +	struct list_head	entry;
> +	struct kref		ref;
> +};
> +
>   struct nvme_ns {
>   	struct list_head list;
>   
>   	struct nvme_ctrl *ctrl;
>   	struct request_queue *queue;
>   	struct gendisk *disk;
> +	struct list_head siblings;

And this list_head list (or entry, or sibling, or sibling_entry)?

>   	struct nvm_dev *ndev;
>   	struct kref kref;
> +	struct nvme_ns_head *head;
>   	int instance;
>   
> -	unsigned ns_id;
> -	struct nvme_ns_ids ids;
>   	int lba_shift;
>   	u16 ms;
>   	u16 sgs;
> 
