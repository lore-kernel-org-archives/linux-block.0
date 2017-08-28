Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 10:50:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
Message-ID: <20170828085015.GA4358@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-8-hch@lst.de> <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 09:51:14AM +0300, Sagi Grimberg wrote:
>> To allow lockless path lookup the list of nvme_ns structures per
>> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
>> structure through call_srcu.
>
> I haven't read the later patches yet, but what requires sleep in the
> path selection?

->make_request is allowed to sleep, and often will.

>> +	} else {
>> +		u8 eui64[8] = { 0 }, nguid[16] = { 0 };
>> +		uuid_t uuid = uuid_null;
>> +
>> +		nvme_report_ns_ids(ctrl, nsid, id, eui64, nguid, &uuid);
>> +		if (!uuid_equal(&head->uuid, &uuid) ||
>> +		    memcmp(&head->nguid, &nguid, sizeof(head->nguid)) ||
>> +		    memcmp(&head->eui64, &eui64, sizeof(head->eui64))) {
>
> Suggestion, given that this matching pattern returns in several places
> would it be better to move it to nvme_ns_match_id()?

I'll look into it.  Maybe we'll need a nvme_ns_ids structure to avoid
having tons of parameters, though.

>>   +/*
>> + * Anchor structure for namespaces.  There is one for each namespace in a
>> + * NVMe subsystem that any of our controllers can see, and the namespace
>> + * structure for each controller is chained of it.  For private namespaces
>> + * there is a 1:1 relation to our namespace structures, that is ->list
>> + * only ever has a single entry for private namespaces.
>> + */
>> +struct nvme_ns_head {
>> +	struct list_head	list;
>
> Maybe siblings is a better name than list,
> and the nvme_ns list_head should be called
> sibling_entry (or just sibling)?

Yeah.
