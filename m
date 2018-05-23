Return-Path: <hare@suse.de>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com> <20180522161704.GA20000@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <53b05a82-a3f6-553a-ae3e-6efb8cbe7183@suse.de>
Date: Wed, 23 May 2018 07:48:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180522161704.GA20000@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/22/2018 06:17 PM, Christoph Hellwig wrote:
> Hi Keith,
> 
> I like this series a lot.  One comment that is probably close
> to the big discussion in the thread:
> 
>>   	switch (ret) {
>>   	case BLK_EH_HANDLED:
>>   		/*
>> +		 * If the request is still in flight, the driver is requesting
>> +		 * blk-mq complete it.
>>   		 */
>> +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
>> +			__blk_mq_complete_request(req);
>> +		break;
> 
> The state check here really irked me, and from the thread it seems like
> I'm not the only one.  At least for the NVMe case I think it is perfectly
> safe, although I agree I'd rather audit what other drivers do carefully.
> 
> That being said I think BLK_EH_HANDLED seems like a fundamentally broken
> idea, and I'd actually prefer to get rid of it over adding things like
> the MQ_RQ_IN_FLIGHT check above.
> 
I can't agree more here.

BLK_EH_HANDLED is breaking all sorts of assumptions, and I'd be glad to 
see it go.

> E.g. if we look at the cases where nvme-pci returns it:
> 
>   - if we did call nvme_dev_disable, we already canceled all requests,
>     so we might as well just return BLK_EH_NOT_HANDLED
>   - the poll for completion case already completed the command,
>     so we should return BLK_EH_NOT_HANDLED
> 
> So I think we need to fix up nvme and if needed any other driver
> to return the right value and then assert that the request is
> still in in-flight status for the BLK_EH_HANDLED case.
> 
... and then kill BLK_EH_HANDLED :-)

Cheers,

Hannes
