Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove confusing comment of
 blk_mq_sched_dispatch_requests
To: Liu Bo <bo.li.liu@oracle.com>, linux-block@vger.kernel.org
Cc: trivial@kernel.org
References: <20180105070906.29664-1-bo.li.liu@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a4953449-3f6e-4bd7-24b6-06c3822e02d6@kernel.dk>
Date: Fri, 5 Jan 2018 08:36:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180105070906.29664-1-bo.li.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/5/18 12:09 AM, Liu Bo wrote:
> Commit de1482974080
> ("blk-mq: introduce .get_budget and .put_budget in blk_mq_ops")
> changes the function to return bool type, and then commit 1f460b63d4b3
> ("blk-mq: don't restart queue when .get_budget returns BLK_STS_RESOURCE")
> changes it back to void, but the comment remains.

Thanks, applied.

-- 
Jens Axboe
