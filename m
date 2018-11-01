Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 21/30] block: remove dead elevator code
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181031175922.8849-1-axboe@kernel.dk>
 <20181031175922.8849-22-axboe@kernel.dk> <20181101212657.GF18005@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d8140092-2fae-39e1-a091-79169cfcc653@kernel.dk>
Date: Thu, 1 Nov 2018 16:32:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181101212657.GF18005@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/1/18 3:26 PM, Omar Sandoval wrote:
> On Wed, Oct 31, 2018 at 11:59:13AM -0600, Jens Axboe wrote:
>> This removes a bunch of core and elevator related code. On the core
>> front, we remove anything related to queue running, draining,
>> initialization, plugging, and congestions. We also kill anything
>> related to request allocation, merging, retrieval, and completion.
>>
>> Remove any checking for single queue IO schedulers, as they no
>> longer exist. This means we can also delete a bunch of code related
>> to request issue, adding, completion, etc - and all the SQ related
>> ops and helpers.
>>
>> Also kill the load_default_modules(), as all that did was provide
>> for a way to load the default single queue elevator.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> [snip]
> 
>> -struct elevator_ops
>> -{
>> -	elevator_merge_fn *elevator_merge_fn;
>> -	elevator_merged_fn *elevator_merged_fn;
>> -	elevator_merge_req_fn *elevator_merge_req_fn;
>> -	elevator_allow_bio_merge_fn *elevator_allow_bio_merge_fn;
>> -	elevator_allow_rq_merge_fn *elevator_allow_rq_merge_fn;
>> -	elevator_bio_merged_fn *elevator_bio_merged_fn;
>> -
>> -	elevator_dispatch_fn *elevator_dispatch_fn;
>> -	elevator_add_req_fn *elevator_add_req_fn;
>> -	elevator_activate_req_fn *elevator_activate_req_fn;
>> -	elevator_deactivate_req_fn *elevator_deactivate_req_fn;
>> -
>> -	elevator_completed_req_fn *elevator_completed_req_fn;
>> -
>> -	elevator_request_list_fn *elevator_former_req_fn;
>> -	elevator_request_list_fn *elevator_latter_req_fn;
>> -
>> -	elevator_init_icq_fn *elevator_init_icq_fn;	/* see iocontext.h */
>> -	elevator_exit_icq_fn *elevator_exit_icq_fn;	/* ditto */
>> -
>> -	elevator_set_req_fn *elevator_set_req_fn;
>> -	elevator_put_req_fn *elevator_put_req_fn;
>> -
>> -	elevator_may_queue_fn *elevator_may_queue_fn;
>> -
>> -	elevator_init_fn *elevator_init_fn;
>> -	elevator_exit_fn *elevator_exit_fn;
>> -	elevator_registered_fn *elevator_registered_fn;
>> -};
>> -
>>  struct blk_mq_alloc_data;
>>  struct blk_mq_hw_ctx;
>>  
>> @@ -138,16 +70,15 @@ struct elevator_type
>>  
>>  	/* fields provided by elevator implementation */
>>  	union {
>> -		struct elevator_ops sq;
>>  		struct elevator_mq_ops mq;
>>  	} ops;
>> +
> 
> Lol. Maybe we should get rid of this union in a followup? At least until
> we rewrite the block layer again.

Totally agree, wanted to do that in a followup patch, but just
haven't gotten around to it. I'll tack one on.

-- 
Jens Axboe
