Return-Path: <obuil.liubo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4105f8f2-ab76-6ab1-c1c3-1e2705283ff6@kernel.dk>
References: <1532132960-44970-1-git-send-email-bo.liu@linux.alibaba.com> <4105f8f2-ab76-6ab1-c1c3-1e2705283ff6@kernel.dk>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Thu, 9 Aug 2018 10:25:06 -0700
Message-ID: <CANQeFDAKC9U0qVG79NPoaCQSbTKCaiHMiOhQTPr=qjSBD3-RPQ@mail.gmail.com>
Subject: Re: [PATCH] Blk-throttle: reduce tail io latency when iops limit is enforced
To: Jens Axboe <axboe@kernel.dk>
Cc: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 9, 2018 at 10:22 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/20/18 6:29 PM, Liu Bo wrote:
>> When an application's iops has exceeded its cgroup's iops limit, surely it
>> is throttled and kernel will set a timer for dispatching, thus IO latency
>> includes the delay.
>>
>> However, the dispatch delay which is calculated by the limit and the
>> elapsed jiffies is suboptimal.  As the dispatch delay is only calculated
>> once the application's iops is (iops limit + 1), it doesn't need to wait
>> any longer than the remaining time of the current slice.
>
> Looks good to me - can you resend against my for-4.19/block branch, as
> it doesn't apply.
>

Sure, I'll rebase against it.

thanks,
liubo
