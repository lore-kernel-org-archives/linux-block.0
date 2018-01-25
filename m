Return-Path: <ming.lei@redhat.com>
Date: Thu, 25 Jan 2018 13:29:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL
 in blk_mq_sched_assign_ioc
Message-ID: <20180125052937.GA21712@ming.t460p>
References: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
 <7a1809ce-c456-0d53-4d3b-2368fb19bfd8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a1809ce-c456-0d53-4d3b-2368fb19bfd8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 24, 2018 at 08:34:14PM -0700, Jens Axboe wrote:
> On 1/24/18 7:46 PM, Jia-Ju Bai wrote:
> > The function ioc_create_icq here is not called in atomic context.
> > Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> > 
> > This is found by a static analysis tool named DCNS written by myself.
> 
> But it's running off the IO submission path, so by definition the GFP
> mask cannot include anything that will do IO. GFP_KERNEL will make
> it deadlock prone.
> 
> It could be GFP_NOIO, but that's also overlooking the fact that we can
> have preemption disabled here.

We have REQ_NOWAIT request too, so GFP_NOIO isn't OK too.

-- 
Ming
