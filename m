Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 16/28] blk-cgroup: remove legacy queue bypassing
To: Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-17-axboe@kernel.dk>
 <5f058345-522c-c24c-d09d-079046e99d7e@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5a75b005-7dc8-c8a9-fb41-6590039d10a4@kernel.dk>
Date: Mon, 29 Oct 2018 08:23:18 -0600
MIME-Version: 1.0
In-Reply-To: <5f058345-522c-c24c-d09d-079046e99d7e@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:00 AM, Johannes Thumshirn wrote:
> Hi Jens,
> 
> On 25/10/18 23:10, Jens Axboe wrote:
> [...]
>> @@ -1487,8 +1485,6 @@ int blkcg_activate_policy(struct request_queue *q,
>>  out_bypass_end:
>>  	if (q->mq_ops)
>>  		blk_mq_unfreeze_queue(q);
>> -	else
>> -		blk_queue_bypass_end(q);
> 
>>  
>>
> 
> Now that we only have mq, do we still need all these checks for q->mq_ops?

We need it for the cases where we can be passing in a stacked driver
or an mq driver, or for cases where we explicitly register mq attributes,
and that sort of thing.

-- 
Jens Axboe
