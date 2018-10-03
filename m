Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet been
 started
To: Bart Van Assche <bvanassche@acm.org>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hare@suse.com" <hare@suse.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
 <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
 <1515794417.2396.72.camel@wdc.com>
 <9ae89a07-7ade-f0c6-cc54-ed56bcc4d5cf@kernel.dk>
 <1515795074.2396.75.camel@wdc.com> <1538602937.205649.29.camel@acm.org>
 <06b58979-0496-c583-2c00-ccdbd10e0aa9@kernel.dk>
 <1538607089.205649.36.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d14b7de-6acd-70f9-b80b-93b2fe3c56d9@kernel.dk>
Date: Wed, 3 Oct 2018 17:52:55 -0600
MIME-Version: 1.0
In-Reply-To: <1538607089.205649.36.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/3/18 4:51 PM, Bart Van Assche wrote:
> On Wed, 2018-10-03 at 16:12 -0600, Jens Axboe wrote:
>> On 10/3/18 3:42 PM, Bart Van Assche wrote:
>>> On Fri, 2018-01-12 at 22:11 +0000, Bart Van Assche wrote:
>>>>  /*
>>>> + * Show "busy" requests - these are the requests owned by the block driver.
>>>> + * The test list_empty(&rq->queuelist) is used to figure out whether or not
>>>> + * a request is owned by the block driver. That test works because the block
>>>> + * layer core uses list_del_init() consistently to remove a request from one
>>>> + * of the request lists.
>>>> + *
>>>>   * Note: the state of a request may change while this function is in progress,
>>>>   * e.g. due to a concurrent blk_mq_finish_request() call.
>>>>   */
>>>> @@ -402,7 +408,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>>  	const struct show_busy_params *params = data;
>>>>  
>>>>  	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
>>>> -	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
>>>> +	    list_empty(&rq->queuelist))
>>>>  		__blk_mq_debugfs_rq_show(params->m,
>>>>  					 list_entry_rq(&rq->queuelist));
>>>>  }
>>>
>>> Hello Jens,
>>>
>>> Can you share your opinion about the above patch?
>>
>> I just convince myself that the list check is super useful. The request
>> could be on any number of lists, either not yet seen by the driver, or
>> maybe sitting in dispatch. You're only going to be finding these
>> requests if the tag is allocated, which means that it's already in some
>> sort of non-idle state.
>>
>> So enlighten me why we need the list check at all? Wouldn't it be better
>> to simply remove it, and ensure that the debug print includes things
>> like list state, rq state, etc?
> 
> Hello Jens,
> 
> I have tried to leave the list_empty() check out but if I do that then
> requests that have the state "idle" (allocated but not yet started) also
> show up. I think these should be left out from the output produced by
> reading the "busy" attribute because such requests are not interesting
> when analyzing an I/O lockup:
> 
> nullb0/hctx1/busy:00000000abe67123 {.op=READ, .cmd_flags=, .rq_flags=IO_STAT|STATS, .s
> tate=idle, .tag=63, .internal_tag=-1}

They might be, if we have allocated tags that aren't going anywhere.
Like in a tag leak, or something. Besides, requests should exist in that
state very shortly, so it's not like it should cloud the output that
much.

-- 
Jens Axboe
