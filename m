Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Thu, 6 Oct 2016 17:29:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/3] zram: support page-based parallel write
Message-ID: <20161006082915.GA946@swordfish>
References: <1474526565-6676-1-git-send-email-minchan@kernel.org>
 <1474526565-6676-2-git-send-email-minchan@kernel.org>
 <20160929031831.GA1175@swordfish>
 <20160930055221.GA16293@bbox>
 <20161004044314.GA835@swordfish>
 <20161005020153.GA2988@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161005020153.GA2988@bbox>
List-ID: <linux-block@vger.kernel.org>

Hello Minchan,

On (10/05/16 11:01), Minchan Kim wrote:
[..]
> 1. just changed ordering of test execution - hope to reduce testing time due to
>    block population before the first reading or reading just zero pages
> 2. used sync_on_close instead of direct io
> 3. Don't use perf to avoid noise
> 4. echo 0 > /sys/block/zram0/use_aio to test synchronous IO for old behavior

ok, will use it in the tests below.

> 1. ZRAM_SIZE=3G ZRAM_COMP_ALG=lzo LOG_SUFFIX=async FIO_LOOPS=2 MAX_ITER=1 ./zram-fio-test.sh
> 2. modify script to disable aio via /sys/block/zram0/use_aio
>    ZRAM_SIZE=3G ZRAM_COMP_ALG=lzo LOG_SUFFIX=sync FIO_LOOPS=2 MAX_ITER=1 ./zram-fio-test.sh
>
>       seq-write     380930     474325     124.52%
>      rand-write     286183     357469     124.91%
>        seq-read     266813     265731      99.59%
>       rand-read     211747     210670      99.49%
>    mixed-seq(R)     145750     171232     117.48%
>    mixed-seq(W)     145736     171215     117.48%
>   mixed-rand(R)     115355     125239     108.57%
>   mixed-rand(W)     115371     125256     108.57%

                no_aio           use_aio

WRITE:          1432.9MB/s	 1511.5MB/s
WRITE:          1173.9MB/s	 1186.9MB/s
READ:           912699KB/s	 912170KB/s
WRITE:          912497KB/s	 911968KB/s
READ:           725658KB/s	 726747KB/s
READ:           579003KB/s	 594543KB/s
READ:           373276KB/s	 373719KB/s
WRITE:          373572KB/s	 374016KB/s

seconds elapsed        45.399702511	44.280199716

> LZO compression is fast and a CPU for queueing while 3 CPU for compressing
> it cannot saturate CPU full bandwidth. Nonetheless, it shows 24% enhancement.
> It could be more in slow CPU like embedded.
> 
> I tested it with deflate. The result is 300% enhancement.
> 
>       seq-write      33598     109882     327.05%
>      rand-write      32815     102293     311.73%
>        seq-read     154323     153765      99.64%
>       rand-read     129978     129241      99.43%
>    mixed-seq(R)      15887      44995     283.22%
>    mixed-seq(W)      15885      44990     283.22%
>   mixed-rand(R)      25074      55491     221.31%
>   mixed-rand(W)      25078      55499     221.31%
>
> So, curious with your test.
> Am my test sync with yours? If you cannot see enhancment in job1, could
> you test with deflate? It seems your CPU is really fast.

interesting observation.

                no_aio           use_aio
WRITE:          47882KB/s	 158931KB/s
WRITE:          47714KB/s	 156484KB/s
READ:           42914KB/s	 137997KB/s
WRITE:          42904KB/s	 137967KB/s
READ:           333764KB/s	 332828KB/s
READ:           293883KB/s	 294709KB/s
READ:           51243KB/s	 129701KB/s
WRITE:          51284KB/s	 129804KB/s

seconds elapsed        480.869169882	181.678431855

yes, looks like with lzo CPU manages to process bdi writeback fast enough
to keep fio-template-static-buffer worker active.

to prove this theory: direct=1 cures zram-deflate.

                no_aio           use_aio
WRITE:          41873KB/s	 34257KB/s
WRITE:          41455KB/s	 34087KB/s
READ:           36705KB/s	 28960KB/s
WRITE:          36697KB/s	 28954KB/s
READ:           327902KB/s	 327270KB/s
READ:           316217KB/s	 316886KB/s
READ:           35980KB/s	 28131KB/s
WRITE:          36008KB/s	 28153KB/s

seconds elapsed        515.575252170	629.114626795



as soon as wb flush kworker can't keep up anymore things are going off
the rails. most of the time, fio-template-static-buffer are in D state,
while the biggest bdi flush kworker is doing the job (a lot of job):

  PID USER      PR  NI    VIRT    RES  %CPU %MEM     TIME+ S COMMAND
 6274 root      20   0    0.0m   0.0m 100.0  0.0   1:15.60 R [kworker/u8:1]
11169 root      20   0  718.1m   1.6m  16.6  0.0   0:01.88 D fio ././conf/fio-template-static-buffer
11171 root      20   0  718.1m   1.6m   3.3  0.0   0:01.15 D fio ././conf/fio-template-static-buffer
11170 root      20   0  718.1m   3.3m   2.6  0.1   0:00.98 D fio ././conf/fio-template-static-buffer


and still working...

 6274 root      20   0    0.0m   0.0m 100.0  0.0   3:05.49 R [kworker/u8:1]
12048 root      20   0  718.1m   1.6m  16.7  0.0   0:01.80 R fio ././conf/fio-template-static-buffer
12047 root      20   0  718.1m   1.6m   3.3  0.0   0:01.12 D fio ././conf/fio-template-static-buffer
12049 root      20   0  718.1m   1.6m   3.3  0.0   0:01.12 D fio ././conf/fio-template-static-buffer
12050 root      20   0  718.1m   1.6m   2.0  0.0   0:00.98 D fio ././conf/fio-template-static-buffer

and working...


[ 4159.338731] CPU: 0 PID: 105 Comm: kworker/u8:4
[ 4159.338734] Workqueue: writeback wb_workfn (flush-254:0)
[ 4159.338746]  [<ffffffffa01d8cff>] zram_make_request+0x4a3/0x67b [zram]
[ 4159.338748]  [<ffffffff810543fe>] ? try_to_wake_up+0x201/0x213
[ 4159.338750]  [<ffffffff810ae9d3>] ? mempool_alloc+0x5e/0x124
[ 4159.338752]  [<ffffffff811a9922>] generic_make_request+0xb8/0x156
[ 4159.338753]  [<ffffffff811a9aaf>] submit_bio+0xef/0xf8
[ 4159.338755]  [<ffffffff81121a97>] submit_bh_wbc.isra.10+0x16b/0x178
[ 4159.338757]  [<ffffffff811223ec>] __block_write_full_page+0x1b2/0x2a6
[ 4159.338758]  [<ffffffff8112403e>] ? bh_submit_read+0x5a/0x5a
[ 4159.338760]  [<ffffffff81120f9a>] ? end_buffer_write_sync+0x36/0x36
[ 4159.338761]  [<ffffffff8112403e>] ? bh_submit_read+0x5a/0x5a
[ 4159.338763]  [<ffffffff811226d8>] block_write_full_page+0xf6/0xff
[ 4159.338765]  [<ffffffff81124342>] blkdev_writepage+0x13/0x15
[ 4159.338767]  [<ffffffff810b498c>] __writepage+0xe/0x26
[ 4159.338768]  [<ffffffff810b65aa>] write_cache_pages+0x28c/0x376
[ 4159.338770]  [<ffffffff810b497e>] ? __wb_calc_thresh+0x83/0x83
[ 4159.338772]  [<ffffffff810b66dc>] generic_writepages+0x48/0x67
[ 4159.338773]  [<ffffffff81124318>] blkdev_writepages+0x9/0xb
[ 4159.338775]  [<ffffffff81124318>] ? blkdev_writepages+0x9/0xb
[ 4159.338776]  [<ffffffff810b6716>] do_writepages+0x1b/0x24
[ 4159.338778]  [<ffffffff8111b12c>] __writeback_single_inode+0x3d/0x155
[ 4159.338779]  [<ffffffff8111b407>] writeback_sb_inodes+0x1c3/0x32c
[ 4159.338781]  [<ffffffff8111b5e1>] __writeback_inodes_wb+0x71/0xa9
[ 4159.338783]  [<ffffffff8111b7ce>] wb_writeback+0x10f/0x1a1
[ 4159.338785]  [<ffffffff8111be32>] wb_workfn+0x1c9/0x24c
[ 4159.338786]  [<ffffffff8111be32>] ? wb_workfn+0x1c9/0x24c
[ 4159.338788]  [<ffffffff8104a2e2>] process_one_work+0x1a4/0x2a7
[ 4159.338790]  [<ffffffff8104ae32>] worker_thread+0x23b/0x37c
[ 4159.338792]  [<ffffffff8104abf7>] ? rescuer_thread+0x2eb/0x2eb
[ 4159.338793]  [<ffffffff8104f285>] kthread+0xce/0xd6
[ 4159.338794]  [<ffffffff8104f1b7>] ? kthread_create_on_node+0x1ad/0x1ad
[ 4159.338796]  [<ffffffff8145ad12>] ret_from_fork+0x22/0x30


so the question is -- can we move this parallelization out of zram
and instead flush bdi in more than one kthread? how bad that would
be? can anyone else benefit from this?



[1] https://lwn.net/Articles/353844/
[2] https://lwn.net/Articles/354852/

	-ss
