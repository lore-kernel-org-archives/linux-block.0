Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Blk-throttle: reduce tail io latency when iops limit is
 enforced
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1532132960-44970-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4105f8f2-ab76-6ab1-c1c3-1e2705283ff6@kernel.dk>
Date: Thu, 9 Aug 2018 11:22:49 -0600
MIME-Version: 1.0
In-Reply-To: <1532132960-44970-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/20/18 6:29 PM, Liu Bo wrote:
> When an application's iops has exceeded its cgroup's iops limit, surely it
> is throttled and kernel will set a timer for dispatching, thus IO latency
> includes the delay.
> 
> However, the dispatch delay which is calculated by the limit and the
> elapsed jiffies is suboptimal.  As the dispatch delay is only calculated
> once the application's iops is (iops limit + 1), it doesn't need to wait
> any longer than the remaining time of the current slice.

Looks good to me - can you resend against my for-4.19/block branch, as
it doesn't apply.

-- 
Jens Axboe
