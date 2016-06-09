Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
To: Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@fb.com>
References: <20160608204347.GA30146@kernel.dk>
 <x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57599734.40607@kernel.dk>
Date: Thu, 9 Jun 2016 10:20:04 -0600
MIME-Version: 1.0
In-Reply-To: <x49k2hyz78z.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/09/2016 09:55 AM, Jeff Moyer wrote:
> Hi, Jens,
>
> Jens Axboe <axboe@fb.com> writes:
>
>> At Facebook, we have a number of cases where people use ionice to set a
>> lower priority, then end up having tasks stuck for a long time because
>> eg meta data updates from an idle priority tasks is blocking out higher
>> priority processes. It's bad enough that it will trigger the softlockup
>> warning.
>
> I expect a higher prio process could be blocked on a lower prio process
> reading the same metadata, too.  I had a hard time tracking down where
> REQ_META WRITE I/O was issued outside of the journal or writeback paths
> (and I hope you're not ionice-ing those!).  Eventually, with the help of
> sandeen, I found some oddball cases that I doubt you're running into.
> Can you enlighten me as to where this (REQ_META write I/O) is happening?
> I don't disagree that it's a problem, I just would like to understand
> your problem case better.
>
> Anyway, it seems to me you could just set REQ_PRIO in the code paths you
> care about instead of modifying CFQ to treat REQ_META and REQ_PRIO as
> the same thing, which essentially undoes commit 65299a3b788bd ("block:
> separate priority boosting from REQ_META") from Christoph.

I personally don't care too much about boosting for just PRIO, or for
both PRIO and META. For the important paths, we basically have both set
anyway. But here's a trace for one such hang:


[478381.198925] ------------[ cut here ]------------
[478381.200315] INFO: task ionice:1168369 blocked for more than 120 seconds.
[478381.201324]       Not tainted 4.0.9-38_fbk5_hotfix1_2936_g85409c6 #1
[478381.202278] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[478381.203462] ionice          D ffff8803692736a8     0 1168369      1 
0x00000080
[478381.203466]  ffff8803692736a8 ffff880399c21300 ffff880276adcc00 
ffff880369273698
[478381.204589]  ffff880369273fd8 0000000000000000 7fffffffffffffff 
0000000000000002
[478381.205752]  ffffffff8177d5e0 ffff8803692736c8 ffffffff8177cea7 
0000000000000000
[478381.206874] Call Trace:
[478381.207253]  [<ffffffff8177d5e0>] ? bit_wait_io_timeout+0x80/0x80
[478381.208175]  [<ffffffff8177cea7>] schedule+0x37/0x90
[478381.208932]  [<ffffffff8177f5fc>] schedule_timeout+0x1dc/0x250
[478381.209805]  [<ffffffff81421c17>] ? __blk_run_queue+0x37/0x50
[478381.210706]  [<ffffffff810ca1c5>] ? ktime_get+0x45/0xb0
[478381.211489]  [<ffffffff8177c407>] io_schedule_timeout+0xa7/0x110
[478381.212402]  [<ffffffff810a8c2b>] ? prepare_to_wait+0x5b/0x90
[478381.213280]  [<ffffffff8177d616>] bit_wait_io+0x36/0x50
[478381.214063]  [<ffffffff8177d325>] __wait_on_bit+0x65/0x90
[478381.214961]  [<ffffffff8177d5e0>] ? bit_wait_io_timeout+0x80/0x80
[478381.215872]  [<ffffffff8177d47c>] out_of_line_wait_on_bit+0x7c/0x90
[478381.216806]  [<ffffffff810a89f0>] ? wake_atomic_t_function+0x40/0x40
[478381.217773]  [<ffffffff811f03aa>] __wait_on_buffer+0x2a/0x30
[478381.218641]  [<ffffffff8123c557>] ext4_bread+0x57/0x70
[478381.219425]  [<ffffffff8124498c>] __ext4_read_dirblock+0x3c/0x380
[478381.220467]  [<ffffffff8124665d>] ext4_dx_find_entry+0x7d/0x170
[478381.221357]  [<ffffffff8114c49e>] ? find_get_entry+0x1e/0xa0
[478381.222208]  [<ffffffff81246bd4>] ext4_find_entry+0x484/0x510
[478381.223090]  [<ffffffff812471a2>] ext4_lookup+0x52/0x160
[478381.223882]  [<ffffffff811c401d>] lookup_real+0x1d/0x60
[478381.224675]  [<ffffffff811c4698>] __lookup_hash+0x38/0x50
[478381.225697]  [<ffffffff817745bd>] lookup_slow+0x45/0xab
[478381.226941]  [<ffffffff811c690e>] link_path_walk+0x7ae/0x820
[478381.227880]  [<ffffffff811c6a42>] path_init+0xc2/0x430
[478381.228677]  [<ffffffff813e6e26>] ? security_file_alloc+0x16/0x20
[478381.229776]  [<ffffffff811c8c57>] path_openat+0x77/0x620
[478381.230767]  [<ffffffff81185c6e>] ? page_add_file_rmap+0x2e/0x70
[478381.232019]  [<ffffffff811cb253>] do_filp_open+0x43/0xa0
[478381.233016]  [<ffffffff8108c4a9>] ? creds_are_invalid+0x29/0x70
[478381.234072]  [<ffffffff811c0cb0>] do_open_execat+0x70/0x170
[478381.235039]  [<ffffffff811c1bf8>] do_execveat_common.isra.36+0x1b8/0x6e0
[478381.236051]  [<ffffffff811c214c>] do_execve+0x2c/0x30
[478381.236809]  [<ffffffff811ca392>] ? getname+0x12/0x20
[478381.237564]  [<ffffffff811c23be>] SyS_execve+0x2e/0x40
[478381.238338]  [<ffffffff81780a1d>] stub_execve+0x6d/0xa0
[478381.239126] ------------[ cut here ]------------
[478381.239915] ------------[ cut here ]------------
[478381.240606] INFO: task python2.7:1168375 blocked for more than 120 
seconds.
[478381.242673]       Not tainted 4.0.9-38_fbk5_hotfix1_2936_g85409c6 #1
[478381.243653] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[478381.244902] python2.7       D ffff88005cf8fb98     0 1168375 1168248 
0x00000080
[478381.244904]  ffff88005cf8fb98 ffff88016c1f0980 ffffffff81c134c0 
ffff88016c1f11a0
[478381.246023]  ffff88005cf8ffd8 ffff880466cd0cbc ffff88016c1f0980 
00000000ffffffff
[478381.247138]  ffff880466cd0cc0 ffff88005cf8fbb8 ffffffff8177cea7 
ffff88005cf8fcc8
[478381.248252] Call Trace:
[478381.248630]  [<ffffffff8177cea7>] schedule+0x37/0x90
[478381.249382]  [<ffffffff8177d08e>] schedule_preempt_disabled+0xe/0x10
[478381.250465]  [<ffffffff8177e892>] __mutex_lock_slowpath+0x92/0x100
[478381.251409]  [<ffffffff8177e91b>] mutex_lock+0x1b/0x2f
[478381.252199]  [<ffffffff817745ae>] lookup_slow+0x36/0xab
[478381.253023]  [<ffffffff811c690e>] link_path_walk+0x7ae/0x820
[478381.253877]  [<ffffffff811aeb41>] ? try_charge+0xc1/0x700
[478381.254690]  [<ffffffff811c6a42>] path_init+0xc2/0x430
[478381.255525]  [<ffffffff813e6e26>] ? security_file_alloc+0x16/0x20
[478381.256450]  [<ffffffff811c8c57>] path_openat+0x77/0x620
[478381.257256]  [<ffffffff8115b2fb>] ? 
lru_cache_add_active_or_unevictable+0x2b/0xa0
[478381.258390]  [<ffffffff8117b623>] ? handle_mm_fault+0x13f3/0x1720
[478381.259309]  [<ffffffff811cb253>] do_filp_open+0x43/0xa0
[478381.260139]  [<ffffffff811d7ae2>] ? __alloc_fd+0x42/0x120
[478381.260962]  [<ffffffff811b95ac>] do_sys_open+0x13c/0x230
[478381.261779]  [<ffffffff81011393>] ? 
syscall_trace_enter_phase1+0x113/0x170
[478381.262851]  [<ffffffff811b96c2>] SyS_open+0x22/0x30
[478381.263598]  [<ffffffff81780532>] system_call_fastpath+0x12/0x17
[478381.264551] ------------[ cut here ]------------
[478381.265377] ------------[ cut here ]------------

These are reads. It's a classic case of starting some operation that
ends up holding a file system resource, then making very slow progress
(due to task being scheduled as idle IO), and hence blocking out
potentially much important tasks.

The IO is marked META|PRIO, so if folks don't are for boosting on meta,
we can just kill that. "Normal" meta data could be scheduled as idle,
but anything scheduled under a fs lock or similar should be marked PRIO
and get boosted.

-- 
Jens Axboe
