Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove wrong 'unlikely' checks
To: huhai <huhai@kylinos.cn>
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20180522093934.20849-1-huhai@kylinos.cn>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3bc10dfd-1167-5a0c-08c8-846755ca9105@kernel.dk>
Date: Tue, 22 May 2018 08:37:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180522093934.20849-1-huhai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/22/18 3:39 AM, huhai wrote:
> When dispatch_rq_from_ctx is called, in the vast majority of cases
> the ctx->rq_list is not empty

I'm fine with killing it, generally I dislike the likely/unlikely
annotations unless the intent is absolutely clear. This one is not.

> Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")

Though for this one, I'll drop the fixes tag as it isn't something we
need to backport to stable and it's not really fixing a real bug that
is causing an issue.

-- 
Jens Axboe
