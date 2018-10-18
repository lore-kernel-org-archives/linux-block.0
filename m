Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, Matthew Wilcox <willy@infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018131817.11813-2-ming.lei@redhat.com>
 <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
 <20181018144306.GA27353@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cbb92881-cdb8-1415-7c67-0ea8a7c2fd2f@kernel.dk>
Date: Thu, 18 Oct 2018 08:46:47 -0600
MIME-Version: 1.0
In-Reply-To: <20181018144306.GA27353@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 8:43 AM, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:27:28AM -0600, Jens Axboe wrote:
>> On 10/18/18 7:18 AM, Ming Lei wrote:
>>> Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
>>> for pass-through request, and it isn't done for normal IO request.
>>>
>>> Given the check has to be done on each bvec, it isn't efficient to add the
>>> check in generic_make_request_checks().
>>>
>>> This patch addes one WARN in blk_queue_split() for capturing this issue.
>>
>> I don't want to do this, because then we are forever doomed to
>> have something that fully loops a bio at submission time. I
>> absolutely hate the splitting we have and the need for it,
>> hopefully it can go away for a subset of IOs at some point.
> 
> It is just a WARN_ON - no one should rely on it, but it is a good
> debug aid.

And then we'll have it start triggering on random things because
some drivers set random limits, that don't reflect reality at
all... We've basically had this setting that some drivers set,
but that we don't really look at except for mapping in user
data. Those should be audited first before adding something like
this.

-- 
Jens Axboe
