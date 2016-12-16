Return-Path: <riteshh@codeaurora.org>
Subject: Re: [PATCH] block: Remove unused member (busy) from struct
 blk_queue_tag
To: Bart Van Assche <bart.vanassche@gmail.com>, axboe@kernel.dk
References: <1481863316-6736-1-git-send-email-riteshh@codeaurora.org>
 <51a34c87-5f34-acbd-1ca5-3930b1c6d006@acm.org>
Cc: linux-block@vger.kernel.org, Bart Van Assche <Bart.VanAssche@sandisk.com>
From: Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <7e46a0cd-7d1c-9523-a407-c75a9449fb49@codeaurora.org>
Date: Fri, 16 Dec 2016 16:02:24 +0530
MIME-Version: 1.0
In-Reply-To: <51a34c87-5f34-acbd-1ca5-3930b1c6d006@acm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 12/16/2016 3:57 PM, Bart Van Assche wrote:
> On 12/16/2016 05:41 AM, Ritesh Harjani wrote:
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  include/linux/blkdev.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 286b2a2..8369564 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -288,7 +288,6 @@ enum blk_queue_state {
>>  struct blk_queue_tag {
>>  	struct request **tag_index;	/* map of busy tags */
>>  	unsigned long *tag_map;		/* bit map of free/busy tags */
>> -	int busy;			/* current depth */
>>  	int max_depth;			/* what we will send to device */
>>  	int real_max_depth;		/* what the array can hold */
>>  	atomic_t refcnt;		/* map can be shared */
>>
>
> That's a good catch. Was this detected manually or did you use a tool to
> detect this? Anyway:
Manually, while I was reading this code.

>
> Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
