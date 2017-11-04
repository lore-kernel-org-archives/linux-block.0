Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3 0/7] blk-mq: don't allocate driver tag beforehand for
 flush rq
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, linux-kernel@vger.kernel.org
References: <20171102152438.25324-1-ming.lei@redhat.com>
 <20171104041703.GA2819@ming.t460p>
 <016e4ab3-c5db-9871-0e4d-cd3ff31eee22@kernel.dk>
Message-ID: <38f3a132-0c0d-4ae1-ac05-86a492720a5f@kernel.dk>
Date: Sat, 4 Nov 2017 12:49:06 -0600
MIME-Version: 1.0
In-Reply-To: <016e4ab3-c5db-9871-0e4d-cd3ff31eee22@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/04/2017 08:18 AM, Jens Axboe wrote:
> On 11/03/2017 10:17 PM, Ming Lei wrote:
>> On Thu, Nov 02, 2017 at 11:24:31PM +0800, Ming Lei wrote:
>>> Hi Jens,
>>>
>>> This patchset avoids to allocate driver tag beforehand for flush rq
>>> in case of I/O scheduler, then flush rq isn't treated specially
>>> wrt. get/put driver tag, code gets cleanup much, such as,
>>> reorder_tags_to_front() is removed, and we needn't to worry
>>> about request order in dispatch list for avoiding I/O deadlock.
>>>
>>> 'dbench -t 30 -s 64' has been run on different devices(shared tag,
>>> multi-queue, singele queue, ...), and no issues are observed,
>>> even very low queue depth test are run, debench still works well.
>>>
>>> Please consider it for V4.15, thanks!
>>
>> Hi Jens,
>>
>> As we discussed before, this patch is a good cleanup on handling flush
>> request, could you share your opinion on V3?
> 
> It looks fine to me. But I'd really like to have the potential hang
> in the current 4.15 branch ironed out, before we pile more stuff on
> top. Meanwhile, I'll see if this passes my testing.

Passes testing. I applied it, but a heads-up that I rewrote most of
your changelogs and also changed formatting. Please at least follow
the 72 char line rule for commit messages, otherwise git log ends
up looking like a mess really quick.

-- 
Jens Axboe
