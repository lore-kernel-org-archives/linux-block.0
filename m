Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 22 Dec 2016 09:12:24 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
Message-ID: <20161222171224.GA26830@vader>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1482423775.2682.6.camel@sandisk.com>
 <20161222165207.GA25717@vader>
 <1482425838.2682.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482425838.2682.9.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 22, 2016 at 04:57:36PM +0000, Bart Van Assche wrote:
> On Thu, 2016-12-22 at 08:52 -0800, Omar Sandoval wrote:
> > This approach occurred to us, but we couldn't figure out a way to make
> > blk_mq_tag_to_rq() work with it. From skimming over the patches, I
> > didn't see a solution to that problem.
> 
> Hello Omar,
> 
> Can you clarify your comment? Since my patches initialize both tags->rqs[]
> and sched_tags->rqs[] the function blk_mq_tag_to_rq() should still work.
> 
> Bart.

Sorry, you're right, it does work, but tags->rqs[] ends up being the
extra lookup table. I suspect that the runtime overhead of keeping that
up to date could be worse than copying the rq fields if you have lots of
CPUs but only one hardware queue.
