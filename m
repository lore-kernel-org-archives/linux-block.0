Subject: Re: [PATCH 1/7] block: use legacy path for flush requests for MQ with
 a scheduler
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-2-git-send-email-axboe@fb.com>
 <20161205130517.GA7100@infradead.org>
 <4008ea37-3c08-a7ba-770d-00bbf69617e5@fb.com>
 <20161205154905.GK8481@linux-x5ow.site>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 linux-block@vger.kernel.org, paolo.valente@linaro.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <b2acf84d-32f0-de4b-cce8-efb9fdbd6087@fb.com>
Date: Mon, 5 Dec 2016 08:49:46 -0700
MIME-Version: 1.0
In-Reply-To: <20161205154905.GK8481@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/05/2016 08:49 AM, Johannes Thumshirn wrote:
> On Mon, Dec 05, 2016 at 08:07:10AM -0700, Jens Axboe wrote:
>> On 12/05/2016 06:05 AM, Christoph Hellwig wrote:
>>> On Fri, Dec 02, 2016 at 08:15:15PM -0700, Jens Axboe wrote:
>>>> No functional changes with this patch, it's just in preparation for
>>>> supporting legacy schedulers on blk-mq.
>>>
>>> Ewww.  I think without refactoring to clear what 'use_mq_path'
>>> means here and better naming this is a total non-started.  Even with
>>> that we'll now have yet another code path to worry about.  Is there
>>> any chance to instead consolidate into a single path?
>>
>> It's not pretty at all. I should have prefaced this patchset with saying
>> that it's an experiment in seeing what it would take to simply use the
>> old IO schedulers, as a temporary measure, on blk/scsi-mq. I did clean
>> it up a bit after posting:
>>
>> http://git.kernel.dk/cgit/linux-block/log/?h=blk-mq-legacy-sched
>>
>> but I'm not going to claim this is anywhere near merge read, nor clean.
>>
>>>>  struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
>>>>  {
>>>> -	if (q->mq_ops)
>>>> +	if (blk_use_mq_path(q))
>>>>  		return blk_mq_alloc_request(q, rw,
>>>>  			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
>>>>  				0 : BLK_MQ_REQ_NOWAIT);
>>>
>>> So now with blk-mq and an elevator set we go into blk_old_get_request,
>>> hich will simply allocate new requests.  How does this not break
>>> every existing driver?
>>
>> Since Johannes found that confusion, maybe I should explain how it all
>> works.
> 
> To clarify the naming, how about sth. like blk_mq_use_sched() (to align
> with blk_mq_sched_dispatch())?

Yeah, that is a much better name indeed. I'll make that change.

-- 
Jens Axboe
