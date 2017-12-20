Return-Path: <axboe@kernel.dk>
Subject: Re: random call_single_data alignment
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@kernel.org>
References: <a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk>
 <3875cde5-a193-6aa6-1f9e-561cc66110f2@kernel.dk>
 <20171220201846.7pbwf5vq57luzg5q@hirez.programming.kicks-ass.net>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0c3cd7f4-9963-8908-1c57-f810748c1749@kernel.dk>
Date: Wed, 20 Dec 2017 13:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <20171220201846.7pbwf5vq57luzg5q@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/20/17 1:18 PM, Peter Zijlstra wrote:
> On Wed, Dec 20, 2017 at 12:40:25PM -0700, Jens Axboe wrote:
>> On 12/20/17 12:10 PM, Jens Axboe wrote:
>>> For some reason, commit 966a967116e6 was added to the tree without
>>> CC'ing relevant maintainers, even though it's touching random subsystems.
>>> One example is struct request, a core structure in the block layer.
>>> After this change, struct request grows from 296 to 320 bytes on my
>>> setup.
> 
>> https://marc.info/?l=linux-block&m=151379793913822&w=2
> 
> Does that actually matter though?, kmalloc is likely to over-allocate in
> any case. Sure it introduces a weird hole in the data structure, but
> that can be easily fixed by rearranging the thing.

Yes it matters, if you look at how blk-mq allocates requests. We do it
by the page, and chop it up.

But you're missing the entire point of this email - don't make random
changes in core data structures without CC'ing the relevant folks. Even
the fact that the change is nonsensical on the block front .

>>> Why are we blindly aligning to 32 bytes? The comment says to avoid
>>> it spanning two cache lines - but if that's the case, look at the
>>> actual use case and see if that's actually a problem. For struct
>>> request, it is not.
>>>
>>> Seems to me, this should have been applied in the specific area
>>> where it was needed. Keep struct call_single_data (instead of some
>>> __ version), and just manually align it where it matters.
> 
> Without enforcement of some kind, its too easy to get wrong.

I'd argue that the change already did more harm than good.
Alignment bloat should only be applied where it matters. And whether
it matters or not should be investigated and deduced separately.

>> https://marc.info/?l=linux-block&m=151379849914002&w=2
> 
> diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
> index ccb9975a97fa..e0c44e4efa44 100644
> --- a/drivers/block/null_blk.c
> +++ b/drivers/block/null_blk.c
> @@ -33,9 +33,9 @@ static inline u64 mb_per_tick(int mbps)
>  }
>  
>  struct nullb_cmd {
> +	call_single_data_t csd;
>  	struct list_head list;
>  	struct llist_node ll_list;
> -	call_single_data_t csd;
>  	struct request *rq;
>  	struct bio *bio;
>  	unsigned int tag;
> 
> 
> Gets you the exact same size back.

Again, besides the point, the random spray of changes like this is
really poor form.

>> In the future, please CC the relevant folks before making (and
>> committing) changes like that.
> 
> Yeah, I usually do, sorry about that :/

At least it didn't make it to a release. Oh...

-- 
Jens Axboe
