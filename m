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
Date: Wed, 01 Mar 2017 18:48:54 +0100
Message-id: <2197595.B57660rO9O@amdc3058>
In-reply-to: <18156581.sUHfslyV5F@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <1718299.ToPxjyb5YA@amdc3058> <18156581.sUHfslyV5F@amdc3058>
 <CGME20170301174856epcas5p16bdf861a0117a33f9dad37a81449a95e@epcas5p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Wednesday, March 01, 2017 04:52:38 PM Bartlomiej Zolnierkiewicz wrote:

> I assume that the problem got introduced even earlier,
> commit 4515dc6 ("mmc: block: shuffle retry and error
> handling") just makes it happen every time.

It seems to be introduced by patch #6. Patch #5 survived
30 consecutive boot+sync iterations (with later patches
the issue shows up during the first 12 iterations).

root@target:~# sync
[  248.801846] INFO: task mmcqd/0:128 blocked for more than 120 seconds.
[  248.806866]       Tainted: G        W       4.10.0-rc3-00113-g5750765 #2739
[  248.814051] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.821696] mmcqd/0         D    0   128      2 0x00000000
[  248.827123] [<c06df51c>] (__schedule) from [<c06dfa24>] (schedule+0x40/0xac)
[  248.834210] [<c06dfa24>] (schedule) from [<c06e5384>] (schedule_timeout+0x148/0x220)
[  248.841912] [<c06e5384>] (schedule_timeout) from [<c06e0310>] (wait_for_common+0xb8/0x144)
[  248.850058] [<c06e0310>] (wait_for_common) from [<c0528100>] (mmc_start_areq+0x40/0x1ac)
[  248.858209] [<c0528100>] (mmc_start_areq) from [<c05376c0>] (mmc_blk_issue_rw_rq+0x78/0x314)
[  248.866599] [<c05376c0>] (mmc_blk_issue_rw_rq) from [<c0538358>] (mmc_blk_issue_rq+0x9c/0x458)
[  248.875293] [<c0538358>] (mmc_blk_issue_rq) from [<c0538868>] (mmc_queue_thread+0x98/0x180)
[  248.883789] [<c0538868>] (mmc_queue_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  248.891058] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  248.898364] INFO: task jbd2/mmcblk0p2-:136 blocked for more than 120 seconds.
[  248.905400]       Tainted: G        W       4.10.0-rc3-00113-g5750765 #2739
[  248.912353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.919923] jbd2/mmcblk0p2- D    0   136      2 0x00000000
[  248.925693] [<c06df51c>] (__schedule) from [<c06dfa24>] (schedule+0x40/0xac)
[  248.932470] [<c06dfa24>] (schedule) from [<c0294ccc>] (jbd2_journal_commit_transaction+0x1e8/0x15c4)
[  248.941552] [<c0294ccc>] (jbd2_journal_commit_transaction) from [<c0298af0>] (kjournald2+0xbc/0x264)
[  248.950608] [<c0298af0>] (kjournald2) from [<c0135604>] (kthread+0xfc/0x134)
[  248.957660] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  248.964860] INFO: task kworker/u16:2:730 blocked for more than 120 seconds.
[  248.971780]       Tainted: G        W       4.10.0-rc3-00113-g5750765 #2739
[  248.978673] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  248.986686] kworker/u16:2   D    0   730      2 0x00000000
[  248.991993] Workqueue: writeback wb_workfn (flush-179:0)
[  248.997230] [<c06df51c>] (__schedule) from [<c06dfa24>] (schedule+0x40/0xac)
[  249.004287] [<c06dfa24>] (schedule) from [<c06e5384>] (schedule_timeout+0x148/0x220)
[  249.011997] [<c06e5384>] (schedule_timeout) from [<c06df364>] (io_schedule_timeout+0x74/0xb0)
[  249.020451] [<c06df364>] (io_schedule_timeout) from [<c06dfd0c>] (bit_wait_io+0x10/0x58)
[  249.028545] [<c06dfd0c>] (bit_wait_io) from [<c06dff1c>] (__wait_on_bit_lock+0x74/0xd0)
[  249.036513] [<c06dff1c>] (__wait_on_bit_lock) from [<c06dffe0>] (out_of_line_wait_on_bit_lock+0x68/0x70)
[  249.046231] [<c06dffe0>] (out_of_line_wait_on_bit_lock) from [<c0293dfc>] (do_get_write_access+0x3d0/0x4c4)
[  249.055729] [<c0293dfc>] (do_get_write_access) from [<c029410c>] (jbd2_journal_get_write_access+0x38/0x64)
[  249.065336] [<c029410c>] (jbd2_journal_get_write_access) from [<c0272680>] (__ext4_journal_get_write_access+0x2c/0x68)
[  249.076016] [<c0272680>] (__ext4_journal_get_write_access) from [<c0278eb8>] (ext4_mb_mark_diskspace_used+0x64/0x474)
[  249.086515] [<c0278eb8>] (ext4_mb_mark_diskspace_used) from [<c027a334>] (ext4_mb_new_blocks+0x258/0xa1c)
[  249.096040] [<c027a334>] (ext4_mb_new_blocks) from [<c026fc80>] (ext4_ext_map_blocks+0x8b4/0xf28)
[  249.104883] [<c026fc80>] (ext4_ext_map_blocks) from [<c024f318>] (ext4_map_blocks+0x144/0x5f8)
[  249.113468] [<c024f318>] (ext4_map_blocks) from [<c0254b0c>] (mpage_map_and_submit_extent+0xa4/0x788)
[  249.122641] [<c0254b0c>] (mpage_map_and_submit_extent) from [<c02556d0>] (ext4_writepages+0x4e0/0x670)
[  249.131925] [<c02556d0>] (ext4_writepages) from [<c01a5348>] (do_writepages+0x24/0x38)
[  249.139774] [<c01a5348>] (do_writepages) from [<c0208038>] (__writeback_single_inode+0x28/0x18c)
[  249.148555] [<c0208038>] (__writeback_single_inode) from [<c02085f0>] (writeback_sb_inodes+0x1e0/0x394)
[  249.157909] [<c02085f0>] (writeback_sb_inodes) from [<c0208814>] (__writeback_inodes_wb+0x70/0xac)
[  249.166833] [<c0208814>] (__writeback_inodes_wb) from [<c02089dc>] (wb_writeback+0x18c/0x1b4)
[  249.175324] [<c02089dc>] (wb_writeback) from [<c0208c74>] (wb_workfn+0xd4/0x388)
[  249.182704] [<c0208c74>] (wb_workfn) from [<c012fdf8>] (process_one_work+0x120/0x318)
[  249.190464] [<c012fdf8>] (process_one_work) from [<c0130054>] (worker_thread+0x2c/0x4ac)
[  249.198551] [<c0130054>] (worker_thread) from [<c0135604>] (kthread+0xfc/0x134)
[  249.205904] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[  249.213094] INFO: task sync:1403 blocked for more than 120 seconds.
[  249.219261]       Tainted: G        W       4.10.0-rc3-00113-g5750765 #2739
[  249.226220] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  249.234019] sync            D    0  1403   1396 0x00000000
[  249.239424] [<c06df51c>] (__schedule) from [<c06dfa24>] (schedule+0x40/0xac)
[  249.246624] [<c06dfa24>] (schedule) from [<c02078c0>] (wb_wait_for_completion+0x50/0x7c)
[  249.254538] [<c02078c0>] (wb_wait_for_completion) from [<c0207c14>] (sync_inodes_sb+0x94/0x20c)
[  249.263200] [<c0207c14>] (sync_inodes_sb) from [<c01e4dc8>] (iterate_supers+0xac/0xd4)
[  249.271056] [<c01e4dc8>] (iterate_supers) from [<c020c088>] (sys_sync+0x30/0x98)
[  249.278446] [<c020c088>] (sys_sync) from [<c01078c0>] (ret_fast_syscall+0x0/0x3c)

I also once hit another problem with patch #6 that doesn't
happen with patch #5:

[   12.121767] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[   12.129747] pgd = c0004000
[   12.132425] [00000008] *pgd=00000000
[   12.135996] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   12.141262] Modules linked in:
[   12.144304] CPU: 0 PID: 126 Comm: mmcqd/0 Tainted: G        W       4.10.0-rc3-00113-g5750765 #2739
[   12.153296] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   12.159367] task: edd19900 task.stack: edd66000
[   12.163900] PC is at kthread_queue_work+0x18/0x64
[   12.168574] LR is at _raw_spin_lock_irqsave+0x20/0x28
[   12.173583] pc : [<c0135b24>]    lr : [<c06e6138>]    psr: 60000193
[   12.173583] sp : edd67d10  ip : 00000000  fp : edcc9b04
[   12.185014] r10: 00000000  r9 : edd6808c  r8 : edcc9b08
[   12.190215] r7 : 00000000  r6 : edc97320  r5 : edc97324  r4 : 00000008
[   12.196714] r3 : edc97000  r2 : 00000000  r1 : 0b750b74  r0 : a0000113
[   12.203216] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   12.210406] Control: 10c5387d  Table: 6d0e006a  DAC: 00000051
[   12.216125] Process mmcqd/0 (pid: 126, stack limit = 0xedd66210)
[   12.222102] Stack: (0xedd67d10 to 0xedd68000)
[   12.226444] 7d00:                                     edc97000 edd68004 edd6808c edc97000
[   12.234595] 7d20: 00000000 c0527ab8 edcc9a10 edc97000 edd68004 edd68004 edcc9b08 c0542834
[   12.242740] 7d40: edd680c0 edcc9a10 00000001 edd680f4 edd68004 c0542b5c edd67da4 edcc9a80
[   12.250886] 7d60: c0b108aa edcc9af0 edcc9af4 00000000 c0a62244 00000000 c0b02080 00000006
[   12.259031] 7d80: 00000101 c011f6f0 00000000 c0b02098 00000006 c0a622c8 c0b02080 c011edac
[   12.267176] 7da0: eea15160 00000001 00000000 00000009 ffff8f8d 00208840 eea15100 00000000
[   12.275322] 7dc0: 0000004b c0a65c20 00000000 00000001 ee818000 edd67e28 00000000 c011f1a8
[   12.283468] 7de0: 0000008c c016068c f0802000 c0b05724 f080200c 000003eb c0b17c30 f0803000
[   12.291614] 7e00: edd67e28 c0101470 c03448b8 20000013 ffffffff edd67e5c 00000000 edd66000
[   12.299759] 7e20: edd68004 c010b00c c08a2154 c0890cdc edd67e78 edd66000 00000000 c011f068
[   12.307904] 7e40: c0890cdc c08a2154 00000000 edd68030 edd68004 00000000 00000001 edd67e78
[   12.316050] 7e60: c011f068 c03448b8 20000013 ffffffff 00000051 00000000 edd68004 00000001
[   12.324195] 7e80: 00000000 00000201 edc97000 edd68004 00000001 c011f068 edc97000 c0527b8c
[   12.332340] 7ea0: 00000000 edd68004 edc97000 edd6813c 00000001 c0527d04 edd68044 edc97000
[   12.340487] 7ec0: 00000000 c0528208 edd68000 edd31800 edd48858 edd48858 ede6fe60 edd48840
[   12.348631] 7ee0: edd48840 00000001 00000000 c05376c0 00000000 00000001 00000000 00000000
[   12.356777] 7f00: 00000000 c013c5ec 00000100 ede6fe60 00000000 edd48858 edd48840 edd48840
[   12.364922] 7f20: edd31800 00000001 00000000 c0538358 edc18b50 edc97000 edd48860 00000001
[   12.373068] 7f40: edc18b50 edd48858 00000000 ede6fe60 edc18b50 edc97000 edd48860 00000001
[   12.381214] 7f60: 00000000 c0538868 edd19900 eeae0500 00000000 edd4e000 eeae0528 edd48858
[   12.389358] 7f80: edc87d14 c05387d0 00000000 c0135604 edd4e000 c0135508 00000000 00000000
[   12.397502] 7fa0: 00000000 00000000 00000000 c0107978 00000000 00000000 00000000 00000000
[   12.405647] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   12.413795] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[   12.421985] [<c0135b24>] (kthread_queue_work) from [<c0527ab8>] (mmc_request_done+0xd8/0x158)
[   12.430458] [<c0527ab8>] (mmc_request_done) from [<c0542834>] (dw_mci_request_end+0xa0/0xd8)
[   12.438848] [<c0542834>] (dw_mci_request_end) from [<c0542b5c>] (dw_mci_tasklet_func+0x2f0/0x394)
[   12.447693] [<c0542b5c>] (dw_mci_tasklet_func) from [<c011f6f0>] (tasklet_action+0x84/0x12c)
[   12.456089] [<c011f6f0>] (tasklet_action) from [<c011edac>] (__do_softirq+0xec/0x244)
[   12.463885] [<c011edac>] (__do_softirq) from [<c011f1a8>] (irq_exit+0xc0/0x104)
[   12.471166] [<c011f1a8>] (irq_exit) from [<c016068c>] (__handle_domain_irq+0x70/0xe4)
[   12.478966] [<c016068c>] (__handle_domain_irq) from [<c0101470>] (gic_handle_irq+0x50/0x9c)
[   12.487280] [<c0101470>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   12.494716] Exception stack(0xedd67e28 to 0xedd67e70)
[   12.499753] 7e20:                   c08a2154 c0890cdc edd67e78 edd66000 00000000 c011f068
[   12.507902] 7e40: c0890cdc c08a2154 00000000 edd68030 edd68004 00000000 00000001 edd67e78
[   12.516039] 7e60: c011f068 c03448b8 20000013 ffffffff
[   12.521085] [<c010b00c>] (__irq_svc) from [<c03448b8>] (check_preemption_disabled+0x30/0x128)
[   12.529573] [<c03448b8>] (check_preemption_disabled) from [<c011f068>] (__local_bh_enable_ip+0xc8/0xec)
[   12.538931] [<c011f068>] (__local_bh_enable_ip) from [<c0527b8c>] (__mmc_start_request+0x54/0xdc)
[   12.547770] [<c0527b8c>] (__mmc_start_request) from [<c0527d04>] (mmc_start_request+0xf0/0x11c)
[   12.556437] [<c0527d04>] (mmc_start_request) from [<c0528208>] (mmc_start_areq+0x148/0x1ac)
[   12.564753] [<c0528208>] (mmc_start_areq) from [<c05376c0>] (mmc_blk_issue_rw_rq+0x78/0x314)
[   12.573155] [<c05376c0>] (mmc_blk_issue_rw_rq) from [<c0538358>] (mmc_blk_issue_rq+0x9c/0x458)
[   12.581733] [<c0538358>] (mmc_blk_issue_rq) from [<c0538868>] (mmc_queue_thread+0x98/0x180)
[   12.590053] [<c0538868>] (mmc_queue_thread) from [<c0135604>] (kthread+0xfc/0x134)
[   12.597603] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[   12.604782] Code: e1a06000 e1a04001 e1a00005 eb16c17c (e5943000) 
[   12.610842] ---[ end trace 86f45842e4b0b193 ]---
[   12.615426] Kernel panic - not syncing: Fatal exception in interrupt
[   12.621786] CPU1: stopping
[   12.624455] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   12.633452] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   12.639567] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   12.647261] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   12.654445] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   12.661810] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   12.669344] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   12.676783] Exception stack(0xee8b3f78 to 0xee8b3fc0)
[   12.681813] 3f60:                                                       00000001 00000000
[   12.689970] 3f80: ee8b3fd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   12.698113] 3fa0: 00000000 00000000 00000001 ee8b3fc8 c01083c0 c01083c4 60000013 ffffffff
[   12.706265] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   12.713653] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   12.721001] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   12.728538] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   12.735463] CPU5: stopping
[   12.738165] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   12.747156] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   12.753291] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   12.760971] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   12.768153] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   12.775515] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   12.783049] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   12.790485] Exception stack(0xee8bbf78 to 0xee8bbfc0)
[   12.795517] bf60:                                                       00000001 00000000
[   12.803673] bf80: ee8bbfd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   12.811817] bfa0: 00000000 00000000 00000001 ee8bbfc8 c01083c0 c01083c4 60000013 ffffffff
[   12.819968] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   12.827350] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   12.834710] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   12.842239] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   12.849159] CPU4: stopping
[   12.851846] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   12.860840] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   12.866957] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   12.874653] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   12.881835] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   12.889197] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   12.896729] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   12.904168] Exception stack(0xee8b9f78 to 0xee8b9fc0)
[   12.909204] 9f60:                                                       00000001 00000000
[   12.917356] 9f80: ee8b9fd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   12.925499] 9fa0: 00000000 00000000 00000001 ee8b9fc8 c01083c0 c01083c4 60000013 ffffffff
[   12.933655] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   12.941028] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   12.948393] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   12.955923] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   12.962842] CPU2: stopping
[   12.965520] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   12.974517] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   12.980621] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   12.988321] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   12.995508] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   13.002875] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   13.010409] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.017849] Exception stack(0xee8b5f78 to 0xee8b5fc0)
[   13.022878] 5f60:                                                       00000001 00000000
[   13.031036] 5f80: ee8b5fd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   13.039182] 5fa0: 00000000 00000000 00000001 ee8b5fc8 c01083c0 c01083c4 60000013 ffffffff
[   13.047329] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   13.054703] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   13.062066] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   13.069600] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   13.076519] CPU3: stopping
[   13.079209] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   13.088207] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   13.094309] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   13.102010] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   13.109197] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   13.116563] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   13.124099] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.131537] Exception stack(0xee8b7f78 to 0xee8b7fc0)
[   13.136566] 7f60:                                                       00000001 00000000
[   13.144723] 7f80: ee8b7fd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   13.152869] 7fa0: 00000000 00000000 00000001 ee8b7fc8 c01083c0 c01083c4 60000013 ffffffff
[   13.161019] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   13.168390] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   13.175754] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   13.183286] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   13.190213] CPU6: stopping
[   13.192912] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   13.201905] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   13.208022] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   13.215716] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   13.222899] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   13.230263] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   13.237796] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.245233] Exception stack(0xee8bdf78 to 0xee8bdfc0)
[   13.250265] df60:                                                       00000001 00000000
[   13.258422] df80: ee8bdfd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   13.266567] dfa0: 00000000 00000000 00000001 ee8bdfc8 c01083c0 c01083c4 60000013 ffffffff
[   13.274720] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   13.282096] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   13.289459] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   13.296989] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   13.303908] CPU7: stopping
[   13.306603] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   13.315594] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   13.321711] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   13.329407] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   13.336587] [<c032956c>] (dump_stack) from [<c010caac>] (handle_IPI+0x170/0x1a8)
[   13.343950] [<c010caac>] (handle_IPI) from [<c01014b0>] (gic_handle_irq+0x90/0x9c)
[   13.351484] [<c01014b0>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.358923] Exception stack(0xee8bff78 to 0xee8bffc0)
[   13.363955] ff60:                                                       00000001 00000000
[   13.372113] ff80: ee8bffd0 c0114060 c0b05444 c0b053e4 c0a66cc8 c0b0544c c0b108a2 00000000
[   13.380256] ffa0: 00000000 00000000 00000001 ee8bffc8 c01083c0 c01083c4 60000013 ffffffff
[   13.388410] [<c010b00c>] (__irq_svc) from [<c01083c4>] (arch_cpu_idle+0x30/0x3c)
[   13.395786] [<c01083c4>] (arch_cpu_idle) from [<c0152f34>] (do_idle+0x13c/0x200)
[   13.403148] [<c0152f34>] (do_idle) from [<c015328c>] (cpu_startup_entry+0x18/0x1c)
[   13.410678] [<c015328c>] (cpu_startup_entry) from [<4010154c>] (0x4010154c)
[   13.417621] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
[   13.424840] ------------[ cut here ]------------
[   13.429318] WARNING: CPU: 0 PID: 126 at kernel/workqueue.c:857 wq_worker_waking_up+0x70/0x80
[   13.437681] Modules linked in:
[   13.440727] CPU: 0 PID: 126 Comm: mmcqd/0 Tainted: G      D W       4.10.0-rc3-00113-g5750765 #2739
[   13.449728] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   13.455823] [<c010d830>] (unwind_backtrace) from [<c010a544>] (show_stack+0x10/0x14)
[   13.463530] [<c010a544>] (show_stack) from [<c032956c>] (dump_stack+0x74/0x94)
[   13.470717] [<c032956c>] (dump_stack) from [<c011ad10>] (__warn+0xd4/0x100)
[   13.477650] [<c011ad10>] (__warn) from [<c011ad5c>] (warn_slowpath_null+0x20/0x28)
[   13.485194] [<c011ad5c>] (warn_slowpath_null) from [<c0130e70>] (wq_worker_waking_up+0x70/0x80)
[   13.493873] [<c0130e70>] (wq_worker_waking_up) from [<c013ba30>] (ttwu_do_activate+0x58/0x6c)
[   13.502355] [<c013ba30>] (ttwu_do_activate) from [<c013c4ec>] (try_to_wake_up+0x190/0x290)
[   13.510586] [<c013c4ec>] (try_to_wake_up) from [<c01521dc>] (__wake_up_common+0x4c/0x80)
[   13.518645] [<c01521dc>] (__wake_up_common) from [<c0152224>] (__wake_up_locked+0x14/0x1c)
[   13.526876] [<c0152224>] (__wake_up_locked) from [<c0152c24>] (complete+0x34/0x44)
[   13.534433] [<c0152c24>] (complete) from [<c04fcd34>] (exynos5_i2c_irq+0x220/0x26c)
[   13.542042] [<c04fcd34>] (exynos5_i2c_irq) from [<c0160dac>] (__handle_irq_event_percpu+0x58/0x140)
[   13.551048] [<c0160dac>] (__handle_irq_event_percpu) from [<c0160eb0>] (handle_irq_event_percpu+0x1c/0x58)
[   13.560664] [<c0160eb0>] (handle_irq_event_percpu) from [<c0160f24>] (handle_irq_event+0x38/0x5c)
[   13.569511] [<c0160f24>] (handle_irq_event) from [<c016422c>] (handle_fasteoi_irq+0xc4/0x19c)
[   13.578016] [<c016422c>] (handle_fasteoi_irq) from [<c0160574>] (generic_handle_irq+0x18/0x28)
[   13.586579] [<c0160574>] (generic_handle_irq) from [<c0160688>] (__handle_domain_irq+0x6c/0xe4)
[   13.595239] [<c0160688>] (__handle_domain_irq) from [<c0101470>] (gic_handle_irq+0x50/0x9c)
[   13.603556] [<c0101470>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.610994] Exception stack(0xedd67b30 to 0xedd67b78)
[   13.616028] 7b20:                                     00000041 edd19900 00000102 edd66000
[   13.624180] 7b40: c0b49ae8 00000000 c0881434 00000000 00000000 edd19900 60000193 edcc9b04
[   13.632321] 7b60: 00000001 edd67b80 c0196974 c0196978 20000113 ffffffff
[   13.638933] [<c010b00c>] (__irq_svc) from [<c0196978>] (panic+0x1e8/0x26c)
[   13.645769] [<c0196978>] (panic) from [<c010a7f8>] (die+0x2b0/0x2e0)
[   13.652099] [<c010a7f8>] (die) from [<c011514c>] (__do_kernel_fault.part.0+0x54/0x1e4)
[   13.659982] [<c011514c>] (__do_kernel_fault.part.0) from [<c0110bec>] (do_page_fault+0x26c/0x294)
[   13.668812] [<c0110bec>] (do_page_fault) from [<c0101308>] (do_DataAbort+0x34/0xb4)
[   13.676432] [<c0101308>] (do_DataAbort) from [<c010af78>] (__dabt_svc+0x58/0x80)
[   13.683783] Exception stack(0xedd67cc0 to 0xedd67d08)
[   13.688825] 7cc0: a0000113 0b750b74 00000000 edc97000 00000008 edc97324 edc97320 00000000
[   13.696970] 7ce0: edcc9b08 edd6808c 00000000 edcc9b04 00000000 edd67d10 c06e6138 c0135b24
[   13.705102] 7d00: 60000193 ffffffff
[   13.708586] [<c010af78>] (__dabt_svc) from [<c0135b24>] (kthread_queue_work+0x18/0x64)
[   13.716478] [<c0135b24>] (kthread_queue_work) from [<c0527ab8>] (mmc_request_done+0xd8/0x158)
[   13.724970] [<c0527ab8>] (mmc_request_done) from [<c0542834>] (dw_mci_request_end+0xa0/0xd8)
[   13.733373] [<c0542834>] (dw_mci_request_end) from [<c0542b5c>] (dw_mci_tasklet_func+0x2f0/0x394)
[   13.742211] [<c0542b5c>] (dw_mci_tasklet_func) from [<c011f6f0>] (tasklet_action+0x84/0x12c)
[   13.750614] [<c011f6f0>] (tasklet_action) from [<c011edac>] (__do_softirq+0xec/0x244)
[   13.758411] [<c011edac>] (__do_softirq) from [<c011f1a8>] (irq_exit+0xc0/0x104)
[   13.765689] [<c011f1a8>] (irq_exit) from [<c016068c>] (__handle_domain_irq+0x70/0xe4)
[   13.773486] [<c016068c>] (__handle_domain_irq) from [<c0101470>] (gic_handle_irq+0x50/0x9c)
[   13.781804] [<c0101470>] (gic_handle_irq) from [<c010b00c>] (__irq_svc+0x6c/0xa8)
[   13.789241] Exception stack(0xedd67e28 to 0xedd67e70)
[   13.794279] 7e20:                   c08a2154 c0890cdc edd67e78 edd66000 00000000 c011f068
[   13.802427] 7e40: c0890cdc c08a2154 00000000 edd68030 edd68004 00000000 00000001 edd67e78
[   13.810565] 7e60: c011f068 c03448b8 20000013 ffffffff
[   13.815603] [<c010b00c>] (__irq_svc) from [<c03448b8>] (check_preemption_disabled+0x30/0x128)
[   13.824098] [<c03448b8>] (check_preemption_disabled) from [<c011f068>] (__local_bh_enable_ip+0xc8/0xec)
[   13.833457] [<c011f068>] (__local_bh_enable_ip) from [<c0527b8c>] (__mmc_start_request+0x54/0xdc)
[   13.842297] [<c0527b8c>] (__mmc_start_request) from [<c0527d04>] (mmc_start_request+0xf0/0x11c)
[   13.850963] [<c0527d04>] (mmc_start_request) from [<c0528208>] (mmc_start_areq+0x148/0x1ac)
[   13.859278] [<c0528208>] (mmc_start_areq) from [<c05376c0>] (mmc_blk_issue_rw_rq+0x78/0x314)
[   13.867680] [<c05376c0>] (mmc_blk_issue_rw_rq) from [<c0538358>] (mmc_blk_issue_rq+0x9c/0x458)
[   13.876258] [<c0538358>] (mmc_blk_issue_rq) from [<c0538868>] (mmc_queue_thread+0x98/0x180)
[   13.884579] [<c0538868>] (mmc_queue_thread) from [<c0135604>] (kthread+0xfc/0x134)
[   13.892121] [<c0135604>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
[   13.899292] ---[ end trace 86f45842e4b0b194 ]---

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
