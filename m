Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
Date: Fri, 16 Jun 2017 13:41:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170616180942.GD27996@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 12:09 PM, Christoph Hellwig wrote:
>> We default to allocating 4 streams per name space, but it is
>> configurable with the 'streams_per_ns' module option.
> 
> What's your strategy for multi-namespace devices?  You won't even get
> your 4 streams for a handful namespaces with devices today or the near
> future.  Should we cut down the number of streams per namespace?  Or
> just not set aside streams for namespace exclusive use?  Or so far
> you simply don't care about the multi-ns case?

I'm assuming most devices will have 8 streams, or 16. So for 2 or 4
namespaces, we'd be fine.

But honestly, I simply don't care too much about it, for a few reasons:

1) I don't know of anyone that uses name spaces to split up a device,
   except for places where the want integrity on one and not the other.
   And I haven't even seen that.

2) If you do have multiple name spaces, you get some data separation
   through that. Or not, depending on the device.

In any case, we'll just have to divide up the streams. Right now we just
allocate 4 in a first-come first-serve basis. If you have more name
spaces than streams/4, then some name spaces don't get streams. We could
make this more fair and do:

streams_per_ns = ctrl->nssa / num_namespaces;

I'm not sure what the best answer is here, or if there even is one known
righ answer for this, as it will depend on the use case. That's
something we can change down the line without impacting anything, so I'm
not too worried about that.

>> +static void nvme_write_hint_work(struct work_struct *work)
>> +{
> 	struct nvme_ns *ns = container_of(work, struct nvme_ns, write_hint_work);
> 
> nasty 81 character line :)

Dear lord, I'll fix that up.

>> +	nr_streams = streams_per_ns;
>> +	if (nr_streams > ns->ctrl->nssa)
>> +		nr_streams = ns->ctrl->nssa;
> 
> min() ?

Yep, let's use that.

>> +static enum rw_hint nvme_get_write_stream(struct nvme_ns *ns,
>> +					   struct request *req)
>> +{
>> +	enum rw_hint streamid = req->cmd_flags & REQ_WRITE_LIFE_MASK;
>> +
>> +	if (req_op(req) != REQ_OP_WRITE ||
>> +	    !(ns->ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
>> +		return WRITE_LIFE_NONE;
> 
> How about moving this to the caller?
> 
>> +	/*
>> +	 * If we support streams and this request is a write with a valid
>> +	 * hint, then flag it as such. If we haven't allocated streams on
>> +	 * this ns before, do so lazily.
>> +	 */
>> +	stream = nvme_get_write_stream(ns, req);
>> +	if (stream != WRITE_LIFE_NONE) {
>> +		if (ns->nr_streams) {
>> +			control |= NVME_RW_DTYPE_STREAMS;
>> +			dsmgmt |= (stream << 16);
>> +		} else
>> +			nvme_configure_streams(ns);
>> +	}
> 
> .. and instead pass control and dsmgmt to nvme_get_write_stream by
> reference to isolate the functionality there.  And move the
> nvme_configure_streams call into it as well.

OK, I can make those two changes, fine with me.

> Last but not least this will need some tweaks in the deallocate
> code due to:
> 
> "If the host issues a Dataset Management command to deallocate logical
>  blocks that are associated with a stream, it should specify a starting
>  LBA and length that is aligned to and in multiples of the Stream
>  Granularity Size"

Do we use that internally?

-- 
Jens Axboe
