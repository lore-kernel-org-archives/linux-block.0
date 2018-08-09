Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] Blk-throttle: reduce tail io latency when iops
 limit is enforced
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1533836822-47977-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7935d56d-7f1f-503b-45df-ddf6acbbd421@kernel.dk>
Date: Thu, 9 Aug 2018 13:17:45 -0600
MIME-Version: 1.0
In-Reply-To: <1533836822-47977-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 11:47 AM, Liu Bo wrote:
> When an application's iops has exceeded its cgroup's iops limit, surely it
> is throttled and kernel will set a timer for dispatching, thus IO latency
> includes the delay.
> 
> However, the dispatch delay which is calculated by the limit and the
> elapsed jiffies is suboptimal.  As the dispatch delay is only calculated
> once the application's iops is (iops limit + 1), it doesn't need to wait
> any longer than the remaining time of the current slice.

Applied, thanks.

-- 
Jens Axboe
