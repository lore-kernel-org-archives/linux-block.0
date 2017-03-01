Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/16] mmc: block: shuffle retry and error handling
Date: Wed, 01 Mar 2017 16:52:38 +0100
Message-id: <18156581.sUHfslyV5F@amdc3058>
In-reply-to: <1718299.ToPxjyb5YA@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <22219053.LlSbdLjSYi@amdc3058> <1718299.ToPxjyb5YA@amdc3058>
 <CGME20170301155243epcas1p1140ce11db60b31065a0356525a2ee0a0@epcas1p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Wednesday, March 01, 2017 12:45:57 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, February 28, 2017 06:45:20 PM Bartlomiej Zolnierkiewicz wrote:
> > On Thursday, February 09, 2017 04:33:58 PM Linus Walleij wrote:
> > > Instead of doing retries at the same time as trying to submit new
> > > requests, do the retries when the request is reported as completed
> > > by the driver, in the finalization worker.
> > > 
> > > This is achieved by letting the core worker call back into the block
> > > layer using mmc_blk_rw_done(), that will read the status and repeatedly
> > > try to hammer the request using single request etc by calling back to
> > > the core layer using mmc_restart_areq()
> > > 
> > > The beauty of it is that the completion will not complete until the
> > > block layer has had the opportunity to hammer a bit at the card using
> > > a bunch of different approaches in the while() loop in
> > > mmc_blk_rw_done()
> > > 
> > > The algorithm for recapture, retry and handle errors is essentially
> > > identical to the one we used to have in mmc_blk_issue_rw_rq(),
> > > only augmented to get called in another path.
> > > 
> > > We have to add and initialize a pointer back to the struct mmc_queue
> > > from the struct mmc_queue_req to find the queue from the asynchronous
> > > request.
> > > 
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > It seems that after this change we can end up queuing more
> > work for kthread from the kthread worker itself and wait
> > inside it for this nested work to complete.  I hope that
> 
> On the second look it seems that there is no waiting for
> the retried areq to complete so I cannot see what protects
> us from racing and trying to run two areq-s in parallel:
> 
> 1st areq being retried (in the completion kthread):
> 
> 	mmc_blk_rw_done()->mmc_restart_areq()->__mmc_start_data_req()
> 
> 2nd areq coming from the second request in the queue
> (in the queuing kthread):
> 
> 	mmc_blk_issue_rw_rq()->mmc_start_areq()->__mmc_start_data_req()
> 
> (after mmc_blk_rw_done() is done in mmc_finalize_areq() 1st
> areq is marked as completed by the completion kthread and
> the waiting on host->areq in mmc_start_areq() of the queuing
> kthread is done and 2nd areq is started while the 1st one
> is still being retried)
> 
> ?
> 
> Also retrying of areqs for MMC_BLK_RETRY status case got broken
> (before change do {} while() loop increased retry variable,
> now the loop is gone and retry variable will not be increased
> correctly and we can loop forever).

There is another problem with this patch.

During boot there is ~30 sec delay and later I get deadlock
on trying to run sync command (first thing I do after boot):

...
[    5.960623] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
done.
[....] Waiting for /dev to be fully populated...[   17.745887] random: crng init done
done.
[....] Activating swap...done.
[   39.767982] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
...
root@target:~# sync
[  248.801708] INFO: task udevd:287 blocked for more than 120 seconds.
[  248.806552]       Tainted: G        W       4.10.0-rc3-00118-g4515dc6 #2736
[  248.813590] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.821275] udevd           D    0   287    249 0x00000005
[  248.826815] [<c06df404>] (__schedule) from [<c06df90c>] (schedule+0x40/0xac)
[  248.833889] [<c06df90c>] (schedule) from [<c06e526c>] (schedule_timeout+0x148/0x220)
[  248.841598] [<c06e526c>] (schedule_timeout) from [<c06df24c>] (io_schedule_timeout+0x74/0xb0)
[  248.849993] [<c06df24c>] (io_schedule_timeout) from [<c0198a0c>] (__lock_page+0xe8/0x118)
[  248.858235] [<c0198a0c>] (__lock_page) from [<c01a88b0>] (truncate_inode_pages_range+0x580/0x59c)
[  248.867053] [<c01a88b0>] (truncate_inode_pages_range) from [<c01a8984>] (truncate_inode_pages+0x18/0x20)
[  248.876525] [<c01a8984>] (truncate_inode_pages) from [<c0214bf0>] (__blkdev_put+0x68/0x1d8)
[  248.884828] [<c0214bf0>] (__blkdev_put) from [<c0214ea8>] (blkdev_close+0x18/0x20)
[  248.892375] [<c0214ea8>] (blkdev_close) from [<c01e3178>] (__fput+0x84/0x1c0)
[  248.899383] [<c01e3178>] (__fput) from [<c0133d60>] (task_work_run+0xbc/0xdc)
[  248.906593] [<c0133d60>] (task_work_run) from [<c011de60>] (do_exit+0x304/0x9bc)
[  248.913938] [<c011de60>] (do_exit) from [<c011e664>] (do_group_exit+0x3c/0xbc)
[  248.921046] [<c011e664>] (do_group_exit) from [<c01278c0>] (get_signal+0x200/0x65c)
[  248.928776] [<c01278c0>] (get_signal) from [<c010ed48>] (do_signal+0x84/0x3c4)
[  248.935970] [<c010ed48>] (do_signal) from [<c010a0e4>] (do_work_pending+0xa4/0xb4)
[  248.943506] [<c010a0e4>] (do_work_pending) from [<c0107914>] (slow_work_pending+0xc/0x20)
[  248.951637] INFO: task sync:1398 blocked for more than 120 seconds.
[  248.957756]       Tainted: G        W       4.10.0-rc3-00118-g4515dc6 #2736
[  248.965052] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.972681] sync            D    0  1398   1390 0x00000000
[  248.978117] [<c06df404>] (__schedule) from [<c06df90c>] (schedule+0x40/0xac)
[  248.985174] [<c06df90c>] (schedule) from [<c06dfb3c>] (schedule_preempt_disabled+0x14/0x20)
[  248.993609] [<c06dfb3c>] (schedule_preempt_disabled) from [<c06e3b18>] (__mutex_lock_slowpath+0x480/0x6ec)
[  249.003153] [<c06e3b18>] (__mutex_lock_slowpath) from [<c0215964>] (iterate_bdevs+0xb8/0x108)
[  249.011729] [<c0215964>] (iterate_bdevs) from [<c020c0ac>] (sys_sync+0x54/0x98)
[  249.018802] [<c020c0ac>] (sys_sync) from [<c01078c0>] (ret_fast_syscall+0x0/0x3c)

To be exact the same issue also sometimes happens with
previous commit 784da04 ("mmc: queue: simplify queue
logic") and I also got deadlock on boot once with commit
9a4c8a3 ("mmc: core: kill off the context info"):

...
[    5.958868] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
done.
[....] Waiting for /dev to be fully populated...[   16.361597] random: crng init done
done.
[  248.801776] INFO: task mmcqd/0:127 blocked for more than 120 seconds.
[  248.806795]       Tainted: G        W       4.10.0-rc3-00116-g9a4c8a3 #2735
[  248.813882] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.821909] mmcqd/0         D    0   127      2 0x00000000
[  248.827031] [<c06df4b4>] (__schedule) from [<c06df9bc>] (schedule+0x40/0xac)
[  248.834098] [<c06df9bc>] (schedule) from [<c06e531c>] (schedule_timeout+0x148/0x220)
[  248.841788] [<c06e531c>] (schedule_timeout) from [<c06e02a8>] (wait_for_common+0xb8/0x144)
[  248.849969] [<c06e02a8>] (wait_for_common) from [<c05280f8>] (mmc_start_areq+0x40/0x1ac)
[  248.858092] [<c05280f8>] (mmc_start_areq) from [<c0537680>] (mmc_blk_issue_rw_rq+0x78/0x314)
[  248.866485] [<c0537680>] (mmc_blk_issue_rw_rq) from [<c0538318>] (mmc_blk_issue_rq+0x9c/0x458)
[  248.875060] [<c0538318>] (mmc_blk_issue_rq) from [<c0538820>] (mmc_queue_thread+0x90/0x16c)
[  248.883383] [<c0538820>] (mmc_queue_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  248.890867] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  248.898124] INFO: task udevd:273 blocked for more than 120 seconds.
[  248.904331]       Tainted: G        W       4.10.0-rc3-00116-g9a4c8a3 #2735
[  248.911191] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.919057] udevd           D    0   273    250 0x00000005
[  248.924543] [<c06df4b4>] (__schedule) from [<c06df9bc>] (schedule+0x40/0xac)
[  248.931557] [<c06df9bc>] (schedule) from [<c06e531c>] (schedule_timeout+0x148/0x220)
[  248.939206] [<c06e531c>] (schedule_timeout) from [<c06df2fc>] (io_schedule_timeout+0x74/0xb0)
[  248.947770] [<c06df2fc>] (io_schedule_timeout) from [<c0198a0c>] (__lock_page+0xe8/0x118)
[  248.955916] [<c0198a0c>] (__lock_page) from [<c01a88b0>] (truncate_inode_pages_range+0x580/0x59c)
[  248.964751] [<c01a88b0>] (truncate_inode_pages_range) from [<c01a8984>] (truncate_inode_pages+0x18/0x20)
[  248.974401] [<c01a8984>] (truncate_inode_pages) from [<c0214bf0>] (__blkdev_put+0x68/0x1d8)
[  248.982593] [<c0214bf0>] (__blkdev_put) from [<c0214ea8>] (blkdev_close+0x18/0x20)
[  248.990088] [<c0214ea8>] (blkdev_close) from [<c01e3178>] (__fput+0x84/0x1c0)
[  248.997229] [<c01e3178>] (__fput) from [<c0133d60>] (task_work_run+0xbc/0xdc)
[  249.004380] [<c0133d60>] (task_work_run) from [<c011de60>] (do_exit+0x304/0x9bc)
[  249.011570] [<c011de60>] (do_exit) from [<c011e664>] (do_group_exit+0x3c/0xbc)
[  249.018732] [<c011e664>] (do_group_exit) from [<c01278c0>] (get_signal+0x200/0x65c)
[  249.026392] [<c01278c0>] (get_signal) from [<c010ed48>] (do_signal+0x84/0x3c4)
[  249.033577] [<c010ed48>] (do_signal) from [<c010a0e4>] (do_work_pending+0xa4/0xb4)
[  249.041086] [<c010a0e4>] (do_work_pending) from [<c0107914>] (slow_work_pending+0xc/0x20)

I assume that the problem got introduced even earlier,
commit 4515dc6 ("mmc: block: shuffle retry and error
handling") just makes it happen every time.

The hardware I use for testing is Odroid XU3-Lite.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
