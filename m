Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 15:16:57 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402221657.GL388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
 <20180402211047.GF388343@devbig577.frc2.facebook.com>
 <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
 <20180402220136.GI388343@devbig577.frc2.facebook.com>
 <6d6985b8d95317aa5572809f1b987c45e932c5b2.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d6985b8d95317aa5572809f1b987c45e932c5b2.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Apr 02, 2018 at 10:09:18PM +0000, Bart Van Assche wrote:
> Please elaborate what your long-term goal is for the blk-mq timeout handler.

Hmm... I don't really have any plans beyond what's been posted.

> The legacy block layer suspends request state changes while a timeout is
> being processed by holding the request queue lock while requests are being
> processed, while processing a timeout and while calling q->rq_timed_out_fn(rq).
> Do you think it is possible to make the blk-mq core suspend request processing
> while processing a timeout without introducing locking in
> blk_mq_complete_request()? If you do not plan to add locking in
> blk_mq_complete_request(), do you think it is possible to fix all the races we
> discussed in previous e-mails?

I don't know of multiple race conditions.  What am I missing?  AFAIK,
there's one non-critical race condition which has always been there.
We have a larger race window for that case but don't yet know whether
that's problematic or not.  If that actually is problematic, we can
figure out a way to solve that but such effort / added complexity
doesn't seem justified yet.  No?

Thanks.

-- 
tejun
