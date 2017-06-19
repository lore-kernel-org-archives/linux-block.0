Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-12-git-send-email-axboe@kernel.dk>
 <20170619063529.GF2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <02daf14d-9a93-5654-f336-9c9551a855fe@kernel.dk>
Date: Mon, 19 Jun 2017 09:04:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170619063529.GF2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:35 AM, Christoph Hellwig wrote:
> Can you add linux-nvme for the next repost?
> 
> As said before I think we should rely on implicit streams allocation,
> as that will make the whole patch a lot simpler, and it solves the issue
> that your current patch will take away your 4 streams from the general
> pool on every controller that supports streams, which isn't optimal.

The only thing it'll change in the patch is the removal of
nvme_streams_allocate(), which is 20 lines of code. So I don't
think it'll simplify things a lot. The patch is already very simple.
But if we don't need to allocate the streams, then of course it should
just go.

>> +	streamid = (req->cmd_flags & REQ_WRITE_LIFE_MASK)
>> +			>> __REQ_WRITE_HINT_SHIFT;
> 
> Can we add a helper to convert the REQ_* flags back to the hint next
> to where we have the helper to do the reverse one?

OK, will od.

>> +	if (streamid == WRITE_LIFE_NONE)
>> +		return;
>> +
>> +	/* for now just round-robin, do something more clever later */
>> +	if (streamid > ctrl->nr_streams)
>> +		streamid = (streamid % ctrl->nr_streams) + 1;
> 
> I thought you were going to fix that to do more intelligent collapsing?

Sure, if you want me to do that now, I can. I propose:

- With 4 streams, direct mapping.
- With 3 streams, collapse two longest life times.
- With 2 streams, collapse short+medium, and long+extreme.
- With 1 stream, don't use streams.

We could potentially still use streams with just 1 stream, since we
have the default of no stream as well. But I don't think it makes
sense at that point.

> 
>> -	ns->queue->limits.discard_granularity = logical_block_size;
>> +	if (ctrl->nr_streams && ns->sws && ns->sgs) {
>> +		unsigned int sz = logical_block_size * ns->sws * ns->sgs;
>> +
>> +		ns->queue->limits.discard_alignment = sz;
> 
> I don't think this is correct:
> 
> "Data that is aligned to and in multiples of the Stream Write Size (SWS)
>  provides optimal performance of the write commands to the controller.
>  The Stream Granularity Size indicates the size of the media that is prepared
>  as a unit for future allocation for write commands and is a multiple of the
>  Stream Write Size. The controller may allocate and group together a stream
>  in Stream Granularity Size (SGS) units. Refer to Figure 293."
> 
> So I think the ns->sws should go away.

The SGS value is in units of SWS, however.

>> +		ns->queue->limits.discard_granularity = sz;
>> +	} else {
>> +		u32 logical_block_size = queue_logical_block_size(ns->queue);
> 
> I think we already have a logical_block_size with the same value in
> scope here.

Oops yes.

>> +	ns->sws = le32_to_cpu(s.sws);
>> +	ns->sgs = le16_to_cpu(s.sgs);
>> +
>> +	if (ns->sws) {
>> +		unsigned int bs = 1 << ns->lba_shift;
>> +
>> +		blk_queue_io_min(ns->queue, bs * ns->sws);
>> +		if (ns->sgs)
>> +			blk_queue_io_opt(ns->queue, bs * ns->sws * ns->sgs);
> 
> drop the multiplication with ns->sws here as well.

See above.

-- 
Jens Axboe
