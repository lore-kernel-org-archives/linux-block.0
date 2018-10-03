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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <06b58979-0496-c583-2c00-ccdbd10e0aa9@kernel.dk>
Date: Wed, 3 Oct 2018 16:12:13 -0600
MIME-Version: 1.0
In-Reply-To: <1538602937.205649.29.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/3/18 3:42 PM, Bart Van Assche wrote:
> On Fri, 2018-01-12 at 22:11 +0000, Bart Van Assche wrote:
>> On Fri, 2018-01-12 at 15:05 -0700, Jens Axboe wrote:
>>> On 1/12/18 3:00 PM, Bart Van Assche wrote:
>>>> On Fri, 2018-01-12 at 14:55 -0700, Jens Axboe wrote:
>>>>> On 1/12/18 2:52 PM, Bart Van Assche wrote:
>>>>>> When debugging e.g. the SCSI timeout handler it is important that
>>>>>> requests that have not yet been started or that already have
>>>>>> completed are also reported through debugfs.
>>>>>>
>>>>>> This patch depends on a patch that went upstream recently, namely
>>>>>> commit 14e3062fb185 ("scsi: core: Fix a scsi_show_rq() NULL pointer
>>>>>> dereference").
>>>>>
>>>>> Why don't we just kill the check, and dump any request that has a
>>>>> matching hctx? We already know the bit was set, so just print
>>>>> all of them.
>>>>
>>>> It is very helpful during debugging that requests owned by a block driver and
>>>> requests owned by the block layer core show up in different debugfs files.
>>>> Removing the check completely would cause all requests to show up in the same
>>>> debugfs file and would make interpreting the contents of these debugfs files
>>>> much harder.
>>>
>>> Yeah, we'd have to make it just one file at that point. I'm not hugely
>>> against the queuelist check, but probably warrants a comment as it's not
>>> immediately clear (as opposed to the idle check, or the previous START
>>> bit check).
>>
>> How about the below?
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 19db3f583bf1..da859dac442b 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -394,6 +394,12 @@ struct show_busy_params {
>>  };
>>  
>>  /*
>> + * Show "busy" requests - these are the requests owned by the block driver.
>> + * The test list_empty(&rq->queuelist) is used to figure out whether or not
>> + * a request is owned by the block driver. That test works because the block
>> + * layer core uses list_del_init() consistently to remove a request from one
>> + * of the request lists.
>> + *
>>   * Note: the state of a request may change while this function is in progress,
>>   * e.g. due to a concurrent blk_mq_finish_request() call.
>>   */
>> @@ -402,7 +408,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>  	const struct show_busy_params *params = data;
>>  
>>  	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
>> -	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
>> +	    list_empty(&rq->queuelist))
>>  		__blk_mq_debugfs_rq_show(params->m,
>>  					 list_entry_rq(&rq->queuelist));
>>  }
> 
> Hello Jens,
> 
> Can you share your opinion about the above patch?

I just convince myself that the list check is super useful. The request
could be on any number of lists, either not yet seen by the driver, or
maybe sitting in dispatch. You're only going to be finding these
requests if the tag is allocated, which means that it's already in some
sort of non-idle state.

So enlighten me why we need the list check at all? Wouldn't it be better
to simply remove it, and ensure that the debug print includes things
like list state, rq state, etc?

-- 
Jens Axboe
