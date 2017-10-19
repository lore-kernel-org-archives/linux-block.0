Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 15/17] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-16-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c68d0c8-a063-44f9-a76b-0970c9e4ad5d@grimberg.me>
Date: Thu, 19 Oct 2017 14:06:07 +0300
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-16-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Christoph,

>   static void nvme_free_ns(struct kref *kref)
>   {
>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>   
> +	if (ns->head)
> +		nvme_put_ns_head(ns->head);
> +

When can we not have a ns-head set?

AFAICT, if nvme_alloc_ns succeeded, we have it set don't we?
