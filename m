Return-Path: <minchan.kim@gmail.com>
Return-Path: <minchan.kim@gmail.com>
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 4 Oct 2016 16:35:27 +0900
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/3] zram: support page-based parallel write
Message-ID: <20161004073527.GA16641@blaptop>
References: <1474526565-6676-1-git-send-email-minchan@kernel.org>
 <1474526565-6676-2-git-send-email-minchan@kernel.org>
 <20160929031831.GA1175@swordfish>
 <20160930055221.GA16293@bbox>
 <20161004044314.GA835@swordfish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004044314.GA835@swordfish>
List-ID: <linux-block@vger.kernel.org>

Hi Sergey,

On Tue, Oct 04, 2016 at 01:43:14PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> Cc Jens and block-dev,
> 
> I'll outline the commit message for Jens and blockdev people, may be
> someone will have some thoughts/ideas/opinions:

Thanks for Ccing relevant poeple. Even, I didn't know we have block-dev
mailing list.

> 
> > On (09/22/16 15:42), Minchan Kim wrote:
> : zram supports stream-based parallel compression. IOW, it can support
> : parallel compression on SMP system only if each cpus has streams.
> : For example, assuming 4 CPU system, there are 4 sources for compressing
> : in system and each source must be located in each CPUs for full
> : parallel compression.
> :
> : So, if there is *one* stream in the system, it cannot be compressed
> : in parallel although the system supports multiple CPUs. This patch
> : aims to overcome such weakness.
> :
> : The idea is to use multiple background threads to compress pages
> : in idle CPU and foreground just queues BIOs without interrupting
> : while other CPUs consumes pages in BIO to compress.
> : It means zram begins to support asynchronous writeback to increase
> : write bandwidth.
> 
> 
> is there any way of addressing this issues? [a silly idea] can we, for
> instance, ask the bock layer to split request and put pages into different
> queues (assuming that we run in blk-mq mode)? because this looks like a
> common issue, and it may be a bit too late to fix it in zram driver.
> any thoughts?

Hmm, blk-mq works with request-level, not even bio-level. Right?
If so, I have a concern about that. Zram as swap storage has been worked
with rw_page to avoid bio allocation which was not small and heard from
product people it was great enhancement in very pool memory device.
I didn't follw up at that time but I guess it was due to waiting free
memory from mempool. If blk-rq works with request-level, should we abandon
rw_page approach? 

> 
> 
> [..]
> > Could you retest the benchmark without direct IO? Instead of dio,
> > I used fsync_on_close to flush buffered IO.
> > 
> > DIO isn't normal workload compared to buffered IO. The reason I used DIO
> > for zram benchmark was that it's handy to transfer IO to block layer effectively
> > and no-noise of page cache.
> > If we use buffered IO, the result would be fake as dirty page was just
> > queued in page cache without any flushing.
> > I think you know already it very well so no need to explan any more. :)
> > 
> > More important thing is current zram is poor for parallel IO.
> > Let's thing two usecases, zram-swap, zram-fs.
> 
> well, that's why we use direct=1 in benchmarks - to test the peformance
> of zram; not anything else. but I can run fsync_on_close=1 tests as well
> (see later).
> 
> 
> > 1) zram-swap
> > 
> > parallel IO can be done only where every CPU have reclaim context.
> > IOW,
> > 
> > 1. kswapd on CPU 0
> > 2. A process direct reclaim on CPU 1
> > 3. process direct reclaim on CPU 2
> > 4. process direct reclaim on CPU 3
> >
> > I don't think it's usual workload. Most of time, a kswapd and a process
> > direct reclaim in embedded platform workload. The point is we can not
> > use full bandwidth.
> 
> hm. but we are on an SMP system and at least one process had to start
> direct reclaim, which basically increases chances of direct reclaims
> from other CPUs, should running processes there request big enough
> memory allocations. I really see no reasons to rule this possibility
> out.

I didn't rule out the possiblity. It is just one scenario we can use
full-bandwidth. However, there are  many scenarios we cannot use
full-bandwidth.

Imagine that a kswapd waked up and a process entered direct relcaim.
The process can get a memory easily with watermark play and go with
the memory but kswapd alone should continue to reclaim memory until high
watermark. It means there is no process in direct reclaim. 

Additionally, with your scenario, we can use just 2 CPU for compression
and relies on the luck the hope with 1. other processes in 2. different CPU
will 3. allocate memory soon and VM should reclaim 4. anonymous memory,
not page cache. It needs many assumptions to use full bandwidth.

However, with current approach, we can use full-bandwidth unconditionally
once VM decide to reclaim anonymous memory.
So, I think it's better approach.

> 
> 
> > 2) zram-fs
> > 
> > Currently, there is a work per bdi. So, without fsync(and friends),
> > every IO submit would be done via that work on worker thread.
> > It means the IO couldn't be parallelized. However, if we use fsync,
> > it could be parallelized but it depends on the sync granuarity.
> > For exmaple, if your test application uses fsync directly, the IO
> > would be done in the CPU context your application running on. So,
> > if you has 4 test applications, every CPU could be utilized.
> > However, if you test application doesn't use fsync directly and
> > parant process calls sync if every test child applications, the
> > IO could be done 2 CPU context(1 is parent process context and
> > other is bdi work context).
> > So, In summary, we were poor for parallel IO workload without
> > sync or DIO.
> 
> but this again looks [to me] like a more general problem which can be
> addressed somewhere up the stack. zram is not absolutely silly here - it
> just does what it's being asked to do. any block drivers/block device can
> suffer from that.

Agree and hope it can work with rw_page, too.

> 
> 
> 
> 
> TEST
> ****
> 
> new tests results; same tests, same conditions, same .config.
> 4-way test:
> - BASE zram, fio direct=1
> - BASE zram, fio fsync_on_close=1
> - NEW zram, fio direct=1
> - NEW zram, fio fsync_on_close=1
> 
> 
> 
> and what I see is that:
>  - new zram is x3 times slower when we do a lot of direct=1 IO
> and
>  - 10% faster when we use buffered IO (fsync_on_close); but not always;
>    for instance, test execution time is longer (a reproducible behavior)
>    when the number of jobs equals the number of CPUs - 4.

Hmm, strange. with my own old benchmark, it was great enhancement.
I will spend a time to test with your benchmark and report back with
why. :)

Thanks for the review, Sergey!
