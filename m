Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 2/7] blk-mq: abstract out blk_mq_dispatch_rq_list() helper
To: Ritesh Harjani <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>,
	<axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-3-git-send-email-axboe@fb.com>
 <fbf10c2c-b7c0-186e-debb-2905c30af2af@codeaurora.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <71656abd-f737-6548-9e07-a899e33fcd9f@sandisk.com>
Date: Tue, 13 Dec 2016 10:29:41 +0100
MIME-Version: 1.0
In-Reply-To: <fbf10c2c-b7c0-186e-debb-2905c30af2af@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/13/2016 10:18 AM, Ritesh Harjani wrote:
> On 12/9/2016 1:43 AM, Jens Axboe wrote:
>> +    if (!list_empty_careful(&hctx->dispatch)) {
>> +        spin_lock(&hctx->lock);
>> +        if (!list_empty(&hctx->dispatch))
> list_splice_init already checks for list_empty. So this may be
> redundant. Please check.

Hello Ritesh,

I think the list_empty() check is on purpose and is intended as a 
performance optimization.

Bart.
