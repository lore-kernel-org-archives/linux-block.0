Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
To: =?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>
Cc: "ming.lei" <ming.lei@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
References: <tencent_47349987636D0D2B620828E0@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
Date: Fri, 18 May 2018 08:27:57 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_47349987636D0D2B620828E0@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 7:42 AM, 胡海 wrote:
> Author: huhai <huhai@kylinos.cn>
> Date:   Fri May 18 17:09:56 2018 +0800
> 
>     blk-mq: make sure that correct hctx->dispatch_from is set
>     
>     When the number of hardware queues is changed, the drivers will call
>     blk_mq_update_nr_hw_queues() to remap hardware queues, and then
>     the ctx mapped on hctx will also change, but the current code forgets to
>     make sure that correct hctx->dispatch_from is set, and hctx->dispatch_from
>     may point to a ctx that does not belong to the current hctx.

Looks good, thanks. One minor note for future patches - for cases like this,
when the patch fixes an issue with a specific commit, add a fixes line.
For this one, it would be:

Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")

-- 
Jens Axboe
