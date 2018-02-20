Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk: optimization for classic polling
To: Peter Zijlstra <peterz@infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180220132137.GG25314@hirez.programming.kicks-ass.net>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <35a2d52e-dd40-d130-85d9-5f3ffe0d28af@kernel.dk>
Date: Tue, 20 Feb 2018 12:37:07 -1000
MIME-Version: 1.0
In-Reply-To: <20180220132137.GG25314@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/20/18 3:21 AM, Peter Zijlstra wrote:
> On Sun, May 30, 2083 at 09:51:06AM +0530, Nitesh Shetty wrote:
>> This removes the dependency on interrupts to wake up task. Set task
>> state as TASK_RUNNING, if need_resched() returns true,
>> while polling for IO completion.
>> Earlier, polling task used to sleep, relying on interrupt to wake it up.
>> This made some IO take very long when interrupt-coalescing is enabled in
>> NVMe.
> 
> This is a horrible Changelog.. it does not in fact explain why the patch
> works or is correct.

Yeah, that should have been improved.

> Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
> __blk_mq_poll), why do you need that memory barrier?

I pointed that out in the review, and v2 fixed it. v2 is the
one that got merged.

-- 
Jens Axboe
