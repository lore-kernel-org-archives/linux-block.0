Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: make __blk_mq_stop_hw_queues static
To: Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
References: <20170508104440.10945-1-colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <11c54006-03bf-4532-970f-2d5fecf734a6@kernel.dk>
Date: Mon, 8 May 2017 08:09:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170508104440.10945-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/08/2017 04:44 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Making __blk_mq_stop_hw_queues static fixes sparse warning:
> 
>   block/blk-mq.c:6: warning: symbol '__blk_mq_stop_hw_queues' was not
>   declared. Should it be static?

Thanks, added.

-- 
Jens Axboe
