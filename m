Return-Path: <peterz@infradead.org>
Date: Wed, 21 Feb 2018 09:32:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	joshi.k@samsung.com
Subject: Re: [PATCH] blk: optimization for classic polling
Message-ID: <20180221083208.GH25314@hirez.programming.kicks-ass.net>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180220132137.GG25314@hirez.programming.kicks-ass.net>
 <35a2d52e-dd40-d130-85d9-5f3ffe0d28af@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35a2d52e-dd40-d130-85d9-5f3ffe0d28af@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 20, 2018 at 12:37:07PM -1000, Jens Axboe wrote:
> On 2/20/18 3:21 AM, Peter Zijlstra wrote:
> > On Sun, May 30, 2083 at 09:51:06AM +0530, Nitesh Shetty wrote:
> >> This removes the dependency on interrupts to wake up task. Set task
> >> state as TASK_RUNNING, if need_resched() returns true,
> >> while polling for IO completion.
> >> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> >> This made some IO take very long when interrupt-coalescing is enabled in
> >> NVMe.
> > 
> > This is a horrible Changelog.. it does not in fact explain why the patch
> > works or is correct.
> 
> Yeah, that should have been improved.

Being ever more forgetful (I blame the kids) I find Changelogs more and
more important, ymmv ;-)

> > Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
> > __blk_mq_poll), why do you need that memory barrier?
> 
> I pointed that out in the review, and v2 fixed it. v2 is the
> one that got merged.

Right missed that. In fact, possibly the only reason I saw this is that
Nitesh had this computer configured wrong and the email is from the
future and thus the very first entry in my lkml folder.
