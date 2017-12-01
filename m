Return-Path: <ming.lei@redhat.com>
Date: Fri, 1 Dec 2017 21:35:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ivan Kozik <ivan@ludios.org>
Cc: axboe@kernel.dk, paolo.valente@linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Subject: Re: blk-mq + bfq IO hangs after writing partition table
Message-ID: <20171201133546.GA11483@ming.t460p>
References: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
 <20171201085051.GA1308@ming.t460p>
 <CAKynti+h_-MuR7YXsiYHqTv7xCiy1QhRUyu=zCcb9brwR2ByxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKynti+h_-MuR7YXsiYHqTv7xCiy1QhRUyu=zCcb9brwR2ByxQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 01, 2017 at 12:18:25PM +0000, Ivan Kozik wrote:
> On Fri, Dec 1, 2017 at 8:50 AM, Ming Lei <ming.lei@redhat.com> wrote:
> > Could you run the following script[1] and provide us the result after
> > the IO hang is triggered?
> >
> >         #./dump-blk-info /dev/sdX       #/dev/sdX is name of your USB disk
> >
> > [1] http://people.redhat.com/minlei/tests/tools/dump-blk-info
> 
> Hi Ming,
> 
> Thanks for taking a look.  I have pasted and attached (in case of
> gmail corruption) these files:
> 
> Samsung-128GB-before: Samsung 128GB USB 3.0 Fit plugged into HP 8460p,
> before gdisk write
> 
> Samsung-128GB-after:  Samsung 128GB USB 3.0 Fit plugged into HP 8460p,
> after gdisk write
> 
> Generic-4GB-after:    some awful generic but working 4GB USB flash
> drive plugged into HP 8460p, after gdisk write
> 
> I have reproduced this again on the same kernel revision and blk-mq bfq with:
> 
> minimized cmdline: scsi_mod.use_blk_mq=y
> gdisk writing the partition table as-is, no changes
> 
> and confirmed again that kyber never triggers this.
> 
> Thanks,
> 
> Ivan
> 
> 
> 
> 
> Samsung-128GB-before
> =============sdc/hctx0==================
> $active
> 0
> 
> $busy
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu0
>     $completed
>     3 14
>     $dispatched
>     3 14
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu1
>     $completed
>     159 76
>     $dispatched
>     159 76
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu2
>     $completed
>     84 57
>     $dispatched
>     84 57
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu3
>     $completed
>     154 54
>     $dispatched
>     155 54
>     $merged
>     1
>     $rq_list
> 
> $ctx_map
> 00000000: 00
> 
> $dispatch
> 
> $dispatched
>        0    8
>        1    701
>        2    0
>        4    0
>        8    0
>       16    0
>       32+    0
> 
> $flags
> alloc_policy=FIFO SHOULD_MERGE|SG_MERGE
> 
> $io_poll
> considered=0
> invoked=0
> success=0
> 
> $queued
> 602
> 
> $run
> 843
> 
> $sched_tags
> nr_tags=2
> nr_reserved_tags=0
> active_queues=0
> 
> bitmap_tags:
> depth=2
> busy=1
> bits_per_word=64
> map_nr=1
> alloc_hint={0, 1, 0, 0, 0, 1, 1, 0}
> wake_batch=1
> wake_index=0
> ws={
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
> }
> round_robin=0
> 
> $sched_tags_bitmap
> 00000000: 01
> 
> $state
> 
> 
> $tags
> nr_tags=1
> nr_reserved_tags=0
> active_queues=0
> 
> bitmap_tags:
> depth=1
> busy=0
> bits_per_word=64
> map_nr=1
> alloc_hint={0, 0, 0, 0, 0, 0, 0, 0}
> wake_batch=1
> wake_index=0
> ws={
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
> }
> round_robin=0
> 
> $tags_bitmap
> 00000000: 00
> 
> 
> 
> 
> Samsung-128GB-after
> =============sdc/hctx0==================
> $active
> 0
> 
> $busy
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu0
>     $completed
>     3 14
>     $dispatched
>     3 14
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu1
>     $completed
>     159 95
>     $dispatched
>     159 96
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu2
>     $completed
>     84 58
>     $dispatched
>     84 58
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu3
>     $completed
>     154 54
>     $dispatched
>     155 54
>     $merged
>     1
>     $rq_list
> 
> $ctx_map
> 00000000: 00
> 
> $dispatch
> 
> $dispatched
>        0    8
>        1    721
>        2    0
>        4    0
>        8    0
>       16    0
>       32+    0
> 
> $flags
> alloc_policy=FIFO SHOULD_MERGE|SG_MERGE
> 
> $io_poll
> considered=0
> invoked=0
> success=0
> 
> $queued
> 623
> 
> $run
> 887
> 
> $sched_tags
> nr_tags=2
> nr_reserved_tags=0
> active_queues=0
> 
> bitmap_tags:
> depth=2
> busy=2
> bits_per_word=64
> map_nr=1
> alloc_hint={0, 0, 0, 0, 0, 1, 1, 0}
> wake_batch=1
> wake_index=0
> ws={
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
> }
> round_robin=0
> 
> $sched_tags_bitmap
> 00000000: 03
> 
> $state
> 
> 
> $tags
> nr_tags=1
> nr_reserved_tags=0
> active_queues=0
> 
> bitmap_tags:
> depth=1
> busy=0
> bits_per_word=64
> map_nr=1
> alloc_hint={0, 0, 0, 0, 0, 0, 0, 0}
> wake_batch=1
> wake_index=0
> ws={
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
> }
> round_robin=0
> 
> $tags_bitmap
> 00000000: 00
> 
> 
> 
> 
> Generic-4GB-after
> =============sdc/hctx0==================
> $active
> 0
> 
> $busy
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu0
>     $completed
>     94 32
>     $dispatched
>     94 33
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu1
>     $completed
>     561 113
>     $dispatched
>     562 113
>     $merged
>     0
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu2
>     $completed
>     251 179
>     $dispatched
>     251 179
>     $merged
>     4
>     $rq_list
> 
> $/sys/kernel/debug/block/sdc//hctx0/cpu3
>     $completed
>     228 63
>     $dispatched
>     228 63
>     $merged
>     0
>     $rq_list
> 
> $ctx_map
> 00000000: 00
> 
> $dispatch
> 
> $dispatched
>        0    21
>        1    1707
>        2    0
>        4    0
>        8    0
>       16    0
>       32+    0
> 
> $flags
> alloc_policy=FIFO SHOULD_MERGE|SG_MERGE
> 
> $io_poll
> considered=0
> invoked=0
> success=0
> 
> $queued
> 1523
> 
> $run
> 2000
> 
> $sched_tags
> nr_tags=2
> nr_reserved_tags=0
> active_queues=0
> 
> bitmap_tags:
> depth=2
> busy=2
> bits_per_word=64
> map_nr=1
> alloc_hint={0, 0, 0, 0, 1, 1, 0, 0}
> wake_batch=1
> wake_index=0
> ws={
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=active},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},
>     {.wait_cnt=1, .wait=inactive},

Hi Ivan,

Thanks for your post and test!

Basically all IO hang happen inside get_request(), and seems this issue
isn't related with recent change in V4.15, could you run V4.14 to see if
there is such issue?

I guess it might be related with sbitmap_queue's wakeup because SCSI
always run queue after one request is completed, and there isn't any
request in hctx->dispatch, and for all requests in scheduler queue,
there is always chance to dispatch them from SCSI's restart(scsi_end_request).

Maybe need Jens/Omar to take a look.

Thanks,
Ming
