Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Improvements to the hybrid polling sleep time
 calculation
To: sbates@raithlin.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: osandov@fb.com, damien.lemoal@wdc.com
References: <1503326134-3862-1-git-send-email-sbates@raithlin.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <54dad77e-18d7-eb64-35fb-670fecc83ce7@kernel.dk>
Date: Tue, 22 Aug 2017 14:22:49 -0600
MIME-Version: 1.0
In-Reply-To: <1503326134-3862-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/21/2017 08:35 AM, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> Hybrid polling currently uses half the average completion time as an
> estimate of how long to poll for. We can improve upon this by noting
> that polling before the minimum completion time makes no sense. Add a
> sysfs entry to use this fact to improve CPU utilization in certain
> cases.
> 
> At the same time the minimum is a bit too long to sleep for since we
> must factor in OS wake time for the thread. For now allow the user to
> set this via a second sysfs entry (in nanoseconds).
> 
> Testing this patch on Intel Optane SSDs showed that using the minimum
> rather than half reduced CPU utilization from 59% to 38%. Tuning
> this via the wake time adjustment allowed us to trade CPU load for
> latency. For example
> 
> io_poll	 delay	hyb_use_min adjust	latency	CPU load
> 1	 -1	N/A	    N/A		8.4	100%
> 1	 0	0	    N/A		8.4	57%
> 1	 0	1	    0		10.3	34%
> 1	 9	1	    1000	9.9	37%
> 1	 0	1	    2000	8.4	47%
> 1	 0	1	    10000	8.4	100%
> 
> Ideally we will extend this to auto-calculate the wake time rather
> than have it set by the user.

I don't like this, it's another weird knob that will exist but that
no one will know how to use. For most of the testing I've done
recently, hybrid is a win over busy polling - hence I think we should
make that the default. 60% of mean has also, in testing, been shown
to be a win. So that's an easy fix/change we can consider.

To go beyond that, I'd much rather see us tracking the time waste.
If we consider the total completion time of an IO to be A+B+C, where:

A	Time needed to go to sleep
B	Sleep time
C	Time needed to wake up

then we could feasibly track A+C. We already know how long the IO
will take to complete, as we track that. At that point we'd have
a full picture of how long we should sleep.

Bonus points for informing the lower level scheduler of this as
well. If the CPU is going idle, we'll enter some sort of power
state in the processor. If we were able to pass in how long we
expect to sleep, we could be making better decisions here.

-- 
Jens Axboe
