Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 15:51:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/17] nvme: track shared namespaces
Message-ID: <20171019135151.GB21452@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-16-hch@lst.de> <3c68d0c8-a063-44f9-a76b-0970c9e4ad5d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3c68d0c8-a063-44f9-a76b-0970c9e4ad5d@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 02:06:07PM +0300, Sagi Grimberg wrote:
> Christoph,
>
>>   static void nvme_free_ns(struct kref *kref)
>>   {
>>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>>   +	if (ns->head)
>> +		nvme_put_ns_head(ns->head);
>> +
>
> When can we not have a ns-head set?
>
> AFAICT, if nvme_alloc_ns succeeded, we have it set don't we?

Yes, I don't think we should need it.  Let me verify that for the
next round.
