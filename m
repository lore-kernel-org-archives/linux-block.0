Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
To: Keith Busch <keith.busch@intel.com>
Cc: Scott Bauer <sbauer@eng.utah.edu>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
 <20171221213400.GB2975@localhost.localdomain>
 <5d3f06bf-8cb8-048d-30c5-9af611ad9ee7@kernel.dk>
 <20171221231054.GA2875@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0936aeea-ba88-701c-8a77-6e94b2566b02@kernel.dk>
Date: Fri, 22 Dec 2017 08:40:10 -0700
MIME-Version: 1.0
In-Reply-To: <20171221231054.GA2875@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 4:10 PM, Keith Busch wrote:
> On Thu, Dec 21, 2017 at 03:17:41PM -0700, Jens Axboe wrote:
>> On 12/21/17 2:34 PM, Keith Busch wrote:
>>> It would be nice, but the driver doesn't know a request's completion
>>> is going to be a polled. 
>>
>> That's trivially solvable though, since the information is available
>> at submission time.
>>
>>> Even if it did, we don't have a spec defined
>>> way to tell the controller not to send an interrupt with this command's
>>> compeletion, which would be negated anyway if any interrupt driven IO
>>> is mixed in the same queue. We could possibly create a special queue
>>> with interrupts disabled for this purpose if we can pass the HIPRI hint
>>> through the request.
>>
>> There's on way to do it per IO, right. But you can create a sq/cq pair
>> without interrupts enabled. This would also allow you to scale better
>> with multiple users of polling, a case where we currently don't
>> perform as well spdk, for instance.
> 
> Would you be open to have blk-mq provide special hi-pri hardware contexts
> for all these requests to come through? Maybe one per NUMA node? If not,
> I don't think have enough unused bits in the NVMe command id to stash
> the hctx id to extract the original request.

Yeah, in fact I think we HAVE to do it this way. I've been thinking about
this for a while, and ideally I'd really like blk-mq to support multiple
queue "pools". It's basically just a mapping thing. Right now you hand
blk-mq all your queues, and the mappings are defined for one set of
queues. It'd be nifty to support multiple sets, so we could do things
like "reserve X for polling", for example, and just have the mappings
magically work. blk_mq_map_queue() then just needs to take the bio
or request (or just cmd flags) to be able to decide what set the
request belongs to, making the mapping a function of {cpu,type}.

I originally played with this in the context of isolating writes on
a single queue, to reduce the amount of resources they can grab. And
it'd work nicely on this as well.

Completions could be configurable to where the submitter would do it
(like now, best for sync single thread), or to where you have a/more
kernel threads doing it (spdk'ish, best for high qd / thread count).

-- 
Jens Axboe
