Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: remove unnecessary judgement from blk_mq_make_request
To: =?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>
Cc: linux-block <linux-block@vger.kernel.org>
References: <tencent_024782AB2B10E01A63664862@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fef2e37c-8f45-898b-96cc-a98b9093f7ea@kernel.dk>
Date: Wed, 16 May 2018 08:19:45 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_024782AB2B10E01A63664862@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/15/18 8:47 PM, 胡海 wrote:
> Author: huhai <huhai@kylinos.cn>
> Date:   Tue May 15 15:15:06 2018 +0800
> 
>     blk-mq: remove unnecessary judgement from blk_mq_make_request
>     
>     Whether q->elevator is true or not, we can use blk_mq_sched_insert_request to complete the work.

This looks good, applied for 4.18.

-- 
Jens Axboe
