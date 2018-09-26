Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537986295.209118.0.camel@acm.org>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
From: Bart Van Assche <bvanassche@acm.org>
To: Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Ming Lei
	 <ming.lei@redhat.com>
Date: Wed, 26 Sep 2018 11:24:55 -0700
In-Reply-To: <20180926150634.GD13588@linux-x5ow.site>
References: <20180921203122.49743-1-bvanassche@acm.org>
	 <20180921203122.49743-8-bvanassche@acm.org> <20180926142740.GE8604@lst.de>
	 <20180926144357.GC13588@linux-x5ow.site> <20180926145732.GA9446@lst.de>
	 <20180926150634.GD13588@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-26 at 17:06 +-0200, Johannes Thumshirn wrote:
+AD4 On Wed, Sep 26, 2018 at 04:57:32PM +-0200, Christoph Hellwig wrote:
+AD4 +AD4 I don't think this actually works given that rpm+AF8-status only exists
+AD4 +AD4 if CONFIG+AF8-PM is set.
+AD4 
+AD4 I think it'll work as GCC does constant propagation. There are
+AD4 actually some places in the kernel that follow this pattern.

This is what gcc on my development system thinks about that proposal:

In file included from ./arch/x86/include/asm/bug.h:83:0,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread+AF8-info.h:12,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:81,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from block/blk-core.c:15:
block/blk-core.c: In function +IBg-elv+AF8-next+AF8-request+IBk:
block/blk-core.c:2795:44: error: +IBg-struct request+AF8-queue+IBk has no member named +IBg-rpm+AF8-status+IBkAOw did you mean +IBg-stats+IBk?
                            WARN+AF8-ON+AF8-ONCE(q-+AD4-rpm+AF8-status +AD0APQ RPM+AF8-SUSPENDED)+ADs
                                            +AF4
./include/asm-generic/bug.h:69:25: note: in definition of macro +IBg-WARN+AF8-ON+AF8-ONCE+IBk
  int +AF8AXw-ret+AF8-warn+AF8-on +AD0 +ACEAIQ(condition)+ADs   +AFw
                         +AF4AfgB+AH4AfgB+AH4AfgB+
scripts/Makefile.build:305: recipe for target 'block/blk-core.o' failed

Bart.
