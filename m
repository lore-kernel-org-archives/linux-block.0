Subject: Re: [PATCH] block: do not put mq context in blk_mq_alloc_request_hctx
To: Minchan Kim <minchan@kernel.org>
References: <1490851245-32245-1-git-send-email-minchan@kernel.org>
Cc: kernel-team@lge.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <8787097b-7da5-3ae7-7896-cd08f5376018@fb.com>
Date: Thu, 30 Mar 2017 08:12:28 -0600
MIME-Version: 1.0
In-Reply-To: <1490851245-32245-1-git-send-email-minchan@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/29/2017 11:20 PM, Minchan Kim wrote:
> In blk_mq_alloc_request_hctx, blk_mq_sched_get_request doesn't
> get sw context so we don't need to put the context with
> blk_mq_put_ctx. Unless, we will see preempt counter underflow.

Good catch, that's definitely a bug. I have applied your patch
for 4.11.

-- 
Jens Axboe
