Return-Path: <hch@lst.de>
Date: Wed, 18 Oct 2017 12:15:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] nvme: track shared namespaces
Message-ID: <20171018101552.GB14859@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-8-hch@lst.de> <68479c83-cdaa-77e0-232e-45c94b704765@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68479c83-cdaa-77e0-232e-45c94b704765@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 11, 2017 at 03:04:14PM +0300, Sagi Grimberg wrote:
>
>> +/*
>> + * Anchor structure for namespaces.  There is one for each namespace in a
>> + * NVMe subsystem that any of our controllers can see, and the namespace
>> + * structure for each controller is chained of it.  For private namespaces
>> + * there is a 1:1 relation to our namespace structures, that is ->list
>> + * only ever has a single entry for private namespaces.
>> + */
>> +struct nvme_ns_head {
>> +	struct list_head	list;
>
> Didn't we agree to call this list_head siblings?

Don't think I did.

>>     	struct nvme_ctrl *ctrl;
>>   	struct request_queue *queue;
>>   	struct gendisk *disk;
>> +	struct list_head siblings;
>
> And this list_head list (or entry, or sibling, or sibling_entry)?

I think siblings fits perfectly fine.  It is a lot more descriptive
than entry..
