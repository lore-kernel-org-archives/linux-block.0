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
Date: Wed, 01 Mar 2017 16:58:19 +0100
Message-id: <1736240.zsmNExgN5W@amdc3058>
In-reply-to: <18156581.sUHfslyV5F@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <1718299.ToPxjyb5YA@amdc3058> <18156581.sUHfslyV5F@amdc3058>
 <CGME20170301155822epcas5p103373c6afbd516e4792ebef9bb202b94@epcas5p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Wednesday, March 01, 2017 04:52:38 PM Bartlomiej Zolnierkiewicz wrote:

> I assume that the problem got introduced even earlier,
> commit 4515dc6 ("mmc: block: shuffle retry and error
> handling") just makes it happen every time.

Patch #16 makes it worse as now I get deadlock on boot:

[  248.801750] INFO: task kworker/2:2:113 blocked for more than 120 seconds.
[  248.807119]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  248.814162] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.821943] kworker/2:2     D    0   113      2 0x00000000
[  248.827357] Workqueue: events_freezable mmc_rescan
[  248.832227] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  248.839123] [<c06df634>] (schedule) from [<c0527708>] (__mmc_claim_host+0x8c/0x1a0)
[  248.846851] [<c0527708>] (__mmc_claim_host) from [<c052dc54>] (mmc_attach_mmc+0xb8/0x14c)
[  248.854989] [<c052dc54>] (mmc_attach_mmc) from [<c052a124>] (mmc_rescan+0x274/0x34c)
[  248.862725] [<c052a124>] (mmc_rescan) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  248.870498] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  248.878653] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  248.885934] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  248.893098] INFO: task jbd2/mmcblk0p2-:132 blocked for more than 120 seconds.
[  248.900092]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  248.907108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.914904] jbd2/mmcblk0p2- D    0   132      2 0x00000000
[  248.920319] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  248.927433] [<c06df634>] (schedule) from [<c06e4f94>] (schedule_timeout+0x148/0x220)
[  248.935139] [<c06e4f94>] (schedule_timeout) from [<c06def74>] (io_schedule_timeout+0x74/0xb0)
[  248.943634] [<c06def74>] (io_schedule_timeout) from [<c06df91c>] (bit_wait_io+0x10/0x58)
[  248.951684] [<c06df91c>] (bit_wait_io) from [<c06dfd3c>] (__wait_on_bit+0x84/0xbc)
[  248.959134] [<c06dfd3c>] (__wait_on_bit) from [<c06dfe60>] (out_of_line_wait_on_bit+0x68/0x70)
[  248.968142] [<c06dfe60>] (out_of_line_wait_on_bit) from [<c0295f4c>] (jbd2_journal_commit_transaction+0x1468/0x15c4)
[  248.978397] [<c0295f4c>] (jbd2_journal_commit_transaction) from [<c0298af0>] (kjournald2+0xbc/0x264)
[  248.987514] [<c0298af0>] (kjournald2) from [<c0135604>] (kthread+0xfc/0x134)
[  248.994494] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  249.001714] INFO: task kworker/1:2H:134 blocked for more than 120 seconds.
[  249.008412]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.015479] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.023094] kworker/1:2H    D    0   134      2 0x00000000
[  249.028510] Workqueue: kblockd blk_mq_run_work_fn
[  249.033330] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.040199] [<c06df634>] (schedule) from [<c0527708>] (__mmc_claim_host+0x8c/0x1a0)
[  249.047856] [<c0527708>] (__mmc_claim_host) from [<c053881c>] (mmc_queue_rq+0x9c/0xa8)
[  249.055736] [<c053881c>] (mmc_queue_rq) from [<c0314358>] (blk_mq_dispatch_rq_list+0xd4/0x1d0)
[  249.064316] [<c0314358>] (blk_mq_dispatch_rq_list) from [<c03145d4>] (blk_mq_process_rq_list+0x180/0x198)
[  249.073845] [<c03145d4>] (blk_mq_process_rq_list) from [<c03146a4>] (__blk_mq_run_hw_queue+0xb8/0x110)
[  249.083120] [<c03146a4>] (__blk_mq_run_hw_queue) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  249.092076] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  249.099990] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  249.107322] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  249.114485] INFO: task kworker/5:2H:136 blocked for more than 120 seconds.
[  249.121326]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.128232] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.136074] kworker/5:2H    D    0   136      2 0x00000000
[  249.141544] Workqueue: kblockd blk_mq_run_work_fn
[  249.146187] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.153419] [<c06df634>] (schedule) from [<c0527708>] (__mmc_claim_host+0x8c/0x1a0)
[  249.160825] [<c0527708>] (__mmc_claim_host) from [<c053881c>] (mmc_queue_rq+0x9c/0xa8)
[  249.168755] [<c053881c>] (mmc_queue_rq) from [<c0314358>] (blk_mq_dispatch_rq_list+0xd4/0x1d0)
[  249.177318] [<c0314358>] (blk_mq_dispatch_rq_list) from [<c03145d4>] (blk_mq_process_rq_list+0x180/0x198)
[  249.186858] [<c03145d4>] (blk_mq_process_rq_list) from [<c03146a4>] (__blk_mq_run_hw_queue+0xb8/0x110)
[  249.196124] [<c03146a4>] (__blk_mq_run_hw_queue) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  249.204969] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  249.213161] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  249.220270] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  249.227505] INFO: task kworker/0:1H:145 blocked for more than 120 seconds.
[  249.234328]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.241229] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.249066] kworker/0:1H    D    0   145      2 0x00000000
[  249.254521] Workqueue: kblockd blk_mq_run_work_fn
[  249.259176] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.266233] [<c06df634>] (schedule) from [<c0527708>] (__mmc_claim_host+0x8c/0x1a0)
[  249.274001] [<c0527708>] (__mmc_claim_host) from [<c053881c>] (mmc_queue_rq+0x9c/0xa8)
[  249.281747] [<c053881c>] (mmc_queue_rq) from [<c0314358>] (blk_mq_dispatch_rq_list+0xd4/0x1d0)
[  249.290284] [<c0314358>] (blk_mq_dispatch_rq_list) from [<c03145d4>] (blk_mq_process_rq_list+0x180/0x198)
[  249.299843] [<c03145d4>] (blk_mq_process_rq_list) from [<c03146a4>] (__blk_mq_run_hw_queue+0xb8/0x110)
[  249.309122] [<c03146a4>] (__blk_mq_run_hw_queue) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  249.317951] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  249.326017] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  249.333408] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  249.340459] INFO: task udevd:280 blocked for more than 120 seconds.
[  249.346725]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.353644] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.361452] udevd           D    0   280    258 0x00000005
[  249.366885] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.373964] [<c06df634>] (schedule) from [<c06e4f94>] (schedule_timeout+0x148/0x220)
[  249.381651] [<c06e4f94>] (schedule_timeout) from [<c06def74>] (io_schedule_timeout+0x74/0xb0)
[  249.390110] [<c06def74>] (io_schedule_timeout) from [<c0198a0c>] (__lock_page+0xe8/0x118)
[  249.398399] [<c0198a0c>] (__lock_page) from [<c01a88b0>] (truncate_inode_pages_range+0x580/0x59c)
[  249.407129] [<c01a88b0>] (truncate_inode_pages_range) from [<c01a8984>] (truncate_inode_pages+0x18/0x20)
[  249.416571] [<c01a8984>] (truncate_inode_pages) from [<c0214bf0>] (__blkdev_put+0x68/0x1d8)
[  249.424892] [<c0214bf0>] (__blkdev_put) from [<c0214ea8>] (blkdev_close+0x18/0x20)
[  249.432422] [<c0214ea8>] (blkdev_close) from [<c01e3178>] (__fput+0x84/0x1c0)
[  249.439501] [<c01e3178>] (__fput) from [<c0133d60>] (task_work_run+0xbc/0xdc)
[  249.446677] [<c0133d60>] (task_work_run) from [<c011de60>] (do_exit+0x304/0x9bc)
[  249.454152] [<c011de60>] (do_exit) from [<c011e664>] (do_group_exit+0x3c/0xbc)
[  249.461165] [<c011e664>] (do_group_exit) from [<c01278c0>] (get_signal+0x200/0x65c)
[  249.468833] [<c01278c0>] (get_signal) from [<c010ed48>] (do_signal+0x84/0x3c4)
[  249.476015] [<c010ed48>] (do_signal) from [<c010a0e4>] (do_work_pending+0xa4/0xb4)
[  249.483557] [<c010a0e4>] (do_work_pending) from [<c0107914>] (slow_work_pending+0xc/0x20)
[  249.491689] INFO: task udevd:281 blocked for more than 120 seconds.
[  249.497900]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.504892] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.512771] udevd           D    0   281    258 0x00000005
[  249.518097] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.525153] [<c06df634>] (schedule) from [<c06e4f94>] (schedule_timeout+0x148/0x220)
[  249.532853] [<c06e4f94>] (schedule_timeout) from [<c06def74>] (io_schedule_timeout+0x74/0xb0)
[  249.541354] [<c06def74>] (io_schedule_timeout) from [<c0198a0c>] (__lock_page+0xe8/0x118)
[  249.549463] [<c0198a0c>] (__lock_page) from [<c01a88b0>] (truncate_inode_pages_range+0x580/0x59c)
[  249.558331] [<c01a88b0>] (truncate_inode_pages_range) from [<c01a8984>] (truncate_inode_pages+0x18/0x20)
[  249.567785] [<c01a8984>] (truncate_inode_pages) from [<c0214bf0>] (__blkdev_put+0x68/0x1d8)
[  249.576207] [<c0214bf0>] (__blkdev_put) from [<c0214ea8>] (blkdev_close+0x18/0x20)
[  249.583669] [<c0214ea8>] (blkdev_close) from [<c01e3178>] (__fput+0x84/0x1c0)
[  249.590710] [<c01e3178>] (__fput) from [<c0133d60>] (task_work_run+0xbc/0xdc)
[  249.597843] [<c0133d60>] (task_work_run) from [<c011de60>] (do_exit+0x304/0x9bc)
[  249.605217] [<c011de60>] (do_exit) from [<c011e664>] (do_group_exit+0x3c/0xbc)
[  249.612399] [<c011e664>] (do_group_exit) from [<c01278c0>] (get_signal+0x200/0x65c)
[  249.620000] [<c01278c0>] (get_signal) from [<c010ed48>] (do_signal+0x84/0x3c4)
[  249.627228] [<c010ed48>] (do_signal) from [<c010a0e4>] (do_work_pending+0xa4/0xb4)
[  249.634874] [<c010a0e4>] (do_work_pending) from [<c0107914>] (slow_work_pending+0xc/0x20)
[  249.642922] INFO: task kworker/u16:2:1268 blocked for more than 120 seconds.
[  249.649891]       Tainted: G        W       4.10.0-rc3-00123-g1bec9a6 #2726
[  249.656847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.664654] kworker/u16:2   D    0  1268      2 0x00000000
[  249.670094] Workqueue: writeback wb_workfn (flush-179:0)
[  249.675398] [<c06df12c>] (__schedule) from [<c06df634>] (schedule+0x40/0xac)
[  249.682425] [<c06df634>] (schedule) from [<c06e4f94>] (schedule_timeout+0x148/0x220)
[  249.690103] [<c06e4f94>] (schedule_timeout) from [<c06def74>] (io_schedule_timeout+0x74/0xb0)
[  249.698738] [<c06def74>] (io_schedule_timeout) from [<c03154e4>] (bt_get+0x140/0x228)
[  249.706432] [<c03154e4>] (bt_get) from [<c03156d0>] (blk_mq_get_tag+0x24/0xa8)
[  249.713613] [<c03156d0>] (blk_mq_get_tag) from [<c03119c0>] (__blk_mq_alloc_request+0x10/0x15c)
[  249.722287] [<c03119c0>] (__blk_mq_alloc_request) from [<c0311bbc>] (blk_mq_map_request+0xb0/0xfc)
[  249.731178] [<c0311bbc>] (blk_mq_map_request) from [<c03136f0>] (blk_sq_make_request+0x8c/0x298)
[  249.739962] [<c03136f0>] (blk_sq_make_request) from [<c0308e00>] (generic_make_request+0xd8/0x180)
[  249.748891] [<c0308e00>] (generic_make_request) from [<c0308f30>] (submit_bio+0x88/0x148)
[  249.757175] [<c0308f30>] (submit_bio) from [<c0256ccc>] (ext4_io_submit+0x34/0x40)
[  249.764581] [<c0256ccc>] (ext4_io_submit) from [<c0255674>] (ext4_writepages+0x484/0x670)
[  249.772722] [<c0255674>] (ext4_writepages) from [<c01a5348>] (do_writepages+0x24/0x38)
[  249.780573] [<c01a5348>] (do_writepages) from [<c0208038>] (__writeback_single_inode+0x28/0x18c)
[  249.789359] [<c0208038>] (__writeback_single_inode) from [<c02085f0>] (writeback_sb_inodes+0x1e0/0x394)
[  249.798717] [<c02085f0>] (writeback_sb_inodes) from [<c0208814>] (__writeback_inodes_wb+0x70/0xac)
[  249.807643] [<c0208814>] (__writeback_inodes_wb) from [<c02089dc>] (wb_writeback+0x18c/0x1b4)
[  249.816241] [<c02089dc>] (wb_writeback) from [<c0208d68>] (wb_workfn+0x1c8/0x388)
[  249.823590] [<c0208d68>] (wb_workfn) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  249.831375] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  249.839408] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  249.846726] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
