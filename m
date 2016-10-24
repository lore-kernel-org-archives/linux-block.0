Return-Path: <minchan.kim@gmail.com>
Return-Path: <minchan.kim@gmail.com>
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 24 Oct 2016 13:51:56 +0900
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/3] zram: support page-based parallel write
Message-ID: <20161024045156.GB4938@blaptop>
References: <1474526565-6676-1-git-send-email-minchan@kernel.org>
 <1474526565-6676-2-git-send-email-minchan@kernel.org>
 <20160929031831.GA1175@swordfish>
 <20160930055221.GA16293@bbox>
 <20161004044314.GA835@swordfish>
 <20161005020153.GA2988@bbox>
 <20161006082915.GA946@swordfish>
 <20161007063322.GA24554@bbox>
 <20161017050424.GA4591@blaptop>
 <20161021060809.GB527@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021060809.GB527@swordfish>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 21, 2016 at 03:08:09PM +0900, Sergey Senozhatsky wrote:
> Hello Minchan,
> 
> On (10/17/16 14:04), Minchan Kim wrote:
> > Hi Sergey,
> > 
> > On Fri, Oct 07, 2016 at 03:33:22PM +0900, Minchan Kim wrote:
> > 
> > < snip >
> > 
> > > > so the question is -- can we move this parallelization out of zram
> > > > and instead flush bdi in more than one kthread? how bad that would
> > > > be? can anyone else benefit from this?
> > > 
> > > Isn't it blk-mq you mentioned? With blk-mq, I have some concerns.
> > > 
> > > 1. read speed degradation
> > > 2. no work with rw_page
> > > 3. more memory footprint by bio/request queue allocation
> > > 
> > > Having said, it's worth to look into it in detail more.
> > > I will have time to see that approach to know what I can do
> > > with that.
> > 
> > queue_mode=2 bs=4096 nr_devices=1 submit_queues=4 hw_queue_depth=128
> > 
> > Last week, I played with null_blk and blk-mq.c to get an idea how
> > blk-mq works and I realized it's not good for zram because it aims
> > to solve 1) dispatch queue bottleneck 2) cache-friendly IO completion
> > through IRQ so 3) avoids remote memory accesses.
> > 
> > For zram which is used for embedded as primary purpose, ones listed
> > abvoe are not a severe problem. Most imporant thing is there is no
> > model to support that a process queueing IO request on *a* CPU while
> > other CPUs issues the queued IO to driver.
> > 
> > Anyway, Although blk-mrq can support that model, it is blk-layer thing.
> > IOW, it's software stuff for fast IO delievry but what we need is
> > device parallelism of zram itself. So, although we follow blk-mq,
> > we still need multiple threads to compress in parallel which is most of
> > code I wrote in this patchset.
> 
> yes. but at least wb can be multi-threaded. well, sort of. seems like.
> sometimes.

Maybe, but it would be rather greedy approach for zram because zram will
do real IO(esp, compression which consumed a lot of time) in that context
although the context is sharable resource of all processes in the system.

> 
> > If I cannot get huge benefit(e.g., reduce a lot of zram-speicif code
> > to support such model) with blk-mq, I don't feel to switch to request
> > model at the cost of reasons I stated above.
> 
> thanks.
> I'm looking at your patches.

Currently, I found some subtle bug in my patchset so I will resend them
after hunting that with fixing a bug you found.

Thanks, Sergey!
