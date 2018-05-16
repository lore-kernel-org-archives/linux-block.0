Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: for sync case, whether it is mq or sq make_request
 instances, we should send the request directly
To: =?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>,
 linux-block <linux-block@vger.kernel.org>
References: <tencent_4D4715133E9C8F2D37E3ACAF@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <73bcb98c-2e0a-123b-5b45-6c7fd71f3595@kernel.dk>
Date: Wed, 16 May 2018 08:15:57 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_4D4715133E9C8F2D37E3ACAF@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/15/18 9:42 PM, 胡海 wrote:
> Author: huhai <huhai@kylinos.cn>
> Date:   Wed May 16 10:34:22 2018 +0800
> 
>     blk-mq: for sync case, whether it is mq or sq make_request instances, we should send the request directly
>     
>     For sq make_request instances, we should issue sync request directly too, 
>     otherwise it will break down the semantics of sync request, 
>     the current code logic is to send synchronous requests asynchronously.

It doesn't break the semantics of a sync request. The reason we don't do
it on single queue hardware is for efficiency reasons. On multiple queue
hardware, we can efficiently have multiple processes doing sync issue,
that isn't the case on single queue hardware.

-- 
Jens Axboe
