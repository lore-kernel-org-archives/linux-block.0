Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove double set queue_num
To: weiping <zhangweiping@didichuxing.com>
Cc: linux-block@vger.kernel.org
References: <20170622150656.GA26913@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <53c1fd8c-1bfa-2055-9a2f-e5a50dacd8a9@kernel.dk>
Date: Thu, 22 Jun 2017 09:19:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170622150656.GA26913@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/22/2017 09:06 AM, weiping wrote:
> hwctx's queue_num has been set prior call blk_mq_init_hctx, so no need
> set it again.
> 
> Signed-off-by: weiping <zhangweiping@didichuxing.com>

I still prefer full names, but it's trivial enough, I've queued it up
for 4.13. Thanks.

-- 
Jens Axboe
