Return-Path: <jthumshirn@suse.de>
Date: Thu, 27 Sep 2018 08:54:35 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180927065435.GA6959@linux-x5ow.site>
References: <20180921203122.49743-1-bvanassche@acm.org>
 <20180921203122.49743-8-bvanassche@acm.org>
 <20180926142740.GE8604@lst.de>
 <20180926144357.GC13588@linux-x5ow.site>
 <20180926145732.GA9446@lst.de>
 <20180926150634.GD13588@linux-x5ow.site>
 <1537986295.209118.0.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1537986295.209118.0.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 26, 2018 at 11:24:55AM -0700, Bart Van Assche wrote:
> On Wed, 2018-09-26 at 17:06 +0200, Johannes Thumshirn wrote:
> > On Wed, Sep 26, 2018 at 04:57:32PM +0200, Christoph Hellwig wrote:
> > > I don't think this actually works given that rpm_status only exists
> > > if CONFIG_PM is set.
> > 
> > I think it'll work as GCC does constant propagation. There are
> > actually some places in the kernel that follow this pattern.
> 
> This is what gcc on my development system thinks about that proposal:
> 
> In file included from ./arch/x86/include/asm/bug.h:83:0,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from block/blk-core.c:15:
> block/blk-core.c: In function ‘elv_next_request’:
> block/blk-core.c:2795:44: error: ‘struct request_queue’ has no member named ‘rpm_status’; did you mean ‘stats’?
>                             WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
>                                             ^
> ./include/asm-generic/bug.h:69:25: note: in definition of macro ‘WARN_ON_ONCE’
>   int __ret_warn_on = !!(condition);   \
>                          ^~~~~~~~~
> scripts/Makefile.build:305: recipe for target 'block/blk-core.o' failed

Aparently this only works for functions and not struct members, my
bad.

	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
