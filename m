Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH 16/28] blk-cgroup: remove legacy queue bypassing
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-17-axboe@kernel.dk>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <5f058345-522c-c24c-d09d-079046e99d7e@suse.de>
Date: Mon, 29 Oct 2018 12:00:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-17-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

On 25/10/18 23:10, Jens Axboe wrote:
[...]
> @@ -1487,8 +1485,6 @@ int blkcg_activate_policy(struct request_queue *q,
>  out_bypass_end:
>  	if (q->mq_ops)
>  		blk_mq_unfreeze_queue(q);
> -	else
> -		blk_queue_bypass_end(q);

>  
> 

Now that we only have mq, do we still need all these checks for q->mq_ops?

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
