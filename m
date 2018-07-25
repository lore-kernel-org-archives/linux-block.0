Return-Path: <pgwipeout@gmail.com>
Return-Path: <pgwipeout@gmail.com>
To: ming.lei@redhat.com
From: Peter Geis <pgwipeout@gmail.com>
Subject: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
Cc: linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, axboe@kernel.dk
Message-ID: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
Date: Wed, 25 Jul 2018 13:28:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Good Afternoon,

I have encountered an issue on both Tegra 2 and Tegra 3 devices 
accessing emmc following the 25 July 2018 remote tracking merge.

The offending commit is:
6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
blk-mq: issue directly if hw queue isn't busy in case of 'none'.

Reverting this commit corrects the issue, but the issue has left the 
file system in a corrupted state.

The issue causes the following error message when the file system is 
remounted RW:
[    3.173189] ------------[ cut here ]------------
[    3.177907] WARNING: CPU: 0 PID: 114 at drivers/mmc/host/sdhci.c:1203 
sdhci_send_command+0x6d0/0xeb4
[    3.187059] Modules linked in: ip_tables x_tables autofs4
[    3.192503] CPU: 0 PID: 114 Comm: (direxec) Not tainted 
4.18.0-rc6-next-20180723+ #9
[    3.200228] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    3.206511] [<c0114828>] (unwind_backtrace) from [<c010eae0>] 
(show_stack+0x20/0x24)
[    3.214248] [<c010eae0>] (show_stack) from [<c09e30cc>] 
(dump_stack+0x80/0x94)
[    3.221468] [<c09e30cc>] (dump_stack) from [<c012f56c>] 
(__warn+0xf0/0x108)
[    3.228420] [<c012f56c>] (__warn) from [<c012f6bc>] 
(warn_slowpath_null+0x50/0x58)
[    3.235981] [<c012f6bc>] (warn_slowpath_null) from [<c078dec8>] 
(sdhci_send_command+0x6d0/0xeb4)
[    3.244754] [<c078dec8>] (sdhci_send_command) from [<c078ea5c>] 
(sdhci_request+0x84/0xe0)
[    3.252924] [<c078ea5c>] (sdhci_request) from [<c076a084>] 
(__mmc_start_request+0x88/0x1c4)
[    3.261263] [<c076a084>] (__mmc_start_request) from [<c076adcc>] 
(mmc_start_request+0xa4/0xc8)
[    3.269871] [<c076adcc>] (mmc_start_request) from [<c077f648>] 
(mmc_blk_mq_issue_rq+0x648/0x8c8)
[    3.278644] [<c077f648>] (mmc_blk_mq_issue_rq) from [<c077fd5c>] 
(mmc_mq_queue_rq+0x124/0x218)
[    3.287247] [<c077fd5c>] (mmc_mq_queue_rq) from [<c0508864>] 
(__blk_mq_try_issue_directly+0x148/0x1dc)
[    3.296538] [<c0508864>] (__blk_mq_try_issue_directly) from 
[<c0509cf0>] (blk_mq_request_issue_directly+0x68/0x98)
[    3.306869] [<c0509cf0>] (blk_mq_request_issue_directly) from 
[<c0509d68>] (blk_mq_try_issue_list_directly+0x48/0x80)
[    3.317466] [<c0509d68>] (blk_mq_try_issue_list_directly) from 
[<c050dedc>] (blk_mq_sched_insert_requests+0x9c/0xbc)
[    3.327971] [<c050dedc>] (blk_mq_sched_insert_requests) from 
[<c0509bb0>] (blk_mq_flush_plug_list+0x258/0x330)
[    3.337960] [<c0509bb0>] (blk_mq_flush_plug_list) from [<c04fcb90>] 
(blk_flush_plug_list+0xec/0x22c)
[    3.347078] [<c04fcb90>] (blk_flush_plug_list) from [<c04fd22c>] 
(blk_finish_plug+0x3c/0x54)
[    3.355507] [<c04fd22c>] (blk_finish_plug) from [<c02b0c00>] 
(read_pages+0x78/0x17c)
[    3.363240] [<c02b0c00>] (read_pages) from [<c02b0ef8>] 
(__do_page_cache_readahead+0x1f4/0x214)
[    3.371925] [<c02b0ef8>] (__do_page_cache_readahead) from 
[<c02b1078>] (ondemand_readahead+0x160/0x298)
[    3.381302] [<c02b1078>] (ondemand_readahead) from [<c02b1474>] 
(page_cache_sync_readahead+0xb4/0x104)
[    3.390598] [<c02b1474>] (page_cache_sync_readahead) from 
[<c02a03b4>] (generic_file_read_iter+0x7d0/0xb28)
[    3.400336] [<c02a03b4>] (generic_file_read_iter) from [<c03c9528>] 
(ext4_file_read_iter+0x48/0x54)
[    3.409373] [<c03c9528>] (ext4_file_read_iter) from [<c031b45c>] 
(__vfs_read+0x10c/0x16c)
[    3.417538] [<c031b45c>] (__vfs_read) from [<c031b558>] 
(vfs_read+0x9c/0x168)
[    3.424659] [<c031b558>] (vfs_read) from [<c031b658>] 
(kernel_read+0x34/0x44)
[    3.431784] [<c031b658>] (kernel_read) from [<c0322bd8>] 
(prepare_binprm+0xf4/0x198)
[    3.439515] [<c0322bd8>] (prepare_binprm) from [<c0324250>] 
(__do_execve_file+0x5d0/0x894)
[    3.447766] [<c0324250>] (__do_execve_file) from [<c03247e4>] 
(sys_execve+0x44/0x4c)
[    3.455495] [<c03247e4>] (sys_execve) from [<c0101000>] 
(ret_fast_syscall+0x0/0x54)
[    3.463134] Exception stack(0xeda61fa8 to 0xeda61ff0)
[    3.468176] 1fa0:                   b67c64e0 ffffffff 008078c0 
bef74b60 bef74f0c b6f9cb94
[    3.476335] 1fc0: b67c64e0 ffffffff 00000000 0000000b 008052f0 
008078c0 00000000 ffffffff
[    3.484494] 1fe0: b6ea3b08 bef74ae4 b6dd7313 b6f1aba8
[    3.489535] ---[ end trace 4eb4571f10ae8bad ]---
