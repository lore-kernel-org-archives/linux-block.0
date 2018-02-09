Return-Path: <axboe@kernel.dk>
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "paolo.valente@linaro.org" <paolo.valente@linaro.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1518202449.2871.32.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
Date: Fri, 9 Feb 2018 11:58:56 -0700
MIME-Version: 1.0
In-Reply-To: <1518202449.2871.32.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/9/18 11:54 AM, Bart Van Assche wrote:
> Hello Paolo,
> 
> If I enable the BFQ scheduler for a dm-mpath device then a kernel oops
> appears (see also below). This happens systematically with Linus' tree from
> this morning (commit 54ce685cae30) merged with Jens' for-linus branch (commit
> a78773906147 ("block, bfq: add requeue-request hook")) and for-next branch
> (commit 88455ad7f928). Is this a known issue?

Does it happen on Linus -git as well, or just with my for-linus merged in?
What I'm getting at is if a78773906147 caused this or not.



-- 
Jens Axboe
